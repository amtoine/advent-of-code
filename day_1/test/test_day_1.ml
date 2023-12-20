open Alcotest

let test f input expected () =
    check int "same" expected (f input)

let silver = "1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet"

let suite = [
    "example", `Quick, test Day_1.silver silver 142
]

let () =
    Alcotest.run "Day 1: Trebuchet?!" [ "silver", suite ]
