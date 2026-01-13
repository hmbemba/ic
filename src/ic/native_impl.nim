## Native implementation of ic macros
## 
## Used when compiling for native targets (not JS, not nimscript)

import std/[terminal, macros, times, sequtils, strutils]
import ./config

# Generic ref stringify - sometimes you might need to do:
proc `$`(r: ref): string =
  if r.isNil: "nil"
  else: system.`$` r[]

proc now_unix: int64 = 
  now().toTime.toUnix

proc unix_to_human_readable(unix_time: int): string = 
  unix_time.fromUnix().format("yyyy-MM-dd h:mmtt")

# Color output procs
proc green*(body: string) = stdout.styledWriteLine(fgGreen, body)
proc red*(body: string)   = stdout.styledWriteLine(fgRed, body)
proc blue*(body: string)  = stdout.styledWriteLine(fgBlue, body)
proc ylw*(body: string)   = stdout.styledWriteLine(fgYellow, body)

template ic_inner*(incoming: untyped, str_lit: string): untyped = 
  when defined(ic) or defined(icg):
    let 
      info           = instantiationInfo(fullPaths = true)
      formatted_info = info.filename & ":" & $info.line
    var output = ""
    
    when ic_prefix != "": 
      output &= ic_prefix & " | "
    when ic_show_time: 
      when ic_hrdt:
        output &= unix_to_human_readable(now_unix().int) & " | "
      else:
        output &= $now_unix() & " | "
    when ic_show_location: 
      output &= formatted_info & " | "
    when ic_show_variable: 
      output &= "'" & str_lit & "'" & " | "
    when ic_show_value: 
      output &= $incoming
    
    output.green

template icr_inner*(incoming: untyped, str_lit: string): untyped = 
  when defined(ic) or defined(icr):
    let 
      info           = instantiationInfo(fullPaths = true)
      formatted_info = info.filename & ":" & $info.line
    var output = ""
    
    when ic_prefix != "": 
      output &= ic_prefix & " | "
    when ic_show_time: 
      when ic_hrdt:
        output &= unix_to_human_readable(now_unix().int) & " | "
      else:
        output &= $now_unix() & " | "
    when ic_show_location: 
      output &= formatted_info & " | "
    when ic_show_variable: 
      output &= "'" & str_lit & "'" & " | "
    when ic_show_value: 
      output &= $incoming
    
    output.red

template icb_inner*(incoming: untyped, str_lit: string): untyped = 
  when defined(ic) or defined(icb):
    let 
      info           = instantiationInfo(fullPaths = true)
      formatted_info = info.filename & ":" & $info.line
    var output = ""
    
    when ic_prefix != "": 
      output &= ic_prefix & " | "
    when ic_show_time: 
      when ic_hrdt:
        output &= unix_to_human_readable(now_unix().int) & " | "
      else:
        output &= $now_unix() & " | "
    when ic_show_location: 
      output &= formatted_info & " | "
    when ic_show_variable: 
      output &= "'" & str_lit & "'" & " | "
    when ic_show_value: 
      output &= $incoming
    
    output.blue

template icy_inner*(incoming: untyped, str_lit: string): untyped = 
  when defined(ic) or defined(icy):
    let 
      info           = instantiationInfo(fullPaths = true)
      formatted_info = info.filename & ":" & $info.line
    var output = ""
    
    when ic_prefix != "": 
      output &= ic_prefix & " | "
    when ic_show_time: 
      when ic_hrdt:
        output &= unix_to_human_readable(now_unix().int) & " | "
      else:
        output &= $now_unix() & " | "
    when ic_show_location: 
      output &= formatted_info & " | "
    when ic_show_variable: 
      output &= "'" & str_lit & "'" & " | "
    when ic_show_value: 
      output &= $incoming
    
    output.ylw

# Main macros
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