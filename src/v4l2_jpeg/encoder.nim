# ==============================================================================
# High-level JPEG encoder
# ==============================================================================

import std/[options, posix]
import ./errors
import ./bindings/[types, lowlevel]

# ==============================================================================
# Public types
# ==============================================================================

type
  Nm12ImageView* = object
    width*: uint32
    height*: uint32
    strideY*: uint32
    strideUV*: uint32
    yData*: pointer
    uvData*: pointer
  JpegEncoder* = ref object
    fd*: cint
    width*: uint32
    height*: uint32
    opened*: bool
    outputFmt*: V4l2Format
    captureFmt*: V4l2Format
    outputPlanes*: array[VIDEO_MAX_PLANES, V4l2Plane]
    capturePlanes*: array[VIDEO_MAX_PLANES, V4l2Plane]
    outputBuf*: V4l2Buffer
    captureBuf*: V4l2Buffer
    outputMap0*: pointer
    outputMap1*: pointer
    captureMap0*: pointer
    outputLen0*: int
    outputLen1*: int
    captureLen0*: int
    outputStreaming*: bool
    captureStreaming*: bool


# ==============================================================================
# Helpers
# ==============================================================================

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc bytesPerPlaneY(width, height: uint32): int =
  result = int(width * height)

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc bytesPerPlaneUV(width, height: uint32): int =
  result = int(width * height div 2)

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc closeIgnoreError(fd: cint) =
  discard close(fd)

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc unmapIgnoreError(p: pointer, length: int) =
  if p != nil and length > 0:
    discard munmap(p, length)

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc streamOffIgnoreError(fd: cint, bufType: uint32) =
  discard streamOff(fd, bufType)

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc releaseBuffersIgnoreError(fd: cint, bufType: uint32) =
  discard requestBuffers(fd, bufType, 0)

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc cleanupPartial(enc: var JpegEncoder) =
  if enc.isNil:
    return

  if enc.captureStreaming:
    streamOffIgnoreError(enc.fd, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
    enc.captureStreaming = false

  if enc.outputStreaming:
    streamOffIgnoreError(enc.fd, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
    enc.outputStreaming = false

  unmapIgnoreError(enc.captureMap0, enc.captureLen0)
  enc.captureMap0 = nil
  enc.captureLen0 = 0

  unmapIgnoreError(enc.outputMap1, enc.outputLen1)
  enc.outputMap1 = nil
  enc.outputLen1 = 0

  unmapIgnoreError(enc.outputMap0, enc.outputLen0)
  enc.outputMap0 = nil
  enc.outputLen0 = 0

  if enc.fd >= 0:
    releaseBuffersIgnoreError(enc.fd, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
    releaseBuffersIgnoreError(enc.fd, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
    closeIgnoreError(enc.fd)
    enc.fd = -1

  enc.opened = false

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc ensureDimensions(enc: JpegEncoder, src: Nm12ImageView): JpegResult[void] =
  if src.width != enc.width or src.height != enc.height:
    return err(makeError(
      "NM12 image size mismatch: expected " &
      $enc.width & "x" & $enc.height &
      ", got " & $src.width & "x" & $src.height
    ))

  if src.yData.isNil:
    return err(makeError("NM12 image yData is nil"))

  if src.uvData.isNil:
    return err(makeError("NM12 image uvData is nil"))

  if src.strideY < enc.width:
    return err(makeError("NM12 image strideY is smaller than width"))

  if src.strideUV < enc.width:
    return err(makeError("NM12 image strideUV is smaller than width"))

  ok()

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc copyNm12ToMappedBuffer(
    enc: JpegEncoder,
    src: Nm12ImageView
): JpegResult[void] =

  let dimCheck = ensureDimensions(enc, src)
  if dimCheck.isErr:
    return err(dimCheck.error)

  if src.strideY == enc.width:
    copyMem(enc.outputMap0, src.yData, bytesPerPlaneY(enc.width, enc.height))
  else:
    let rowBytes = int(enc.width)
    for y in 0 ..< int(enc.height):
      let dstRow = cast[pointer](cast[uint](enc.outputMap0) + uint(y * rowBytes))
      let srcRow = cast[pointer](cast[uint](src.yData) + uint(y * int(src.strideY)))
      copyMem(dstRow, srcRow, rowBytes)

  if src.strideUV == enc.width:
    copyMem(enc.outputMap1, src.uvData, bytesPerPlaneUV(enc.width, enc.height))
  else:
    let rowBytes = int(enc.width)
    let uvRows = int(enc.height div 2)
    for y in 0 ..< uvRows:
      let dstRow = cast[pointer](cast[uint](enc.outputMap1) + uint(y * rowBytes))
      let srcRow = cast[pointer](cast[uint](src.uvData) + uint(y * int(src.strideUV)))
      copyMem(dstRow, srcRow, rowBytes)

  ok()

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc prepareBuffersForQueue(enc: JpegEncoder) =
  zeroMem(addr enc.outputBuf, sizeof(enc.outputBuf))
  zeroMem(addr enc.captureBuf, sizeof(enc.captureBuf))
  zeroMem(addr enc.outputPlanes[0], sizeof(enc.outputPlanes))
  zeroMem(addr enc.capturePlanes[0], sizeof(enc.capturePlanes))

  enc.outputBuf.type_field = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE
  enc.outputBuf.memory = V4L2_MEMORY_MMAP
  enc.outputBuf.index = 0
  enc.outputBuf.length = 2
  enc.outputBuf.m.planes = addr enc.outputPlanes[0]

  enc.captureBuf.type_field = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE
  enc.captureBuf.memory = V4L2_MEMORY_MMAP
  enc.captureBuf.index = 0
  enc.captureBuf.length = 1
  enc.captureBuf.m.planes = addr enc.capturePlanes[0]

  enc.outputPlanes[0].bytesused = uint32(bytesPerPlaneY(enc.width, enc.height))
  enc.outputPlanes[1].bytesused = uint32(bytesPerPlaneUV(enc.width, enc.height))
  enc.capturePlanes[0].bytesused = 0'u32

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc initializeOutputBuffers(enc: var JpegEncoder): JpegResult[void] =
  let req = requestBuffers(enc.fd, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE, 1)
  if req.isErr:
    return err(req.error)

  zeroMem(addr enc.outputPlanes[0], sizeof(enc.outputPlanes))
  let q = queryBuffer(
    enc.fd,
    V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
    0,
    addr enc.outputPlanes[0]
  )
  if q.isErr:
    return err(q.error)

  enc.outputBuf = q.get

  enc.outputLen0 = int(enc.outputPlanes[0].length)
  enc.outputLen1 = int(enc.outputPlanes[1].length)

  let map0 = mapPlane(enc.fd, enc.outputLen0, Off(enc.outputPlanes[0].m.mem_offset))
  if map0.isErr:
    return err(map0.error)
  enc.outputMap0 = map0.get

  let map1 = mapPlane(enc.fd, enc.outputLen1, Off(enc.outputPlanes[1].m.mem_offset))
  if map1.isErr:
    unmapIgnoreError(enc.outputMap0, enc.outputLen0)
    enc.outputMap0 = nil
    enc.outputLen0 = 0
    return err(map1.error)
  enc.outputMap1 = map1.get

  ok()

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc initializeCaptureBuffers(enc: var JpegEncoder): JpegResult[void] =
  let req = requestBuffers(enc.fd, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE, 1)
  if req.isErr:
    return err(req.error)

  zeroMem(addr enc.capturePlanes[0], sizeof(enc.capturePlanes))
  let q = queryBuffer(
    enc.fd,
    V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
    0,
    addr enc.capturePlanes[0]
  )
  if q.isErr:
    return err(q.error)

  enc.captureBuf = q.get

  enc.captureLen0 = int(enc.capturePlanes[0].length)

  let map0 = mapPlane(enc.fd, enc.captureLen0, Off(enc.capturePlanes[0].m.mem_offset))
  if map0.isErr:
    return err(map0.error)
  enc.captureMap0 = map0.get

  ok()

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc startStreamingIfNeeded(enc: JpegEncoder): JpegResult[void] =
  if not enc.outputStreaming:
    let r = streamOn(enc.fd, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
    if r.isErr:
      return err(r.error)
    enc.outputStreaming = true

  if not enc.captureStreaming:
    let r = streamOn(enc.fd, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
    if r.isErr:
      if enc.outputStreaming:
        streamOffIgnoreError(enc.fd, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
        enc.outputStreaming = false
      return err(r.error)
    enc.captureStreaming = true

  ok()


# ==============================================================================
# Opening / closing encoder
# ==============================================================================

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc open*(
    _: type JpegEncoder,
    device: string = "/dev/video0",
    width: uint32,
    height: uint32
): JpegResult[JpegEncoder] =

  var enc = JpegEncoder(
    fd: -1,
    width: width,
    height: height
  )

  let fdResult = openDevice(device)
  if fdResult.isErr:
    return err(fdResult.error)
  enc.fd = fdResult.get

  let outFmt = setOutputFormatNm12m(enc.fd, width, height)
  if outFmt.isErr:
    cleanupPartial(enc)
    return err(outFmt.error)
  enc.outputFmt = outFmt.get

  let capFmt = setCaptureFormatJpeg(enc.fd, width, height)
  if capFmt.isErr:
    cleanupPartial(enc)
    return err(capFmt.error)
  enc.captureFmt = capFmt.get

  let initOut = initializeOutputBuffers(enc)
  if initOut.isErr:
    cleanupPartial(enc)
    return err(initOut.error)

  let initCap = initializeCaptureBuffers(enc)
  if initCap.isErr:
    cleanupPartial(enc)
    return err(initCap.error)

  enc.opened = true
  ok(enc)

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc close*(enc: var JpegEncoder): JpegResult[void] =
  if enc.isNil:
    return ok()

  cleanupPartial(enc)
  ok()


# ==============================================================================
# Encoding
# ==============================================================================

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc encode*(enc: JpegEncoder, src: Nm12ImageView): JpegResult[seq[uint8]] =
  if enc.isNil or not enc.opened:
    return err(makeError("JPEG encoder is not open"))

  let copyResult = copyNm12ToMappedBuffer(enc, src)
  if copyResult.isErr:
    return err(copyResult.error)

  prepareBuffersForQueue(enc)

  let qCap = queueBuffer(enc.fd, enc.captureBuf)
  if qCap.isErr:
    return err(qCap.error)

  let qOut = queueBuffer(enc.fd, enc.outputBuf)
  if qOut.isErr:
    return err(qOut.error)

  let stream = startStreamingIfNeeded(enc)
  if stream.isErr:
    return err(stream.error)

  let cmd = encoderCmdStart(enc.fd)
  if cmd.isErr:
    return err(cmd.error)

  var dqCap = enc.captureBuf
  let rDqCap = dequeueBuffer(enc.fd, dqCap)
  if rDqCap.isErr:
    return err(rDqCap.error)

  var dqOut = enc.outputBuf
  let rDqOut = dequeueBuffer(enc.fd, dqOut)
  if rDqOut.isErr:
    return err(rDqOut.error)

  let jpegLen = int(dqCap.m.planes[].bytesused)
  if jpegLen <= 0:
    return err(makeError("JPEG encoder returned empty output"))

  result = ok(newSeq[uint8](jpegLen))
  copyMem(addr result.get[0], enc.captureMap0, jpegLen)

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc encode*(
    enc: JpegEncoder,
    width, height: uint32,
    strideY, strideUV: uint32,
    yData, uvData: pointer
): JpegResult[seq[uint8]] =
  let view = Nm12ImageView(
    width: width,
    height: height,
    strideY: strideY,
    strideUV: strideUV,
    yData: yData,
    uvData: uvData
  )
  result = enc.encode(view)

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc encode*(
    enc: JpegEncoder,
    yData, uvData: pointer
): JpegResult[seq[uint8]] =
  result = enc.encode(
    enc.width,
    enc.height,
    enc.width,
    enc.width,
    yData,
    uvData
  )

# ==============================================================================
# Convenience helpers
# ==============================================================================

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
proc encodeNm12File*(
    enc: JpegEncoder,
    yData: pointer,
    uvData: pointer
): JpegResult[seq[uint8]] =
  let view = Nm12ImageView(
    width: enc.width,
    height: enc.height,
    strideY: enc.width,
    strideUV: enc.width,
    yData: yData,
    uvData: uvData
  )
  enc.encode(view)
