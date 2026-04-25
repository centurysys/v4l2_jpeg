# v4l2_jpeg

## Overview
`v4l2_jpeg` is an ultra-fast JPEG encoder for embedded Linux systems using V4L2 M2M hardware acceleration.

This implementation is designed for Texas Instruments AM67A (e5010 JPEG encoder) and achieves extremely high performance compared to software encoders like libjpeg-turbo.

## Performance

Measured on AM67A (Cortex-A53 environment):

- Resolution: 1920x1080 (Full HD)
- Quality: 90
- Encoding time: **~7.5 ms per frame**

This is significantly faster than CPU-based JPEG encoding.

## Features

- Hardware-accelerated JPEG encoding via V4L2 M2M
- NV12/NM12 input support
- Low-latency encoding
- Designed for real-time pipelines
- Nim-friendly API

## Notes

- This implementation is **hardware-dependent**
- Currently verified only on:
  - TI AM67A (e5010 JPEG encoder)
- Requires proper V4L2 driver support

## Typical Pipeline

```
NV12 input -> v4l2_jpeg -> JPEG output
```

For best performance, avoid RGB/RGBA conversions and stay in YUV formats.

