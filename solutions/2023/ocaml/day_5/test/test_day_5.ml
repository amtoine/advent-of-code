let test f input expected () = Alcotest.(check int) "same" expected (f input)
let data_dir = Sys.getcwd () ^ "/../../../../../_data/day_5/"

let () =
  Alcotest.run "Day 5: If You Give A Seed A Fertilizer"
    [
      ( "examples",
        [
          ( "silver",
            `Quick,
            test Day_5.silver (Day_5__Fs.read_file (data_dir ^ "silver/input.txt")) 35
          );
          ( "amtoine-silver",
            `Quick,
            test Day_5.silver
              (Day_5__Fs.read_file (data_dir ^ "amtoine/input.txt"))
              199602917 );
          ( "gold",
            `Quick,
            test Day_5.gold (Day_5__Fs.read_file (data_dir ^ "gold/input.txt")) 46
          );
          (* ( "amtoine-gold", *)
          (*   `Quick, *)
          (*   test Day_5.gold *)
          (*     (Day_5__Fs.read_file (data_dir ^ "amtoine/input.txt")) *)
          (*     2254686 ); *)
        ] );
    ]
