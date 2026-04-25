import std/[strformat, oserrors]
import results
export results

# ------------------------------------------------------------------------------
# Error type aliases
# ------------------------------------------------------------------------------
type
  HyperJpegError* = object of CatchableError
  HE* = ref HyperJpegError
  HJResult*[T] = Result[T, HE]

# ------------------------------------------------------------------------------
# Constructors
# ------------------------------------------------------------------------------
proc makeError*(msg: string): HE =
  result = newException(HyperJpegError, msg)

# ------------------------------------------------------------------------------
# OS / ioctl helpers
# ------------------------------------------------------------------------------
proc makeIoctlError*(op: string; code: OSErrorCode = osLastError()): HE =
  result = newException(HyperJpegError,
    &"{op} failed: errno={int(code)} ({osErrorMsg(code)})"
  )

proc raiseIoctlError*(op: string) {.noreturn.} =
  raise makeIoctlError(op)

proc failIoctl*[T](op: string): HJResult[T] =
  result = err[T, HE](makeIoctlError(op))
