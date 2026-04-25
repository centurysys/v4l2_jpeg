# ==============================================================================
# Benchmark: RGBA -> TurboJPEG vs RGBA -> HW (via libyuv toNv12)
# ==============================================================================
#
# Requires:
#   - libturbojpeg_nim
#   - libyuv_nim (with toNv12(RgbaView))
#   - v4l2_jpeg
#
# Compared paths:
#   1) TurboJPEG encode from RGBX image
#   2) RGBX -> RgbaImage (move only, no pixel copy) -> toNv12() -> HW encode
#
# Output:
#   - Prints timing comparison
#   - Writes ONE JPEG from HW path for color validation
#
# ==============================================================================

import std/[os, strutils, monotimes, times]
import results
import v4l2_jpeg
import libturbojpeg_nim
import libyuv_nim

# ==============================================================================
# Helpers
# ==============================================================================

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc fail(msg: string) {.noreturn.} =
  stderr.writeLine(msg)
  quit(1)

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc parseNatural(name, value: string): int =
  try:
    let n = parseInt(value)
    if n < 0:
      fail("invalid " & name & ": " & value)
    result = n
  except ValueError:
    fail("invalid " & name & ": " & value)

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc elapsedUs(startTime: MonoTime): int64 =
  result = (getMonoTime() - startTime).inMicroseconds

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc writeBinaryFile(path: string, data: seq[uint8]) =
  var s = newString(data.len)
  if data.len > 0:
    copyMem(addr s[0], unsafeAddr data[0], data.len)
  try:
    writeFile(path, s)
  except CatchableError:
    fail("failed to write file: " & path)

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc printStatLine(name: string, totalUs: int64, loops: int) =
  let avgUs = totalUs.float64 / loops.float64
  let avgMs = avgUs / 1000.0
  echo name, ": total=", totalUs, " us, avg=", avgUs.formatFloat(ffDecimal, 1),
       " us (", avgMs.formatFloat(ffDecimal, 3), " ms)"

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc requireOk[T, E](r: Result[T, E], msg: string): T =
  if r.isErr:
    when compiles(r.error.msg):
      fail(msg & ": " & r.error.msg)
    else:
      fail(msg & ": error")
  result = r.get()

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc rgbaFromRgbx(src: var RgbxImage): RgbaImage =
  ## Move-only conversion. Pixel buffer ownership is moved from RgbxImage
  ## into RgbaImage without copying pixel data.
  ##
  ## This relies on the layout compatibility already verified separately.
  result.width = src.width
  result.height = src.height
  result.stride = src.width * 4
  result.data = move cast[ptr seq[PixelRGBA]](addr src.data)[]

proc view*(img: var RgbaImage): RgbaView =
  result.width = img.width
  result.height = img.height
  result.stride = img.stride
  if img.data.len == 0:
    result.data = nil
  else:
    result.data = cast[ptr uint8](unsafeAddr img.data[0])

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc rgbaCopyFromRgbx(src: RgbxImage): RgbaImage =
  result.width = src.width
  result.height = src.height
  result.stride = src.width * 4
  result.data = newSeq[PixelRGBA](src.width * src.height)

  if src.data.len > 0:
    copyMem(
      addr result.data[0],
      unsafeAddr src.data[0],
      src.data.len * sizeof(PixelRGBX)
    )

# ==============================================================================
# Main
# ==============================================================================

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc main() =
  if paramCount() != 4:
    stderr.writeLine(
      "usage: bench_rgba_hw_vs_turbo <input.jpg> <quality> <warmup_loops> <measure_loops>"
    )
    quit(1)

  let inputPath = paramStr(1)
  let quality = parseNatural("quality", paramStr(2))
  let warmupLoops = parseNatural("warmup_loops", paramStr(3))
  let measureLoops = parseNatural("measure_loops", paramStr(4))

  if measureLoops <= 0:
    fail("measure_loops must be > 0")

  if not fileExists(inputPath):
    fail("input file does not exist: " & inputPath)

  let rgbxTurbo = requireOk(readJpegRgbx(inputPath), "readJpegRgbx")
  var rgba = rgbaCopyFromRgbx(rgbxTurbo)
  let rgbaView = rgba.view()

  let openStart = getMonoTime()
  let encRes = JpegEncoder.open(
    device = "/dev/video0",
    width = uint32(rgba.width),
    height = uint32(rgba.height)
  )
  let hwOpenUs = elapsedUs(openStart)
  if encRes.isErr:
    fail("JpegEncoder.open failed: " & encRes.error.msg)

  var enc = encRes.get()
  defer:
    discard enc.close()

  echo "== benchmark =="
  echo "inputPath        = ", inputPath
  echo "width            = ", rgba.width
  echo "height           = ", rgba.height
  echo "quality          = ", quality
  echo "warmupLoops      = ", warmupLoops
  echo "measureLoops     = ", measureLoops
  echo "hw open          = ", hwOpenUs, " us"

  if warmupLoops > 0:
    echo ""
    echo "warming up..."
    for _ in 0 ..< warmupLoops:
      discard requireOk(encodeJpeg(rgbxTurbo, quality), "warmup turbo encode")

      let nv12 = requireOk(rgbaView.toNv12(), "warmup toNv12")
      if nv12.y.len == 0 or nv12.uv.len == 0:
        fail("warmup toNv12 returned empty planes")

      let hwRes = enc.encode(
        uint32(nv12.width),
        uint32(nv12.height),
        uint32(nv12.strideY),
        uint32(nv12.strideUV),
        cast[pointer](unsafeAddr nv12.y[0]),
        cast[pointer](unsafeAddr nv12.uv[0])
      )
      if hwRes.isErr:
        fail("warmup hw encode failed: " & hwRes.error.msg)

  var totalTurboUs = 0'i64
  var totalConvertUs = 0'i64
  var totalHwEncodeUs = 0'i64
  var totalHwPathUs = 0'i64
  var lastTurboBytes = 0
  var lastHwBytes = 0
  var lastHwJpeg: seq[uint8]

  echo ""
  echo "measuring..."

  for i in 0 ..< measureLoops:
    let turboStart = getMonoTime()
    let tj = requireOk(encodeJpeg(rgbxTurbo, quality), "turbo encode")
    let turboUs = elapsedUs(turboStart)

    let convertStart = getMonoTime()
    let nv12 = requireOk(rgbaView.toNv12(), "toNv12")
    let convertUs = elapsedUs(convertStart)

    if nv12.y.len == 0 or nv12.uv.len == 0:
      fail("toNv12 returned empty planes at loop " & $(i + 1))

    let hwStart = getMonoTime()
    let hwRes = enc.encode(
      uint32(nv12.width),
      uint32(nv12.height),
      uint32(nv12.strideY),
      uint32(nv12.strideUV),
      cast[pointer](unsafeAddr nv12.y[0]),
      cast[pointer](unsafeAddr nv12.uv[0])
    )
    let hwEncodeUs = elapsedUs(hwStart)
    if hwRes.isErr:
      fail("HW encode failed at loop " & $(i + 1) & ": " & hwRes.error.msg)

    let hw = hwRes.get()
    let hwPathUs = convertUs + hwEncodeUs

    totalTurboUs += turboUs
    totalConvertUs += convertUs
    totalHwEncodeUs += hwEncodeUs
    totalHwPathUs += hwPathUs
    lastTurboBytes = tj.len
    lastHwBytes = hw.len
    lastHwJpeg = hw

    echo "loop ", i + 1,
         ": turbo=", turboUs, " us",
         ", convert=", convertUs, " us",
         ", hw=", hwEncodeUs, " us",
         ", hw_total=", hwPathUs, " us",
         ", turbo_bytes=", lastTurboBytes,
         ", hw_bytes=", lastHwBytes

  echo ""
  echo "== summary =="
  echo "turbo jpeg bytes = ", lastTurboBytes
  echo "hw jpeg bytes    = ", lastHwBytes
  printStatLine("turbo encode", totalTurboUs, measureLoops)
  printStatLine("RGBA->NV12", totalConvertUs, measureLoops)
  printStatLine("HW encode", totalHwEncodeUs, measureLoops)
  printStatLine("convert + HW", totalHwPathUs, measureLoops)

  if lastHwJpeg.len > 0:
    writeBinaryFile("hw_output_check.jpg", lastHwJpeg)
    echo ""
    echo "wrote hw_output_check.jpg"


# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
when isMainModule:
  main()
