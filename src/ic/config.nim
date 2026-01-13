## Configuration constants and shared utilities for ic
## 
## All configuration is done via compile-time defines.

const 
  ic_show_time*     {.booldefine: "ic.show_time".}     : bool   = true
  ic_show_location* {.booldefine: "ic.show_location".} : bool   = true
  ic_show_variable* {.booldefine: "ic.show_variable".} : bool   = true
  ic_show_value*    {.booldefine: "ic.show_value".}    : bool   = true
  ic_hrdt*          {.booldefine: "ic.hrdt".}          : bool   = false
  ic_prefix*        {.strdefine:  "ic.prefix".}        : string = ""

