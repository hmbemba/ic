import unittest
import ic
import os


discard """

## Basic Usage
nim c -r -d:ic tests/test_ic.nim ; rm tests/test_ic.exe

Compile with -d:icg to enable only ic (green)
nim c -r -d:icg tests/test_ic.nim ; rm tests/test_ic.exe

Compile with -d:icr to enable only icr (red)
nim c -r -d:icr tests/test_ic.nim ; rm tests/test_ic.exe

Compile with -d:icb to enable only icb (blue)
nim c -r -d:icb tests/test_ic.nim ; rm tests/test_ic.exe

Compile with -d:icy to enable only icy (yellow)
nim c -r -d:icy tests/test_ic.nim ; rm tests/test_ic.exe

Compile with multiple defines:
nim c -r -d:icg -d:icy tests/test_ic.nim ; rm tests/test_ic.exe

Compile with custom configuration:
nim c -r -d:ic -d:ic.show_time=true -d:ic.show_location=true -d:ic.prefix=TestApp tests/test_ic.nim ; rm tests/test_ic.exe

nim c -r -d:ic -d:ic.show_time=false -d:ic.show_location=true -d:ic.prefix=TestApp tests/test_ic.nim ; rm tests/test_ic.exe

nim c -r -d:ic -d:ic.show_time=false -d:ic.show_location=false -d:ic.prefix=TestApp tests/test_ic.nim ; rm tests/test_ic.exe

"""

suite "ic basic tests":
  test "ic compiles without error":
    let x = 42
    let s = "hello"
    let arr = @[1, 2, 3]
    
    # These should compile and run without error
    # Output only visible when compiled with -d:ic
    ic x
    icr s
    icb arr
    icy x + 10

  test "ic handles multiple args":
    let a = 1
    let b = 2
    let c = 3
    
    ic a, b, c

  test "ic handles expressions":
    let x = 10
    ic x * 2
    ic x > 5
    ic @[x, x+1, x+2]

  test "ic handles ref types":
    type Foo = ref object
      value: int
    
    var f: Foo = nil
    ic f  # should show nil
    
    f = Foo(value: 123)
    ic f  # should show the object

  test "all colors work":
    let msg = "test message"
    ic msg   # green
    icr msg  # red
    icb msg  # blue
    icy msg  # yellow

  test "expensive call not evaluated when disabled":
    var counter = 0
    proc expensiveCall(): int =
      inc counter
      sleep 1_000
      return 99

    # Compile without -d:ic to disable ic macros
    ic expensiveCall()
    icr expensiveCall()
    icb expensiveCall()
    icy expensiveCall()

    # Counter should remain 0 if ic macros are disabled
    when defined(ic) or defined(icg) or defined(icr) or defined(icb) or defined(icy):
      check counter > 0
    else:
      check counter == 0