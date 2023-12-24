let test f input expected () = Alcotest.(check int) "same" expected (f input)
let data_dir = Sys.getcwd () ^ "/../../../../../_data/day_4/"

let () =
  Alcotest.run "Day 4: Scratchcards"
    [
      ( "examples",
        [
          ( "silver",
            `Quick,
            test Day_4.silver (Day_4__Fs.read_file (data_dir ^ "silver/input.txt")) 13
          );
          ( "amtoine-silver",
            `Quick,
            test Day_4.silver
              (Day_4__Fs.read_file (data_dir ^ "amtoine/input.txt"))
              28750 );
          ( "gold",
            `Quick,
            test Day_4.gold (Day_4__Fs.read_file (data_dir ^ "silver/input.txt")) 30
          );
          ( "amtoine-gold",
            `Quick,
            test Day_4.gold
              (Day_4__Fs.read_file (data_dir ^ "amtoine/input.txt"))
              10212704 );
        ] );
    ]
