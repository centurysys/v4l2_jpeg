# ==============================================================================
# V4L2 JPEG device probing
# ==============================================================================

import std/[algorithm, options, os, strutils]

import ./bindings/[lowlevel, types]
import ./errors

# ==============================================================================
# Types
# ==============================================================================

type
  JpegDeviceInfo* = object
    path*: string
    driver*: string
    card*: string
    busInfo*: string
    caps*: uint32
    supportsM2M*: bool
    supportsOutputNv12*: bool
    supportsOutputNm12*: bool
    supportsCaptureJpeg*: bool

# ==============================================================================
# Internal helpers
# ==============================================================================

# ------------------------------------------------------------------------------
# cArrayToString
# ------------------------------------------------------------------------------
proc cArrayToString*[N: static int](buf: array[N, uint8]): string =
  var n = 0
  while n < N and buf[n] != 0'u8:
    inc n

  result = newString(n)
  for i in 0 ..< n:
    result[i] = char(buf[i])

# ------------------------------------------------------------------------------
# effectiveCaps
# ------------------------------------------------------------------------------
proc effectiveCaps(cap: V4l2Capability): uint32 =
  if (cap.capabilities and V4L2_CAP_DEVICE_CAPS) != 0'u32:
    result = cap.device_caps
  else:
    result = cap.capabilities

# ------------------------------------------------------------------------------
# hasM2MCapability
# ------------------------------------------------------------------------------
proc hasM2MCapability(caps: uint32): bool =
  result =
    ((caps and V4L2_CAP_VIDEO_M2M_MPLANE) != 0'u32) or
    ((caps and V4L2_CAP_VIDEO_M2M) != 0'u32)

# ------------------------------------------------------------------------------
# hasFormat
# ------------------------------------------------------------------------------
proc hasFormat(fd: cint, bufType: uint32, fourcc: uint32): JpegResult[bool] =
  var index = 0'u32

  while true:
    let res = enumFormat(fd, bufType, index)
    if res.isErr:
      return ok(false)

    let desc = res.get()
    if desc.pixelformat == fourcc:
      return ok(true)

    inc index

# ==============================================================================
# Public helpers
# ==============================================================================

# ------------------------------------------------------------------------------
# fourccString
# ------------------------------------------------------------------------------
proc fourccString*(v: uint32): string =
  result = newString(4)
  result[0] = char(v and 0xff'u32)
  result[1] = char((v shr 8) and 0xff'u32)
  result[2] = char((v shr 16) and 0xff'u32)
  result[3] = char((v shr 24) and 0xff'u32)

# ------------------------------------------------------------------------------
# isVideoDevice
# ------------------------------------------------------------------------------
proc isVideoDevice*(path: string): bool =
  result = path.extractFilename().startsWith("video")

# ------------------------------------------------------------------------------
# supportsOutputFormat
# ------------------------------------------------------------------------------
proc supportsOutputFormat*(path: string, fourcc: uint32): JpegResult[bool] =
  let fd = ?openDevice(path)
  defer:
    discard closeDevice(fd)

  result = hasFormat(fd, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE, fourcc)

# ------------------------------------------------------------------------------
# supportsCaptureFormat
# ------------------------------------------------------------------------------
proc supportsCaptureFormat*(path: string, fourcc: uint32): JpegResult[bool] =
  let fd = ?openDevice(path)
  defer:
    discard closeDevice(fd)

  result = hasFormat(fd, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE, fourcc)

# ------------------------------------------------------------------------------
# probeJpegEncoderDevice
# ------------------------------------------------------------------------------
proc probeJpegEncoderDevice*(path: string): JpegResult[JpegDeviceInfo] =
  let fd = ?openDevice(path)
  defer:
    discard closeDevice(fd)

  let cap = ?queryCapability(fd)
  let caps = effectiveCaps(cap)

  let supportsOutputNv12 = ?hasFormat(
    fd, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE, V4L2_PIX_FMT_NV12)
  let supportsOutputNm12 = ?hasFormat(
    fd, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE, V4L2_PIX_FMT_NV12M)
  let supportsCaptureJpeg = ?hasFormat(
    fd, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE, V4L2_PIX_FMT_JPEG)

  result = ok(JpegDeviceInfo(
    path: path,
    driver: cArrayToString(cap.driver),
    card: cArrayToString(cap.card),
    busInfo: cArrayToString(cap.bus_info),
    caps: caps,
    supportsM2M: hasM2MCapability(caps),
    supportsOutputNv12: supportsOutputNv12,
    supportsOutputNm12: supportsOutputNm12,
    supportsCaptureJpeg: supportsCaptureJpeg
  ))

# ------------------------------------------------------------------------------
# isJpegEncoderDevice
# ------------------------------------------------------------------------------
proc isJpegEncoderDevice*(path: string): JpegResult[bool] =
  let info = ?probeJpegEncoderDevice(path)

  result = ok(
    info.supportsM2M and
    (info.supportsOutputNv12 or info.supportsOutputNm12) and
    info.supportsCaptureJpeg
  )

# ------------------------------------------------------------------------------
# listVideoDevices
# ------------------------------------------------------------------------------
proc listVideoDevices*(): seq[string] =
  result = @[]

  for path in walkPattern("/dev/video*"):
    if isVideoDevice(path):
      result.add(path)

  result.sort()

# ------------------------------------------------------------------------------
# listJpegEncoderDevices
# ------------------------------------------------------------------------------
proc listJpegEncoderDevices*(): JpegResult[seq[JpegDeviceInfo]] =
  var devices: seq[JpegDeviceInfo] = @[]

  for path in listVideoDevices():
    let probeRes = probeJpegEncoderDevice(path)
    if probeRes.isErr:
      continue

    let info = probeRes.get()
    if info.supportsM2M and
        (info.supportsOutputNv12 or info.supportsOutputNm12) and
        info.supportsCaptureJpeg:
      devices.add(info)

  result = ok(devices)

# ------------------------------------------------------------------------------
# findJpegEncoderDevice
# ------------------------------------------------------------------------------
proc findJpegEncoderDevice*(): JpegResult[Option[JpegDeviceInfo]] =
  let devices = ?listJpegEncoderDevices()

  if devices.len == 0:
    result = ok(none(JpegDeviceInfo))
  else:
    result = ok(some(devices[0]))
