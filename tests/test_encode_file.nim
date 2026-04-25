# ==============================================================================
# Test: encode raw NV12/NM12 file to JPEG
# ==============================================================================

import std/[os, strutils]
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
proc expectedNm12Size(width, height: uint32): int =
  result = int(width * height * 3'u32 div 2'u32)

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc planePointers(data: var seq[uint8], width, height: uint32): tuple[y, uv: pointer] =
  let ySize = int(width * height)
  if data.len < ySize:
    fail("input is too small")
  result.y = addr data[0]
  result.uv = addr data[ySize]


# ==============================================================================
# Main
# ==============================================================================

when isMainModule:
  proc main() =
    if paramCount() != 4:
      stderr.writeLine("usage: test_encode_file <width> <height> <input.nv12> <output.jpg>")
      quit(1)

    let width = parseUInt32("width", paramStr(1))
    let height = parseUInt32("height", paramStr(2))
    let inputPath = paramStr(3)
    let outputPath = paramStr(4)

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

    let openResult = JpegEncoder.open(
      device = "/dev/video0",
      width = width,
      height = height
    )
    if openResult.isErr:
      fail("open failed: " & openResult.error.msg)

    var encoder = openResult.get
    defer:
      discard encoder.close()

    let view = Nm12ImageView(
      width: width,
      height: height,
      strideY: width,
      strideUV: width,
      yData: planes.y,
      uvData: planes.uv
    )

    let encodeResult = encoder.encode(view)
    if encodeResult.isErr:
      fail("encode failed: " & encodeResult.error.msg)

    let jpegData = encodeResult.get
    writeBinaryFile(outputPath, jpegData)

    echo "encoded: ", inputPath, " -> ", outputPath
    echo "jpeg bytes: ", jpegData.len

  main()