## JavaScript implementation of ic macros
## 
## Maps to browser console methods with appropriate log levels

import jsconsole

template ic*(body: varargs[untyped]): untyped = 
  when defined(ic):
    console.trace body

template icr*(body: varargs[untyped]): untyped =
  when defined(ic):
    console.error body

template icb*(body: varargs[untyped]): untyped =
  when defined(ic):
    console.info body

template icy*(body: varargs[untyped]): untyped =
  when defined(ic):
    console.warn body

template group*(body: untyped): untyped =
  ## Create a console group without a label
  when defined(ic):
    console.group()
    body
    {.emit: "console.groupEnd()".}

template group*(group_label: cstring, body: untyped): untyped =
  ## Create a labeled console group
  when defined(ic):
    console.group(group_label)
    body
    {.emit: "console.groupEnd()".}