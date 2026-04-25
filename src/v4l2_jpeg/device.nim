# ------------------------------------------------------------------------------
# Device probe (minimal)
# ------------------------------------------------------------------------------

import std/[posix, strutils]

import ./bindings/[lowlevel, types]
import ./errors

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc isVideoDevice*(path: string): bool =
  result = path.startsWith("/dev/video")

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc isJpegEncoderDevice*(path: string): JpegResult[bool] =
  let fd = ?openDevice(path)
  defer:
    discard closeDevice(fd)

  let cap = ?queryCapability(fd)

  # device_caps が有効ならそっちを使う
  let caps =
    if (cap.capabilities and V4L2_CAP_DEVICE_CAPS) != 0'u32:
      cap.device_caps
    else:
      cap.capabilities

  let isM2M =
    (caps and V4L2_CAP_VIDEO_M2M_MPLANE) != 0'u32 or
    (caps and V4L2_CAP_VIDEO_M2M) != 0'u32

  result = ok(isM2M)
