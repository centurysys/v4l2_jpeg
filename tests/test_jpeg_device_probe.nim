# ------------------------------------------------------------------------------
# Test: JPEG encoder device probe
# ------------------------------------------------------------------------------

import std/[options, strformat]

import v4l2_jpeg

# ------------------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------------------
proc yesNo(v: bool): string =
  if v:
    result = "yes"
  else:
    result = "no"

# ------------------------------------------------------------------------------
# Main
# ------------------------------------------------------------------------------
when isMainModule:
  echo "== video devices =="

  let devices = listVideoDevices()
  if devices.len == 0:
    echo "no /dev/video* devices found"
  else:
    for path in devices:
      let probed = probeJpegEncoderDevice(path)
      if probed.isErr:
        echo &"{path}: error: {probed.error.msg}"
        continue

      let info = probed.get()
      echo &"{path}:"
      echo &"  driver              : {info.driver}"
      echo &"  card                : {info.card}"
      echo &"  busInfo             : {info.busInfo}"
      echo &"  m2m                 : {yesNo(info.supportsM2m)}"
      echo &"  output NV12         : {yesNo(info.supportsOutputNv12)}"
      echo &"  output NM12/NV12M   : {yesNo(info.supportsOutputNm12)}"
      echo &"  capture JPEG        : {yesNo(info.supportsCaptureJpeg)}"

  echo ""
  echo "== usable JPEG encoders =="

  let encoders = listJpegEncoderDevices()
  if encoders.isErr:
    echo &"error: {encoders.error.msg}"
  elif encoders.get().len == 0:
    echo "none"
  else:
    for info in encoders.get():
      echo &"{info.path}: {info.driver} / {info.card}"

  echo ""
  echo "== first usable JPEG encoder =="

  let first = findJpegEncoderDevice()
  if first.isErr:
    echo &"error: {first.error.msg}"
  elif first.get().isSome:
    let info = first.get().get()
    echo &"{info.path}: {info.driver} / {info.card}"
  else:
    echo "none"
