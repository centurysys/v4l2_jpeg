#pragma once

#include <stdint.h>
#include <linux/videodev2.h>

#ifdef __cplusplus
extern "C" {
#endif

extern const uint32_t v4l2_jpeg_v4l2_pix_fmt_jpeg;
extern const uint32_t v4l2_jpeg_v4l2_pix_fmt_nv12;
extern const uint32_t v4l2_jpeg_v4l2_pix_fmt_nv12m;
extern const uint32_t v4l2_jpeg_v4l2_pix_fmt_nv21;
extern const uint32_t v4l2_jpeg_v4l2_pix_fmt_nv21m;

extern const uint32_t v4l2_jpeg_v4l2_buf_type_video_capture_mplane;
extern const uint32_t v4l2_jpeg_v4l2_buf_type_video_output_mplane;
extern const uint32_t v4l2_jpeg_v4l2_memory_mmap;

extern const uint32_t v4l2_jpeg_v4l2_colorspace_jpeg;
extern const uint32_t v4l2_jpeg_v4l2_field_none;

extern const uint32_t v4l2_jpeg_v4l2_cap_video_m2m;
extern const uint32_t v4l2_jpeg_v4l2_cap_video_m2m_mplane;
extern const uint32_t v4l2_jpeg_v4l2_cap_streaming;
extern const uint32_t v4l2_jpeg_v4l2_cap_device_caps;

extern const uint32_t v4l2_jpeg_v4l2_enc_cmd_start;
extern const uint32_t v4l2_jpeg_v4l2_enc_cmd_stop;

extern const unsigned long v4l2_jpeg_vidioc_querycap;
extern const unsigned long v4l2_jpeg_vidioc_enum_fmt;
extern const unsigned long v4l2_jpeg_vidioc_s_fmt;
extern const unsigned long v4l2_jpeg_vidioc_g_fmt;
extern const unsigned long v4l2_jpeg_vidioc_reqbufs;
extern const unsigned long v4l2_jpeg_vidioc_querybuf;
extern const unsigned long v4l2_jpeg_vidioc_qbuf;
extern const unsigned long v4l2_jpeg_vidioc_dqbuf;
extern const unsigned long v4l2_jpeg_vidioc_streamon;
extern const unsigned long v4l2_jpeg_vidioc_streamoff;
extern const unsigned long v4l2_jpeg_vidioc_encoder_cmd;

#ifdef __cplusplus
}
#endif
