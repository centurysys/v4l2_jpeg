# ==============================================================================
# Benchmark / visual test: raw RGBA -> libyuv NV12 -> v4l2_jpeg HW JPEG
# ==============================================================================
#
# Requires:
# - v4l2_jpeg
# - libyuv_nim with toNv12Into()
#
# Input:
# - raw RGBA/RGBx-compatible file
# - byte order: R, G, B, A/X
#
# Output:
# - writes only the last JPEG frame for visual validation
#
# Example:
#
#   nim c -d:release tests/benchmark_rgba_to_jpeg_visual.nim
#   ./tests/benchmark_rgba_to_jpeg_visual \
#     1920 1080 /home/user1/picture.rgba 5 100 rgba_to_hw.jpg
#
# ==============================================================================

import std/[os, strutils, monotimes, times]
import results
import v4l2_jpeg
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
proc parseUInt32(name, value: string): uint32 =
  try:
    let n = parseInt(value)
    if n < 0:
      fail("invalid " & name & ": " & value)
    result = uint32(n)
  except ValueError:
    fail("invalid " & name & ": " & value)

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
proc printStatLine(name: string, totalUs: int64, loops: int) =
  let avgUs = totalUs.float64 / loops.float64
  let avgMs = avgUs / 1000.0
  echo name, ": total=", totalUs, " us, avg=",
       avgUs.formatFloat(ffDecimal, 1), " us (",
       avgMs.formatFloat(ffDecimal, 3), " ms)"

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
proc readRgbaImage(path: string, width, height: int): RgbaImage =
  let expectedBytes = width * height * 4

  let s =
    try:
      readFile(path)
    except CatchableError:
      fail("failed to read file: " & path)

  if s.len != expectedBytes:
    fail(
      "unexpected RGBA input size: got " & $s.len &
      " bytes, expected " & $expectedBytes &
      " bytes for " & $width & "x" & $height & " RGBA/RGBx"
    )

  result.width = width
  result.height = height
  result.stride = width * 4
  result.data = newSeq[PixelRGBA](width * height)

  if expectedBytes > 0:
    copyMem(addr result.data[0], unsafeAddr s[0], expectedBytes)

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc allocNv12(width, height: int): Nv12Image =
  if (width mod 2) != 0 or (height mod 2) != 0:
    fail("width and height must be even for NV12")

  result.width = width
  result.height = height
  result.strideY = width
  result.strideUV = width
  result.y = newSeq[uint8](width * height)
  result.uv = newSeq[uint8](width * height div 2)

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc nv12ViewForHyperJpeg(image: var Nv12Image): Nm12ImageView =
  if image.y.len == 0 or image.uv.len == 0:
    fail("NV12 image has empty planes")

  result = Nm12ImageView(
    width: uint32(image.width),
    height: uint32(image.height),
    strideY: uint32(image.strideY),
    strideUV: uint32(image.strideUV),
    yData: cast[pointer](addr image.y[0]),
    uvData: cast[pointer](addr image.uv[0])
  )

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
proc requireVoidOk[E](r: Result[void, E], msg: string) =
  if r.isErr:
    when compiles(r.error.msg):
      fail(msg & ": " & r.error.msg)
    else:
      fail(msg & ": error")

# ==============================================================================
# Main
# ==============================================================================

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc main() =
  if paramCount() != 6:
    stderr.writeLine(
      "usage: benchmark_rgba_to_jpeg_visual " &
      "<width> <height> <input.rgba> <warmup_loops> <measure_loops> <output.jpg>"
    )
    quit(1)

  let widthU32 = parseUInt32("width", paramStr(1))
  let heightU32 = parseUInt32("height", paramStr(2))
  let width = int(widthU32)
  let height = int(heightU32)
  let inputPath = paramStr(3)
  let warmupLoops = parseNatural("warmup_loops", paramStr(4))
  let measureLoops = parseNatural("measure_loops", paramStr(5))
  let outputPath = paramStr(6)

  if measureLoops <= 0:
    fail("measure_loops must be > 0")

  if not fileExists(inputPath):
    fail("input file does not exist: " & inputPath)

  let rgbaReadStart = getMonoTime()
  let rgba = readRgbaImage(inputPath, width, height)
  let rgbaReadUs = elapsedUs(rgbaReadStart)

  let nv12AllocStart = getMonoTime()
  var nv12 = allocNv12(width, height)
  let nv12AllocUs = elapsedUs(nv12AllocStart)

  let openStart = getMonoTime()
  let openResult = JpegEncoder.open(
    device = "/dev/video0",
    width = widthU32,
    height = heightU32
  )
  let openUs = elapsedUs(openStart)

  if openResult.isErr:
    fail("JpegEncoder.open failed: " & openResult.error.msg)

  var encoder = openResult.get()
  defer:
    discard encoder.close()

  var view = nv12ViewForHyperJpeg(nv12)

  echo "== RGBA -> NV12 -> HW JPEG visual benchmark =="
  echo "width = ", width
  echo "height = ", height
  echo "inputPath = ", inputPath
  echo "outputPath = ", outputPath
  echo "warmupLoops = ", warmupLoops
  echo "measureLoops = ", measureLoops
  echo "rgba read = ", rgbaReadUs, " us"
  echo "nv12 alloc = ", nv12AllocUs, " us"
  echo "encoder open = ", openUs, " us"
  echo ""

  if warmupLoops > 0:
    echo "warming up..."
    for i in 0 ..< warmupLoops:
      requireVoidOk(rgba.toNv12Into(nv12), "warmup RGBA->NV12 failed at loop " & $(i + 1))
      let r = encoder.encode(view)
      if r.isErr:
        fail("warmup encode failed at loop " & $(i + 1) & ": " & r.error.msg)

  var totalConvertUs = 0'i64
  var totalEncodeUs = 0'i64
  var totalPathUs = 0'i64
  var minPathUs = high(int64)
  var maxPathUs = low(int64)

  var firstJpegBytes = -1
  var lastJpegBytes = -1
  var minJpegBytes = high(int)
  var maxJpegBytes = low(int)
  var sizeMismatchCount = 0
  var lastJpeg: seq[uint8]

  echo ""
  echo "measuring..."

  for i in 0 ..< measureLoops:
    let convertStart = getMonoTime()
    requireVoidOk(rgba.toNv12Into(nv12), "RGBA->NV12 failed at loop " & $(i + 1))
    let convertUs = elapsedUs(convertStart)

    let encodeStart = getMonoTime()
    let encResult = encoder.encode(view)
    let encodeUs = elapsedUs(encodeStart)

    if encResult.isErr:
      fail("HW encode failed at loop " & $(i + 1) & ": " & encResult.error.msg)

    let jpeg = encResult.get()
    let pathUs = convertUs + encodeUs
    let jpegBytes = jpeg.len

    if firstJpegBytes < 0:
      firstJpegBytes = jpegBytes
    elif jpegBytes != firstJpegBytes:
      inc sizeMismatchCount

    lastJpegBytes = jpegBytes
    if jpegBytes < minJpegBytes:
      minJpegBytes = jpegBytes
    if jpegBytes > maxJpegBytes:
      maxJpegBytes = jpegBytes

    if pathUs < minPathUs:
      minPathUs = pathUs
    if pathUs > maxPathUs:
      maxPathUs = pathUs

    totalConvertUs += convertUs
    totalEncodeUs += encodeUs
    totalPathUs += pathUs

    lastJpeg = jpeg

    echo "loop ", i + 1,
         ": convert=", convertUs, " us",
         ", encode=", encodeUs, " us",
         ", total=", pathUs, " us",
         ", jpeg=", jpegBytes, " bytes"

  let closeStart = getMonoTime()
  let closeResult = encoder.close()
  let closeUs = elapsedUs(closeStart)
  if closeResult.isErr:
    fail("close failed: " & closeResult.error.msg)

  if lastJpeg.len > 0:
    writeBinaryFile(outputPath, lastJpeg)

  echo ""
  echo "== summary =="
  echo "first jpeg bytes = ", firstJpegBytes
  echo "last jpeg bytes = ", lastJpegBytes
  echo "min jpeg bytes = ", minJpegBytes
  echo "max jpeg bytes = ", maxJpegBytes
  echo "size mismatches = ", sizeMismatchCount
  printStatLine("RGBA->NV12", totalConvertUs, measureLoops)
  printStatLine("HW JPEG encode", totalEncodeUs, measureLoops)
  printStatLine("convert + HW encode", totalPathUs, measureLoops)
  echo "path min = ", minPathUs, " us (", (minPathUs.float64 / 1000.0).formatFloat(ffDecimal, 3), " ms)"
  echo "path max = ", maxPathUs, " us (", (maxPathUs.float64 / 1000.0).formatFloat(ffDecimal, 3), " ms)"
  echo "encoder close = ", closeUs, " us"
  echo "wrote ", outputPath

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
when isMainModule:
  main()
