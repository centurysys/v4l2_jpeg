# ==============================================================================
# Benchmark: reuse one encoder and call encode() repeatedly
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
proc planePointers(
    data: var seq[uint8],
    width, height: uint32
): tuple[y, uv: pointer] =
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


# ==============================================================================
# Main
# ==============================================================================

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc main() =
  if paramCount() != 5:
    stderr.writeLine(
      "usage: benchmark_reuse_encoder <width> <height> <input.nv12> <warmup_loops> <measure_loops>"
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

  let view = Nm12ImageView(
    width: width,
    height: height,
    strideY: width,
    strideUV: width,
    yData: planes.y,
    uvData: planes.uv
  )

  echo "== benchmark =="
  echo "width          = ", width
  echo "height         = ", height
  echo "inputPath      = ", inputPath
  echo "warmupLoops    = ", warmupLoops
  echo "measureLoops   = ", measureLoops
  echo "mode           = reuse one encoder"

  let openStart = getMonoTime()
  let openResult = JpegEncoder.open(
    device = "/dev/video0",
    width = width,
    height = height
  )
  let openUs = elapsedUs(openStart)
  if openResult.isErr:
    fail("open failed: " & openResult.error.msg)

  var encoder = openResult.get
  defer:
    discard encoder.close()

  echo ""
  echo "open           = ", openUs, " us"

  if warmupLoops > 0:
    echo ""
    echo "warming up..."
    for i in 0 ..< warmupLoops:
      let r = encoder.encode(view)
      if r.isErr:
        fail("warmup encode failed at loop " & $(i + 1) & ": " & r.error.msg)

  var totalEncodeUs = 0'i64
  var minEncodeUs = high(int64)
  var maxEncodeUs = low(int64)
  var firstJpegBytes = -1
  var lastJpegBytes = -1
  var sizeMismatchCount = 0

  echo ""
  echo "measuring..."

  for i in 0 ..< measureLoops:
    let startTime = getMonoTime()
    let r = encoder.encode(view)
    let encodeUs = elapsedUs(startTime)

    if r.isErr:
      fail("encode failed at loop " & $(i + 1) & ": " & r.error.msg)

    let jpegBytes = r.get.len
    if firstJpegBytes < 0:
      firstJpegBytes = jpegBytes
    elif jpegBytes != firstJpegBytes:
      inc sizeMismatchCount

    lastJpegBytes = jpegBytes
    totalEncodeUs += encodeUs

    if encodeUs < minEncodeUs:
      minEncodeUs = encodeUs
    if encodeUs > maxEncodeUs:
      maxEncodeUs = encodeUs

    echo "loop ", i + 1, ": encode=", encodeUs, " us, jpeg=", jpegBytes, " bytes"

  let closeStart = getMonoTime()
  let closeResult = encoder.close()
  let closeUs = elapsedUs(closeStart)
  if closeResult.isErr:
    fail("close failed: " & closeResult.error.msg)

  echo ""
  echo "== summary =="
  echo "first jpeg bytes = ", firstJpegBytes
  echo "last jpeg bytes  = ", lastJpegBytes
  echo "size mismatches  = ", sizeMismatchCount
  printStatLine("encode", totalEncodeUs, measureLoops)
  echo "encode min       = ", minEncodeUs, " us (",
       (minEncodeUs.float64 / 1000.0).formatFloat(ffDecimal, 3), " ms)"
  echo "encode max       = ", maxEncodeUs, " us (",
       (maxEncodeUs.float64 / 1000.0).formatFloat(ffDecimal, 3), " ms)"
  echo "close            = ", closeUs, " us"


# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
when isMainModule:
  main()
