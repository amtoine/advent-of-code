let test f input expected () = Alcotest.(check int) "same" expected (f input)
let data_dir = Sys.getcwd () ^ "/../../../../../_data/day_2/"

let () =
  Alcotest.run "Day 2: Cube Conundrum"
    [
      ( "examples",
        [
          ( "silver",
            `Quick,
            test Day_2.silver (Day_2__Fs.read_file (data_dir ^ "silver.txt")) 8
          );
          ( "gold",
            `Quick,
            test Day_2.gold (Day_2__Fs.read_file (data_dir ^ "gold.txt")) 2286
          );
          ( "amtoine-silver",
            `Quick,
            test Day_2.silver
              (Day_2__Fs.read_file (data_dir ^ "amtoine.txt"))
              2164 );
          ( "amtoine-gold",
            `Quick,
            test Day_2.gold
              (Day_2__Fs.read_file (data_dir ^ "amtoine.txt"))
              69929 );
        ] );
    ]
