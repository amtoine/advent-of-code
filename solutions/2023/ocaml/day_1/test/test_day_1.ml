let test f input expected () =
    Alcotest.(check int) "same" expected (f input)

let test_dir = Sys.getcwd () ^ "/../../../test/"

let () =
    Alcotest.run "Day 1: Trebuchet?!" [
        "examples", [
            "silver", `Quick, test Day_1.silver (Day_1.read_file (test_dir ^ "silver.txt")) 142;
            "gold", `Quick, test Day_1.gold (Day_1.read_file (test_dir ^ "gold.txt")) 281;
        ]
    ]
