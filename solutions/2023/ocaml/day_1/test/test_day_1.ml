let test f input expected () = Alcotest.(check int) "same" expected (f input)
let data_dir = Sys.getcwd () ^ "/../../../../../_data/day_1/"

let () =
  Alcotest.run "Day 1: Trebuchet?!"
    [
      ( "examples",
        [
          ( "silver",
            `Quick,
            test Day_1.silver
              (Day_1__Fs.read_file (data_dir ^ "silver/input.txt"))
              142 );
          ( "gold",
            `Quick,
            test Day_1.gold (Day_1__Fs.read_file (data_dir ^ "gold/input.txt")) 281 );
          ( "amtoine-silver",
            `Quick,
            test Day_1.silver
              (Day_1__Fs.read_file (data_dir ^ "amtoine/input.txt"))
              53974 );
          ( "amtoine-gold",
            `Quick,
            test Day_1.gold
              (Day_1__Fs.read_file (data_dir ^ "amtoine/input.txt"))
              52840 );
        ] );
    ]
