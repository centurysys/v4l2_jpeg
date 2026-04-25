# ==============================================================================
# Benchmark: encode raw NV12/NM12 file to JPEG
# ==============================================================================

import std/[os, strutils, monotimes, times]
import v4l2_jpeg

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
proc readBinaryFile(path: string): seq[uint8] =
  let s =
    try:
      readFile(path)
    except CatchableError:
      fail("failed to read file: " & path)

  result = newSeq[uint8](s.len)
  if s.len > 0:
    copyMem(addr result[0], unsafeAddr s[0], s.len)

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc expectedNm12Size(width, height: uint32): int =
  result = int(width * height * 3'u32 div 2'u32)

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc planePointers(data: var seq[uint8], width, height: uint32):
    tuple[y, uv: pointer] =
  let ySize = int(width * height)
  if data.len < ySize:
    fail("input is too small")

  result.y = addr data[0]
  result.uv = addr data[ySize]

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
  echo name, ": total=", totalUs, " us, avg=", avgUs.formatFloat(ffDecimal, 1),
       " us (", avgMs.formatFloat(ffDecimal, 3), " ms)"

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc runOneEncode(width: uint32, height: uint32, yPtr: pointer, uvPtr: pointer):
    tuple[openUs, encodeUs, closeUs, totalUs: int64, jpegBytes: int] =
  let totalStart = getMonoTime()

  let openStart = getMonoTime()
  let openResult = JpegEncoder.open(
    device = "/dev/video0",
    width = width,
    height = height
  )
  result.openUs = elapsedUs(openStart)
  if openResult.isErr:
    fail("open failed: " & openResult.error.msg)

  var encoder = openResult.get

  let encodeStart = getMonoTime()
  let view = Nm12ImageView(
    width: width,
    height: height,
    strideY: width,
    strideUV: width,
    yData: yPtr,
    uvData: uvPtr
  )

  let encodeResult = encoder.encode(view)
  result.encodeUs = elapsedUs(encodeStart)
  if encodeResult.isErr:
    discard encoder.close()
    fail("encode failed: " & encodeResult.error.msg)

  result.jpegBytes = encodeResult.get.len

  let closeStart = getMonoTime()
  discard encoder.close()
  result.closeUs = elapsedUs(closeStart)

  result.totalUs = elapsedUs(totalStart)

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc warmup(
    loops: int,
    width: uint32,
    height: uint32,
    yPtr: pointer,
    uvPtr: pointer
) =
  for _ in 0 ..< loops:
    discard runOneEncode(width, height, yPtr, uvPtr)


# ==============================================================================
# Main
# ==============================================================================

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc main() =
  if paramCount() != 5:
    stderr.writeLine(
      "usage: benchmark_encode_file <width> <height> <input.nv12> <warmup_loops> <measure_loops>"
    )
    quit(1)

  let width = parseUInt32("width", paramStr(1))
  let height = parseUInt32("height", paramStr(2))
  let inputPath = paramStr(3)
  let warmupLoops = parseNatural("warmup_loops", paramStr(4))
  let measureLoops = parseNatural("measure_loops", paramStr(5))

  if measureLoops <= 0:
    fail("measure_loops must be > 0")

  if not fileExists(inputPath):
    fail("input file does not exist: " & inputPath)

  var inputData = readBinaryFile(inputPath)
  let expectedSize = expectedNm12Size(width, height)
  if inputData.len != expectedSize:
    fail(
      "unexpected input size: got " & $inputData.len &
      " bytes, expected " & $expectedSize &
      " bytes for " & $width & "x" & $height & " NM12/NV12"
    )

  let planes = planePointers(inputData, width, height)

  echo "== benchmark =="
  echo "width          = ", width
  echo "height         = ", height
  echo "inputPath      = ", inputPath
  echo "warmupLoops    = ", warmupLoops
  echo "measureLoops   = ", measureLoops

  if warmupLoops > 0:
    echo ""
    echo "warming up..."
    warmup(warmupLoops, width, height, planes.y, planes.uv)

  var totalOpenUs = 0'i64
  var totalEncodeUs = 0'i64
  var totalCloseUs = 0'i64
  var totalAllUs = 0'i64
  var lastJpegBytes = 0

  echo ""
  echo "measuring..."

  for i in 0 ..< measureLoops:
    let r = runOneEncode(width, height, planes.y, planes.uv)
    totalOpenUs += r.openUs
    totalEncodeUs += r.encodeUs
    totalCloseUs += r.closeUs
    totalAllUs += r.totalUs
    lastJpegBytes = r.jpegBytes

    echo "loop ", i + 1, ": open=", r.openUs, " us, encode=", r.encodeUs,
         " us, close=", r.closeUs, " us, total=", r.totalUs, " us, jpeg=",
         r.jpegBytes, " bytes"

  echo ""
  echo "== summary =="
  echo "jpeg bytes     = ", lastJpegBytes
  printStatLine("open", totalOpenUs, measureLoops)
  printStatLine("encode", totalEncodeUs, measureLoops)
  printStatLine("close", totalCloseUs, measureLoops)
  printStatLine("total", totalAllUs, measureLoops)


# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
when isMainModule:
  main()
