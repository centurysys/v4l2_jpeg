# tests/test_querycap.nim

import v4l2_jpeg
import v4l2_jpeg/device

for dev in ["/dev/video0", "/dev/video1", "/dev/video2"]:
  let res = isJpegEncoderDevice(dev)
  if res.isOk:
    echo dev, " => ", res.get()
  else:
    echo dev, " => error"
