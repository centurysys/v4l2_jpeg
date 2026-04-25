## Thin type/constant bridge for V4L2 bindings.
##
## This module intentionally keeps the generated bindings separate from
## constants that are easier and safer to materialize through the C compiler.

import std/[os, posix]

const thisDir = currentSourcePath.parentDir()

{.passC: "-I" & thisDir.}
{.compile: "v4l2_consts.c".}

import ./generated/videodev2_gen

proc ioctl*(fd: cint, request: culong, argp: pointer): cint
  {.importc, header: "<sys/ioctl.h>".}

var
  V4L2_PIX_FMT_JPEG* {.importc: "v4l2_jpeg_v4l2_pix_fmt_jpeg", header: "v4l2_consts.h".}: uint32
  V4L2_PIX_FMT_NV12* {.importc: "v4l2_jpeg_v4l2_pix_fmt_nv12", header: "v4l2_consts.h".}: uint32
  V4L2_PIX_FMT_NV12M* {.importc: "v4l2_jpeg_v4l2_pix_fmt_nv12m", header: "v4l2_consts.h".}: uint32
  V4L2_PIX_FMT_NV21* {.importc: "v4l2_jpeg_v4l2_pix_fmt_nv21", header: "v4l2_consts.h".}: uint32
  V4L2_PIX_FMT_NV21M* {.importc: "v4l2_jpeg_v4l2_pix_fmt_nv21m", header: "v4l2_consts.h".}: uint32

  V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE* {.importc: "v4l2_jpeg_v4l2_buf_type_video_capture_mplane", header: "v4l2_consts.h".}: uint32
  V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE* {.importc: "v4l2_jpeg_v4l2_buf_type_video_output_mplane", header: "v4l2_consts.h".}: uint32
  V4L2_MEMORY_MMAP* {.importc: "v4l2_jpeg_v4l2_memory_mmap", header: "v4l2_consts.h".}: uint32
  V4L2_COLORSPACE_JPEG* {.importc: "v4l2_jpeg_v4l2_colorspace_jpeg", header: "v4l2_consts.h".}: uint32
  V4L2_FIELD_NONE* {.importc: "v4l2_jpeg_v4l2_field_none", header: "v4l2_consts.h".}: uint32
  V4L2_ENC_CMD_START* {.importc: "v4l2_jpeg_v4l2_enc_cmd_start", header: "v4l2_consts.h".}: uint32
  V4L2_ENC_CMD_STOP* {.importc: "v4l2_jpeg_v4l2_enc_cmd_stop", header: "v4l2_consts.h".}: uint32

  VIDIOC_QUERYCAP* {.importc: "v4l2_jpeg_vidioc_querycap", header: "v4l2_consts.h".}: culong
  VIDIOC_S_FMT* {.importc: "v4l2_jpeg_vidioc_s_fmt", header: "v4l2_consts.h".}: culong
  VIDIOC_G_FMT* {.importc: "v4l2_jpeg_vidioc_g_fmt", header: "v4l2_consts.h".}: culong
  VIDIOC_REQBUFS* {.importc: "v4l2_jpeg_vidioc_reqbufs", header: "v4l2_consts.h".}: culong
  VIDIOC_QUERYBUF* {.importc: "v4l2_jpeg_vidioc_querybuf", header: "v4l2_consts.h".}: culong
  VIDIOC_QBUF* {.importc: "v4l2_jpeg_vidioc_qbuf", header: "v4l2_consts.h".}: culong
  VIDIOC_DQBUF* {.importc: "v4l2_jpeg_vidioc_dqbuf", header: "v4l2_consts.h".}: culong
  VIDIOC_STREAMON* {.importc: "v4l2_jpeg_vidioc_streamon", header: "v4l2_consts.h".}: culong
  VIDIOC_STREAMOFF* {.importc: "v4l2_jpeg_vidioc_streamoff", header: "v4l2_consts.h".}: culong
  VIDIOC_ENCODER_CMD* {.importc: "v4l2_jpeg_vidioc_encoder_cmd", header: "v4l2_consts.h".}: culong

type
  V4l2Plane* = struct_v4l2_plane
  V4l2Buffer* = struct_v4l2_buffer
  V4l2Format* = struct_v4l2_format
  V4l2RequestBuffers* = struct_v4l2_requestbuffers
  V4l2Capability* = struct_v4l2_capability
  V4l2EncoderCmd* = struct_v4l2_encoder_cmd

const
  VIDEO_MAX_PLANES* = 8
  V4L2_COLORSPACE_SRGB* = 8'u32
