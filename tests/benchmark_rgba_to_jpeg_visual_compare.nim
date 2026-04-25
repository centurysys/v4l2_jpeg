# ==============================================================================
# Benchmark / visual test: raw RGBA -> libyuv NV12 -> v4l2_jpeg HW JPEG
# ==============================================================================
#
# Saves both first and last JPEG outputs for visual comparison.
#
# Modes:
#
#   convert-each:
#     Each loop does RGBA -> NV12 -> HW JPEG.
#
#   encode-only:
#     RGBA -> NV12 is done once before the loop.
#     Each loop only does HW JPEG from the same NV12 buffer.
#
# Example:
#
#   nim c -d:release tests/benchmark_rgba_to_jpeg_visual_compare.nim
#
#   ./tests/benchmark_rgba_to_jpeg_visual_compare \
#     1920 1080 /home/user1/picture.rgba 5 100 convert-each first.jpg last.jpg
#
#   ./tests/benchmark_rgba_to_jpeg_visual_compare \
#     1920 1080 /home/user1/picture.rgba 5 100 encode-only first.jpg last.jpg
#
# ==============================================================================

import std/[os, strutils, monotimes, times]
import results
import v4l2_jpeg
import libyuv_nim

# ==============================================================================
# Helpers
# ==============================================================================

proc fail(msg: string) {.noreturn.} =
  stderr.writeLine(msg)
  quit(1)

proc parseUInt32(name, value: string): uint32 =
  try:
    let n = parseInt(value)
    if n < 0:
      fail("invalid " & name & ": " & value)
    result = uint32(n)
  except ValueError:
    fail("invalid " & name & ": " & value)

proc parseNatural(name, value: string): int =
  try:
    let n = parseInt(value)
    if n < 0:
      fail("invalid " & name & ": " & value)
    result = n
  except ValueError:
    fail("invalid " & name & ": " & value)

proc elapsedUs(startTime: MonoTime): int64 =
  result = (getMonoTime() - startTime).inMicroseconds

proc printStatLine(name: string, totalUs: int64, loops: int) =
  let avgUs = totalUs.float64 / loops.float64
  let avgMs = avgUs / 1000.0
  echo name, ": total=", totalUs, " us, avg=",
       avgUs.formatFloat(ffDecimal, 1), " us (",
       avgMs.formatFloat(ffDecimal, 3), " ms)"

proc writeBinaryFile(path: string, data: seq[uint8]) =
  var s = newString(data.len)
  if data.len > 0:
    copyMem(addr s[0], unsafeAddr data[0], data.len)

  try:
    writeFile(path, s)
  except CatchableError:
    fail("failed to write file: " & path)

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

proc allocNv12(width, height: int): Nv12Image =
  if (width mod 2) != 0 or (height mod 2) != 0:
    fail("width and height must be even for NV12")

  result.width = width
  result.height = height
  result.strideY = width
  result.strideUV = width
  result.y = newSeq[uint8](width * height)
  result.uv = newSeq[uint8](width * height div 2)

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

proc requireVoidOk[E](r: Result[void, E], msg: string) =
  if r.isErr:
    when compiles(r.error.msg):
      fail(msg & ": " & r.error.msg)
    else:
      fail(msg & ": error")

proc copyJpeg(data: seq[uint8]): seq[uint8] =
  result = newSeq[uint8](data.len)
  if data.len > 0:
    copyMem(addr result[0], unsafeAddr data[0], data.len)

# ==============================================================================
# Main
# ==============================================================================

proc main() =
  if paramCount() != 8:
    stderr.writeLine(
      "usage: benchmark_rgba_to_jpeg_visual_compare " &
      "<width> <height> <input.rgba> <warmup_loops> <measure_loops> " &
      "<convert-each|encode-only> <first.jpg> <last.jpg>"
    )
    quit(1)

  let widthU32 = parseUInt32("width", paramStr(1))
  let heightU32 = parseUInt32("height", paramStr(2))
  let width = int(widthU32)
  let height = int(heightU32)
  let inputPath = paramStr(3)
  let warmupLoops = parseNatural("warmup_loops", paramStr(4))
  let measureLoops = parseNatural("measure_loops", paramStr(5))
  let mode = paramStr(6)
  let firstOutputPath = paramStr(7)
  let lastOutputPath = paramStr(8)

  if mode notin ["convert-each", "encode-only"]:
    fail("mode must be convert-each or encode-only")

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

  echo "== RGBA -> NV12 -> HW JPEG visual compare benchmark =="
  echo "width = ", width
  echo "height = ", height
  echo "inputPath = ", inputPath
  echo "firstOutputPath = ", firstOutputPath
  echo "lastOutputPath = ", lastOutputPath
  echo "warmupLoops = ", warmupLoops
  echo "measureLoops = ", measureLoops
  echo "mode = ", mode
  echo "rgba read = ", rgbaReadUs, " us"
  echo "nv12 alloc = ", nv12AllocUs, " us"
  echo "encoder open = ", openUs, " us"
  echo ""

  if mode == "encode-only":
    requireVoidOk(rgba.toNv12Into(nv12), "initial RGBA->NV12 failed")

  if warmupLoops > 0:
    echo "warming up..."
    for i in 0 ..< warmupLoops:
      if mode == "convert-each":
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
  var firstJpeg: seq[uint8]
  var lastJpeg: seq[uint8]

  echo ""
  echo "measuring..."

  for i in 0 ..< measureLoops:
    var convertUs = 0'i64
    if mode == "convert-each":
      let convertStart = getMonoTime()
      requireVoidOk(rgba.toNv12Into(nv12), "RGBA->NV12 failed at loop " & $(i + 1))
      convertUs = elapsedUs(convertStart)

    let encodeStart = getMonoTime()
    let encResult = encoder.encode(view)
    let encodeUs = elapsedUs(encodeStart)

    if encResult.isErr:
      fail("HW encode failed at loop " & $(i + 1) & ": " & encResult.error.msg)

    let jpeg = encResult.get()
    let pathUs = convertUs + encodeUs
    let jpegBytes = jpeg.len

    if i == 0:
      firstJpegBytes = jpegBytes
      firstJpeg = copyJpeg(jpeg)
    elif jpegBytes != firstJpegBytes:
      inc sizeMismatchCount

    if i == measureLoops - 1:
      lastJpeg = copyJpeg(jpeg)

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

  writeBinaryFile(firstOutputPath, firstJpeg)
  writeBinaryFile(lastOutputPath, lastJpeg)

  echo ""
  echo "== summary =="
  echo "first jpeg bytes = ", firstJpegBytes
  echo "last jpeg bytes = ", lastJpegBytes
  echo "min jpeg bytes = ", minJpegBytes
  echo "max jpeg bytes = ", maxJpegBytes
  echo "size mismatches = ", sizeMismatchCount
  if mode == "convert-each":
    printStatLine("RGBA->NV12", totalConvertUs, measureLoops)
  else:
    echo "RGBA->NV12: done once before loop"
  printStatLine("HW JPEG encode", totalEncodeUs, measureLoops)
  printStatLine("convert + HW encode", totalPathUs, measureLoops)
  echo "path min = ", minPathUs, " us (", (minPathUs.float64 / 1000.0).formatFloat(ffDecimal, 3), " ms)"
  echo "path max = ", maxPathUs, " us (", (maxPathUs.float64 / 1000.0).formatFloat(ffDecimal, 3), " ms)"
  echo "encoder close = ", closeUs, " us"
  echo "wrote first = ", firstOutputPath
  echo "wrote last  = ", lastOutputPath

when isMainModule:
  main()
