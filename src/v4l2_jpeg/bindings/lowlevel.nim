# ==============================================================================
# Low-level V4L2 JPEG encoder bindings (Result-based, no exceptions)
# ==============================================================================
import std/[posix, oserrors]
import ../errors
import ./types

# ==============================================================================
# Helpers
# ==============================================================================

# ------------------------------------------------------------------------------
# xioctl
# ------------------------------------------------------------------------------
proc xioctl*(fd: cint, request: culong, argp: pointer, opName: string):
    JpegResult[cint] =
  while true:
    let rc = ioctl(fd, request, argp)
    if rc >= 0:
      return ok(rc)
    let errc = osLastError()
    if errc == OSErrorCode(EINTR):
      continue
    return err(makeIoctlError(opName))


# ==============================================================================
# Device
# ==============================================================================

# ------------------------------------------------------------------------------
# openDevice
# ------------------------------------------------------------------------------
proc openDevice*(path: string): JpegResult[cint] =
  let fd = open(path, O_RDWR)
  if fd < 0:
    return err(makeIoctlError("open"))
  ok(fd)

# ------------------------------------------------------------------------------
# closeDevice
# ------------------------------------------------------------------------------
proc closeDevice*(fd: cint): JpegResult[void] =
  if close(fd) < 0:
    return err(makeIoctlError("close"))
  ok()

# ------------------------------------------------------------------------------
# Capability
# ------------------------------------------------------------------------------
proc queryCapability*(fd: cint): JpegResult[V4l2Capability] =
  var cap: V4l2Capability

  if ioctl(fd, VIDIOC_QUERYCAP, addr cap) < 0:
    return failIoctl[V4l2Capability]("VIDIOC_QUERYCAP")

  result = ok(cap)


# ------------------------------------------------------------------------------
# enumFormat
# ------------------------------------------------------------------------------
proc enumFormat*(fd: cint, bufType: uint32, index: uint32):
    JpegResult[V4l2FormatDescription] =
  var desc: V4l2FormatDescription
  zeroMem(addr desc, sizeof(desc))
  desc.index = index
  desc.type_field = bufType

  let rc = xioctl(fd, VIDIOC_ENUM_FMT, addr desc, "VIDIOC_ENUM_FMT")
  if rc.isErr:
    return err(rc.error)

  result = ok(desc)

# ==============================================================================
# Format
# ==============================================================================

# ------------------------------------------------------------------------------
# setOutputFormatNm12m
# ------------------------------------------------------------------------------
proc setOutputFormatNm12m*(fd: cint, width, height: uint32,
    colorspace: uint32 = V4L2_COLORSPACE_SRGB): JpegResult[V4l2Format] =
  var fmt: V4l2Format
  zeroMem(addr fmt, sizeof(fmt))
  fmt.type_field = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE
  fmt.fmt.pix_mp.width = width
  fmt.fmt.pix_mp.height = height
  fmt.fmt.pix_mp.pixelformat = V4L2_PIX_FMT_NV12M
  fmt.fmt.pix_mp.colorspace = colorspace
  let rc = xioctl(fd, VIDIOC_S_FMT, addr fmt, "VIDIOC_S_FMT OUTPUT")
  if rc.isErr:
    return err(rc.error)
  zeroMem(addr fmt, sizeof(fmt))
  discard xioctl(fd, VIDIOC_G_FMT, addr fmt, "VIDIOC_G_FMT OUTPUT")
  ok(fmt)

# ------------------------------------------------------------------------------
# setCaptureFormatJpeg
# ------------------------------------------------------------------------------
proc setCaptureFormatJpeg*(fd: cint, width, height: uint32): JpegResult[V4l2Format] =
  var fmt: V4l2Format
  zeroMem(addr fmt, sizeof(fmt))
  fmt.type_field = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE
  fmt.fmt.pix_mp.width = width
  fmt.fmt.pix_mp.height = height
  fmt.fmt.pix_mp.pixelformat = V4L2_PIX_FMT_JPEG
  fmt.fmt.pix_mp.colorspace = V4L2_COLORSPACE_JPEG
  let rc = xioctl(fd, VIDIOC_S_FMT, addr fmt, "VIDIOC_S_FMT CAPTURE")
  if rc.isErr:
    return err(rc.error)
  ok(fmt)

# ==============================================================================
# Buffers
# ==============================================================================

# ------------------------------------------------------------------------------
# requestBuffers
# ------------------------------------------------------------------------------
proc requestBuffers*(fd: cint, bufType: uint32, count: uint32):
    JpegResult[V4l2RequestBuffers] =
  var req: V4l2RequestBuffers
  zeroMem(addr req, sizeof(req))
  req.count = count
  req.type_field = bufType
  req.memory = V4L2_MEMORY_MMAP
  let rc = xioctl(fd, VIDIOC_REQBUFS, addr req, "VIDIOC_REQBUFS")
  if rc.isErr:
    return err(rc.error)
  ok(req)

# ------------------------------------------------------------------------------
# queryBuffer
# ------------------------------------------------------------------------------
proc queryBuffer*(fd: cint, bufType: uint32, index: uint32, planes: ptr V4l2Plane):
    JpegResult[V4l2Buffer] =
  var buf: V4l2Buffer
  zeroMem(addr buf, sizeof(buf))
  buf.type_field = bufType
  buf.memory = V4L2_MEMORY_MMAP
  buf.index = index
  buf.length = VIDEO_MAX_PLANES
  buf.m.planes = planes
  let rc = xioctl(fd, VIDIOC_QUERYBUF, addr buf, "VIDIOC_QUERYBUF")
  if rc.isErr:
    return err(rc.error)
  ok(buf)

# ==============================================================================
# mmap
# ==============================================================================

# ------------------------------------------------------------------------------
# mapPlane
# ------------------------------------------------------------------------------
proc mapPlane*(fd: cint, length: int, offset: Off): JpegResult[pointer] =
  let p = mmap(nil, length, PROT_READ or PROT_WRITE, MAP_SHARED, fd, offset)
  if p == cast[pointer](-1):
    return err(makeIoctlError("mmap"))
  ok(p)

# ------------------------------------------------------------------------------
# unmapPlane
# ------------------------------------------------------------------------------
proc unmapPlane*(p: pointer, length: int): JpegResult[void] =
  if p != nil:
    if munmap(p, length) < 0:
      return err(makeIoctlError("munmap"))
  ok()


# ==============================================================================
# Queue / Dequeue
# ==============================================================================

# ------------------------------------------------------------------------------
# queueBuffer
# ------------------------------------------------------------------------------
proc queueBuffer*(fd: cint, buf: var V4l2Buffer): JpegResult[void] =
  let rc = xioctl(fd, VIDIOC_QBUF, addr buf, "VIDIOC_QBUF")
  if rc.isErr:
    return err(rc.error)
  ok()

# ------------------------------------------------------------------------------
# dequeueBuffer
# ------------------------------------------------------------------------------
proc dequeueBuffer*(fd: cint, buf: var V4l2Buffer): JpegResult[void] =
  let rc = xioctl(fd, VIDIOC_DQBUF, addr buf, "VIDIOC_DQBUF")
  if rc.isErr:
    return err(rc.error)
  ok()

# ==============================================================================
# Stream
# ==============================================================================

# ------------------------------------------------------------------------------
# streamOn
# ------------------------------------------------------------------------------
proc streamOn*(fd: cint, bufType: uint32): JpegResult[void] =
  var t = bufType
  let rc = xioctl(fd, VIDIOC_STREAMON, addr t, "VIDIOC_STREAMON")
  if rc.isErr:
    return err(rc.error)
  ok()

# ------------------------------------------------------------------------------
# streamOff
# ------------------------------------------------------------------------------
proc streamOff*(fd: cint, bufType: uint32): JpegResult[void] =
  var t = bufType
  let rc = xioctl(fd, VIDIOC_STREAMOFF, addr t, "VIDIOC_STREAMOFF")
  if rc.isErr:
    return err(rc.error)
  ok()


# ==============================================================================
# Controls
# ==============================================================================

# ------------------------------------------------------------------------------
# setControl
# ------------------------------------------------------------------------------
proc setControl*(fd: cint, id: uint32, value: int32): JpegResult[void] =
  var ctrl: V4l2Control
  zeroMem(addr ctrl, sizeof(ctrl))
  ctrl.id = id
  ctrl.value = value

  let rc = xioctl(fd, VIDIOC_S_CTRL, addr ctrl, "VIDIOC_S_CTRL")
  if rc.isErr:
    return err(rc.error)

  result = ok()

# ------------------------------------------------------------------------------
# setJpegQuality
# ------------------------------------------------------------------------------
proc setJpegQuality*(fd: cint, quality: int): JpegResult[void] =
  if quality < 1 or quality > 100:
    return err(makeError("JPEG quality must be in the range 1..100"))

  result = setControl(
    fd,
    V4L2_CID_JPEG_COMPRESSION_QUALITY,
    quality.int32
  )

# ==============================================================================
# Encoder control
# ==============================================================================

# ------------------------------------------------------------------------------
# encoderCmdStart
# ------------------------------------------------------------------------------
proc encoderCmdStart*(fd: cint): JpegResult[void] =
  var cmd: V4l2EncoderCmd
  zeroMem(addr cmd, sizeof(cmd))
  cmd.cmd = V4L2_ENC_CMD_START
  let rc = xioctl(fd, VIDIOC_ENCODER_CMD, addr cmd, "VIDIOC_ENCODER_CMD")
  if rc.isErr:
    return err(rc.error)
  ok()
