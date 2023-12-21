open Alcotest

let test f input expected () =
    check int "same" expected (f input)

let test_dir = Sys.getcwd () ^ "/../../../test/"

let suite = [
    "example", `Quick, test Day_1.silver (Day_1.read_file (test_dir ^ "silver.txt")) 142;
    "example", `Quick, test Day_1.silver (Day_1.read_file (test_dir ^ "gold.txt")) 281;
]

let () =
    Alcotest.run "Day 1: Trebuchet?!" [ "silver", suite ]
