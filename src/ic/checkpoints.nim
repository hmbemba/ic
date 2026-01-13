# Checkpoint logging

when defined(js):
    template blok*(tag:string, body:untyped) : untyped = 
        body

when not defined(js) and not defined(nimscript):
    import std/terminal

    proc mag(body:string) = stdout.styledWriteLine(fgMagenta, body)

    template cp* : untyped = 
        when defined(cp): 
            block:
                let 
                    info              = instantiationInfo(fullPaths = true)
                    formatted_info    = "CHECKPOINT: " & info.filename & ":" & $info.line
                formatted_info.mag
            
    template blok*(tag:string, body:untyped) : untyped = 
        when defined(cp): 
            block:
                let 
                    info              = instantiationInfo(fullPaths = true)
                    formatted_info    = "CHECKPOINT: " & info.filename & ":" & $info.line & " ==> " & tag
                formatted_info.mag
        body

