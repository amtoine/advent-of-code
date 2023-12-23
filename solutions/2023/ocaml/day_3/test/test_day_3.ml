let test f input expected () =
    Alcotest.(check int) "same" expected (f input)

let data_dir = Sys.getcwd () ^ "/../../../../../_data/day_3/"

let () =
    Alcotest.run "Day 3: Gear Ratios" [
        "examples", [
            "silver", `Quick, test Day_3.silver (Day_3__Fs.read_file (data_dir ^ "silver.txt")) 4361;
            "amtoine-silver", `Quick, test Day_3.silver (Day_3__Fs.read_file (data_dir ^ "amtoine.txt")) 557705;
            "gold", `Quick, test Day_3.gold (Day_3__Fs.read_file (data_dir ^ "silver.txt")) 467835;
            "amtoine-gold", `Quick, test Day_3.gold (Day_3__Fs.read_file (data_dir ^ "amtoine.txt")) 84266818;
        ]
    ]
