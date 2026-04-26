# ------------------------------------------------------------------------------
# test_quality_sizes.nim
# ------------------------------------------------------------------------------
#
# Verify that JPEG quality control changes the encoded output size.
#
# This test creates a synthetic NV12/NM12 input frame with gradients and stripe
# patterns so that JPEG quality differences are visible in output size.
#
# Usage:
#   nim c -r tests/test_quality_sizes.nim
#   sudo ./test_quality_sizes
#
# Optional:
#   sudo ./test_quality_sizes 1920 1080
#
# ------------------------------------------------------------------------------

import std/[os, strformat, strutils]

import libyuv_nim
import v4l2_jpeg

# ------------------------------------------------------------------------------
# Constants
# ------------------------------------------------------------------------------

const
  DefaultWidth = 1920
  DefaultHeight = 1080

# ------------------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------------------

proc usage() =
  echo "usage: test_quality_sizes [width height]"

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc parseSize(): tuple[width: int, height: int] =
  result = (DefaultWidth, DefaultHeight)

  let args = commandLineParams()
  if args.len == 0:
    return

  if args.len != 2:
    usage()
    quit(1)

  try:
    result.width = parseInt(args[0])
    result.height = parseInt(args[1])
  except ValueError:
    usage()
    quit(1)

  if result.width <= 0 or result.height <= 0:
    echo "width and height must be positive"
    quit(1)

  if (result.width mod 2) != 0 or (result.height mod 2) != 0:
    echo "NV12 requires even width and height"
    quit(1)

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc makeSyntheticNv12(width, height: int): Nv12Image =
  ## Create a synthetic NV12 frame with enough texture to make JPEG quality
  ## differences show up in output size.
  result = allocNv12Image(width, height).get()

  # Y plane: gradient + checker/stripe pattern.
  for y in 0 ..< height:
    for x in 0 ..< width:
      let gradient = (x * 255) div max(1, width - 1)
      let vertical = (y * 96) div max(1, height - 1)
      let checker =
        if (((x div 32) xor (y div 32)) and 1) == 0:
          32
        else:
          -32
      var value = gradient + vertical + checker
      if value < 0:
        value = 0
      elif value > 255:
        value = 255
      result.y[y * result.strideY + x] = value.uint8

  # UV plane: mild chroma variation.
  # NV12 stores interleaved U,V for each 2x2 pixel block.
  let chromaHeight = height div 2
  for y in 0 ..< chromaHeight:
    for x in countup(0, width - 2, 2):
      let u = 96 + ((x * 64) div max(1, width - 1))
      let v = 160 - ((y * 64) div max(1, chromaHeight - 1))
      let idx = y * result.strideUV + x
      result.uv[idx] = u.uint8
      result.uv[idx + 1] = v.uint8

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc viewOf(image: var Nv12Image): Nm12ImageView =
  ## v4l2_jpeg currently names its NV12/NM12 input view as Nm12ImageView.
  result = Nm12ImageView(
    width: image.width.uint32,
    height: image.height.uint32,
    strideY: image.strideY.uint32,
    strideUV: image.strideUV.uint32,
    yData: addr image.y[0],
    uvData: addr image.uv[0]
  )

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc main(): JpegResult[void] =
  let (width, height) = parseSize()

  echo &"== input =="
  echo &"width  = {width}"
  echo &"height = {height}"

  var image = makeSyntheticNv12(width, height)
  let view = image.viewOf()

  var enc = ?JpegEncoder.open(width.uint32, height.uint32)
  defer:
    discard enc.close()

  let qualities = [30, 50, 70, 90, 95]
  var prevSize = 0

  echo ""
  echo "== encoded sizes =="
  for q in qualities:
    let jpeg = ?enc.encode(view, quality = q)
    echo &"quality={q:>3}: {jpeg.len:>9} bytes"

    if prevSize > 0:
      let delta = jpeg.len - prevSize
      echo &"             delta from previous: {delta:+} bytes"
    prevSize = jpeg.len

  echo ""
  echo "If quality control is working, sizes should generally increase as quality rises."
  echo "Exact monotonic behavior is driver-dependent, but quality=30 and quality=95 should differ."

when isMainModule:
  discard main()
