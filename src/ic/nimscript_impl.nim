## NimScript implementation of ic macros
## 
## Used when running in nimscript context (e.g., .nims files, nimble tasks)
## Note: Color support depends on the nimscript environment

import std/macros

# Note: In nimscript, we don't have access to times module the same way
# These templates provide basic functionality

template ic_inner*(incoming: untyped, str_lit: string): untyped = 
  when defined(ic) or defined(icg):
    let info           = instantiationInfo(fullPaths = true)
    let formatted_info = info.filename & ":" & $info.line
    var output = formatted_info & " " & "'" & str_lit & "'" & " ==> " & $incoming
    echo output

template icr_inner*(incoming: untyped, str_lit: string): untyped =
  when defined(ic) or defined(icr):
    let info           = instantiationInfo(fullPaths = true)
    let formatted_info = info.filename & ":" & $info.line
    var output = formatted_info & " " & "'" & str_lit & "'" & " ==> " & $incoming
    echo output

template icb_inner*(incoming: untyped, str_lit: string): untyped =
  when defined(ic) or defined(icb):
    let info           = instantiationInfo(fullPaths = true)
    let formatted_info = info.filename & ":" & $info.line
    var output = formatted_info & " " & "'" & str_lit & "'" & " ==> " & $incoming
    echo output

template icy_inner*(incoming: untyped, str_lit: string): untyped =
  when defined(ic) or defined(icy):
    let info           = instantiationInfo(fullPaths = true)
    let formatted_info = info.filename & ":" & $info.line
    var output = formatted_info & " " & "'" & str_lit & "'" & " ==> " & $incoming
    echo output

template echog*(msg: string) =
  ## Echo with location info (green style)
  let info           = instantiationInfo(fullPaths = true)
  let formatted_info = info.filename & ":" & $info.line
  echo formatted_info & " " & msg

template echor*(msg: string) =
  ## Echo with location info (red style)
  let info           = instantiationInfo(fullPaths = true)
  let formatted_info = info.filename & ":" & $info.line
  echo formatted_info & " " & msg

template echob*(msg: string) =
  ## Echo with location info (blue style)
  let info           = instantiationInfo(fullPaths = true)
  let formatted_info = info.filename & ":" & $info.line
  echo formatted_info & " " & msg

template echoy*(msg: string) =
  ## Echo with location info (yellow style)
  let info           = instantiationInfo(fullPaths = true)
  let formatted_info = info.filename & ":" & $info.line
  echo formatted_info & " " & msg

macro ic*(args: varargs[untyped]): untyped =
  result = newNimNode(nnkStmtList, args)
  for a in args:
    result.add newCall(bindSym"ic_inner", a, toStrLit(a))

macro icr*(args: varargs[untyped]): untyped =
  result = newNimNode(nnkStmtList, args)
  for a in args:
    result.add newCall(bindSym"icr_inner", a, toStrLit(a))

macro icb*(args: varargs[untyped]): untyped =
  result = newNimNode(nnkStmtList, args)
  for a in args:
    result.add newCall(bindSym"icb_inner", a, toStrLit(a))

macro icy*(args: varargs[untyped]): untyped =
  result = newNimNode(nnkStmtList, args)
  for a in args:
    result.add newCall(bindSym"icy_inner", a, toStrLit(a))