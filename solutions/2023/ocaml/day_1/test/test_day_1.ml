open Alcotest

let test f input expected () =
    check int "same" expected (f input)

let read_channel channel =
    let buffer = Buffer.create 4096 in
    let rec loop () =
        let line = input_line channel in
        Buffer.add_string buffer line;
        Buffer.add_char buffer '\n';
        loop ()
    in
        try loop () with
            End_of_file -> Buffer.contents buffer

let read_file filename =
    let channel = open_in (Sys.getcwd () ^ "/../../../test/" ^ filename) in
        read_channel channel

let suite = [
    "example", `Quick, test Day_1.silver (read_file "silver.txt") 142
]

let () =
    Alcotest.run "Day 1: Trebuchet?!" [ "silver", suite ]
