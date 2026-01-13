discard """
ic - IceCream-style debug printing for Nim

A debugging library inspired by Python's icecream that provides
colored, informative debug output with variable names, values,
timestamps, and source locations.

Configuration vua compile-time defines

```
-d:ic                         # Enable all ic macros (ic, icr, icb, icy)
-d:icg                        # Enable ic macro only (green)
-d:icr                        # Enable icr macro only (red)
-d:icb                        # Enable icb macro only (blue)
-d:icy                        # Enable icy macro only (yellow)
-d:"ic.show_time=true"        # Show timestamp in output
-d:"ic.show_location=true"    # Show file:line in output
-d:"ic.show_variable=true"    # Show variable name in output
-d:"ic.show_value=true"       # Show value in output
-d:"ic.hrdt=true"             # Use human readable datetime
-d:"ic.prefix=MyApp"          # Add custom prefix to output
```

## Basic Usage

```proj.nim
import ic

let x = 42
let name = "hello"

ic x           # Green: prints 'x' ==> 42
icr name       # Red: prints 'name' ==> "hello"
icb x, name    # Blue: prints both variables
icy x + 1      # Yellow: prints 'x + 1' ==> 43


Compile with -d:ic to see output:
nim c -r -d:ic proj.nim 

Compile with -d:icg to enable only ic (green)
nim c -r -d:icg proj.nim 

Compile with -d:icr to enable only icr (red)
nim c -r -d:icr proj.nim 

Compile with -d:icb to enable only icb (blue)
nim c -r -d:icb proj.nim 

Compile with -d:icy to enable only icy (yellow)
nim c -r -d:icy proj.nim 

Compile with multiple defines:
nim c -r -d:icg -d:icy proj.nim 

Compile with custom configuration:
nim c -r -d:ic -d:ic.show_time=true -d:ic.show_location=true -d:ic.prefix=TestApp proj.nim 

nim c -r -d:ic -d:ic.show_time=false -d:ic.show_location=true -d:ic.prefix=TestApp proj.nim 

nim c -r -d:ic -d:ic.show_time=false -d:ic.show_location=false -d:ic.prefix=TestApp proj.nim 


```
"""

import ic/config      ; export config
import ic/checkpoints ; export checkpoints

when defined(nimscript):
  import ic/nimscript_impl
  export nimscript_impl

elif defined(js):
  import ic/js_impl
  export js_impl

else:
  import ic/native_impl
  export native_impl