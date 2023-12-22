let test f input expected () =
    Alcotest.(check int) "same" expected (f input)

let data_dir = Sys.getcwd () ^ "/../../../../../_data/day_2/"

let () =
    Alcotest.run "Day 1: Trebuchet?!" [
        "examples", [
            "silver", `Quick, test Day_2.silver (Day_2__Fs.read_file (data_dir ^ "silver.txt")) 8;
        ]
    ]
