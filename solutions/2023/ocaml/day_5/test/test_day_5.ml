let test f input expected () = Alcotest.(check int) "same" expected (f input)
let data_dir = Sys.getcwd () ^ "/../../../../../_data/day_5/"

let () =
  Alcotest.run "Day 5: If You Give A Seed A Fertilizer"
    [
      ( "examples",
        [
          ( "silver",
            `Quick,
            test Day_5.silver (Day_5__Fs.read_file (data_dir ^ "silver.txt")) 35
          );
          (* "gold", `Quick, test Day_5.gold (Day_5__Fs.read_file (data_dir ^ "gold.txt")) xxx; *)
        ] );
    ]
