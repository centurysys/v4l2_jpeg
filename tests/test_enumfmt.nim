# ==============================================================================
# Test: enumerate V4L2 formats for video devices
# ==============================================================================

import std/[os, strformat, strutils]

import v4l2_jpeg/bindings/[lowlevel, types]
import v4l2_jpeg/errors

# ==============================================================================
# Helpers
# ==============================================================================

# ------------------------------------------------------------------------------
# fourccString
# ------------------------------------------------------------------------------
proc fourccString(v: uint32): string =
  result = newString(4)
  result[0] = char(v and 0xff'u32)
  result[1] = char((v shr 8) and 0xff'u32)
  result[2] = char((v shr 16) and 0xff'u32)
  result[3] = char((v shr 24) and 0xff'u32)

# ------------------------------------------------------------------------------
# descriptionString
# ------------------------------------------------------------------------------
proc descriptionString(desc: V4l2FormatDescription): string =
  result = ""
  for ch in desc.description:
    if ch == 0:
      break
    result.add(char(ch))

# ------------------------------------------------------------------------------
# printFormats
# ------------------------------------------------------------------------------
proc printFormats(fd: cint, label: string, bufType: uint32) =
  echo &"  [{label}]"

  var index = 0'u32
  var count = 0

  while true:
    let res = enumFormat(fd, bufType, index)
    if res.isErr:
      if index == 0'u32:
        echo "    <none or not supported>"
      break

    let desc = res.get()
    echo &"    {index}: {fourccString(desc.pixelformat)}  {descriptionString(desc)}"
    inc index
    inc count

# ==============================================================================
# Main
# ==============================================================================

let devices =
  if paramCount() > 0:
    commandLineParams()
  else:
    @["/dev/video0", "/dev/video1", "/dev/video2", "/dev/video3"]

for path in devices:
  echo path

  let fdRes = openDevice(path)
  if fdRes.isErr:
    echo &"  open error: {fdRes.error.msg}"
    continue

  let fd = fdRes.get()
  defer:
    discard closeDevice(fd)

  let capRes = queryCapability(fd)
  if capRes.isErr:
    echo &"  querycap error: {capRes.error.msg}"
    continue

  let cap = capRes.get()
  let caps =
    if (cap.capabilities and V4L2_CAP_DEVICE_CAPS) != 0'u32:
      cap.device_caps
    else:
      cap.capabilities

  echo &"  caps=0x{caps.toHex(8)}"

  printFormats(fd, "OUTPUT_MPLANE", V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
  printFormats(fd, "CAPTURE_MPLANE", V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
