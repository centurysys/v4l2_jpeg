# ==============================================================================
# Alternating RGBA -> shared NV12 -> HW JPEG test
# ==============================================================================
#
# Purpose:
#   Verify that:
#
#   1. libyuv_nim toNv12Into() correctly overwrites a reused NV12 buffer.
#   2. v4l2_jpeg / e5010 consumes the current NV12 content each time.
#   3. Two different RGBA inputs produce stable alternating JPEG outputs.
#
# Test pattern:
#   RGBA A -> shared NV12 -> JPEG
#   RGBA B -> shared NV12 -> JPEG
#   RGBA A -> shared NV12 -> JPEG
#   RGBA B -> shared NV12 -> JPEG
#   ...
#
# Expected:
#   - All A iterations have the same JPEG size.
#   - All B iterations have the same JPEG size.
#   - A size and B size differ.
#   - First A and last A are byte-identical.
#   - First B and last B are byte-identical.
#
# Build:
#   nim c -d:release tests/benchmark_alternating_rgba_to_jpeg.nim
#
# Run:
#   ./tests/benchmark_alternating_rgba_to_jpeg 1920 1080 100 a_first.jpg a_last.jpg b_first.jpg b_last.jpg
#
# ==============================================================================

import std/[os, strutils, monotimes, times]
import results
import v4l2_jpeg
import libyuv_nim

proc fail(msg: string) {.noreturn.} =
  stderr.writeLine(msg)
  quit(1)

proc parseUInt32(name, value: string): uint32 =
  try:
    let n = parseInt(value)
    if n <= 0:
      fail("invalid " & name & ": " & value)
    result = uint32(n)
  except ValueError:
    fail("invalid " & name & ": " & value)

proc parsePositive(name, value: string): int =
  try:
    let n = parseInt(value)
    if n <= 0:
      fail("invalid " & name & ": " & value)
    result = n
  except ValueError:
    fail("invalid " & name & ": " & value)

proc elapsedUs(startTime: MonoTime): int64 =
  result = (getMonoTime() - startTime).inMicroseconds

proc writeBinaryFile(path: string, data: seq[uint8]) =
  var s = newString(data.len)
  if data.len > 0:
    copyMem(addr s[0], unsafeAddr data[0], data.len)

  try:
    writeFile(path, s)
  except CatchableError:
    fail("failed to write file: " & path)

proc copyBytes(data: seq[uint8]): seq[uint8] =
  result = newSeq[uint8](data.len)
  if data.len > 0:
    copyMem(addr result[0], unsafeAddr data[0], data.len)

proc bytesEqual(a, b: seq[uint8]): bool =
  if a.len != b.len:
    result = false
    return
  if a.len == 0:
    result = true
    return
  result = equalMem(unsafeAddr a[0], unsafeAddr b[0], a.len)

proc checksumBytes(data: seq[uint8]): uint64 =
  if data.len == 0:
    result = 0
    return

  var h = 1469598103934665603'u64
  let step = max(1, data.len div 4096)
  var i = 0
  while i < data.len:
    h = h xor uint64(data[i])
    h = h * 1099511628211'u64
    i += step
  h = h xor uint64(data[^1])
  result = h

proc printStat(name: string; totalUs: int64; loops: int) =
  let avgUs = totalUs.float64 / loops.float64
  let avgMs = avgUs / 1000.0
  echo name, ": total=", totalUs, " us, avg=",
       avgUs.formatFloat(ffDecimal, 1), " us (",
       avgMs.formatFloat(ffDecimal, 3), " ms)"

proc requireVoidOk[E](r: Result[void, E], msg: string) =
  if r.isErr:
    when compiles(r.error.msg):
      fail(msg & ": " & r.error.msg)
    else:
      fail(msg & ": error")

proc allocRgba(width, height: int): RgbaImage =
  result.width = width
  result.height = height
  result.stride = width * 4
  result.data = newSeq[PixelRGBA](width * height)

type
  ByteArray = UncheckedArray[uint8]

proc rgbaBytesPtr(img: var RgbaImage): ptr ByteArray =
  if img.data.len == 0:
    result = nil
    return
  result = cast[ptr ByteArray](addr img.data[0])

proc fillRgbaA(img: var RgbaImage) =
  let p = rgbaBytesPtr(img)
  for y in 0 ..< img.height:
    for x in 0 ..< img.width:
      let i = y * img.stride + x * 4
      p[i + 0] = uint8((x + y) and 0xff)
      p[i + 1] = uint8((x * 2 + y) and 0xff)
      p[i + 2] = uint8((x + y * 3) and 0xff)
      p[i + 3] = 255'u8

proc fillRgbaB(img: var RgbaImage) =
  let p = rgbaBytesPtr(img)
  for y in 0 ..< img.height:
    for x in 0 ..< img.width:
      let i = y * img.stride + x * 4
      let blocks = ((x div 64) xor (y div 64)) and 1
      if blocks == 0:
        p[i + 0] = 240'u8
        p[i + 1] = uint8((32 + x) and 0xff)
        p[i + 2] = 32'u8
      else:
        p[i + 0] = 24'u8
        p[i + 1] = 220'u8
        p[i + 2] = uint8((64 + y) and 0xff)
      p[i + 3] = 255'u8

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

proc main() =
  if paramCount() != 7:
    stderr.writeLine(
      "usage: benchmark_alternating_rgba_to_jpeg " &
      "<width> <height> <pairs> <a_first.jpg> <a_last.jpg> <b_first.jpg> <b_last.jpg>"
    )
    quit(1)

  let widthU32 = parseUInt32("width", paramStr(1))
  let heightU32 = parseUInt32("height", paramStr(2))
  let width = int(widthU32)
  let height = int(heightU32)
  let pairs = parsePositive("pairs", paramStr(3))
  let aFirstPath = paramStr(4)
  let aLastPath = paramStr(5)
  let bFirstPath = paramStr(6)
  let bLastPath = paramStr(7)

  echo "== Alternating RGBA -> shared NV12 -> HW JPEG test =="
  echo "width = ", width
  echo "height = ", height
  echo "pairs = ", pairs
  echo "total encodes = ", pairs * 2
  echo ""

  var rgbaA = allocRgba(width, height)
  var rgbaB = allocRgba(width, height)
  fillRgbaA(rgbaA)
  fillRgbaB(rgbaB)

  var nv12 = allocNv12(width, height)
  var view = nv12ViewForHyperJpeg(nv12)

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

  echo "encoder open = ", openUs, " us"
  echo ""

  requireVoidOk(rgbaA.toNv12Into(nv12), "warmup A RGBA->NV12 failed")
  let warmA = encoder.encode(view)
  if warmA.isErr:
    fail("warmup A encode failed: " & warmA.error.msg)

  requireVoidOk(rgbaB.toNv12Into(nv12), "warmup B RGBA->NV12 failed")
  let warmB = encoder.encode(view)
  if warmB.isErr:
    fail("warmup B encode failed: " & warmB.error.msg)

  var totalConvertUs = 0'i64
  var totalEncodeUs = 0'i64

  var aExpectedSize = -1
  var bExpectedSize = -1
  var aSizeMismatchCount = 0
  var bSizeMismatchCount = 0
  var aByteMismatchCount = 0
  var bByteMismatchCount = 0

  var aFirst: seq[uint8]
  var aLast: seq[uint8]
  var bFirst: seq[uint8]
  var bLast: seq[uint8]

  var aFirstChecksum = 0'u64
  var bFirstChecksum = 0'u64

  echo "measuring..."

  for pairIndex in 0 ..< pairs:
    let aConvStart = getMonoTime()
    requireVoidOk(rgbaA.toNv12Into(nv12), "A RGBA->NV12 failed at pair " & $(pairIndex + 1))
    let aConvUs = elapsedUs(aConvStart)

    let aEncStart = getMonoTime()
    let aEnc = encoder.encode(view)
    let aEncUs = elapsedUs(aEncStart)

    if aEnc.isErr:
      fail("A encode failed at pair " & $(pairIndex + 1) & ": " & aEnc.error.msg)

    let aJpeg = aEnc.get()
    let aSize = aJpeg.len
    let aChecksum = checksumBytes(aJpeg)

    if pairIndex == 0:
      aExpectedSize = aSize
      aFirst = copyBytes(aJpeg)
      aFirstChecksum = aChecksum
    else:
      if aSize != aExpectedSize:
        inc aSizeMismatchCount
      if aChecksum != aFirstChecksum:
        inc aByteMismatchCount

    if pairIndex == pairs - 1:
      aLast = copyBytes(aJpeg)

    totalConvertUs += aConvUs
    totalEncodeUs += aEncUs

    let bConvStart = getMonoTime()
    requireVoidOk(rgbaB.toNv12Into(nv12), "B RGBA->NV12 failed at pair " & $(pairIndex + 1))
    let bConvUs = elapsedUs(bConvStart)

    let bEncStart = getMonoTime()
    let bEnc = encoder.encode(view)
    let bEncUs = elapsedUs(bEncStart)

    if bEnc.isErr:
      fail("B encode failed at pair " & $(pairIndex + 1) & ": " & bEnc.error.msg)

    let bJpeg = bEnc.get()
    let bSize = bJpeg.len
    let bChecksum = checksumBytes(bJpeg)

    if pairIndex == 0:
      bExpectedSize = bSize
      bFirst = copyBytes(bJpeg)
      bFirstChecksum = bChecksum
    else:
      if bSize != bExpectedSize:
        inc bSizeMismatchCount
      if bChecksum != bFirstChecksum:
        inc bByteMismatchCount

    if pairIndex == pairs - 1:
      bLast = copyBytes(bJpeg)

    totalConvertUs += bConvUs
    totalEncodeUs += bEncUs

    echo "pair ", pairIndex + 1,
         ": A size=", aSize, " checksum=0x", aChecksum.toHex,
         " conv=", aConvUs, "us enc=", aEncUs, "us",
         " | B size=", bSize, " checksum=0x", bChecksum.toHex,
         " conv=", bConvUs, "us enc=", bEncUs, "us"

  let closeStart = getMonoTime()
  let closeResult = encoder.close()
  let closeUs = elapsedUs(closeStart)
  if closeResult.isErr:
    fail("encoder close failed: " & closeResult.error.msg)

  writeBinaryFile(aFirstPath, aFirst)
  writeBinaryFile(aLastPath, aLast)
  writeBinaryFile(bFirstPath, bFirst)
  writeBinaryFile(bLastPath, bLast)

  echo ""
  echo "== summary =="
  echo "A expected size = ", aExpectedSize
  echo "B expected size = ", bExpectedSize
  echo "A size mismatches = ", aSizeMismatchCount
  echo "B size mismatches = ", bSizeMismatchCount
  echo "A checksum mismatches = ", aByteMismatchCount
  echo "B checksum mismatches = ", bByteMismatchCount
  echo "A first == A last = ", bytesEqual(aFirst, aLast)
  echo "B first == B last = ", bytesEqual(bFirst, bLast)
  echo "A size != B size = ", aExpectedSize != bExpectedSize
  printStat("RGBA->NV12 total", totalConvertUs, pairs * 2)
  printStat("HW JPEG encode total", totalEncodeUs, pairs * 2)
  printStat("total path", totalConvertUs + totalEncodeUs, pairs * 2)
  echo "encoder close = ", closeUs, " us"
  echo "wrote A first = ", aFirstPath
  echo "wrote A last  = ", aLastPath
  echo "wrote B first = ", bFirstPath
  echo "wrote B last  = ", bLastPath

  if aSizeMismatchCount == 0 and
     bSizeMismatchCount == 0 and
     aByteMismatchCount == 0 and
     bByteMismatchCount == 0 and
     bytesEqual(aFirst, aLast) and
     bytesEqual(bFirst, bLast) and
     aExpectedSize != bExpectedSize:
    echo "RESULT: PASS"
  else:
    echo "RESULT: FAIL"
    quit(1)

when isMainModule:
  main()
