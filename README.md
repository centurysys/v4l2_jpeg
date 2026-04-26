# v4l2_jpeg

V4L2 M2M JPEG encoder library for Linux (Nim).

This library provides a simple, high-level API to use hardware JPEG
encoders (e.g. TI E5010 on AM67A) via V4L2, with automatic device
detection and quality control.

------------------------------------------------------------------------

## Features

-   Automatic V4L2 JPEG encoder detection
-   NV12 / NM12 input support
-   Hardware-accelerated JPEG encoding
-   Adjustable JPEG quality (via V4L2 controls)
-   Simple, reusable API
-   Zero-copy friendly design

------------------------------------------------------------------------

## Requirements

-   Linux with V4L2 M2M support
-   A JPEG encoder device (e.g. `/dev/videoX`)
-   Supported pixel formats:
    -   Input: NV12 / NM12
    -   Output: JPEG

------------------------------------------------------------------------

## Installation

Add as a Nimble dependency or clone into your project.

------------------------------------------------------------------------

## Quick Example

``` nim
import v4l2_jpeg

let enc = ?JpegEncoder.open(1920, 1080)

let jpeg = ?enc.encode(frame)
echo jpeg.len
```

------------------------------------------------------------------------

## Device Selection

If no device is specified, the library automatically selects a usable
JPEG encoder:

``` nim
let enc = ?JpegEncoder.open(1920, 1080)
```

To specify manually:

``` nim
let enc = ?JpegEncoder.open(1920, 1080, device="/dev/video0")
```

------------------------------------------------------------------------

## Quality Control

Set default quality at open:

``` nim
let enc = ?JpegEncoder.open(1920, 1080, quality=90)
```

Override per encode:

``` nim
let jpeg = ?enc.encode(frame, quality=70)
```

------------------------------------------------------------------------

## Performance

Typical performance (AM67A + E5010):

-   1920x1080 NV12 → JPEG: \~7--8 ms per frame

------------------------------------------------------------------------

## Design Notes

-   Uses V4L2 M2M API directly (no GStreamer dependency)
-   Separates low-level bindings from high-level API
-   Designed to integrate with libyuv for color conversion

------------------------------------------------------------------------

## Future Work

-   RGBA/RGB support via libyuv integration
-   TurboJPEG fallback
-   H.264/HEVC encoder support

------------------------------------------------------------------------

## License

MIT
