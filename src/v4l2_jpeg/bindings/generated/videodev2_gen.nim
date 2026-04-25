
type
  enum_v4l2_field* {.size: sizeof(cuint).} = enum
    V4L2_FIELD_ANY = 0, V4L2_FIELD_NONE = 1, V4L2_FIELD_TOP = 2,
    V4L2_FIELD_BOTTOM = 3, V4L2_FIELD_INTERLACED = 4, V4L2_FIELD_SEQ_TB = 5,
    V4L2_FIELD_SEQ_BT = 6, V4L2_FIELD_ALTERNATE = 7,
    V4L2_FIELD_INTERLACED_TB = 8, V4L2_FIELD_INTERLACED_BT = 9
type
  enum_v4l2_buf_type* {.size: sizeof(cuint).} = enum
    V4L2_BUF_TYPE_VIDEO_CAPTURE = 1, V4L2_BUF_TYPE_VIDEO_OUTPUT = 2,
    V4L2_BUF_TYPE_VIDEO_OVERLAY = 3, V4L2_BUF_TYPE_VBI_CAPTURE = 4,
    V4L2_BUF_TYPE_VBI_OUTPUT = 5, V4L2_BUF_TYPE_SLICED_VBI_CAPTURE = 6,
    V4L2_BUF_TYPE_SLICED_VBI_OUTPUT = 7, V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY = 8,
    V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE = 9,
    V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE = 10, V4L2_BUF_TYPE_SDR_CAPTURE = 11,
    V4L2_BUF_TYPE_SDR_OUTPUT = 12, V4L2_BUF_TYPE_META_CAPTURE = 13,
    V4L2_BUF_TYPE_META_OUTPUT = 14, V4L2_BUF_TYPE_PRIVATE = 128
type
  enum_v4l2_tuner_type* {.size: sizeof(cuint).} = enum
    V4L2_TUNER_RADIO = 1, V4L2_TUNER_ANALOG_TV = 2, V4L2_TUNER_DIGITAL_TV = 3,
    V4L2_TUNER_SDR = 4, V4L2_TUNER_RF = 5
type
  enum_v4l2_memory* {.size: sizeof(cuint).} = enum
    V4L2_MEMORY_MMAP = 1, V4L2_MEMORY_USERPTR = 2, V4L2_MEMORY_OVERLAY = 3,
    V4L2_MEMORY_DMABUF = 4
type
  enum_v4l2_colorspace* {.size: sizeof(cuint).} = enum
    V4L2_COLORSPACE_DEFAULT = 0, V4L2_COLORSPACE_SMPTE170M = 1,
    V4L2_COLORSPACE_SMPTE240M = 2, V4L2_COLORSPACE_REC709 = 3,
    V4L2_COLORSPACE_BT878 = 4, V4L2_COLORSPACE_470_SYSTEM_M = 5,
    V4L2_COLORSPACE_470_SYSTEM_BG = 6, V4L2_COLORSPACE_JPEG = 7,
    V4L2_COLORSPACE_SRGB = 8, V4L2_COLORSPACE_OPRGB = 9,
    V4L2_COLORSPACE_BT2020 = 10, V4L2_COLORSPACE_RAW = 11,
    V4L2_COLORSPACE_DCI_P3 = 12
type
  enum_v4l2_xfer_func* {.size: sizeof(cuint).} = enum
    V4L2_XFER_FUNC_DEFAULT = 0, V4L2_XFER_FUNC_709 = 1, V4L2_XFER_FUNC_SRGB = 2,
    V4L2_XFER_FUNC_OPRGB = 3, V4L2_XFER_FUNC_SMPTE240M = 4,
    V4L2_XFER_FUNC_NONE = 5, V4L2_XFER_FUNC_DCI_P3 = 6,
    V4L2_XFER_FUNC_SMPTE2084 = 7
type
  enum_v4l2_ycbcr_encoding* {.size: sizeof(cuint).} = enum
    V4L2_YCBCR_ENC_DEFAULT = 0, V4L2_YCBCR_ENC_601 = 1, V4L2_YCBCR_ENC_709 = 2,
    V4L2_YCBCR_ENC_XV601 = 3, V4L2_YCBCR_ENC_XV709 = 4, V4L2_YCBCR_ENC_SYCC = 5,
    V4L2_YCBCR_ENC_BT2020 = 6, V4L2_YCBCR_ENC_BT2020_CONST_LUM = 7,
    V4L2_YCBCR_ENC_SMPTE240M = 8
type
  enum_v4l2_hsv_encoding* {.size: sizeof(cuint).} = enum
    V4L2_HSV_ENC_180 = 128, V4L2_HSV_ENC_256 = 129
type
  enum_v4l2_quantization* {.size: sizeof(cuint).} = enum
    V4L2_QUANTIZATION_DEFAULT = 0, V4L2_QUANTIZATION_FULL_RANGE = 1,
    V4L2_QUANTIZATION_LIM_RANGE = 2
type
  enum_v4l2_priority* {.size: sizeof(cuint).} = enum
    V4L2_PRIORITY_UNSET = 0, V4L2_PRIORITY_BACKGROUND = 1,
    V4L2_PRIORITY_INTERACTIVE = 2, V4L2_PRIORITY_RECORD = 3
const
  V4L2_PRIORITY_DEFAULT* = enum_v4l2_priority.V4L2_PRIORITY_INTERACTIVE
type
  enum_v4l2_frmsizetypes* {.size: sizeof(cuint).} = enum
    V4L2_FRMSIZE_TYPE_DISCRETE = 1, V4L2_FRMSIZE_TYPE_CONTINUOUS = 2,
    V4L2_FRMSIZE_TYPE_STEPWISE = 3
type
  enum_v4l2_frmivaltypes* {.size: sizeof(cuint).} = enum
    V4L2_FRMIVAL_TYPE_DISCRETE = 1, V4L2_FRMIVAL_TYPE_CONTINUOUS = 2,
    V4L2_FRMIVAL_TYPE_STEPWISE = 3
type
  enum_v4l2_ctrl_type* {.size: sizeof(cuint).} = enum
    V4L2_CTRL_TYPE_INTEGER = 1, V4L2_CTRL_TYPE_BOOLEAN = 2,
    V4L2_CTRL_TYPE_MENU = 3, V4L2_CTRL_TYPE_BUTTON = 4,
    V4L2_CTRL_TYPE_INTEGER64 = 5, V4L2_CTRL_TYPE_CTRL_CLASS = 6,
    V4L2_CTRL_TYPE_STRING = 7, V4L2_CTRL_TYPE_BITMASK = 8,
    V4L2_CTRL_TYPE_INTEGER_MENU = 9, V4L2_CTRL_COMPOUND_TYPES = 256,
    V4L2_CTRL_TYPE_U16 = 257, V4L2_CTRL_TYPE_U32 = 258,
    V4L2_CTRL_TYPE_AREA = 262, V4L2_CTRL_TYPE_HDR10_CLL_INFO = 272,
    V4L2_CTRL_TYPE_HDR10_MASTERING_DISPLAY = 273, V4L2_CTRL_TYPE_H264_SPS = 512,
    V4L2_CTRL_TYPE_H264_PPS = 513, V4L2_CTRL_TYPE_H264_SCALING_MATRIX = 514,
    V4L2_CTRL_TYPE_H264_SLICE_PARAMS = 515,
    V4L2_CTRL_TYPE_H264_DECODE_PARAMS = 516,
    V4L2_CTRL_TYPE_H264_PRED_WEIGHTS = 517, V4L2_CTRL_TYPE_FWHT_PARAMS = 544,
    V4L2_CTRL_TYPE_VP8_FRAME = 576, V4L2_CTRL_TYPE_MPEG2_QUANTISATION = 592,
    V4L2_CTRL_TYPE_MPEG2_SEQUENCE = 593, V4L2_CTRL_TYPE_MPEG2_PICTURE = 594,
    V4L2_CTRL_TYPE_VP9_COMPRESSED_HDR = 608, V4L2_CTRL_TYPE_VP9_FRAME = 609,
    V4L2_CTRL_TYPE_HEVC_SPS = 624, V4L2_CTRL_TYPE_HEVC_PPS = 625,
    V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS = 626,
    V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX = 627,
    V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS = 628, V4L2_CTRL_TYPE_AV1_SEQUENCE = 640,
    V4L2_CTRL_TYPE_AV1_TILE_GROUP_ENTRY = 641, V4L2_CTRL_TYPE_AV1_FRAME = 642,
    V4L2_CTRL_TYPE_AV1_FILM_GRAIN = 643
const
  V4L2_CTRL_TYPE_U8* = enum_v4l2_ctrl_type.V4L2_CTRL_COMPOUND_TYPES
type
  enum_v4l2_av1_frame_type* {.size: sizeof(cuint).} = enum
    V4L2_AV1_KEY_FRAME = 0, V4L2_AV1_INTER_FRAME = 1,
    V4L2_AV1_INTRA_ONLY_FRAME = 2, V4L2_AV1_SWITCH_FRAME = 3
type
  enum_v4l2_av1_interpolation_filter* {.size: sizeof(cuint).} = enum
    V4L2_AV1_INTERPOLATION_FILTER_EIGHTTAP = 0,
    V4L2_AV1_INTERPOLATION_FILTER_EIGHTTAP_SMOOTH = 1,
    V4L2_AV1_INTERPOLATION_FILTER_EIGHTTAP_SHARP = 2,
    V4L2_AV1_INTERPOLATION_FILTER_BILINEAR = 3,
    V4L2_AV1_INTERPOLATION_FILTER_SWITCHABLE = 4
type
  enum_v4l2_av1_tx_mode* {.size: sizeof(cuint).} = enum
    V4L2_AV1_TX_MODE_ONLY_4X4 = 0, V4L2_AV1_TX_MODE_LARGEST = 1,
    V4L2_AV1_TX_MODE_SELECT = 2
type
  enum_v4l2_av1_frame_restoration_type* {.size: sizeof(cuint).} = enum
    V4L2_AV1_FRAME_RESTORE_NONE = 0, V4L2_AV1_FRAME_RESTORE_WIENER = 1,
    V4L2_AV1_FRAME_RESTORE_SGRPROJ = 2, V4L2_AV1_FRAME_RESTORE_SWITCHABLE = 3
type
  enum_v4l2_av1_warp_model* {.size: sizeof(cuint).} = enum
    V4L2_AV1_WARP_MODEL_IDENTITY = 0, V4L2_AV1_WARP_MODEL_TRANSLATION = 1,
    V4L2_AV1_WARP_MODEL_ROTZOOM = 2, V4L2_AV1_WARP_MODEL_AFFINE = 3
type
  V4L2_PIX_FMT_NV12_16L16* = object
type
  V4L2_PIX_FMT_NV12_32L32* = object
type
  struct_v4l2_rect* {.pure, inheritable, bycopy.} = object
    left*: compiler_s32      ## Generated based on /usr/include/linux/videodev2.h:407:8
    top*: compiler_s32
    width*: compiler_u32
    height*: compiler_u32
  compiler_s32* = cint       ## Generated based on /usr/include/asm-generic/int-ll64.h:26:24
  compiler_u32* = cuint      ## Generated based on /usr/include/asm-generic/int-ll64.h:27:22
  struct_v4l2_fract* {.pure, inheritable, bycopy.} = object
    numerator*: compiler_u32 ## Generated based on /usr/include/linux/videodev2.h:414:8
    denominator*: compiler_u32
  struct_v4l2_area* {.pure, inheritable, bycopy.} = object
    width*: compiler_u32     ## Generated based on /usr/include/linux/videodev2.h:419:8
    height*: compiler_u32
  struct_v4l2_capability* {.pure, inheritable, bycopy.} = object
    driver*: array[16'i64, compiler_u8] ## Generated based on /usr/include/linux/videodev2.h:435:8
    card*: array[32'i64, compiler_u8]
    bus_info*: array[32'i64, compiler_u8]
    version*: compiler_u32
    capabilities*: compiler_u32
    device_caps*: compiler_u32
    reserved*: array[3'i64, compiler_u32]
  compiler_u8* = uint8       ## Generated based on /usr/include/asm-generic/int-ll64.h:21:23
  struct_v4l2_pix_format_anon0_t* {.union, bycopy.} = object
    ycbcr_enc*: compiler_u32
    hsv_enc*: compiler_u32
  struct_v4l2_pix_format* {.pure, inheritable, bycopy.} = object
    width*: compiler_u32     ## Generated based on /usr/include/linux/videodev2.h:490:8
    height*: compiler_u32
    pixelformat*: compiler_u32
    field*: compiler_u32
    bytesperline*: compiler_u32
    sizeimage*: compiler_u32
    colorspace*: compiler_u32
    priv*: compiler_u32
    flags*: compiler_u32
    anon0*: struct_v4l2_pix_format_anon0_t
    quantization*: compiler_u32
    xfer_func*: compiler_u32
  struct_v4l2_fmtdesc* {.pure, inheritable, bycopy.} = object
    index*: compiler_u32     ## Generated based on /usr/include/linux/videodev2.h:825:8
    type_field*: compiler_u32
    flags*: compiler_u32
    description*: array[32'i64, compiler_u8]
    pixelformat*: compiler_u32
    mbus_code*: compiler_u32
    reserved*: array[3'i64, compiler_u32]
  struct_v4l2_frmsize_discrete* {.pure, inheritable, bycopy.} = object
    width*: compiler_u32     ## Generated based on /usr/include/linux/videodev2.h:856:8
    height*: compiler_u32
  struct_v4l2_frmsize_stepwise* {.pure, inheritable, bycopy.} = object
    min_width*: compiler_u32 ## Generated based on /usr/include/linux/videodev2.h:861:8
    max_width*: compiler_u32
    step_width*: compiler_u32
    min_height*: compiler_u32
    max_height*: compiler_u32
    step_height*: compiler_u32
  struct_v4l2_frmsizeenum_anon0_t* {.union, bycopy.} = object
    discrete*: struct_v4l2_frmsize_discrete
    stepwise*: struct_v4l2_frmsize_stepwise
  struct_v4l2_frmsizeenum* {.pure, inheritable, bycopy.} = object
    index*: compiler_u32     ## Generated based on /usr/include/linux/videodev2.h:870:8
    pixel_format*: compiler_u32
    type_field*: compiler_u32
    anon0*: struct_v4l2_frmsizeenum_anon0_t
    reserved*: array[2'i64, compiler_u32]
  struct_v4l2_frmival_stepwise* {.pure, inheritable, bycopy.} = object
    min*: struct_v4l2_fract  ## Generated based on /usr/include/linux/videodev2.h:892:8
    max*: struct_v4l2_fract
    step*: struct_v4l2_fract
  struct_v4l2_frmivalenum_anon0_t* {.union, bycopy.} = object
    discrete*: struct_v4l2_fract
    stepwise*: struct_v4l2_frmival_stepwise
  struct_v4l2_frmivalenum* {.pure, inheritable, bycopy.} = object
    index*: compiler_u32     ## Generated based on /usr/include/linux/videodev2.h:898:8
    pixel_format*: compiler_u32
    width*: compiler_u32
    height*: compiler_u32
    type_field*: compiler_u32
    anon0*: struct_v4l2_frmivalenum_anon0_t
    reserved*: array[2'i64, compiler_u32]
  struct_v4l2_timecode* {.pure, inheritable, bycopy.} = object
    type_field*: compiler_u32 ## Generated based on /usr/include/linux/videodev2.h:916:8
    flags*: compiler_u32
    frames*: compiler_u8
    seconds*: compiler_u8
    minutes*: compiler_u8
    hours*: compiler_u8
    userbits*: array[4'i64, compiler_u8]
  struct_v4l2_jpegcompression* {.pure, inheritable, bycopy.} = object
    quality*: cint           ## Generated based on /usr/include/linux/videodev2.h:941:8
    APPn*: cint
    APP_len*: cint
    APP_data*: array[60'i64, cschar]
    COM_len*: cint
    COM_data*: array[60'i64, cschar]
    jpeg_markers*: compiler_u32
  struct_v4l2_requestbuffers* {.pure, inheritable, bycopy.} = object
    count*: compiler_u32     ## Generated based on /usr/include/linux/videodev2.h:975:8
    type_field*: compiler_u32
    memory*: compiler_u32
    capabilities*: compiler_u32
    flags*: compiler_u8
    reserved*: array[3'i64, compiler_u8]
  struct_v4l2_plane_m_t* {.union, bycopy.} = object
    mem_offset*: compiler_u32
    userptr*: culong
    fd*: compiler_s32
  struct_v4l2_plane* {.pure, inheritable, bycopy.} = object
    bytesused*: compiler_u32 ## Generated based on /usr/include/linux/videodev2.h:1018:8
    length*: compiler_u32
    m*: struct_v4l2_plane_m_t
    data_offset*: compiler_u32
    reserved*: array[11'i64, compiler_u32]
  struct_v4l2_buffer_m_t* {.union, bycopy.} = object
    offset*: compiler_u32
    userptr*: culong
    planes*: ptr struct_v4l2_plane
    fd*: compiler_s32
  struct_v4l2_buffer_anon0_t* {.union, bycopy.} = object
    request_fd*: compiler_s32
    reserved*: compiler_u32
  struct_v4l2_buffer* {.pure, inheritable, bycopy.} = object
    index*: compiler_u32     ## Generated based on /usr/include/linux/videodev2.h:1065:8
    type_field*: compiler_u32
    bytesused*: compiler_u32
    flags*: compiler_u32
    field*: compiler_u32
    timestamp*: struct_timeval
    timecode*: struct_v4l2_timecode
    sequence*: compiler_u32
    memory*: compiler_u32
    m*: struct_v4l2_buffer_m_t
    length*: compiler_u32
    reserved2*: compiler_u32
    anon0*: struct_v4l2_buffer_anon0_t
  struct_timeval* {.pure, inheritable, bycopy.} = object
    tv_sec*: compiler_time_t ## Generated based on /usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h:8:8
    tv_usec*: compiler_suseconds_t
  compiler_u64* = culonglong ## Generated based on /usr/include/asm-generic/int-ll64.h:31:42
  struct_v4l2_exportbuffer* {.pure, inheritable, bycopy.} = object
    type_field*: compiler_u32 ## Generated based on /usr/include/linux/videodev2.h:1162:8
    index*: compiler_u32
    plane*: compiler_u32
    flags*: compiler_u32
    fd*: compiler_s32
    reserved*: array[11'i64, compiler_u32]
  struct_v4l2_framebuffer_fmt_t* {.pure, inheritable, bycopy.} = object
    width*: compiler_u32
    height*: compiler_u32
    pixelformat*: compiler_u32
    field*: compiler_u32
    bytesperline*: compiler_u32
    sizeimage*: compiler_u32
    colorspace*: compiler_u32
    priv*: compiler_u32
  struct_v4l2_framebuffer* {.pure, inheritable, bycopy.} = object
    capability*: compiler_u32 ## Generated based on /usr/include/linux/videodev2.h:1174:8
    flags*: compiler_u32
    base*: pointer
    fmt*: struct_v4l2_framebuffer_fmt_t
  struct_v4l2_clip* {.pure, inheritable, bycopy.} = object
    c*: struct_v4l2_rect     ## Generated based on /usr/include/linux/videodev2.h:1209:8
    next*: ptr struct_v4l2_clip
  struct_v4l2_window* {.pure, inheritable, bycopy.} = object
    w*: struct_v4l2_rect     ## Generated based on /usr/include/linux/videodev2.h:1214:8
    field*: compiler_u32
    chromakey*: compiler_u32
    clips*: ptr struct_v4l2_clip
    clipcount*: compiler_u32
    bitmap*: pointer
    global_alpha*: compiler_u8
  struct_v4l2_captureparm* {.pure, inheritable, bycopy.} = object
    capability*: compiler_u32 ## Generated based on /usr/include/linux/videodev2.h:1227:8
    capturemode*: compiler_u32
    timeperframe*: struct_v4l2_fract
    extendedmode*: compiler_u32
    readbuffers*: compiler_u32
    reserved*: array[4'i64, compiler_u32]
  struct_v4l2_outputparm* {.pure, inheritable, bycopy.} = object
    capability*: compiler_u32 ## Generated based on /usr/include/linux/videodev2.h:1240:8
    outputmode*: compiler_u32
    timeperframe*: struct_v4l2_fract
    extendedmode*: compiler_u32
    writebuffers*: compiler_u32
    reserved*: array[4'i64, compiler_u32]
  struct_v4l2_cropcap* {.pure, inheritable, bycopy.} = object
    type_field*: compiler_u32 ## Generated based on /usr/include/linux/videodev2.h:1252:8
    bounds*: struct_v4l2_rect
    defrect*: struct_v4l2_rect
    pixelaspect*: struct_v4l2_fract
  struct_v4l2_crop* {.pure, inheritable, bycopy.} = object
    type_field*: compiler_u32 ## Generated based on /usr/include/linux/videodev2.h:1259:8
    c*: struct_v4l2_rect
  struct_v4l2_selection* {.pure, inheritable, bycopy.} = object
    type_field*: compiler_u32 ## Generated based on /usr/include/linux/videodev2.h:1277:8
    target*: compiler_u32
    flags*: compiler_u32
    r*: struct_v4l2_rect
    reserved*: array[9'i64, compiler_u32]
  v4l2_std_id* = compiler_u64 ## Generated based on /usr/include/linux/videodev2.h:1290:15
  struct_v4l2_standard* {.pure, inheritable, bycopy.} = object
    index*: compiler_u32     ## Generated based on /usr/include/linux/videodev2.h:1422:8
    id*: v4l2_std_id
    name*: array[24'i64, compiler_u8]
    frameperiod*: struct_v4l2_fract
    framelines*: compiler_u32
    reserved*: array[4'i64, compiler_u32]
  struct_v4l2_bt_timings* {.pure, inheritable, bycopy, packed.} = object
    width*: compiler_u32     ## Generated based on /usr/include/linux/videodev2.h:1470:8
    height*: compiler_u32
    interlaced*: compiler_u32
    polarities*: compiler_u32
    pixelclock*: compiler_u64
    hfrontporch*: compiler_u32
    hsync*: compiler_u32
    hbackporch*: compiler_u32
    vfrontporch*: compiler_u32
    vsync*: compiler_u32
    vbackporch*: compiler_u32
    il_vfrontporch*: compiler_u32
    il_vsync*: compiler_u32
    il_vbackporch*: compiler_u32
    standards*: compiler_u32
    flags*: compiler_u32
    picture_aspect*: struct_v4l2_fract
    cea861_vic*: compiler_u8
    hdmi_vic*: compiler_u8
    reserved*: array[46'i64, compiler_u8]
  struct_v4l2_dv_timings_anon0_t* {.union, bycopy.} = object
    bt*: struct_v4l2_bt_timings
    reserved*: array[32'i64, compiler_u32]
  struct_v4l2_dv_timings* {.pure, inheritable, bycopy, packed.} = object
    type_field*: compiler_u32 ## Generated based on /usr/include/linux/videodev2.h:1594:8
    anon0*: struct_v4l2_dv_timings_anon0_t
  struct_v4l2_enum_dv_timings* {.pure, inheritable, bycopy.} = object
    index*: compiler_u32     ## Generated based on /usr/include/linux/videodev2.h:1613:8
    pad*: compiler_u32
    reserved*: array[2'i64, compiler_u32]
    timings*: struct_v4l2_dv_timings
  struct_v4l2_bt_timings_cap* {.pure, inheritable, bycopy, packed.} = object
    min_width*: compiler_u32 ## Generated based on /usr/include/linux/videodev2.h:1631:8
    max_width*: compiler_u32
    min_height*: compiler_u32
    max_height*: compiler_u32
    min_pixelclock*: compiler_u64
    max_pixelclock*: compiler_u64
    standards*: compiler_u32
    capabilities*: compiler_u32
    reserved*: array[16'i64, compiler_u32]
  struct_v4l2_dv_timings_cap_anon0_t* {.union, bycopy.} = object
    bt*: struct_v4l2_bt_timings_cap
    raw_data*: array[32'i64, compiler_u32]
  struct_v4l2_dv_timings_cap* {.pure, inheritable, bycopy.} = object
    type_field*: compiler_u32 ## Generated based on /usr/include/linux/videodev2.h:1658:8
    pad*: compiler_u32
    reserved*: array[2'i64, compiler_u32]
    anon0*: struct_v4l2_dv_timings_cap_anon0_t
  struct_v4l2_input* {.pure, inheritable, bycopy.} = object
    index*: compiler_u32     ## Generated based on /usr/include/linux/videodev2.h:1672:8
    name*: array[32'i64, compiler_u8]
    type_field*: compiler_u32
    audioset*: compiler_u32
    tuner*: compiler_u32
    std*: v4l2_std_id
    status*: compiler_u32
    capabilities*: compiler_u32
    reserved*: array[3'i64, compiler_u32]
  struct_v4l2_output* {.pure, inheritable, bycopy.} = object
    index*: compiler_u32     ## Generated based on /usr/include/linux/videodev2.h:1724:8
    name*: array[32'i64, compiler_u8]
    type_field*: compiler_u32
    audioset*: compiler_u32
    modulator*: compiler_u32
    std*: v4l2_std_id
    capabilities*: compiler_u32
    reserved*: array[3'i64, compiler_u32]
  struct_v4l2_control* {.pure, inheritable, bycopy.} = object
    id*: compiler_u32        ## Generated based on /usr/include/linux/videodev2.h:1748:8
    value*: compiler_s32
  struct_v4l2_ext_control_anon0_t* {.union, bycopy.} = object
    value*: compiler_s32
    value64*: compiler_s64
    string*: cstring
    p_u8*: ptr compiler_u8
    p_u16*: ptr compiler_u16
    p_u32*: ptr compiler_u32
    p_s32*: ptr compiler_s32
    p_s64*: ptr compiler_s64
    p_area*: ptr struct_v4l2_area
    p_h264_sps*: ptr struct_v4l2_ctrl_h264_sps
    p_h264_pps*: ptr struct_v4l2_ctrl_h264_pps
    p_h264_scaling_matrix*: ptr struct_v4l2_ctrl_h264_scaling_matrix
    p_h264_pred_weights*: ptr struct_v4l2_ctrl_h264_pred_weights
    p_h264_slice_params*: ptr struct_v4l2_ctrl_h264_slice_params
    p_h264_decode_params*: ptr struct_v4l2_ctrl_h264_decode_params
    p_fwht_params*: ptr struct_v4l2_ctrl_fwht_params
    p_vp8_frame*: ptr struct_v4l2_ctrl_vp8_frame
    p_mpeg2_sequence*: ptr struct_v4l2_ctrl_mpeg2_sequence
    p_mpeg2_picture*: ptr struct_v4l2_ctrl_mpeg2_picture
    p_mpeg2_quantisation*: ptr struct_v4l2_ctrl_mpeg2_quantisation
    p_vp9_compressed_hdr_probs*: ptr struct_v4l2_ctrl_vp9_compressed_hdr
    p_vp9_frame*: ptr struct_v4l2_ctrl_vp9_frame
    p_hevc_sps*: ptr struct_v4l2_ctrl_hevc_sps
    p_hevc_pps*: ptr struct_v4l2_ctrl_hevc_pps
    p_hevc_slice_params*: ptr struct_v4l2_ctrl_hevc_slice_params
    p_hevc_scaling_matrix*: ptr struct_v4l2_ctrl_hevc_scaling_matrix
    p_hevc_decode_params*: ptr struct_v4l2_ctrl_hevc_decode_params
    p_av1_sequence*: ptr struct_v4l2_ctrl_av1_sequence
    p_av1_tile_group_entry*: ptr struct_v4l2_ctrl_av1_tile_group_entry
    p_av1_frame*: ptr struct_v4l2_ctrl_av1_frame
    p_av1_film_grain*: ptr struct_v4l2_ctrl_av1_film_grain
    p_hdr10_cll_info*: ptr struct_v4l2_ctrl_hdr10_cll_info
    p_hdr10_mastering_display*: ptr struct_v4l2_ctrl_hdr10_mastering_display
    ptr_field*: pointer
  struct_v4l2_ext_control* {.pure, inheritable, bycopy, packed.} = object
    id*: compiler_u32        ## Generated based on /usr/include/linux/videodev2.h:1753:8
    size*: compiler_u32
    reserved2*: array[1'i64, compiler_u32]
    anon0*: struct_v4l2_ext_control_anon0_t
  compiler_s64* = clonglong  ## Generated based on /usr/include/asm-generic/int-ll64.h:30:44
  compiler_u16* = cushort    ## Generated based on /usr/include/asm-generic/int-ll64.h:24:24
  struct_v4l2_ctrl_h264_sps* {.pure, inheritable, bycopy.} = object
    profile_idc*: compiler_u8 ## Generated based on /usr/include/linux/v4l2-controls.h:1397:8
    constraint_set_flags*: compiler_u8
    level_idc*: compiler_u8
    seq_parameter_set_id*: compiler_u8
    chroma_format_idc*: compiler_u8
    bit_depth_luma_minus8*: compiler_u8
    bit_depth_chroma_minus8*: compiler_u8
    log2_max_frame_num_minus4*: compiler_u8
    pic_order_cnt_type*: compiler_u8
    log2_max_pic_order_cnt_lsb_minus4*: compiler_u8
    max_num_ref_frames*: compiler_u8
    num_ref_frames_in_pic_order_cnt_cycle*: compiler_u8
    offset_for_ref_frame*: array[255'i64, compiler_s32]
    offset_for_non_ref_pic*: compiler_s32
    offset_for_top_to_bottom_field*: compiler_s32
    pic_width_in_mbs_minus1*: compiler_u16
    pic_height_in_map_units_minus1*: compiler_u16
    flags*: compiler_u32
  struct_v4l2_ctrl_h264_pps* {.pure, inheritable, bycopy.} = object
    pic_parameter_set_id*: compiler_u8 ## Generated based on /usr/include/linux/v4l2-controls.h:1453:8
    seq_parameter_set_id*: compiler_u8
    num_slice_groups_minus1*: compiler_u8
    num_ref_idx_l0_default_active_minus1*: compiler_u8
    num_ref_idx_l1_default_active_minus1*: compiler_u8
    weighted_bipred_idc*: compiler_u8
    pic_init_qp_minus26*: compiler_s8
    pic_init_qs_minus26*: compiler_s8
    chroma_qp_index_offset*: compiler_s8
    second_chroma_qp_index_offset*: compiler_s8
    flags*: compiler_u16
  struct_v4l2_ctrl_h264_scaling_matrix* {.pure, inheritable, bycopy.} = object
    scaling_list_4x4*: array[6'i64, array[16'i64, compiler_u8]] ## Generated based on /usr/include/linux/v4l2-controls.h:1485:8
    scaling_list_8x8*: array[6'i64, array[64'i64, compiler_u8]]
  struct_v4l2_ctrl_h264_pred_weights* {.pure, inheritable, bycopy.} = object
    luma_log2_weight_denom*: compiler_u16 ## Generated based on /usr/include/linux/v4l2-controls.h:1515:8
    chroma_log2_weight_denom*: compiler_u16
    weight_factors*: array[2'i64, struct_v4l2_h264_weight_factors]
  struct_v4l2_ctrl_h264_slice_params* {.pure, inheritable, bycopy.} = object
    header_bit_size*: compiler_u32 ## Generated based on /usr/include/linux/v4l2-controls.h:1588:8
    first_mb_in_slice*: compiler_u32
    slice_type*: compiler_u8
    colour_plane_id*: compiler_u8
    redundant_pic_cnt*: compiler_u8
    cabac_init_idc*: compiler_u8
    slice_qp_delta*: compiler_s8
    slice_qs_delta*: compiler_s8
    disable_deblocking_filter_idc*: compiler_u8
    slice_alpha_c0_offset_div2*: compiler_s8
    slice_beta_offset_div2*: compiler_s8
    num_ref_idx_l0_active_minus1*: compiler_u8
    num_ref_idx_l1_active_minus1*: compiler_u8
    reserved*: compiler_u8
    ref_pic_list0*: array[32'i64, struct_v4l2_h264_reference]
    ref_pic_list1*: array[32'i64, struct_v4l2_h264_reference]
    flags*: compiler_u32
  struct_v4l2_ctrl_h264_decode_params* {.pure, inheritable, bycopy.} = object
    dpb*: array[16'i64, struct_v4l2_h264_dpb_entry] ## Generated based on /usr/include/linux/v4l2-controls.h:1672:8
    nal_ref_idc*: compiler_u16
    frame_num*: compiler_u16
    top_field_order_cnt*: compiler_s32
    bottom_field_order_cnt*: compiler_s32
    idr_pic_id*: compiler_u16
    pic_order_cnt_lsb*: compiler_u16
    delta_pic_order_cnt_bottom*: compiler_s32
    delta_pic_order_cnt0*: compiler_s32
    delta_pic_order_cnt1*: compiler_s32
    dec_ref_pic_marking_bit_size*: compiler_u32
    pic_order_cnt_bit_size*: compiler_u32
    slice_group_change_cycle*: compiler_u32
    reserved*: compiler_u32
    flags*: compiler_u32
  struct_v4l2_ctrl_fwht_params* {.pure, inheritable, bycopy.} = object
    backward_ref_ts*: compiler_u64 ## Generated based on /usr/include/linux/v4l2-controls.h:1750:8
    version*: compiler_u32
    width*: compiler_u32
    height*: compiler_u32
    flags*: compiler_u32
    colorspace*: compiler_u32
    xfer_func*: compiler_u32
    ycbcr_enc*: compiler_u32
    quantization*: compiler_u32
  struct_v4l2_ctrl_vp8_frame* {.pure, inheritable, bycopy.} = object
    segment*: struct_v4l2_vp8_segment ## Generated based on /usr/include/linux/v4l2-controls.h:1927:8
    lf*: struct_v4l2_vp8_loop_filter
    quant*: struct_v4l2_vp8_quantization
    entropy*: struct_v4l2_vp8_entropy
    coder_state*: struct_v4l2_vp8_entropy_coder_state
    width*: compiler_u16
    height*: compiler_u16
    horizontal_scale*: compiler_u8
    vertical_scale*: compiler_u8
    version*: compiler_u8
    prob_skip_false*: compiler_u8
    prob_intra*: compiler_u8
    prob_last*: compiler_u8
    prob_gf*: compiler_u8
    num_dct_parts*: compiler_u8
    first_part_size*: compiler_u32
    first_part_header_bits*: compiler_u32
    dct_part_sizes*: array[8'i64, compiler_u32]
    last_frame_ts*: compiler_u64
    golden_frame_ts*: compiler_u64
    alt_frame_ts*: compiler_u64
    flags*: compiler_u64
  struct_v4l2_ctrl_mpeg2_sequence* {.pure, inheritable, bycopy.} = object
    horizontal_size*: compiler_u16 ## Generated based on /usr/include/linux/v4l2-controls.h:1983:8
    vertical_size*: compiler_u16
    vbv_buffer_size*: compiler_u32
    profile_and_level_indication*: compiler_u16
    chroma_format*: compiler_u8
    flags*: compiler_u8
  struct_v4l2_ctrl_mpeg2_picture* {.pure, inheritable, bycopy.} = object
    backward_ref_ts*: compiler_u64 ## Generated based on /usr/include/linux/v4l2-controls.h:2030:8
    forward_ref_ts*: compiler_u64
    flags*: compiler_u32
    f_code*: array[2'i64, array[2'i64, compiler_u8]]
    picture_coding_type*: compiler_u8
    picture_structure*: compiler_u8
    intra_dc_precision*: compiler_u8
    reserved*: array[5'i64, compiler_u8]
  struct_v4l2_ctrl_mpeg2_quantisation* {.pure, inheritable, bycopy.} = object
    intra_quantiser_matrix*: array[64'i64, compiler_u8] ## Generated based on /usr/include/linux/v4l2-controls.h:2063:8
    non_intra_quantiser_matrix*: array[64'i64, compiler_u8]
    chroma_intra_quantiser_matrix*: array[64'i64, compiler_u8]
    chroma_non_intra_quantiser_matrix*: array[64'i64, compiler_u8]
  struct_v4l2_ctrl_vp9_compressed_hdr* {.pure, inheritable, bycopy.} = object
    tx_mode*: compiler_u8    ## Generated based on /usr/include/linux/v4l2-controls.h:2831:8
    tx8*: array[2'i64, array[1'i64, compiler_u8]]
    tx16*: array[2'i64, array[2'i64, compiler_u8]]
    tx32*: array[2'i64, array[3'i64, compiler_u8]]
    coef*: array[4'i64, array[2'i64, array[2'i64,
        array[6'i64, array[6'i64, array[3'i64, compiler_u8]]]]]]
    skip*: array[3'i64, compiler_u8]
    inter_mode*: array[7'i64, array[3'i64, compiler_u8]]
    interp_filter*: array[4'i64, array[2'i64, compiler_u8]]
    is_inter*: array[4'i64, compiler_u8]
    comp_mode*: array[5'i64, compiler_u8]
    single_ref*: array[5'i64, array[2'i64, compiler_u8]]
    comp_ref*: array[5'i64, compiler_u8]
    y_mode*: array[4'i64, array[9'i64, compiler_u8]]
    uv_mode*: array[10'i64, array[9'i64, compiler_u8]]
    partition*: array[16'i64, array[3'i64, compiler_u8]]
    mv*: struct_v4l2_vp9_mv_probs
  struct_v4l2_ctrl_vp9_frame* {.pure, inheritable, bycopy.} = object
    lf*: struct_v4l2_vp9_loop_filter ## Generated based on /usr/include/linux/v4l2-controls.h:2739:8
    quant*: struct_v4l2_vp9_quantization
    seg*: struct_v4l2_vp9_segmentation
    flags*: compiler_u32
    compressed_header_size*: compiler_u16
    uncompressed_header_size*: compiler_u16
    frame_width_minus_1*: compiler_u16
    frame_height_minus_1*: compiler_u16
    render_width_minus_1*: compiler_u16
    render_height_minus_1*: compiler_u16
    last_frame_ts*: compiler_u64
    golden_frame_ts*: compiler_u64
    alt_frame_ts*: compiler_u64
    ref_frame_sign_bias*: compiler_u8
    reset_frame_context*: compiler_u8
    frame_context_idx*: compiler_u8
    profile*: compiler_u8
    bit_depth*: compiler_u8
    interpolation_filter*: compiler_u8
    tile_cols_log2*: compiler_u8
    tile_rows_log2*: compiler_u8
    reference_mode*: compiler_u8
    reserved*: array[7'i64, compiler_u8]
  struct_v4l2_ctrl_hevc_sps* {.pure, inheritable, bycopy.} = object
    video_parameter_set_id*: compiler_u8 ## Generated based on /usr/include/linux/v4l2-controls.h:2165:8
    seq_parameter_set_id*: compiler_u8
    pic_width_in_luma_samples*: compiler_u16
    pic_height_in_luma_samples*: compiler_u16
    bit_depth_luma_minus8*: compiler_u8
    bit_depth_chroma_minus8*: compiler_u8
    log2_max_pic_order_cnt_lsb_minus4*: compiler_u8
    sps_max_dec_pic_buffering_minus1*: compiler_u8
    sps_max_num_reorder_pics*: compiler_u8
    sps_max_latency_increase_plus1*: compiler_u8
    log2_min_luma_coding_block_size_minus3*: compiler_u8
    log2_diff_max_min_luma_coding_block_size*: compiler_u8
    log2_min_luma_transform_block_size_minus2*: compiler_u8
    log2_diff_max_min_luma_transform_block_size*: compiler_u8
    max_transform_hierarchy_depth_inter*: compiler_u8
    max_transform_hierarchy_depth_intra*: compiler_u8
    pcm_sample_bit_depth_luma_minus1*: compiler_u8
    pcm_sample_bit_depth_chroma_minus1*: compiler_u8
    log2_min_pcm_luma_coding_block_size_minus3*: compiler_u8
    log2_diff_max_min_pcm_luma_coding_block_size*: compiler_u8
    num_short_term_ref_pic_sets*: compiler_u8
    num_long_term_ref_pics_sps*: compiler_u8
    chroma_format_idc*: compiler_u8
    sps_max_sub_layers_minus1*: compiler_u8
    reserved*: array[6'i64, compiler_u8]
    flags*: compiler_u64
  struct_v4l2_ctrl_hevc_pps* {.pure, inheritable, bycopy.} = object
    pic_parameter_set_id*: compiler_u8 ## Generated based on /usr/include/linux/v4l2-controls.h:2254:8
    num_extra_slice_header_bits*: compiler_u8
    num_ref_idx_l0_default_active_minus1*: compiler_u8
    num_ref_idx_l1_default_active_minus1*: compiler_u8
    init_qp_minus26*: compiler_s8
    diff_cu_qp_delta_depth*: compiler_u8
    pps_cb_qp_offset*: compiler_s8
    pps_cr_qp_offset*: compiler_s8
    num_tile_columns_minus1*: compiler_u8
    num_tile_rows_minus1*: compiler_u8
    column_width_minus1*: array[20'i64, compiler_u8]
    row_height_minus1*: array[22'i64, compiler_u8]
    pps_beta_offset_div2*: compiler_s8
    pps_tc_offset_div2*: compiler_s8
    log2_parallel_merge_level_minus2*: compiler_u8
    reserved*: compiler_u8
    flags*: compiler_u64
  struct_v4l2_ctrl_hevc_slice_params* {.pure, inheritable, bycopy.} = object
    bit_size*: compiler_u32  ## Generated based on /usr/include/linux/v4l2-controls.h:2411:8
    data_byte_offset*: compiler_u32
    num_entry_point_offsets*: compiler_u32
    nal_unit_type*: compiler_u8
    nuh_temporal_id_plus1*: compiler_u8
    slice_type*: compiler_u8
    colour_plane_id*: compiler_u8
    slice_pic_order_cnt*: compiler_s32
    num_ref_idx_l0_active_minus1*: compiler_u8
    num_ref_idx_l1_active_minus1*: compiler_u8
    collocated_ref_idx*: compiler_u8
    five_minus_max_num_merge_cand*: compiler_u8
    slice_qp_delta*: compiler_s8
    slice_cb_qp_offset*: compiler_s8
    slice_cr_qp_offset*: compiler_s8
    slice_act_y_qp_offset*: compiler_s8
    slice_act_cb_qp_offset*: compiler_s8
    slice_act_cr_qp_offset*: compiler_s8
    slice_beta_offset_div2*: compiler_s8
    slice_tc_offset_div2*: compiler_s8
    pic_struct*: compiler_u8
    reserved0*: array[3'i64, compiler_u8]
    slice_segment_addr*: compiler_u32
    ref_idx_l0*: array[16'i64, compiler_u8]
    ref_idx_l1*: array[16'i64, compiler_u8]
    short_term_ref_pic_set_size*: compiler_u16
    long_term_ref_pic_set_size*: compiler_u16
    pred_weight_table*: struct_v4l2_hevc_pred_weight_table
    reserved1*: array[2'i64, compiler_u8]
    flags*: compiler_u64
  struct_v4l2_ctrl_hevc_scaling_matrix* {.pure, inheritable, bycopy.} = object
    scaling_list_4x4*: array[6'i64, array[16'i64, compiler_u8]] ## Generated based on /usr/include/linux/v4l2-controls.h:2524:8
    scaling_list_8x8*: array[6'i64, array[64'i64, compiler_u8]]
    scaling_list_16x16*: array[6'i64, array[64'i64, compiler_u8]]
    scaling_list_32x32*: array[2'i64, array[64'i64, compiler_u8]]
    scaling_list_dc_coef_16x16*: array[6'i64, compiler_u8]
    scaling_list_dc_coef_32x32*: array[2'i64, compiler_u8]
  struct_v4l2_ctrl_hevc_decode_params* {.pure, inheritable, bycopy.} = object
    pic_order_cnt_val*: compiler_s32 ## Generated based on /usr/include/linux/v4l2-controls.h:2485:8
    short_term_ref_pic_set_size*: compiler_u16
    long_term_ref_pic_set_size*: compiler_u16
    num_active_dpb_entries*: compiler_u8
    num_poc_st_curr_before*: compiler_u8
    num_poc_st_curr_after*: compiler_u8
    num_poc_lt_curr*: compiler_u8
    poc_st_curr_before*: array[16'i64, compiler_u8]
    poc_st_curr_after*: array[16'i64, compiler_u8]
    poc_lt_curr*: array[16'i64, compiler_u8]
    num_delta_pocs_of_ref_rps_idx*: compiler_u8
    reserved*: array[3'i64, compiler_u8]
    dpb*: array[16'i64, struct_v4l2_hevc_dpb_entry]
    flags*: compiler_u64
  struct_v4l2_ctrl_av1_sequence* {.pure, inheritable, bycopy.} = object
    flags*: compiler_u32     ## Generated based on /usr/include/linux/v4l2-controls.h:2909:8
    seq_profile*: compiler_u8
    order_hint_bits*: compiler_u8
    bit_depth*: compiler_u8
    reserved*: compiler_u8
    max_frame_width_minus_1*: compiler_u16
    max_frame_height_minus_1*: compiler_u16
  struct_v4l2_ctrl_av1_tile_group_entry* {.pure, inheritable, bycopy.} = object
    tile_offset*: compiler_u32 ## Generated based on /usr/include/linux/v4l2-controls.h:2938:8
    tile_size*: compiler_u32
    tile_row*: compiler_u32
    tile_col*: compiler_u32
  struct_v4l2_ctrl_av1_frame* {.pure, inheritable, bycopy.} = object
    tile_info*: struct_v4l2_av1_tile_info ## Generated based on /usr/include/linux/v4l2-controls.h:3358:8
    quantization*: struct_v4l2_av1_quantization
    superres_denom*: compiler_u8
    segmentation*: struct_v4l2_av1_segmentation
    loop_filter*: struct_v4l2_av1_loop_filter
    cdef*: struct_v4l2_av1_cdef
    skip_mode_frame*: array[2'i64, compiler_u8]
    primary_ref_frame*: compiler_u8
    loop_restoration*: struct_v4l2_av1_loop_restoration
    global_motion*: struct_v4l2_av1_global_motion
    flags*: compiler_u32
    frame_type*: enum_v4l2_av1_frame_type
    order_hint*: compiler_u32
    upscaled_width*: compiler_u32
    interpolation_filter*: enum_v4l2_av1_interpolation_filter
    tx_mode*: enum_v4l2_av1_tx_mode
    frame_width_minus_1*: compiler_u32
    frame_height_minus_1*: compiler_u32
    render_width_minus_1*: compiler_u16
    render_height_minus_1*: compiler_u16
    current_frame_id*: compiler_u32
    buffer_removal_time*: array[32'i64, compiler_u32]
    reserved*: array[4'i64, compiler_u8]
    order_hints*: array[8'i64, compiler_u32]
    reference_frame_ts*: array[8'i64, compiler_u64]
    ref_frame_idx*: array[7'i64, compiler_s8]
    refresh_frame_flags*: compiler_u8
  struct_v4l2_ctrl_av1_film_grain* {.pure, inheritable, bycopy.} = object
    flags*: compiler_u8      ## Generated based on /usr/include/linux/v4l2-controls.h:3461:8
    cr_mult*: compiler_u8
    grain_seed*: compiler_u16
    film_grain_params_ref_idx*: compiler_u8
    num_y_points*: compiler_u8
    point_y_value*: array[16'i64, compiler_u8]
    point_y_scaling*: array[16'i64, compiler_u8]
    num_cb_points*: compiler_u8
    point_cb_value*: array[16'i64, compiler_u8]
    point_cb_scaling*: array[16'i64, compiler_u8]
    num_cr_points*: compiler_u8
    point_cr_value*: array[16'i64, compiler_u8]
    point_cr_scaling*: array[16'i64, compiler_u8]
    grain_scaling_minus_8*: compiler_u8
    ar_coeff_lag*: compiler_u8
    ar_coeffs_y_plus_128*: array[25'i64, compiler_u8]
    ar_coeffs_cb_plus_128*: array[25'i64, compiler_u8]
    ar_coeffs_cr_plus_128*: array[25'i64, compiler_u8]
    ar_coeff_shift_minus_6*: compiler_u8
    grain_scale_shift*: compiler_u8
    cb_mult*: compiler_u8
    cb_luma_mult*: compiler_u8
    cr_luma_mult*: compiler_u8
    cb_offset*: compiler_u16
    cr_offset*: compiler_u16
    reserved*: array[4'i64, compiler_u8]
  struct_v4l2_ctrl_hdr10_cll_info* {.pure, inheritable, bycopy.} = object
    max_content_light_level*: compiler_u16 ## Generated based on /usr/include/linux/v4l2-controls.h:2538:8
    max_pic_average_light_level*: compiler_u16
  struct_v4l2_ctrl_hdr10_mastering_display* {.pure, inheritable, bycopy.} = object
    display_primaries_x*: array[3'i64, compiler_u16] ## Generated based on /usr/include/linux/v4l2-controls.h:2558:8
    display_primaries_y*: array[3'i64, compiler_u16]
    white_point_x*: compiler_u16
    white_point_y*: compiler_u16
    max_display_mastering_luminance*: compiler_u32
    min_display_mastering_luminance*: compiler_u32
  struct_v4l2_ext_controls_anon0_t* {.union, bycopy.} = object
    ctrl_class*: compiler_u32
    which*: compiler_u32
  struct_v4l2_ext_controls* {.pure, inheritable, bycopy.} = object
    anon0*: struct_v4l2_ext_controls_anon0_t ## Generated based on /usr/include/linux/videodev2.h:1795:8
    count*: compiler_u32
    error_idx*: compiler_u32
    request_fd*: compiler_s32
    reserved*: array[1'i64, compiler_u32]
    controls*: ptr struct_v4l2_ext_control
  struct_v4l2_queryctrl* {.pure, inheritable, bycopy.} = object
    id*: compiler_u32        ## Generated based on /usr/include/linux/videodev2.h:1868:8
    type_field*: compiler_u32
    name*: array[32'i64, compiler_u8]
    minimum*: compiler_s32
    maximum*: compiler_s32
    step*: compiler_s32
    default_value*: compiler_s32
    flags*: compiler_u32
    reserved*: array[2'i64, compiler_u32]
  struct_v4l2_query_ext_ctrl* {.pure, inheritable, bycopy.} = object
    id*: compiler_u32        ## Generated based on /usr/include/linux/videodev2.h:1881:8
    type_field*: compiler_u32
    name*: array[32'i64, cschar]
    minimum*: compiler_s64
    maximum*: compiler_s64
    step*: compiler_u64
    default_value*: compiler_s64
    flags*: compiler_u32
    elem_size*: compiler_u32
    elems*: compiler_u32
    nr_of_dims*: compiler_u32
    dims*: array[4'i64, compiler_u32]
    reserved*: array[32'i64, compiler_u32]
  struct_v4l2_querymenu_anon0_t* {.union, bycopy.} = object
    name*: array[32'i64, compiler_u8]
    value*: compiler_s64
  struct_v4l2_querymenu* {.pure, inheritable, bycopy, packed.} = object
    id*: compiler_u32        ## Generated based on /usr/include/linux/videodev2.h:1898:8
    index*: compiler_u32
    anon0*: struct_v4l2_querymenu_anon0_t
    reserved*: compiler_u32
  struct_v4l2_tuner* {.pure, inheritable, bycopy.} = object
    index*: compiler_u32     ## Generated based on /usr/include/linux/videodev2.h:1935:8
    name*: array[32'i64, compiler_u8]
    type_field*: compiler_u32
    capability*: compiler_u32
    rangelow*: compiler_u32
    rangehigh*: compiler_u32
    rxsubchans*: compiler_u32
    audmode*: compiler_u32
    signal*: compiler_s32
    afc*: compiler_s32
    reserved*: array[4'i64, compiler_u32]
  struct_v4l2_modulator* {.pure, inheritable, bycopy.} = object
    index*: compiler_u32     ## Generated based on /usr/include/linux/videodev2.h:1949:8
    name*: array[32'i64, compiler_u8]
    capability*: compiler_u32
    rangelow*: compiler_u32
    rangehigh*: compiler_u32
    txsubchans*: compiler_u32
    type_field*: compiler_u32
    reserved*: array[3'i64, compiler_u32]
  struct_v4l2_frequency* {.pure, inheritable, bycopy.} = object
    tuner*: compiler_u32     ## Generated based on /usr/include/linux/videodev2.h:1992:8
    type_field*: compiler_u32
    frequency*: compiler_u32
    reserved*: array[8'i64, compiler_u32]
  struct_v4l2_frequency_band* {.pure, inheritable, bycopy.} = object
    tuner*: compiler_u32     ## Generated based on /usr/include/linux/videodev2.h:2003:8
    type_field*: compiler_u32
    index*: compiler_u32
    capability*: compiler_u32
    rangelow*: compiler_u32
    rangehigh*: compiler_u32
    modulation*: compiler_u32
    reserved*: array[9'i64, compiler_u32]
  struct_v4l2_hw_freq_seek* {.pure, inheritable, bycopy.} = object
    tuner*: compiler_u32     ## Generated based on /usr/include/linux/videodev2.h:2014:8
    type_field*: compiler_u32
    seek_upward*: compiler_u32
    wrap_around*: compiler_u32
    spacing*: compiler_u32
    rangelow*: compiler_u32
    rangehigh*: compiler_u32
    reserved*: array[5'i64, compiler_u32]
  struct_v4l2_rds_data* {.pure, inheritable, bycopy, packed.} = object
    lsb*: compiler_u8        ## Generated based on /usr/include/linux/videodev2.h:2029:8
    msb*: compiler_u8
    block_field*: compiler_u8
  struct_v4l2_audio* {.pure, inheritable, bycopy.} = object
    index*: compiler_u32     ## Generated based on /usr/include/linux/videodev2.h:2049:8
    name*: array[32'i64, compiler_u8]
    capability*: compiler_u32
    mode*: compiler_u32
    reserved*: array[2'i64, compiler_u32]
  struct_v4l2_audioout* {.pure, inheritable, bycopy.} = object
    index*: compiler_u32     ## Generated based on /usr/include/linux/videodev2.h:2064:8
    name*: array[32'i64, compiler_u8]
    capability*: compiler_u32
    mode*: compiler_u32
    reserved*: array[2'i64, compiler_u32]
  struct_v4l2_enc_idx_entry* {.pure, inheritable, bycopy.} = object
    offset*: compiler_u64    ## Generated based on /usr/include/linux/videodev2.h:2081:8
    pts*: compiler_u64
    length*: compiler_u32
    flags*: compiler_u32
    reserved*: array[2'i64, compiler_u32]
  struct_v4l2_enc_idx* {.pure, inheritable, bycopy.} = object
    entries*: compiler_u32   ## Generated based on /usr/include/linux/videodev2.h:2090:8
    entries_cap*: compiler_u32
    reserved*: array[4'i64, compiler_u32]
    entry*: array[64'i64, struct_v4l2_enc_idx_entry]
  struct_v4l2_encoder_cmd_anon0_t_raw_t* {.pure, inheritable, bycopy.} = object
    data*: array[8'i64, compiler_u32]
  struct_v4l2_encoder_cmd_anon0_t* {.union, bycopy.} = object
    raw*: struct_v4l2_encoder_cmd_anon0_t_raw_t
  struct_v4l2_encoder_cmd* {.pure, inheritable, bycopy.} = object
    cmd*: compiler_u32       ## Generated based on /usr/include/linux/videodev2.h:2106:8
    flags*: compiler_u32
    anon0*: struct_v4l2_encoder_cmd_anon0_t
  struct_v4l2_decoder_cmd_anon0_t_stop_t* {.pure, inheritable, bycopy.} = object
    pts*: compiler_u64
  struct_v4l2_decoder_cmd_anon0_t_start_t* {.pure, inheritable, bycopy.} = object
    speed*: compiler_s32
    format*: compiler_u32
  struct_v4l2_decoder_cmd_anon0_t_raw_t* {.pure, inheritable, bycopy.} = object
    data*: array[16'i64, compiler_u32]
  struct_v4l2_decoder_cmd_anon0_t* {.union, bycopy.} = object
    stop*: struct_v4l2_decoder_cmd_anon0_t_stop_t
    start*: struct_v4l2_decoder_cmd_anon0_t_start_t
    raw*: struct_v4l2_decoder_cmd_anon0_t_raw_t
  struct_v4l2_decoder_cmd* {.pure, inheritable, bycopy.} = object
    cmd*: compiler_u32       ## Generated based on /usr/include/linux/videodev2.h:2142:8
    flags*: compiler_u32
    anon0*: struct_v4l2_decoder_cmd_anon0_t
  struct_v4l2_vbi_format* {.pure, inheritable, bycopy.} = object
    sampling_rate*: compiler_u32 ## Generated based on /usr/include/linux/videodev2.h:2175:8
    offset*: compiler_u32
    samples_per_line*: compiler_u32
    sample_format*: compiler_u32
    start*: array[2'i64, compiler_s32]
    count*: array[2'i64, compiler_u32]
    flags*: compiler_u32
    reserved*: array[2'i64, compiler_u32]
  struct_v4l2_sliced_vbi_format* {.pure, inheritable, bycopy.} = object
    service_set*: compiler_u16 ## Generated based on /usr/include/linux/videodev2.h:2203:8
    service_lines*: array[2'i64, array[24'i64, compiler_u16]]
    io_size*: compiler_u32
    reserved*: array[2'i64, compiler_u32]
  struct_v4l2_sliced_vbi_cap* {.pure, inheritable, bycopy.} = object
    service_set*: compiler_u16 ## Generated based on /usr/include/linux/videodev2.h:2227:8
    service_lines*: array[2'i64, array[24'i64, compiler_u16]]
    type_field*: compiler_u32
    reserved*: array[3'i64, compiler_u32]
  struct_v4l2_sliced_vbi_data* {.pure, inheritable, bycopy.} = object
    id*: compiler_u32        ## Generated based on /usr/include/linux/videodev2.h:2238:8
    field*: compiler_u32
    line*: compiler_u32
    reserved*: compiler_u32
    data*: array[48'i64, compiler_u8]
  struct_v4l2_mpeg_vbi_itv0_line* {.pure, inheritable, bycopy, packed.} = object
    id*: compiler_u8         ## Generated based on /usr/include/linux/videodev2.h:2268:8
    data*: array[42'i64, compiler_u8]
  struct_v4l2_mpeg_vbi_itv0* {.pure, inheritable, bycopy, packed.} = object
    linemask*: array[2'i64, compiler_le32] ## Generated based on /usr/include/linux/videodev2.h:2273:8
    line*: array[35'i64, struct_v4l2_mpeg_vbi_itv0_line]
  compiler_le32* = compiler_u32 ## Generated based on /usr/include/linux/types.h:33:25
  struct_v4l2_mpeg_vbi_ITV0_struct* {.pure, inheritable, bycopy, packed.} = object
    line*: array[36'i64, struct_v4l2_mpeg_vbi_itv0_line] ## Generated based on /usr/include/linux/videodev2.h:2278:8
  struct_v4l2_mpeg_vbi_fmt_ivtv_anon0_t* {.union, bycopy.} = object
    itv0*: struct_v4l2_mpeg_vbi_itv0
    ITV0*: struct_v4l2_mpeg_vbi_ITV0_struct
  struct_v4l2_mpeg_vbi_fmt_ivtv* {.pure, inheritable, bycopy, packed.} = object
    magic*: array[4'i64, compiler_u8] ## Generated based on /usr/include/linux/videodev2.h:2285:8
    anon0*: struct_v4l2_mpeg_vbi_fmt_ivtv_anon0_t
  struct_v4l2_plane_pix_format* {.pure, inheritable, bycopy, packed.} = object
    sizeimage*: compiler_u32 ## Generated based on /usr/include/linux/videodev2.h:2305:8
    bytesperline*: compiler_u32
    reserved*: array[6'i64, compiler_u16]
  struct_v4l2_pix_format_mplane_anon0_t* {.union, bycopy.} = object
    ycbcr_enc*: compiler_u8
    hsv_enc*: compiler_u8
  struct_v4l2_pix_format_mplane* {.pure, inheritable, bycopy, packed.} = object
    width*: compiler_u32     ## Generated based on /usr/include/linux/videodev2.h:2327:8
    height*: compiler_u32
    pixelformat*: compiler_u32
    field*: compiler_u32
    colorspace*: compiler_u32
    plane_fmt*: array[8'i64, struct_v4l2_plane_pix_format]
    num_planes*: compiler_u8
    flags*: compiler_u8
    anon0*: struct_v4l2_pix_format_mplane_anon0_t
    quantization*: compiler_u8
    xfer_func*: compiler_u8
    reserved*: array[7'i64, compiler_u8]
  struct_v4l2_sdr_format* {.pure, inheritable, bycopy, packed.} = object
    pixelformat*: compiler_u32 ## Generated based on /usr/include/linux/videodev2.h:2352:8
    buffersize*: compiler_u32
    reserved*: array[24'i64, compiler_u8]
  struct_v4l2_meta_format* {.pure, inheritable, bycopy, packed.} = object
    dataformat*: compiler_u32 ## Generated based on /usr/include/linux/videodev2.h:2363:8
    buffersize*: compiler_u32
  struct_v4l2_format_fmt_t* {.union, bycopy.} = object
    pix*: struct_v4l2_pix_format
    pix_mp*: struct_v4l2_pix_format_mplane
    win*: struct_v4l2_window
    vbi*: struct_v4l2_vbi_format
    sliced*: struct_v4l2_sliced_vbi_format
    sdr*: struct_v4l2_sdr_format
    meta*: struct_v4l2_meta_format
    raw_data*: array[200'i64, compiler_u8]
  struct_v4l2_format* {.pure, inheritable, bycopy.} = object
    type_field*: compiler_u32 ## Generated based on /usr/include/linux/videodev2.h:2380:8
    fmt*: struct_v4l2_format_fmt_t
  struct_v4l2_streamparm_parm_t* {.union, bycopy.} = object
    capture*: struct_v4l2_captureparm
    output*: struct_v4l2_outputparm
    raw_data*: array[200'i64, compiler_u8]
  struct_v4l2_streamparm* {.pure, inheritable, bycopy.} = object
    type_field*: compiler_u32 ## Generated based on /usr/include/linux/videodev2.h:2396:8
    parm*: struct_v4l2_streamparm_parm_t
  struct_v4l2_event_vsync* {.pure, inheritable, bycopy, packed.} = object
    field*: compiler_u8      ## Generated based on /usr/include/linux/videodev2.h:2419:8
  struct_v4l2_event_ctrl_anon0_t* {.union, bycopy.} = object
    value*: compiler_s32
    value64*: compiler_s64
  struct_v4l2_event_ctrl* {.pure, inheritable, bycopy.} = object
    changes*: compiler_u32   ## Generated based on /usr/include/linux/videodev2.h:2430:8
    type_field*: compiler_u32
    anon0*: struct_v4l2_event_ctrl_anon0_t
    flags*: compiler_u32
    minimum*: compiler_s32
    maximum*: compiler_s32
    step*: compiler_s32
    default_value*: compiler_s32
  struct_v4l2_event_frame_sync* {.pure, inheritable, bycopy.} = object
    frame_sequence*: compiler_u32 ## Generated based on /usr/include/linux/videodev2.h:2444:8
  struct_v4l2_event_src_change* {.pure, inheritable, bycopy.} = object
    changes*: compiler_u32   ## Generated based on /usr/include/linux/videodev2.h:2450:8
  struct_v4l2_event_motion_det* {.pure, inheritable, bycopy.} = object
    flags*: compiler_u32     ## Generated based on /usr/include/linux/videodev2.h:2463:8
    frame_sequence*: compiler_u32
    region_mask*: compiler_u32
  struct_v4l2_event_u_t* {.union, bycopy.} = object
    vsync*: struct_v4l2_event_vsync
    ctrl*: struct_v4l2_event_ctrl
    frame_sync*: struct_v4l2_event_frame_sync
    src_change*: struct_v4l2_event_src_change
    motion_det*: struct_v4l2_event_motion_det
    data*: array[64'i64, compiler_u8]
  struct_v4l2_event* {.pure, inheritable, bycopy.} = object
    type_field*: compiler_u32 ## Generated based on /usr/include/linux/videodev2.h:2469:8
    u*: struct_v4l2_event_u_t
    pending*: compiler_u32
    sequence*: compiler_u32
    timestamp*: struct_timespec
    id*: compiler_u32
    reserved*: array[8'i64, compiler_u32]
  struct_timespec* {.pure, inheritable, bycopy.} = object
    tv_sec*: compiler_time_t ## Generated based on /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h:11:8
    tv_nsec*: compiler_syscall_slong_t
  struct_v4l2_event_subscription* {.pure, inheritable, bycopy.} = object
    type_field*: compiler_u32 ## Generated based on /usr/include/linux/videodev2.h:2489:8
    id*: compiler_u32
    flags*: compiler_u32
    reserved*: array[5'i64, compiler_u32]
  struct_v4l2_dbg_match_anon0_t* {.union, bycopy.} = object
    addr_field*: compiler_u32
    name*: array[32'i64, cschar]
  struct_v4l2_dbg_match* {.pure, inheritable, bycopy, packed.} = object
    type_field*: compiler_u32 ## Generated based on /usr/include/linux/videodev2.h:2514:8
    anon0*: struct_v4l2_dbg_match_anon0_t
  struct_v4l2_dbg_register* {.pure, inheritable, bycopy, packed.} = object
    match*: struct_v4l2_dbg_match ## Generated based on /usr/include/linux/videodev2.h:2522:8
    size*: compiler_u32
    reg*: compiler_u64
    val*: compiler_u64
  struct_v4l2_dbg_chip_info* {.pure, inheritable, bycopy, packed.} = object
    match*: struct_v4l2_dbg_match ## Generated based on /usr/include/linux/videodev2.h:2533:8
    name*: array[32'i64, cschar]
    flags*: compiler_u32
    reserved*: array[32'i64, compiler_u32]
  struct_v4l2_create_buffers* {.pure, inheritable, bycopy.} = object
    index*: compiler_u32     ## Generated based on /usr/include/linux/videodev2.h:2556:8
    count*: compiler_u32
    memory*: compiler_u32
    format*: struct_v4l2_format
    capabilities*: compiler_u32
    flags*: compiler_u32
    max_num_buffers*: compiler_u32
    reserved*: array[5'i64, compiler_u32]
  compiler_time_t* = clong   ## Generated based on /usr/include/x86_64-linux-gnu/bits/types.h:160:26
  compiler_suseconds_t* = clong ## Generated based on /usr/include/x86_64-linux-gnu/bits/types.h:162:31
  compiler_s8* = cschar      ## Generated based on /usr/include/asm-generic/int-ll64.h:20:25
  struct_v4l2_h264_weight_factors* {.pure, inheritable, bycopy.} = object
    luma_weight*: array[32'i64, compiler_s16] ## Generated based on /usr/include/linux/v4l2-controls.h:1490:8
    luma_offset*: array[32'i64, compiler_s16]
    chroma_weight*: array[32'i64, array[2'i64, compiler_s16]]
    chroma_offset*: array[32'i64, array[2'i64, compiler_s16]]
  struct_v4l2_h264_reference* {.pure, inheritable, bycopy.} = object
    fields*: compiler_u8     ## Generated based on /usr/include/linux/v4l2-controls.h:1541:8
    index*: compiler_u8
  struct_v4l2_h264_dpb_entry* {.pure, inheritable, bycopy.} = object
    reference_ts*: compiler_u64 ## Generated based on /usr/include/linux/v4l2-controls.h:1633:8
    pic_num*: compiler_u32
    frame_num*: compiler_u16
    fields*: compiler_u8
    reserved*: array[5'i64, compiler_u8]
    top_field_order_cnt*: compiler_s32
    bottom_field_order_cnt*: compiler_s32
    flags*: compiler_u32
  struct_v4l2_vp8_segment* {.pure, inheritable, bycopy.} = object
    quant_update*: array[4'i64, compiler_s8] ## Generated based on /usr/include/linux/v4l2-controls.h:1783:8
    lf_update*: array[4'i64, compiler_s8]
    segment_probs*: array[3'i64, compiler_u8]
    padding*: compiler_u8
    flags*: compiler_u32
  struct_v4l2_vp8_loop_filter* {.pure, inheritable, bycopy.} = object
    ref_frm_delta*: array[4'i64, compiler_s8] ## Generated based on /usr/include/linux/v4l2-controls.h:1810:8
    mb_mode_delta*: array[4'i64, compiler_s8]
    sharpness_level*: compiler_u8
    level*: compiler_u8
    padding*: compiler_u16
    flags*: compiler_u32
  struct_v4l2_vp8_quantization* {.pure, inheritable, bycopy.} = object
    y_ac_qi*: compiler_u8    ## Generated based on /usr/include/linux/v4l2-controls.h:1835:8
    y_dc_delta*: compiler_s8
    y2_dc_delta*: compiler_s8
    y2_ac_delta*: compiler_s8
    uv_dc_delta*: compiler_s8
    uv_ac_delta*: compiler_s8
    padding*: compiler_u16
  struct_v4l2_vp8_entropy* {.pure, inheritable, bycopy.} = object
    coeff_probs*: array[4'i64,
                        array[8'i64, array[3'i64, array[11'i64, compiler_u8]]]] ## Generated based on /usr/include/linux/v4l2-controls.h:1862:8
    y_mode_probs*: array[4'i64, compiler_u8]
    uv_mode_probs*: array[3'i64, compiler_u8]
    mv_probs*: array[2'i64, array[19'i64, compiler_u8]]
    padding*: array[3'i64, compiler_u8]
  struct_v4l2_vp8_entropy_coder_state* {.pure, inheritable, bycopy.} = object
    range*: compiler_u8      ## Generated based on /usr/include/linux/v4l2-controls.h:1881:8
    value*: compiler_u8
    bit_count*: compiler_u8
    padding*: compiler_u8
  struct_v4l2_vp9_mv_probs* {.pure, inheritable, bycopy.} = object
    joint*: array[3'i64, compiler_u8] ## Generated based on /usr/include/linux/v4l2-controls.h:2783:8
    sign*: array[2'i64, compiler_u8]
    classes*: array[2'i64, array[10'i64, compiler_u8]]
    class0_bit*: array[2'i64, compiler_u8]
    bits*: array[2'i64, array[10'i64, compiler_u8]]
    class0_fr*: array[2'i64, array[2'i64, array[3'i64, compiler_u8]]]
    fr*: array[2'i64, array[3'i64, compiler_u8]]
    class0_hp*: array[2'i64, compiler_u8]
    hp*: array[2'i64, compiler_u8]
  struct_v4l2_vp9_loop_filter* {.pure, inheritable, bycopy.} = object
    ref_deltas*: array[4'i64, compiler_s8] ## Generated based on /usr/include/linux/v4l2-controls.h:2589:8
    mode_deltas*: array[2'i64, compiler_s8]
    level*: compiler_u8
    sharpness*: compiler_u8
    flags*: compiler_u8
    reserved*: array[7'i64, compiler_u8]
  struct_v4l2_vp9_quantization* {.pure, inheritable, bycopy.} = object
    base_q_idx*: compiler_u8 ## Generated based on /usr/include/linux/v4l2-controls.h:2610:8
    delta_q_y_dc*: compiler_s8
    delta_q_uv_dc*: compiler_s8
    delta_q_uv_ac*: compiler_s8
    reserved*: array[4'i64, compiler_u8]
  struct_v4l2_vp9_segmentation* {.pure, inheritable, bycopy.} = object
    feature_data*: array[8'i64, array[4'i64, compiler_s16]] ## Generated based on /usr/include/linux/v4l2-controls.h:2654:8
    feature_enabled*: array[8'i64, compiler_u8]
    tree_probs*: array[7'i64, compiler_u8]
    pred_probs*: array[3'i64, compiler_u8]
    flags*: compiler_u8
    reserved*: array[5'i64, compiler_u8]
  struct_v4l2_hevc_pred_weight_table* {.pure, inheritable, bycopy.} = object
    delta_luma_weight_l0*: array[16'i64, compiler_s8] ## Generated based on /usr/include/linux/v4l2-controls.h:2334:8
    luma_offset_l0*: array[16'i64, compiler_s8]
    delta_chroma_weight_l0*: array[16'i64, array[2'i64, compiler_s8]]
    chroma_offset_l0*: array[16'i64, array[2'i64, compiler_s8]]
    delta_luma_weight_l1*: array[16'i64, compiler_s8]
    luma_offset_l1*: array[16'i64, compiler_s8]
    delta_chroma_weight_l1*: array[16'i64, array[2'i64, compiler_s8]]
    chroma_offset_l1*: array[16'i64, array[2'i64, compiler_s8]]
    luma_log2_weight_denom*: compiler_u8
    delta_chroma_log2_weight_denom*: compiler_s8
  struct_v4l2_hevc_dpb_entry* {.pure, inheritable, bycopy.} = object
    timestamp*: compiler_u64 ## Generated based on /usr/include/linux/v4l2-controls.h:2301:8
    flags*: compiler_u8
    field_pic*: compiler_u8
    reserved*: compiler_u16
    pic_order_cnt_val*: compiler_s32
  struct_v4l2_av1_tile_info* {.pure, inheritable, bycopy.} = object
    flags*: compiler_u8      ## Generated based on /usr/include/linux/v4l2-controls.h:3221:8
    context_update_tile_id*: compiler_u8
    tile_cols*: compiler_u8
    tile_rows*: compiler_u8
    mi_col_starts*: array[65'i64, compiler_u32]
    mi_row_starts*: array[65'i64, compiler_u32]
    width_in_sbs_minus_1*: array[64'i64, compiler_u32]
    height_in_sbs_minus_1*: array[64'i64, compiler_u32]
    tile_size_bytes*: compiler_u8
    reserved*: array[3'i64, compiler_u8]
  struct_v4l2_av1_quantization* {.pure, inheritable, bycopy.} = object
    flags*: compiler_u8      ## Generated based on /usr/include/linux/v4l2-controls.h:3185:8
    base_q_idx*: compiler_u8
    delta_q_y_dc*: compiler_s8
    delta_q_u_dc*: compiler_s8
    delta_q_u_ac*: compiler_s8
    delta_q_v_dc*: compiler_s8
    delta_q_v_ac*: compiler_s8
    qm_y*: compiler_u8
    qm_u*: compiler_u8
    qm_v*: compiler_u8
    delta_q_res*: compiler_u8
  struct_v4l2_av1_segmentation* {.pure, inheritable, bycopy.} = object
    flags*: compiler_u8      ## Generated based on /usr/include/linux/v4l2-controls.h:3116:8
    last_active_seg_id*: compiler_u8
    feature_enabled*: array[8'i64, compiler_u8]
    feature_data*: array[8'i64, array[8'i64, compiler_s16]]
  struct_v4l2_av1_loop_filter* {.pure, inheritable, bycopy.} = object
    flags*: compiler_u8      ## Generated based on /usr/include/linux/v4l2-controls.h:3151:8
    level*: array[4'i64, compiler_u8]
    sharpness*: compiler_u8
    ref_deltas*: array[8'i64, compiler_s8]
    mode_deltas*: array[2'i64, compiler_s8]
    delta_lf_res*: compiler_u8
  struct_v4l2_av1_cdef* {.pure, inheritable, bycopy.} = object
    damping_minus_3*: compiler_u8 ## Generated based on /usr/include/linux/v4l2-controls.h:3065:8
    bits*: compiler_u8
    y_pri_strength*: array[8'i64, compiler_u8]
    y_sec_strength*: array[8'i64, compiler_u8]
    uv_pri_strength*: array[8'i64, compiler_u8]
    uv_sec_strength*: array[8'i64, compiler_u8]
  struct_v4l2_av1_loop_restoration* {.pure, inheritable, bycopy.} = object
    flags*: compiler_u8      ## Generated based on /usr/include/linux/v4l2-controls.h:3044:8
    lr_unit_shift*: compiler_u8
    lr_uv_shift*: compiler_u8
    reserved*: compiler_u8
    frame_restoration_type*: array[3'i64, enum_v4l2_av1_frame_restoration_type]
    loop_restoration_size*: array[3'i64, compiler_u32]
  struct_v4l2_av1_global_motion* {.pure, inheritable, bycopy.} = object
    flags*: array[8'i64, compiler_u8] ## Generated based on /usr/include/linux/v4l2-controls.h:3006:8
    type_field*: array[8'i64, enum_v4l2_av1_warp_model]
    params*: array[8'i64, array[6'i64, compiler_s32]]
    invalid*: compiler_u8
    reserved*: array[3'i64, compiler_u8]
  compiler_syscall_slong_t* = clong ## Generated based on /usr/include/x86_64-linux-gnu/bits/types.h:197:33
  compiler_s16* = cshort     ## Generated based on /usr/include/asm-generic/int-ll64.h:23:26
when 32 is static:
  const
    VIDEO_MAX_FRAME* = 32    ## Generated based on /usr/include/linux/videodev2.h:71:9
else:
  let VIDEO_MAX_FRAME* = 32  ## Generated based on /usr/include/linux/videodev2.h:71:9
when 8 is static:
  const
    VIDEO_MAX_PLANES* = 8    ## Generated based on /usr/include/linux/videodev2.h:72:9
else:
  let VIDEO_MAX_PLANES* = 8  ## Generated based on /usr/include/linux/videodev2.h:72:9
when V4L2_TUNER_SDR is typedesc:
  type
    V4L2_TUNER_ADC* = V4L2_TUNER_SDR ## Generated based on /usr/include/linux/videodev2.h:183:9
else:
  when V4L2_TUNER_SDR is static:
    const
      V4L2_TUNER_ADC* = V4L2_TUNER_SDR ## Generated based on /usr/include/linux/videodev2.h:183:9
  else:
    let V4L2_TUNER_ADC* = V4L2_TUNER_SDR ## Generated based on /usr/include/linux/videodev2.h:183:9
when V4L2_COLORSPACE_OPRGB is typedesc:
  type
    V4L2_COLORSPACE_ADOBERGB* = V4L2_COLORSPACE_OPRGB ## Generated based on /usr/include/linux/videodev2.h:396:9
else:
  when V4L2_COLORSPACE_OPRGB is static:
    const
      V4L2_COLORSPACE_ADOBERGB* = V4L2_COLORSPACE_OPRGB ## Generated based on /usr/include/linux/videodev2.h:396:9
  else:
    let V4L2_COLORSPACE_ADOBERGB* = V4L2_COLORSPACE_OPRGB ## Generated based on /usr/include/linux/videodev2.h:396:9
when V4L2_XFER_FUNC_OPRGB is typedesc:
  type
    V4L2_XFER_FUNC_ADOBERGB* = V4L2_XFER_FUNC_OPRGB ## Generated based on /usr/include/linux/videodev2.h:397:9
else:
  when V4L2_XFER_FUNC_OPRGB is static:
    const
      V4L2_XFER_FUNC_ADOBERGB* = V4L2_XFER_FUNC_OPRGB ## Generated based on /usr/include/linux/videodev2.h:397:9
  else:
    let V4L2_XFER_FUNC_ADOBERGB* = V4L2_XFER_FUNC_OPRGB ## Generated based on /usr/include/linux/videodev2.h:397:9
when 1 is static:
  const
    V4L2_CAP_VIDEO_CAPTURE* = 1 ## Generated based on /usr/include/linux/videodev2.h:446:9
else:
  let V4L2_CAP_VIDEO_CAPTURE* = 1 ## Generated based on /usr/include/linux/videodev2.h:446:9
when 2 is static:
  const
    V4L2_CAP_VIDEO_OUTPUT* = 2 ## Generated based on /usr/include/linux/videodev2.h:447:9
else:
  let V4L2_CAP_VIDEO_OUTPUT* = 2 ## Generated based on /usr/include/linux/videodev2.h:447:9
when 4 is static:
  const
    V4L2_CAP_VIDEO_OVERLAY* = 4 ## Generated based on /usr/include/linux/videodev2.h:448:9
else:
  let V4L2_CAP_VIDEO_OVERLAY* = 4 ## Generated based on /usr/include/linux/videodev2.h:448:9
when 16 is static:
  const
    V4L2_CAP_VBI_CAPTURE* = 16 ## Generated based on /usr/include/linux/videodev2.h:449:9
else:
  let V4L2_CAP_VBI_CAPTURE* = 16 ## Generated based on /usr/include/linux/videodev2.h:449:9
when 32 is static:
  const
    V4L2_CAP_VBI_OUTPUT* = 32 ## Generated based on /usr/include/linux/videodev2.h:450:9
else:
  let V4L2_CAP_VBI_OUTPUT* = 32 ## Generated based on /usr/include/linux/videodev2.h:450:9
when 64 is static:
  const
    V4L2_CAP_SLICED_VBI_CAPTURE* = 64 ## Generated based on /usr/include/linux/videodev2.h:451:9
else:
  let V4L2_CAP_SLICED_VBI_CAPTURE* = 64 ## Generated based on /usr/include/linux/videodev2.h:451:9
when 128 is static:
  const
    V4L2_CAP_SLICED_VBI_OUTPUT* = 128 ## Generated based on /usr/include/linux/videodev2.h:452:9
else:
  let V4L2_CAP_SLICED_VBI_OUTPUT* = 128 ## Generated based on /usr/include/linux/videodev2.h:452:9
when 256 is static:
  const
    V4L2_CAP_RDS_CAPTURE* = 256 ## Generated based on /usr/include/linux/videodev2.h:453:9
else:
  let V4L2_CAP_RDS_CAPTURE* = 256 ## Generated based on /usr/include/linux/videodev2.h:453:9
when 512 is static:
  const
    V4L2_CAP_VIDEO_OUTPUT_OVERLAY* = 512 ## Generated based on /usr/include/linux/videodev2.h:454:9
else:
  let V4L2_CAP_VIDEO_OUTPUT_OVERLAY* = 512 ## Generated based on /usr/include/linux/videodev2.h:454:9
when 1024 is static:
  const
    V4L2_CAP_HW_FREQ_SEEK* = 1024 ## Generated based on /usr/include/linux/videodev2.h:455:9
else:
  let V4L2_CAP_HW_FREQ_SEEK* = 1024 ## Generated based on /usr/include/linux/videodev2.h:455:9
when 2048 is static:
  const
    V4L2_CAP_RDS_OUTPUT* = 2048 ## Generated based on /usr/include/linux/videodev2.h:456:9
else:
  let V4L2_CAP_RDS_OUTPUT* = 2048 ## Generated based on /usr/include/linux/videodev2.h:456:9
when 4096 is static:
  const
    V4L2_CAP_VIDEO_CAPTURE_MPLANE* = 4096 ## Generated based on /usr/include/linux/videodev2.h:459:9
else:
  let V4L2_CAP_VIDEO_CAPTURE_MPLANE* = 4096 ## Generated based on /usr/include/linux/videodev2.h:459:9
when 8192 is static:
  const
    V4L2_CAP_VIDEO_OUTPUT_MPLANE* = 8192 ## Generated based on /usr/include/linux/videodev2.h:461:9
else:
  let V4L2_CAP_VIDEO_OUTPUT_MPLANE* = 8192 ## Generated based on /usr/include/linux/videodev2.h:461:9
when 16384 is static:
  const
    V4L2_CAP_VIDEO_M2M_MPLANE* = 16384 ## Generated based on /usr/include/linux/videodev2.h:463:9
else:
  let V4L2_CAP_VIDEO_M2M_MPLANE* = 16384 ## Generated based on /usr/include/linux/videodev2.h:463:9
when 32768 is static:
  const
    V4L2_CAP_VIDEO_M2M* = 32768 ## Generated based on /usr/include/linux/videodev2.h:465:9
else:
  let V4L2_CAP_VIDEO_M2M* = 32768 ## Generated based on /usr/include/linux/videodev2.h:465:9
when 65536 is static:
  const
    V4L2_CAP_TUNER* = 65536  ## Generated based on /usr/include/linux/videodev2.h:467:9
else:
  let V4L2_CAP_TUNER* = 65536 ## Generated based on /usr/include/linux/videodev2.h:467:9
when 131072 is static:
  const
    V4L2_CAP_AUDIO* = 131072 ## Generated based on /usr/include/linux/videodev2.h:468:9
else:
  let V4L2_CAP_AUDIO* = 131072 ## Generated based on /usr/include/linux/videodev2.h:468:9
when 262144 is static:
  const
    V4L2_CAP_RADIO* = 262144 ## Generated based on /usr/include/linux/videodev2.h:469:9
else:
  let V4L2_CAP_RADIO* = 262144 ## Generated based on /usr/include/linux/videodev2.h:469:9
when 524288 is static:
  const
    V4L2_CAP_MODULATOR* = 524288 ## Generated based on /usr/include/linux/videodev2.h:470:9
else:
  let V4L2_CAP_MODULATOR* = 524288 ## Generated based on /usr/include/linux/videodev2.h:470:9
when 1048576 is static:
  const
    V4L2_CAP_SDR_CAPTURE* = 1048576 ## Generated based on /usr/include/linux/videodev2.h:472:9
else:
  let V4L2_CAP_SDR_CAPTURE* = 1048576 ## Generated based on /usr/include/linux/videodev2.h:472:9
when 2097152 is static:
  const
    V4L2_CAP_EXT_PIX_FORMAT* = 2097152 ## Generated based on /usr/include/linux/videodev2.h:473:9
else:
  let V4L2_CAP_EXT_PIX_FORMAT* = 2097152 ## Generated based on /usr/include/linux/videodev2.h:473:9
when 4194304 is static:
  const
    V4L2_CAP_SDR_OUTPUT* = 4194304 ## Generated based on /usr/include/linux/videodev2.h:474:9
else:
  let V4L2_CAP_SDR_OUTPUT* = 4194304 ## Generated based on /usr/include/linux/videodev2.h:474:9
when 8388608 is static:
  const
    V4L2_CAP_META_CAPTURE* = 8388608 ## Generated based on /usr/include/linux/videodev2.h:475:9
else:
  let V4L2_CAP_META_CAPTURE* = 8388608 ## Generated based on /usr/include/linux/videodev2.h:475:9
when 16777216 is static:
  const
    V4L2_CAP_READWRITE* = 16777216 ## Generated based on /usr/include/linux/videodev2.h:477:9
else:
  let V4L2_CAP_READWRITE* = 16777216 ## Generated based on /usr/include/linux/videodev2.h:477:9
when 67108864 is static:
  const
    V4L2_CAP_STREAMING* = 67108864 ## Generated based on /usr/include/linux/videodev2.h:478:9
else:
  let V4L2_CAP_STREAMING* = 67108864 ## Generated based on /usr/include/linux/videodev2.h:478:9
when 134217728 is static:
  const
    V4L2_CAP_META_OUTPUT* = 134217728 ## Generated based on /usr/include/linux/videodev2.h:479:9
else:
  let V4L2_CAP_META_OUTPUT* = 134217728 ## Generated based on /usr/include/linux/videodev2.h:479:9
when 268435456 is static:
  const
    V4L2_CAP_TOUCH* = 268435456 ## Generated based on /usr/include/linux/videodev2.h:481:9
else:
  let V4L2_CAP_TOUCH* = 268435456 ## Generated based on /usr/include/linux/videodev2.h:481:9
when 536870912 is static:
  const
    V4L2_CAP_IO_MC* = 536870912 ## Generated based on /usr/include/linux/videodev2.h:483:9
else:
  let V4L2_CAP_IO_MC* = 536870912 ## Generated based on /usr/include/linux/videodev2.h:483:9
when 2147483648 is static:
  const
    V4L2_CAP_DEVICE_CAPS* = 2147483648'i64 ## Generated based on /usr/include/linux/videodev2.h:485:9
else:
  let V4L2_CAP_DEVICE_CAPS* = 2147483648'i64 ## Generated based on /usr/include/linux/videodev2.h:485:9
when 4276996862 is static:
  const
    V4L2_PIX_FMT_PRIV_MAGIC* = 4276996862'i64 ## Generated based on /usr/include/linux/videodev2.h:816:9
else:
  let V4L2_PIX_FMT_PRIV_MAGIC* = 4276996862'i64 ## Generated based on /usr/include/linux/videodev2.h:816:9
when 1 is static:
  const
    V4L2_PIX_FMT_FLAG_PREMUL_ALPHA* = 1 ## Generated based on /usr/include/linux/videodev2.h:819:9
else:
  let V4L2_PIX_FMT_FLAG_PREMUL_ALPHA* = 1 ## Generated based on /usr/include/linux/videodev2.h:819:9
when 2 is static:
  const
    V4L2_PIX_FMT_FLAG_SET_CSC* = 2 ## Generated based on /usr/include/linux/videodev2.h:820:9
else:
  let V4L2_PIX_FMT_FLAG_SET_CSC* = 2 ## Generated based on /usr/include/linux/videodev2.h:820:9
when 1 is static:
  const
    V4L2_FMT_FLAG_COMPRESSED* = 1 ## Generated based on /usr/include/linux/videodev2.h:835:9
else:
  let V4L2_FMT_FLAG_COMPRESSED* = 1 ## Generated based on /usr/include/linux/videodev2.h:835:9
when 2 is static:
  const
    V4L2_FMT_FLAG_EMULATED* = 2 ## Generated based on /usr/include/linux/videodev2.h:836:9
else:
  let V4L2_FMT_FLAG_EMULATED* = 2 ## Generated based on /usr/include/linux/videodev2.h:836:9
when 4 is static:
  const
    V4L2_FMT_FLAG_CONTINUOUS_BYTESTREAM* = 4 ## Generated based on /usr/include/linux/videodev2.h:837:9
else:
  let V4L2_FMT_FLAG_CONTINUOUS_BYTESTREAM* = 4 ## Generated based on /usr/include/linux/videodev2.h:837:9
when 8 is static:
  const
    V4L2_FMT_FLAG_DYN_RESOLUTION* = 8 ## Generated based on /usr/include/linux/videodev2.h:838:9
else:
  let V4L2_FMT_FLAG_DYN_RESOLUTION* = 8 ## Generated based on /usr/include/linux/videodev2.h:838:9
when 16 is static:
  const
    V4L2_FMT_FLAG_ENC_CAP_FRAME_INTERVAL* = 16 ## Generated based on /usr/include/linux/videodev2.h:839:9
else:
  let V4L2_FMT_FLAG_ENC_CAP_FRAME_INTERVAL* = 16 ## Generated based on /usr/include/linux/videodev2.h:839:9
when 32 is static:
  const
    V4L2_FMT_FLAG_CSC_COLORSPACE* = 32 ## Generated based on /usr/include/linux/videodev2.h:840:9
else:
  let V4L2_FMT_FLAG_CSC_COLORSPACE* = 32 ## Generated based on /usr/include/linux/videodev2.h:840:9
when 64 is static:
  const
    V4L2_FMT_FLAG_CSC_XFER_FUNC* = 64 ## Generated based on /usr/include/linux/videodev2.h:841:9
else:
  let V4L2_FMT_FLAG_CSC_XFER_FUNC* = 64 ## Generated based on /usr/include/linux/videodev2.h:841:9
when 128 is static:
  const
    V4L2_FMT_FLAG_CSC_YCBCR_ENC* = 128 ## Generated based on /usr/include/linux/videodev2.h:842:9
else:
  let V4L2_FMT_FLAG_CSC_YCBCR_ENC* = 128 ## Generated based on /usr/include/linux/videodev2.h:842:9
when V4L2_FMT_FLAG_CSC_YCBCR_ENC is typedesc:
  type
    V4L2_FMT_FLAG_CSC_HSV_ENC* = V4L2_FMT_FLAG_CSC_YCBCR_ENC ## Generated based on /usr/include/linux/videodev2.h:843:9
else:
  when V4L2_FMT_FLAG_CSC_YCBCR_ENC is static:
    const
      V4L2_FMT_FLAG_CSC_HSV_ENC* = V4L2_FMT_FLAG_CSC_YCBCR_ENC ## Generated based on /usr/include/linux/videodev2.h:843:9
  else:
    let V4L2_FMT_FLAG_CSC_HSV_ENC* = V4L2_FMT_FLAG_CSC_YCBCR_ENC ## Generated based on /usr/include/linux/videodev2.h:843:9
when 256 is static:
  const
    V4L2_FMT_FLAG_CSC_QUANTIZATION* = 256 ## Generated based on /usr/include/linux/videodev2.h:844:9
else:
  let V4L2_FMT_FLAG_CSC_QUANTIZATION* = 256 ## Generated based on /usr/include/linux/videodev2.h:844:9
when 1 is static:
  const
    V4L2_TC_TYPE_24FPS* = 1  ## Generated based on /usr/include/linux/videodev2.h:927:9
else:
  let V4L2_TC_TYPE_24FPS* = 1 ## Generated based on /usr/include/linux/videodev2.h:927:9
when 2 is static:
  const
    V4L2_TC_TYPE_25FPS* = 2  ## Generated based on /usr/include/linux/videodev2.h:928:9
else:
  let V4L2_TC_TYPE_25FPS* = 2 ## Generated based on /usr/include/linux/videodev2.h:928:9
when 3 is static:
  const
    V4L2_TC_TYPE_30FPS* = 3  ## Generated based on /usr/include/linux/videodev2.h:929:9
else:
  let V4L2_TC_TYPE_30FPS* = 3 ## Generated based on /usr/include/linux/videodev2.h:929:9
when 4 is static:
  const
    V4L2_TC_TYPE_50FPS* = 4  ## Generated based on /usr/include/linux/videodev2.h:930:9
else:
  let V4L2_TC_TYPE_50FPS* = 4 ## Generated based on /usr/include/linux/videodev2.h:930:9
when 5 is static:
  const
    V4L2_TC_TYPE_60FPS* = 5  ## Generated based on /usr/include/linux/videodev2.h:931:9
else:
  let V4L2_TC_TYPE_60FPS* = 5 ## Generated based on /usr/include/linux/videodev2.h:931:9
when 1 is static:
  const
    V4L2_TC_FLAG_DROPFRAME* = 1 ## Generated based on /usr/include/linux/videodev2.h:934:9
else:
  let V4L2_TC_FLAG_DROPFRAME* = 1 ## Generated based on /usr/include/linux/videodev2.h:934:9
when 2 is static:
  const
    V4L2_TC_FLAG_COLORFRAME* = 2 ## Generated based on /usr/include/linux/videodev2.h:935:9
else:
  let V4L2_TC_FLAG_COLORFRAME* = 2 ## Generated based on /usr/include/linux/videodev2.h:935:9
when 12 is static:
  const
    V4L2_TC_USERBITS_field* = 12 ## Generated based on /usr/include/linux/videodev2.h:936:9
else:
  let V4L2_TC_USERBITS_field* = 12 ## Generated based on /usr/include/linux/videodev2.h:936:9
when 0 is static:
  const
    V4L2_TC_USERBITS_USERDEFINED* = 0 ## Generated based on /usr/include/linux/videodev2.h:937:9
else:
  let V4L2_TC_USERBITS_USERDEFINED* = 0 ## Generated based on /usr/include/linux/videodev2.h:937:9
when 8 is static:
  const
    V4L2_TC_USERBITS_8BITCHARS* = 8 ## Generated based on /usr/include/linux/videodev2.h:938:9
else:
  let V4L2_TC_USERBITS_8BITCHARS* = 8 ## Generated based on /usr/include/linux/videodev2.h:938:9
when 1 is static:
  const
    V4L2_BUF_FLAG_MAPPED* = 1 ## Generated based on /usr/include/linux/videodev2.h:1105:9
else:
  let V4L2_BUF_FLAG_MAPPED* = 1 ## Generated based on /usr/include/linux/videodev2.h:1105:9
when 2 is static:
  const
    V4L2_BUF_FLAG_QUEUED* = 2 ## Generated based on /usr/include/linux/videodev2.h:1107:9
else:
  let V4L2_BUF_FLAG_QUEUED* = 2 ## Generated based on /usr/include/linux/videodev2.h:1107:9
when 4 is static:
  const
    V4L2_BUF_FLAG_DONE* = 4  ## Generated based on /usr/include/linux/videodev2.h:1109:9
else:
  let V4L2_BUF_FLAG_DONE* = 4 ## Generated based on /usr/include/linux/videodev2.h:1109:9
when 8 is static:
  const
    V4L2_BUF_FLAG_KEYFRAME* = 8 ## Generated based on /usr/include/linux/videodev2.h:1111:9
else:
  let V4L2_BUF_FLAG_KEYFRAME* = 8 ## Generated based on /usr/include/linux/videodev2.h:1111:9
when 16 is static:
  const
    V4L2_BUF_FLAG_PFRAME* = 16 ## Generated based on /usr/include/linux/videodev2.h:1113:9
else:
  let V4L2_BUF_FLAG_PFRAME* = 16 ## Generated based on /usr/include/linux/videodev2.h:1113:9
when 32 is static:
  const
    V4L2_BUF_FLAG_BFRAME* = 32 ## Generated based on /usr/include/linux/videodev2.h:1115:9
else:
  let V4L2_BUF_FLAG_BFRAME* = 32 ## Generated based on /usr/include/linux/videodev2.h:1115:9
when 64 is static:
  const
    V4L2_BUF_FLAG_ERROR* = 64 ## Generated based on /usr/include/linux/videodev2.h:1117:9
else:
  let V4L2_BUF_FLAG_ERROR* = 64 ## Generated based on /usr/include/linux/videodev2.h:1117:9
when 128 is static:
  const
    V4L2_BUF_FLAG_IN_REQUEST* = 128 ## Generated based on /usr/include/linux/videodev2.h:1119:9
else:
  let V4L2_BUF_FLAG_IN_REQUEST* = 128 ## Generated based on /usr/include/linux/videodev2.h:1119:9
when 256 is static:
  const
    V4L2_BUF_FLAG_TIMECODE* = 256 ## Generated based on /usr/include/linux/videodev2.h:1121:9
else:
  let V4L2_BUF_FLAG_TIMECODE* = 256 ## Generated based on /usr/include/linux/videodev2.h:1121:9
when 512 is static:
  const
    V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF* = 512 ## Generated based on /usr/include/linux/videodev2.h:1123:9
else:
  let V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF* = 512 ## Generated based on /usr/include/linux/videodev2.h:1123:9
when 1024 is static:
  const
    V4L2_BUF_FLAG_PREPARED* = 1024 ## Generated based on /usr/include/linux/videodev2.h:1125:9
else:
  let V4L2_BUF_FLAG_PREPARED* = 1024 ## Generated based on /usr/include/linux/videodev2.h:1125:9
when 2048 is static:
  const
    V4L2_BUF_FLAG_NO_CACHE_INVALIDATE* = 2048 ## Generated based on /usr/include/linux/videodev2.h:1127:9
else:
  let V4L2_BUF_FLAG_NO_CACHE_INVALIDATE* = 2048 ## Generated based on /usr/include/linux/videodev2.h:1127:9
when 4096 is static:
  const
    V4L2_BUF_FLAG_NO_CACHE_CLEAN* = 4096 ## Generated based on /usr/include/linux/videodev2.h:1128:9
else:
  let V4L2_BUF_FLAG_NO_CACHE_CLEAN* = 4096 ## Generated based on /usr/include/linux/videodev2.h:1128:9
when 57344 is static:
  const
    V4L2_BUF_FLAG_TIMESTAMP_MASK* = 57344 ## Generated based on /usr/include/linux/videodev2.h:1130:9
else:
  let V4L2_BUF_FLAG_TIMESTAMP_MASK* = 57344 ## Generated based on /usr/include/linux/videodev2.h:1130:9
when 0 is static:
  const
    V4L2_BUF_FLAG_TIMESTAMP_UNKNOWN* = 0 ## Generated based on /usr/include/linux/videodev2.h:1131:9
else:
  let V4L2_BUF_FLAG_TIMESTAMP_UNKNOWN* = 0 ## Generated based on /usr/include/linux/videodev2.h:1131:9
when 8192 is static:
  const
    V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC* = 8192 ## Generated based on /usr/include/linux/videodev2.h:1132:9
else:
  let V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC* = 8192 ## Generated based on /usr/include/linux/videodev2.h:1132:9
when 16384 is static:
  const
    V4L2_BUF_FLAG_TIMESTAMP_COPY* = 16384 ## Generated based on /usr/include/linux/videodev2.h:1133:9
else:
  let V4L2_BUF_FLAG_TIMESTAMP_COPY* = 16384 ## Generated based on /usr/include/linux/videodev2.h:1133:9
when 458752 is static:
  const
    V4L2_BUF_FLAG_TSTAMP_SRC_MASK* = 458752 ## Generated based on /usr/include/linux/videodev2.h:1135:9
else:
  let V4L2_BUF_FLAG_TSTAMP_SRC_MASK* = 458752 ## Generated based on /usr/include/linux/videodev2.h:1135:9
when 0 is static:
  const
    V4L2_BUF_FLAG_TSTAMP_SRC_EOF* = 0 ## Generated based on /usr/include/linux/videodev2.h:1136:9
else:
  let V4L2_BUF_FLAG_TSTAMP_SRC_EOF* = 0 ## Generated based on /usr/include/linux/videodev2.h:1136:9
when 65536 is static:
  const
    V4L2_BUF_FLAG_TSTAMP_SRC_SOE* = 65536 ## Generated based on /usr/include/linux/videodev2.h:1137:9
else:
  let V4L2_BUF_FLAG_TSTAMP_SRC_SOE* = 65536 ## Generated based on /usr/include/linux/videodev2.h:1137:9
when 1048576 is static:
  const
    V4L2_BUF_FLAG_LAST* = 1048576 ## Generated based on /usr/include/linux/videodev2.h:1139:9
else:
  let V4L2_BUF_FLAG_LAST* = 1048576 ## Generated based on /usr/include/linux/videodev2.h:1139:9
when 8388608 is static:
  const
    V4L2_BUF_FLAG_REQUEST_FD* = 8388608 ## Generated based on /usr/include/linux/videodev2.h:1141:9
else:
  let V4L2_BUF_FLAG_REQUEST_FD* = 8388608 ## Generated based on /usr/include/linux/videodev2.h:1141:9
when 1 is static:
  const
    V4L2_FBUF_CAP_EXTERNOVERLAY* = 1 ## Generated based on /usr/include/linux/videodev2.h:1192:9
else:
  let V4L2_FBUF_CAP_EXTERNOVERLAY* = 1 ## Generated based on /usr/include/linux/videodev2.h:1192:9
when 2 is static:
  const
    V4L2_FBUF_CAP_CHROMAKEY* = 2 ## Generated based on /usr/include/linux/videodev2.h:1193:9
else:
  let V4L2_FBUF_CAP_CHROMAKEY* = 2 ## Generated based on /usr/include/linux/videodev2.h:1193:9
when 4 is static:
  const
    V4L2_FBUF_CAP_LIST_CLIPPING* = 4 ## Generated based on /usr/include/linux/videodev2.h:1194:9
else:
  let V4L2_FBUF_CAP_LIST_CLIPPING* = 4 ## Generated based on /usr/include/linux/videodev2.h:1194:9
when 8 is static:
  const
    V4L2_FBUF_CAP_BITMAP_CLIPPING* = 8 ## Generated based on /usr/include/linux/videodev2.h:1195:9
else:
  let V4L2_FBUF_CAP_BITMAP_CLIPPING* = 8 ## Generated based on /usr/include/linux/videodev2.h:1195:9
when 16 is static:
  const
    V4L2_FBUF_CAP_LOCAL_ALPHA* = 16 ## Generated based on /usr/include/linux/videodev2.h:1196:9
else:
  let V4L2_FBUF_CAP_LOCAL_ALPHA* = 16 ## Generated based on /usr/include/linux/videodev2.h:1196:9
when 32 is static:
  const
    V4L2_FBUF_CAP_GLOBAL_ALPHA* = 32 ## Generated based on /usr/include/linux/videodev2.h:1197:9
else:
  let V4L2_FBUF_CAP_GLOBAL_ALPHA* = 32 ## Generated based on /usr/include/linux/videodev2.h:1197:9
when 64 is static:
  const
    V4L2_FBUF_CAP_LOCAL_INV_ALPHA* = 64 ## Generated based on /usr/include/linux/videodev2.h:1198:9
else:
  let V4L2_FBUF_CAP_LOCAL_INV_ALPHA* = 64 ## Generated based on /usr/include/linux/videodev2.h:1198:9
when 128 is static:
  const
    V4L2_FBUF_CAP_SRC_CHROMAKEY* = 128 ## Generated based on /usr/include/linux/videodev2.h:1199:9
else:
  let V4L2_FBUF_CAP_SRC_CHROMAKEY* = 128 ## Generated based on /usr/include/linux/videodev2.h:1199:9
when 1 is static:
  const
    V4L2_FBUF_FLAG_PRIMARY* = 1 ## Generated based on /usr/include/linux/videodev2.h:1201:9
else:
  let V4L2_FBUF_FLAG_PRIMARY* = 1 ## Generated based on /usr/include/linux/videodev2.h:1201:9
when 2 is static:
  const
    V4L2_FBUF_FLAG_OVERLAY* = 2 ## Generated based on /usr/include/linux/videodev2.h:1202:9
else:
  let V4L2_FBUF_FLAG_OVERLAY* = 2 ## Generated based on /usr/include/linux/videodev2.h:1202:9
when 4 is static:
  const
    V4L2_FBUF_FLAG_CHROMAKEY* = 4 ## Generated based on /usr/include/linux/videodev2.h:1203:9
else:
  let V4L2_FBUF_FLAG_CHROMAKEY* = 4 ## Generated based on /usr/include/linux/videodev2.h:1203:9
when 8 is static:
  const
    V4L2_FBUF_FLAG_LOCAL_ALPHA* = 8 ## Generated based on /usr/include/linux/videodev2.h:1204:9
else:
  let V4L2_FBUF_FLAG_LOCAL_ALPHA* = 8 ## Generated based on /usr/include/linux/videodev2.h:1204:9
when 16 is static:
  const
    V4L2_FBUF_FLAG_GLOBAL_ALPHA* = 16 ## Generated based on /usr/include/linux/videodev2.h:1205:9
else:
  let V4L2_FBUF_FLAG_GLOBAL_ALPHA* = 16 ## Generated based on /usr/include/linux/videodev2.h:1205:9
when 32 is static:
  const
    V4L2_FBUF_FLAG_LOCAL_INV_ALPHA* = 32 ## Generated based on /usr/include/linux/videodev2.h:1206:9
else:
  let V4L2_FBUF_FLAG_LOCAL_INV_ALPHA* = 32 ## Generated based on /usr/include/linux/videodev2.h:1206:9
when 64 is static:
  const
    V4L2_FBUF_FLAG_SRC_CHROMAKEY* = 64 ## Generated based on /usr/include/linux/videodev2.h:1207:9
else:
  let V4L2_FBUF_FLAG_SRC_CHROMAKEY* = 64 ## Generated based on /usr/include/linux/videodev2.h:1207:9
when 1 is static:
  const
    V4L2_MODE_HIGHQUALITY* = 1 ## Generated based on /usr/include/linux/videodev2.h:1237:9
else:
  let V4L2_MODE_HIGHQUALITY* = 1 ## Generated based on /usr/include/linux/videodev2.h:1237:9
when 4096 is static:
  const
    V4L2_CAP_TIMEPERFRAME* = 4096 ## Generated based on /usr/include/linux/videodev2.h:1238:9
else:
  let V4L2_CAP_TIMEPERFRAME* = 4096 ## Generated based on /usr/include/linux/videodev2.h:1238:9
when 0 is static:
  const
    V4L2_STD_UNKNOWN* = 0    ## Generated based on /usr/include/linux/videodev2.h:1418:9
else:
  let V4L2_STD_UNKNOWN* = 0  ## Generated based on /usr/include/linux/videodev2.h:1418:9
when 0 is static:
  const
    V4L2_DV_PROGRESSIVE* = 0 ## Generated based on /usr/include/linux/videodev2.h:1494:9
else:
  let V4L2_DV_PROGRESSIVE* = 0 ## Generated based on /usr/include/linux/videodev2.h:1494:9
when 1 is static:
  const
    V4L2_DV_INTERLACED* = 1  ## Generated based on /usr/include/linux/videodev2.h:1495:9
else:
  let V4L2_DV_INTERLACED* = 1 ## Generated based on /usr/include/linux/videodev2.h:1495:9
when 1 is static:
  const
    V4L2_DV_VSYNC_POS_POL* = 1 ## Generated based on /usr/include/linux/videodev2.h:1498:9
else:
  let V4L2_DV_VSYNC_POS_POL* = 1 ## Generated based on /usr/include/linux/videodev2.h:1498:9
when 2 is static:
  const
    V4L2_DV_HSYNC_POS_POL* = 2 ## Generated based on /usr/include/linux/videodev2.h:1499:9
else:
  let V4L2_DV_HSYNC_POS_POL* = 2 ## Generated based on /usr/include/linux/videodev2.h:1499:9
when 0 is static:
  const
    V4L2_DV_BT_656_1120* = 0 ## Generated based on /usr/include/linux/videodev2.h:1603:9
else:
  let V4L2_DV_BT_656_1120* = 0 ## Generated based on /usr/include/linux/videodev2.h:1603:9
when 1 is static:
  const
    V4L2_INPUT_TYPE_TUNER* = 1 ## Generated based on /usr/include/linux/videodev2.h:1685:9
else:
  let V4L2_INPUT_TYPE_TUNER* = 1 ## Generated based on /usr/include/linux/videodev2.h:1685:9
when 2 is static:
  const
    V4L2_INPUT_TYPE_CAMERA* = 2 ## Generated based on /usr/include/linux/videodev2.h:1686:9
else:
  let V4L2_INPUT_TYPE_CAMERA* = 2 ## Generated based on /usr/include/linux/videodev2.h:1686:9
when 3 is static:
  const
    V4L2_INPUT_TYPE_TOUCH* = 3 ## Generated based on /usr/include/linux/videodev2.h:1687:9
else:
  let V4L2_INPUT_TYPE_TOUCH* = 3 ## Generated based on /usr/include/linux/videodev2.h:1687:9
when 1 is static:
  const
    V4L2_IN_ST_NO_POWER* = 1 ## Generated based on /usr/include/linux/videodev2.h:1690:9
else:
  let V4L2_IN_ST_NO_POWER* = 1 ## Generated based on /usr/include/linux/videodev2.h:1690:9
when 2 is static:
  const
    V4L2_IN_ST_NO_SIGNAL* = 2 ## Generated based on /usr/include/linux/videodev2.h:1691:9
else:
  let V4L2_IN_ST_NO_SIGNAL* = 2 ## Generated based on /usr/include/linux/videodev2.h:1691:9
when 4 is static:
  const
    V4L2_IN_ST_NO_COLOR* = 4 ## Generated based on /usr/include/linux/videodev2.h:1692:9
else:
  let V4L2_IN_ST_NO_COLOR* = 4 ## Generated based on /usr/include/linux/videodev2.h:1692:9
when 16 is static:
  const
    V4L2_IN_ST_HFLIP* = 16   ## Generated based on /usr/include/linux/videodev2.h:1696:9
else:
  let V4L2_IN_ST_HFLIP* = 16 ## Generated based on /usr/include/linux/videodev2.h:1696:9
when 32 is static:
  const
    V4L2_IN_ST_VFLIP* = 32   ## Generated based on /usr/include/linux/videodev2.h:1697:9
else:
  let V4L2_IN_ST_VFLIP* = 32 ## Generated based on /usr/include/linux/videodev2.h:1697:9
when 256 is static:
  const
    V4L2_IN_ST_NO_H_LOCK* = 256 ## Generated based on /usr/include/linux/videodev2.h:1700:9
else:
  let V4L2_IN_ST_NO_H_LOCK* = 256 ## Generated based on /usr/include/linux/videodev2.h:1700:9
when 512 is static:
  const
    V4L2_IN_ST_COLOR_KILL* = 512 ## Generated based on /usr/include/linux/videodev2.h:1701:9
else:
  let V4L2_IN_ST_COLOR_KILL* = 512 ## Generated based on /usr/include/linux/videodev2.h:1701:9
when 1024 is static:
  const
    V4L2_IN_ST_NO_V_LOCK* = 1024 ## Generated based on /usr/include/linux/videodev2.h:1702:9
else:
  let V4L2_IN_ST_NO_V_LOCK* = 1024 ## Generated based on /usr/include/linux/videodev2.h:1702:9
when 2048 is static:
  const
    V4L2_IN_ST_NO_STD_LOCK* = 2048 ## Generated based on /usr/include/linux/videodev2.h:1703:9
else:
  let V4L2_IN_ST_NO_STD_LOCK* = 2048 ## Generated based on /usr/include/linux/videodev2.h:1703:9
when 65536 is static:
  const
    V4L2_IN_ST_NO_SYNC* = 65536 ## Generated based on /usr/include/linux/videodev2.h:1706:9
else:
  let V4L2_IN_ST_NO_SYNC* = 65536 ## Generated based on /usr/include/linux/videodev2.h:1706:9
when 131072 is static:
  const
    V4L2_IN_ST_NO_EQU* = 131072 ## Generated based on /usr/include/linux/videodev2.h:1707:9
else:
  let V4L2_IN_ST_NO_EQU* = 131072 ## Generated based on /usr/include/linux/videodev2.h:1707:9
when 262144 is static:
  const
    V4L2_IN_ST_NO_CARRIER* = 262144 ## Generated based on /usr/include/linux/videodev2.h:1708:9
else:
  let V4L2_IN_ST_NO_CARRIER* = 262144 ## Generated based on /usr/include/linux/videodev2.h:1708:9
when 16777216 is static:
  const
    V4L2_IN_ST_MACROVISION* = 16777216 ## Generated based on /usr/include/linux/videodev2.h:1711:9
else:
  let V4L2_IN_ST_MACROVISION* = 16777216 ## Generated based on /usr/include/linux/videodev2.h:1711:9
when 33554432 is static:
  const
    V4L2_IN_ST_NO_ACCESS* = 33554432 ## Generated based on /usr/include/linux/videodev2.h:1712:9
else:
  let V4L2_IN_ST_NO_ACCESS* = 33554432 ## Generated based on /usr/include/linux/videodev2.h:1712:9
when 67108864 is static:
  const
    V4L2_IN_ST_VTR* = 67108864 ## Generated based on /usr/include/linux/videodev2.h:1713:9
else:
  let V4L2_IN_ST_VTR* = 67108864 ## Generated based on /usr/include/linux/videodev2.h:1713:9
when 2 is static:
  const
    V4L2_IN_CAP_DV_TIMINGS* = 2 ## Generated based on /usr/include/linux/videodev2.h:1716:9
else:
  let V4L2_IN_CAP_DV_TIMINGS* = 2 ## Generated based on /usr/include/linux/videodev2.h:1716:9
when V4L2_IN_CAP_DV_TIMINGS is typedesc:
  type
    V4L2_IN_CAP_CUSTOM_TIMINGS* = V4L2_IN_CAP_DV_TIMINGS ## Generated based on /usr/include/linux/videodev2.h:1717:9
else:
  when V4L2_IN_CAP_DV_TIMINGS is static:
    const
      V4L2_IN_CAP_CUSTOM_TIMINGS* = V4L2_IN_CAP_DV_TIMINGS ## Generated based on /usr/include/linux/videodev2.h:1717:9
  else:
    let V4L2_IN_CAP_CUSTOM_TIMINGS* = V4L2_IN_CAP_DV_TIMINGS ## Generated based on /usr/include/linux/videodev2.h:1717:9
when 4 is static:
  const
    V4L2_IN_CAP_STD* = 4     ## Generated based on /usr/include/linux/videodev2.h:1718:9
else:
  let V4L2_IN_CAP_STD* = 4   ## Generated based on /usr/include/linux/videodev2.h:1718:9
when 8 is static:
  const
    V4L2_IN_CAP_NATIVE_SIZE* = 8 ## Generated based on /usr/include/linux/videodev2.h:1719:9
else:
  let V4L2_IN_CAP_NATIVE_SIZE* = 8 ## Generated based on /usr/include/linux/videodev2.h:1719:9
when 1 is static:
  const
    V4L2_OUTPUT_TYPE_MODULATOR* = 1 ## Generated based on /usr/include/linux/videodev2.h:1735:9
else:
  let V4L2_OUTPUT_TYPE_MODULATOR* = 1 ## Generated based on /usr/include/linux/videodev2.h:1735:9
when 2 is static:
  const
    V4L2_OUTPUT_TYPE_ANALOG* = 2 ## Generated based on /usr/include/linux/videodev2.h:1736:9
else:
  let V4L2_OUTPUT_TYPE_ANALOG* = 2 ## Generated based on /usr/include/linux/videodev2.h:1736:9
when 3 is static:
  const
    V4L2_OUTPUT_TYPE_ANALOGVGAOVERLAY* = 3 ## Generated based on /usr/include/linux/videodev2.h:1737:9
else:
  let V4L2_OUTPUT_TYPE_ANALOGVGAOVERLAY* = 3 ## Generated based on /usr/include/linux/videodev2.h:1737:9
when 2 is static:
  const
    V4L2_OUT_CAP_DV_TIMINGS* = 2 ## Generated based on /usr/include/linux/videodev2.h:1740:9
else:
  let V4L2_OUT_CAP_DV_TIMINGS* = 2 ## Generated based on /usr/include/linux/videodev2.h:1740:9
when V4L2_OUT_CAP_DV_TIMINGS is typedesc:
  type
    V4L2_OUT_CAP_CUSTOM_TIMINGS* = V4L2_OUT_CAP_DV_TIMINGS ## Generated based on /usr/include/linux/videodev2.h:1741:9
else:
  when V4L2_OUT_CAP_DV_TIMINGS is static:
    const
      V4L2_OUT_CAP_CUSTOM_TIMINGS* = V4L2_OUT_CAP_DV_TIMINGS ## Generated based on /usr/include/linux/videodev2.h:1741:9
  else:
    let V4L2_OUT_CAP_CUSTOM_TIMINGS* = V4L2_OUT_CAP_DV_TIMINGS ## Generated based on /usr/include/linux/videodev2.h:1741:9
when 4 is static:
  const
    V4L2_OUT_CAP_STD* = 4    ## Generated based on /usr/include/linux/videodev2.h:1742:9
else:
  let V4L2_OUT_CAP_STD* = 4  ## Generated based on /usr/include/linux/videodev2.h:1742:9
when 8 is static:
  const
    V4L2_OUT_CAP_NATIVE_SIZE* = 8 ## Generated based on /usr/include/linux/videodev2.h:1743:9
else:
  let V4L2_OUT_CAP_NATIVE_SIZE* = 8 ## Generated based on /usr/include/linux/videodev2.h:1743:9
when 268435455 is static:
  const
    V4L2_CTRL_ID_MASK* = 268435455 ## Generated based on /usr/include/linux/videodev2.h:1807:9
else:
  let V4L2_CTRL_ID_MASK* = 268435455 ## Generated based on /usr/include/linux/videodev2.h:1807:9
when 4 is static:
  const
    V4L2_CTRL_MAX_DIMS* = 4  ## Generated based on /usr/include/linux/videodev2.h:1811:9
else:
  let V4L2_CTRL_MAX_DIMS* = 4 ## Generated based on /usr/include/linux/videodev2.h:1811:9
when 0 is static:
  const
    V4L2_CTRL_WHICH_CUR_VAL* = 0 ## Generated based on /usr/include/linux/videodev2.h:1812:9
else:
  let V4L2_CTRL_WHICH_CUR_VAL* = 0 ## Generated based on /usr/include/linux/videodev2.h:1812:9
when 251658240 is static:
  const
    V4L2_CTRL_WHICH_DEF_VAL* = 251658240 ## Generated based on /usr/include/linux/videodev2.h:1813:9
else:
  let V4L2_CTRL_WHICH_DEF_VAL* = 251658240 ## Generated based on /usr/include/linux/videodev2.h:1813:9
when 251723776 is static:
  const
    V4L2_CTRL_WHICH_REQUEST_VAL* = 251723776 ## Generated based on /usr/include/linux/videodev2.h:1814:9
else:
  let V4L2_CTRL_WHICH_REQUEST_VAL* = 251723776 ## Generated based on /usr/include/linux/videodev2.h:1814:9
when 1 is static:
  const
    V4L2_CTRL_FLAG_DISABLED* = 1 ## Generated based on /usr/include/linux/videodev2.h:1909:9
else:
  let V4L2_CTRL_FLAG_DISABLED* = 1 ## Generated based on /usr/include/linux/videodev2.h:1909:9
when 2 is static:
  const
    V4L2_CTRL_FLAG_GRABBED* = 2 ## Generated based on /usr/include/linux/videodev2.h:1910:9
else:
  let V4L2_CTRL_FLAG_GRABBED* = 2 ## Generated based on /usr/include/linux/videodev2.h:1910:9
when 4 is static:
  const
    V4L2_CTRL_FLAG_READ_ONLY* = 4 ## Generated based on /usr/include/linux/videodev2.h:1911:9
else:
  let V4L2_CTRL_FLAG_READ_ONLY* = 4 ## Generated based on /usr/include/linux/videodev2.h:1911:9
when 8 is static:
  const
    V4L2_CTRL_FLAG_UPDATE* = 8 ## Generated based on /usr/include/linux/videodev2.h:1912:9
else:
  let V4L2_CTRL_FLAG_UPDATE* = 8 ## Generated based on /usr/include/linux/videodev2.h:1912:9
when 16 is static:
  const
    V4L2_CTRL_FLAG_INACTIVE* = 16 ## Generated based on /usr/include/linux/videodev2.h:1913:9
else:
  let V4L2_CTRL_FLAG_INACTIVE* = 16 ## Generated based on /usr/include/linux/videodev2.h:1913:9
when 32 is static:
  const
    V4L2_CTRL_FLAG_SLIDER* = 32 ## Generated based on /usr/include/linux/videodev2.h:1914:9
else:
  let V4L2_CTRL_FLAG_SLIDER* = 32 ## Generated based on /usr/include/linux/videodev2.h:1914:9
when 64 is static:
  const
    V4L2_CTRL_FLAG_WRITE_ONLY* = 64 ## Generated based on /usr/include/linux/videodev2.h:1915:9
else:
  let V4L2_CTRL_FLAG_WRITE_ONLY* = 64 ## Generated based on /usr/include/linux/videodev2.h:1915:9
when 128 is static:
  const
    V4L2_CTRL_FLAG_VOLATILE* = 128 ## Generated based on /usr/include/linux/videodev2.h:1916:9
else:
  let V4L2_CTRL_FLAG_VOLATILE* = 128 ## Generated based on /usr/include/linux/videodev2.h:1916:9
when 256 is static:
  const
    V4L2_CTRL_FLAG_HAS_PAYLOAD* = 256 ## Generated based on /usr/include/linux/videodev2.h:1917:9
else:
  let V4L2_CTRL_FLAG_HAS_PAYLOAD* = 256 ## Generated based on /usr/include/linux/videodev2.h:1917:9
when 512 is static:
  const
    V4L2_CTRL_FLAG_EXECUTE_ON_WRITE* = 512 ## Generated based on /usr/include/linux/videodev2.h:1918:9
else:
  let V4L2_CTRL_FLAG_EXECUTE_ON_WRITE* = 512 ## Generated based on /usr/include/linux/videodev2.h:1918:9
when 1024 is static:
  const
    V4L2_CTRL_FLAG_MODIFY_LAYOUT* = 1024 ## Generated based on /usr/include/linux/videodev2.h:1919:9
else:
  let V4L2_CTRL_FLAG_MODIFY_LAYOUT* = 1024 ## Generated based on /usr/include/linux/videodev2.h:1919:9
when 2048 is static:
  const
    V4L2_CTRL_FLAG_DYNAMIC_ARRAY* = 2048 ## Generated based on /usr/include/linux/videodev2.h:1920:9
else:
  let V4L2_CTRL_FLAG_DYNAMIC_ARRAY* = 2048 ## Generated based on /usr/include/linux/videodev2.h:1920:9
when 2147483648 is static:
  const
    V4L2_CTRL_FLAG_NEXT_CTRL* = 2147483648'i64 ## Generated based on /usr/include/linux/videodev2.h:1923:9
else:
  let V4L2_CTRL_FLAG_NEXT_CTRL* = 2147483648'i64 ## Generated based on /usr/include/linux/videodev2.h:1923:9
when 1073741824 is static:
  const
    V4L2_CTRL_FLAG_NEXT_COMPOUND* = 1073741824 ## Generated based on /usr/include/linux/videodev2.h:1924:9
else:
  let V4L2_CTRL_FLAG_NEXT_COMPOUND* = 1073741824 ## Generated based on /usr/include/linux/videodev2.h:1924:9
when 1024 is static:
  const
    V4L2_CID_MAX_CTRLS* = 1024 ## Generated based on /usr/include/linux/videodev2.h:1927:9
else:
  let V4L2_CID_MAX_CTRLS* = 1024 ## Generated based on /usr/include/linux/videodev2.h:1927:9
when 134217728 is static:
  const
    V4L2_CID_PRIVATE_BASE* = 134217728 ## Generated based on /usr/include/linux/videodev2.h:1929:9
else:
  let V4L2_CID_PRIVATE_BASE* = 134217728 ## Generated based on /usr/include/linux/videodev2.h:1929:9
when 1 is static:
  const
    V4L2_TUNER_CAP_LOW* = 1  ## Generated based on /usr/include/linux/videodev2.h:1961:9
else:
  let V4L2_TUNER_CAP_LOW* = 1 ## Generated based on /usr/include/linux/videodev2.h:1961:9
when 2 is static:
  const
    V4L2_TUNER_CAP_NORM* = 2 ## Generated based on /usr/include/linux/videodev2.h:1962:9
else:
  let V4L2_TUNER_CAP_NORM* = 2 ## Generated based on /usr/include/linux/videodev2.h:1962:9
when 4 is static:
  const
    V4L2_TUNER_CAP_HWSEEK_BOUNDED* = 4 ## Generated based on /usr/include/linux/videodev2.h:1963:9
else:
  let V4L2_TUNER_CAP_HWSEEK_BOUNDED* = 4 ## Generated based on /usr/include/linux/videodev2.h:1963:9
when 8 is static:
  const
    V4L2_TUNER_CAP_HWSEEK_WRAP* = 8 ## Generated based on /usr/include/linux/videodev2.h:1964:9
else:
  let V4L2_TUNER_CAP_HWSEEK_WRAP* = 8 ## Generated based on /usr/include/linux/videodev2.h:1964:9
when 16 is static:
  const
    V4L2_TUNER_CAP_STEREO* = 16 ## Generated based on /usr/include/linux/videodev2.h:1965:9
else:
  let V4L2_TUNER_CAP_STEREO* = 16 ## Generated based on /usr/include/linux/videodev2.h:1965:9
when 32 is static:
  const
    V4L2_TUNER_CAP_LANG2* = 32 ## Generated based on /usr/include/linux/videodev2.h:1966:9
else:
  let V4L2_TUNER_CAP_LANG2* = 32 ## Generated based on /usr/include/linux/videodev2.h:1966:9
when 32 is static:
  const
    V4L2_TUNER_CAP_SAP* = 32 ## Generated based on /usr/include/linux/videodev2.h:1967:9
else:
  let V4L2_TUNER_CAP_SAP* = 32 ## Generated based on /usr/include/linux/videodev2.h:1967:9
when 64 is static:
  const
    V4L2_TUNER_CAP_LANG1* = 64 ## Generated based on /usr/include/linux/videodev2.h:1968:9
else:
  let V4L2_TUNER_CAP_LANG1* = 64 ## Generated based on /usr/include/linux/videodev2.h:1968:9
when 128 is static:
  const
    V4L2_TUNER_CAP_RDS* = 128 ## Generated based on /usr/include/linux/videodev2.h:1969:9
else:
  let V4L2_TUNER_CAP_RDS* = 128 ## Generated based on /usr/include/linux/videodev2.h:1969:9
when 256 is static:
  const
    V4L2_TUNER_CAP_RDS_BLOCK_IO* = 256 ## Generated based on /usr/include/linux/videodev2.h:1970:9
else:
  let V4L2_TUNER_CAP_RDS_BLOCK_IO* = 256 ## Generated based on /usr/include/linux/videodev2.h:1970:9
when 512 is static:
  const
    V4L2_TUNER_CAP_RDS_CONTROLS* = 512 ## Generated based on /usr/include/linux/videodev2.h:1971:9
else:
  let V4L2_TUNER_CAP_RDS_CONTROLS* = 512 ## Generated based on /usr/include/linux/videodev2.h:1971:9
when 1024 is static:
  const
    V4L2_TUNER_CAP_FREQ_BANDS* = 1024 ## Generated based on /usr/include/linux/videodev2.h:1972:9
else:
  let V4L2_TUNER_CAP_FREQ_BANDS* = 1024 ## Generated based on /usr/include/linux/videodev2.h:1972:9
when 2048 is static:
  const
    V4L2_TUNER_CAP_HWSEEK_PROG_LIM* = 2048 ## Generated based on /usr/include/linux/videodev2.h:1973:9
else:
  let V4L2_TUNER_CAP_HWSEEK_PROG_LIM* = 2048 ## Generated based on /usr/include/linux/videodev2.h:1973:9
when 4096 is static:
  const
    V4L2_TUNER_CAP_1HZ* = 4096 ## Generated based on /usr/include/linux/videodev2.h:1974:9
else:
  let V4L2_TUNER_CAP_1HZ* = 4096 ## Generated based on /usr/include/linux/videodev2.h:1974:9
when 1 is static:
  const
    V4L2_TUNER_SUB_MONO* = 1 ## Generated based on /usr/include/linux/videodev2.h:1977:9
else:
  let V4L2_TUNER_SUB_MONO* = 1 ## Generated based on /usr/include/linux/videodev2.h:1977:9
when 2 is static:
  const
    V4L2_TUNER_SUB_STEREO* = 2 ## Generated based on /usr/include/linux/videodev2.h:1978:9
else:
  let V4L2_TUNER_SUB_STEREO* = 2 ## Generated based on /usr/include/linux/videodev2.h:1978:9
when 4 is static:
  const
    V4L2_TUNER_SUB_LANG2* = 4 ## Generated based on /usr/include/linux/videodev2.h:1979:9
else:
  let V4L2_TUNER_SUB_LANG2* = 4 ## Generated based on /usr/include/linux/videodev2.h:1979:9
when 4 is static:
  const
    V4L2_TUNER_SUB_SAP* = 4  ## Generated based on /usr/include/linux/videodev2.h:1980:9
else:
  let V4L2_TUNER_SUB_SAP* = 4 ## Generated based on /usr/include/linux/videodev2.h:1980:9
when 8 is static:
  const
    V4L2_TUNER_SUB_LANG1* = 8 ## Generated based on /usr/include/linux/videodev2.h:1981:9
else:
  let V4L2_TUNER_SUB_LANG1* = 8 ## Generated based on /usr/include/linux/videodev2.h:1981:9
when 16 is static:
  const
    V4L2_TUNER_SUB_RDS* = 16 ## Generated based on /usr/include/linux/videodev2.h:1982:9
else:
  let V4L2_TUNER_SUB_RDS* = 16 ## Generated based on /usr/include/linux/videodev2.h:1982:9
when 0 is static:
  const
    V4L2_TUNER_MODE_MONO* = 0 ## Generated based on /usr/include/linux/videodev2.h:1985:9
else:
  let V4L2_TUNER_MODE_MONO* = 0 ## Generated based on /usr/include/linux/videodev2.h:1985:9
when 1 is static:
  const
    V4L2_TUNER_MODE_STEREO* = 1 ## Generated based on /usr/include/linux/videodev2.h:1986:9
else:
  let V4L2_TUNER_MODE_STEREO* = 1 ## Generated based on /usr/include/linux/videodev2.h:1986:9
when 2 is static:
  const
    V4L2_TUNER_MODE_LANG2* = 2 ## Generated based on /usr/include/linux/videodev2.h:1987:9
else:
  let V4L2_TUNER_MODE_LANG2* = 2 ## Generated based on /usr/include/linux/videodev2.h:1987:9
when 2 is static:
  const
    V4L2_TUNER_MODE_SAP* = 2 ## Generated based on /usr/include/linux/videodev2.h:1988:9
else:
  let V4L2_TUNER_MODE_SAP* = 2 ## Generated based on /usr/include/linux/videodev2.h:1988:9
when 3 is static:
  const
    V4L2_TUNER_MODE_LANG1* = 3 ## Generated based on /usr/include/linux/videodev2.h:1989:9
else:
  let V4L2_TUNER_MODE_LANG1* = 3 ## Generated based on /usr/include/linux/videodev2.h:1989:9
when 4 is static:
  const
    V4L2_TUNER_MODE_LANG1_LANG2* = 4 ## Generated based on /usr/include/linux/videodev2.h:1990:9
else:
  let V4L2_TUNER_MODE_LANG1_LANG2* = 4 ## Generated based on /usr/include/linux/videodev2.h:1990:9
when 7 is static:
  const
    V4L2_RDS_BLOCK_MSK* = 7  ## Generated based on /usr/include/linux/videodev2.h:2035:9
else:
  let V4L2_RDS_BLOCK_MSK* = 7 ## Generated based on /usr/include/linux/videodev2.h:2035:9
when 0 is static:
  const
    V4L2_RDS_BLOCK_A* = 0    ## Generated based on /usr/include/linux/videodev2.h:2036:9
else:
  let V4L2_RDS_BLOCK_A* = 0  ## Generated based on /usr/include/linux/videodev2.h:2036:9
when 1 is static:
  const
    V4L2_RDS_BLOCK_B* = 1    ## Generated based on /usr/include/linux/videodev2.h:2037:9
else:
  let V4L2_RDS_BLOCK_B* = 1  ## Generated based on /usr/include/linux/videodev2.h:2037:9
when 2 is static:
  const
    V4L2_RDS_BLOCK_C* = 2    ## Generated based on /usr/include/linux/videodev2.h:2038:9
else:
  let V4L2_RDS_BLOCK_C* = 2  ## Generated based on /usr/include/linux/videodev2.h:2038:9
when 3 is static:
  const
    V4L2_RDS_BLOCK_D* = 3    ## Generated based on /usr/include/linux/videodev2.h:2039:9
else:
  let V4L2_RDS_BLOCK_D* = 3  ## Generated based on /usr/include/linux/videodev2.h:2039:9
when 4 is static:
  const
    V4L2_RDS_BLOCK_C_ALT* = 4 ## Generated based on /usr/include/linux/videodev2.h:2040:9
else:
  let V4L2_RDS_BLOCK_C_ALT* = 4 ## Generated based on /usr/include/linux/videodev2.h:2040:9
when 7 is static:
  const
    V4L2_RDS_BLOCK_INVALID* = 7 ## Generated based on /usr/include/linux/videodev2.h:2041:9
else:
  let V4L2_RDS_BLOCK_INVALID* = 7 ## Generated based on /usr/include/linux/videodev2.h:2041:9
when 64 is static:
  const
    V4L2_RDS_BLOCK_CORRECTED* = 64 ## Generated based on /usr/include/linux/videodev2.h:2043:9
else:
  let V4L2_RDS_BLOCK_CORRECTED* = 64 ## Generated based on /usr/include/linux/videodev2.h:2043:9
when 128 is static:
  const
    V4L2_RDS_BLOCK_ERROR* = 128 ## Generated based on /usr/include/linux/videodev2.h:2044:9
else:
  let V4L2_RDS_BLOCK_ERROR* = 128 ## Generated based on /usr/include/linux/videodev2.h:2044:9
when 1 is static:
  const
    V4L2_AUDCAP_STEREO* = 1  ## Generated based on /usr/include/linux/videodev2.h:2058:9
else:
  let V4L2_AUDCAP_STEREO* = 1 ## Generated based on /usr/include/linux/videodev2.h:2058:9
when 2 is static:
  const
    V4L2_AUDCAP_AVL* = 2     ## Generated based on /usr/include/linux/videodev2.h:2059:9
else:
  let V4L2_AUDCAP_AVL* = 2   ## Generated based on /usr/include/linux/videodev2.h:2059:9
when 1 is static:
  const
    V4L2_AUDMODE_AVL* = 1    ## Generated based on /usr/include/linux/videodev2.h:2062:9
else:
  let V4L2_AUDMODE_AVL* = 1  ## Generated based on /usr/include/linux/videodev2.h:2062:9
when 0 is static:
  const
    V4L2_ENC_IDX_FRAME_I* = 0 ## Generated based on /usr/include/linux/videodev2.h:2076:9
else:
  let V4L2_ENC_IDX_FRAME_I* = 0 ## Generated based on /usr/include/linux/videodev2.h:2076:9
when 1 is static:
  const
    V4L2_ENC_IDX_FRAME_P* = 1 ## Generated based on /usr/include/linux/videodev2.h:2077:9
else:
  let V4L2_ENC_IDX_FRAME_P* = 1 ## Generated based on /usr/include/linux/videodev2.h:2077:9
when 2 is static:
  const
    V4L2_ENC_IDX_FRAME_B* = 2 ## Generated based on /usr/include/linux/videodev2.h:2078:9
else:
  let V4L2_ENC_IDX_FRAME_B* = 2 ## Generated based on /usr/include/linux/videodev2.h:2078:9
when 15 is static:
  const
    V4L2_ENC_IDX_FRAME_MASK* = 15 ## Generated based on /usr/include/linux/videodev2.h:2079:9
else:
  let V4L2_ENC_IDX_FRAME_MASK* = 15 ## Generated based on /usr/include/linux/videodev2.h:2079:9
when 64 is static:
  const
    V4L2_ENC_IDX_ENTRIES* = 64 ## Generated based on /usr/include/linux/videodev2.h:2089:9
else:
  let V4L2_ENC_IDX_ENTRIES* = 64 ## Generated based on /usr/include/linux/videodev2.h:2089:9
when 0 is static:
  const
    V4L2_ENC_CMD_START* = 0  ## Generated based on /usr/include/linux/videodev2.h:2098:9
else:
  let V4L2_ENC_CMD_START* = 0 ## Generated based on /usr/include/linux/videodev2.h:2098:9
when 1 is static:
  const
    V4L2_ENC_CMD_STOP* = 1   ## Generated based on /usr/include/linux/videodev2.h:2099:9
else:
  let V4L2_ENC_CMD_STOP* = 1 ## Generated based on /usr/include/linux/videodev2.h:2099:9
when 2 is static:
  const
    V4L2_ENC_CMD_PAUSE* = 2  ## Generated based on /usr/include/linux/videodev2.h:2100:9
else:
  let V4L2_ENC_CMD_PAUSE* = 2 ## Generated based on /usr/include/linux/videodev2.h:2100:9
when 3 is static:
  const
    V4L2_ENC_CMD_RESUME* = 3 ## Generated based on /usr/include/linux/videodev2.h:2101:9
else:
  let V4L2_ENC_CMD_RESUME* = 3 ## Generated based on /usr/include/linux/videodev2.h:2101:9
when 0 is static:
  const
    V4L2_DEC_CMD_START* = 0  ## Generated based on /usr/include/linux/videodev2.h:2117:9
else:
  let V4L2_DEC_CMD_START* = 0 ## Generated based on /usr/include/linux/videodev2.h:2117:9
when 1 is static:
  const
    V4L2_DEC_CMD_STOP* = 1   ## Generated based on /usr/include/linux/videodev2.h:2118:9
else:
  let V4L2_DEC_CMD_STOP* = 1 ## Generated based on /usr/include/linux/videodev2.h:2118:9
when 2 is static:
  const
    V4L2_DEC_CMD_PAUSE* = 2  ## Generated based on /usr/include/linux/videodev2.h:2119:9
else:
  let V4L2_DEC_CMD_PAUSE* = 2 ## Generated based on /usr/include/linux/videodev2.h:2119:9
when 3 is static:
  const
    V4L2_DEC_CMD_RESUME* = 3 ## Generated based on /usr/include/linux/videodev2.h:2120:9
else:
  let V4L2_DEC_CMD_RESUME* = 3 ## Generated based on /usr/include/linux/videodev2.h:2120:9
when 4 is static:
  const
    V4L2_DEC_CMD_FLUSH* = 4  ## Generated based on /usr/include/linux/videodev2.h:2121:9
else:
  let V4L2_DEC_CMD_FLUSH* = 4 ## Generated based on /usr/include/linux/videodev2.h:2121:9
when 0 is static:
  const
    V4L2_DEC_START_FMT_NONE* = 0 ## Generated based on /usr/include/linux/videodev2.h:2136:9
else:
  let V4L2_DEC_START_FMT_NONE* = 0 ## Generated based on /usr/include/linux/videodev2.h:2136:9
when 1 is static:
  const
    V4L2_DEC_START_FMT_GOP* = 1 ## Generated based on /usr/include/linux/videodev2.h:2138:9
else:
  let V4L2_DEC_START_FMT_GOP* = 1 ## Generated based on /usr/include/linux/videodev2.h:2138:9
when 1 is static:
  const
    V4L2_VBI_ITU_525_F1_START* = 1 ## Generated based on /usr/include/linux/videodev2.h:2191:9
else:
  let V4L2_VBI_ITU_525_F1_START* = 1 ## Generated based on /usr/include/linux/videodev2.h:2191:9
when 264 is static:
  const
    V4L2_VBI_ITU_525_F2_START* = 264 ## Generated based on /usr/include/linux/videodev2.h:2192:9
else:
  let V4L2_VBI_ITU_525_F2_START* = 264 ## Generated based on /usr/include/linux/videodev2.h:2192:9
when 1 is static:
  const
    V4L2_VBI_ITU_625_F1_START* = 1 ## Generated based on /usr/include/linux/videodev2.h:2193:9
else:
  let V4L2_VBI_ITU_625_F1_START* = 1 ## Generated based on /usr/include/linux/videodev2.h:2193:9
when 314 is static:
  const
    V4L2_VBI_ITU_625_F2_START* = 314 ## Generated based on /usr/include/linux/videodev2.h:2194:9
else:
  let V4L2_VBI_ITU_625_F2_START* = 314 ## Generated based on /usr/include/linux/videodev2.h:2194:9
when 1 is static:
  const
    V4L2_SLICED_TELETEXT_B* = 1 ## Generated based on /usr/include/linux/videodev2.h:2216:9
else:
  let V4L2_SLICED_TELETEXT_B* = 1 ## Generated based on /usr/include/linux/videodev2.h:2216:9
when 1024 is static:
  const
    V4L2_SLICED_VPS* = 1024  ## Generated based on /usr/include/linux/videodev2.h:2218:9
else:
  let V4L2_SLICED_VPS* = 1024 ## Generated based on /usr/include/linux/videodev2.h:2218:9
when 4096 is static:
  const
    V4L2_SLICED_CAPTION_525* = 4096 ## Generated based on /usr/include/linux/videodev2.h:2220:9
else:
  let V4L2_SLICED_CAPTION_525* = 4096 ## Generated based on /usr/include/linux/videodev2.h:2220:9
when 16384 is static:
  const
    V4L2_SLICED_WSS_625* = 16384 ## Generated based on /usr/include/linux/videodev2.h:2222:9
else:
  let V4L2_SLICED_WSS_625* = 16384 ## Generated based on /usr/include/linux/videodev2.h:2222:9
when V4L2_SLICED_CAPTION_525 is typedesc:
  type
    V4L2_SLICED_VBI_525* = V4L2_SLICED_CAPTION_525 ## Generated based on /usr/include/linux/videodev2.h:2224:9
else:
  when V4L2_SLICED_CAPTION_525 is static:
    const
      V4L2_SLICED_VBI_525* = V4L2_SLICED_CAPTION_525 ## Generated based on /usr/include/linux/videodev2.h:2224:9
  else:
    let V4L2_SLICED_VBI_525* = V4L2_SLICED_CAPTION_525 ## Generated based on /usr/include/linux/videodev2.h:2224:9
when 1 is static:
  const
    V4L2_MPEG_VBI_IVTV_TELETEXT_B* = 1 ## Generated based on /usr/include/linux/videodev2.h:2263:9
else:
  let V4L2_MPEG_VBI_IVTV_TELETEXT_B* = 1 ## Generated based on /usr/include/linux/videodev2.h:2263:9
when 4 is static:
  const
    V4L2_MPEG_VBI_IVTV_CAPTION_525* = 4 ## Generated based on /usr/include/linux/videodev2.h:2264:9
else:
  let V4L2_MPEG_VBI_IVTV_CAPTION_525* = 4 ## Generated based on /usr/include/linux/videodev2.h:2264:9
when 5 is static:
  const
    V4L2_MPEG_VBI_IVTV_WSS_625* = 5 ## Generated based on /usr/include/linux/videodev2.h:2265:9
else:
  let V4L2_MPEG_VBI_IVTV_WSS_625* = 5 ## Generated based on /usr/include/linux/videodev2.h:2265:9
when 7 is static:
  const
    V4L2_MPEG_VBI_IVTV_VPS* = 7 ## Generated based on /usr/include/linux/videodev2.h:2266:9
else:
  let V4L2_MPEG_VBI_IVTV_VPS* = 7 ## Generated based on /usr/include/linux/videodev2.h:2266:9
when "itv0" is static:
  const
    V4L2_MPEG_VBI_IVTV_MAGIC0* = "itv0" ## Generated based on /usr/include/linux/videodev2.h:2282:9
else:
  let V4L2_MPEG_VBI_IVTV_MAGIC0* = "itv0" ## Generated based on /usr/include/linux/videodev2.h:2282:9
when "ITV0" is static:
  const
    V4L2_MPEG_VBI_IVTV_MAGIC1* = "ITV0" ## Generated based on /usr/include/linux/videodev2.h:2283:9
else:
  let V4L2_MPEG_VBI_IVTV_MAGIC1* = "ITV0" ## Generated based on /usr/include/linux/videodev2.h:2283:9
when 0 is static:
  const
    V4L2_EVENT_ALL* = 0      ## Generated based on /usr/include/linux/videodev2.h:2409:9
else:
  let V4L2_EVENT_ALL* = 0    ## Generated based on /usr/include/linux/videodev2.h:2409:9
when 1 is static:
  const
    V4L2_EVENT_VSYNC* = 1    ## Generated based on /usr/include/linux/videodev2.h:2410:9
else:
  let V4L2_EVENT_VSYNC* = 1  ## Generated based on /usr/include/linux/videodev2.h:2410:9
when 2 is static:
  const
    V4L2_EVENT_EOS* = 2      ## Generated based on /usr/include/linux/videodev2.h:2411:9
else:
  let V4L2_EVENT_EOS* = 2    ## Generated based on /usr/include/linux/videodev2.h:2411:9
when 3 is static:
  const
    V4L2_EVENT_CTRL* = 3     ## Generated based on /usr/include/linux/videodev2.h:2412:9
else:
  let V4L2_EVENT_CTRL* = 3   ## Generated based on /usr/include/linux/videodev2.h:2412:9
when 4 is static:
  const
    V4L2_EVENT_FRAME_SYNC* = 4 ## Generated based on /usr/include/linux/videodev2.h:2413:9
else:
  let V4L2_EVENT_FRAME_SYNC* = 4 ## Generated based on /usr/include/linux/videodev2.h:2413:9
when 5 is static:
  const
    V4L2_EVENT_SOURCE_CHANGE* = 5 ## Generated based on /usr/include/linux/videodev2.h:2414:9
else:
  let V4L2_EVENT_SOURCE_CHANGE* = 5 ## Generated based on /usr/include/linux/videodev2.h:2414:9
when 6 is static:
  const
    V4L2_EVENT_MOTION_DET* = 6 ## Generated based on /usr/include/linux/videodev2.h:2415:9
else:
  let V4L2_EVENT_MOTION_DET* = 6 ## Generated based on /usr/include/linux/videodev2.h:2415:9
when 134217728 is static:
  const
    V4L2_EVENT_PRIVATE_START* = 134217728 ## Generated based on /usr/include/linux/videodev2.h:2416:9
else:
  let V4L2_EVENT_PRIVATE_START* = 134217728 ## Generated based on /usr/include/linux/videodev2.h:2416:9
when 0 is static:
  const
    V4L2_CHIP_MATCH_BRIDGE* = 0 ## Generated based on /usr/include/linux/videodev2.h:2505:9
else:
  let V4L2_CHIP_MATCH_BRIDGE* = 0 ## Generated based on /usr/include/linux/videodev2.h:2505:9
when 4 is static:
  const
    V4L2_CHIP_MATCH_SUBDEV* = 4 ## Generated based on /usr/include/linux/videodev2.h:2506:9
else:
  let V4L2_CHIP_MATCH_SUBDEV* = 4 ## Generated based on /usr/include/linux/videodev2.h:2506:9
when V4L2_CHIP_MATCH_BRIDGE is typedesc:
  type
    V4L2_CHIP_MATCH_HOST* = V4L2_CHIP_MATCH_BRIDGE ## Generated based on /usr/include/linux/videodev2.h:2509:9
else:
  when V4L2_CHIP_MATCH_BRIDGE is static:
    const
      V4L2_CHIP_MATCH_HOST* = V4L2_CHIP_MATCH_BRIDGE ## Generated based on /usr/include/linux/videodev2.h:2509:9
  else:
    let V4L2_CHIP_MATCH_HOST* = V4L2_CHIP_MATCH_BRIDGE ## Generated based on /usr/include/linux/videodev2.h:2509:9
when 1 is static:
  const
    V4L2_CHIP_MATCH_I2C_DRIVER* = 1 ## Generated based on /usr/include/linux/videodev2.h:2510:9
else:
  let V4L2_CHIP_MATCH_I2C_DRIVER* = 1 ## Generated based on /usr/include/linux/videodev2.h:2510:9
when 2 is static:
  const
    V4L2_CHIP_MATCH_I2C_ADDR* = 2 ## Generated based on /usr/include/linux/videodev2.h:2511:9
else:
  let V4L2_CHIP_MATCH_I2C_ADDR* = 2 ## Generated based on /usr/include/linux/videodev2.h:2511:9
when 3 is static:
  const
    V4L2_CHIP_MATCH_AC97* = 3 ## Generated based on /usr/include/linux/videodev2.h:2512:9
else:
  let V4L2_CHIP_MATCH_AC97* = 3 ## Generated based on /usr/include/linux/videodev2.h:2512:9
when 192 is static:
  const
    BASE_VIDIOC_PRIVATE* = 192 ## Generated based on /usr/include/linux/videodev2.h:2670:9
else:
  let BASE_VIDIOC_PRIVATE* = 192 ## Generated based on /usr/include/linux/videodev2.h:2670:9
when V4L2_PIX_FMT_NV12_16L16 is typedesc:
  type
    V4L2_PIX_FMT_HM12* = V4L2_PIX_FMT_NV12_16L16 ## Generated based on /usr/include/linux/videodev2.h:2673:9
else:
  when V4L2_PIX_FMT_NV12_16L16 is static:
    const
      V4L2_PIX_FMT_HM12* = V4L2_PIX_FMT_NV12_16L16 ## Generated based on /usr/include/linux/videodev2.h:2673:9
  else:
    let V4L2_PIX_FMT_HM12* = V4L2_PIX_FMT_NV12_16L16 ## Generated based on /usr/include/linux/videodev2.h:2673:9
when V4L2_PIX_FMT_NV12_32L32 is typedesc:
  type
    V4L2_PIX_FMT_SUNXI_TILED_NV12* = V4L2_PIX_FMT_NV12_32L32 ## Generated based on /usr/include/linux/videodev2.h:2674:9
else:
  when V4L2_PIX_FMT_NV12_32L32 is static:
    const
      V4L2_PIX_FMT_SUNXI_TILED_NV12* = V4L2_PIX_FMT_NV12_32L32 ## Generated based on /usr/include/linux/videodev2.h:2674:9
  else:
    let V4L2_PIX_FMT_SUNXI_TILED_NV12* = V4L2_PIX_FMT_NV12_32L32 ## Generated based on /usr/include/linux/videodev2.h:2674:9
when 33554432 is static:
  const
    V4L2_CAP_ASYNCIO* = 33554432 ## Generated based on /usr/include/linux/videodev2.h:2679:9
else:
  let V4L2_CAP_ASYNCIO* = 33554432 ## Generated based on /usr/include/linux/videodev2.h:2679:9