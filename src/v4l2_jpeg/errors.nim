import std/[strformat, oserrors]
import results
export results

# ------------------------------------------------------------------------------
# Error type aliases
# ------------------------------------------------------------------------------
type
  V4L2JpegError* = object of CatchableError
  VJE* = ref V4L2JpegError
  JpegResult*[T] = Result[T, VJE]

# ------------------------------------------------------------------------------
# Constructors
# ------------------------------------------------------------------------------
proc makeError*(msg: string): VJE =
  result = newException(V4L2JpegError, msg)

# ------------------------------------------------------------------------------
# OS / ioctl helpers
# ------------------------------------------------------------------------------
proc makeIoctlError*(op: string; code: OSErrorCode = osLastError()): VJE =
  result = newException(V4L2JpegError,
    &"{op} failed: errno={int(code)} ({osErrorMsg(code)})"
  )

proc raiseIoctlError*(op: string) {.noreturn.} =
  raise makeIoctlError(op)

proc failIoctl*[T](op: string): JpegResult[T] =
  result = err[T, VJE](makeIoctlError(op))
