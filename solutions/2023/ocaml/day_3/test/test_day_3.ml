let test f input expected () = Alcotest.(check int) "same" expected (f input)
let data_dir = Sys.getcwd () ^ "/../../../../../_data/day_3/"

let () =
  Alcotest.run "Day 3: Gear Ratios"
    [
      ( "examples",
        [
          ( "silver",
            `Quick,
            test Day_3.silver
              (Day_3__Fs.read_file (data_dir ^ "silver/input.txt"))
              (Day_3__Fs.read_file (data_dir ^ "silver/expected.txt")
              |> String.trim |> int_of_string) );
          ( "amtoine-silver",
            `Quick,
            test Day_3.silver
              (Day_3__Fs.read_file (data_dir ^ "amtoine/input.txt"))
              (Day_3__Fs.read_file (data_dir ^ "amtoine/silver-expected.txt")
              |> String.trim |> int_of_string) );
          ( "gold",
            `Quick,
            test Day_3.gold
              (Day_3__Fs.read_file (data_dir ^ "gold/input.txt"))
              (Day_3__Fs.read_file (data_dir ^ "gold/expected.txt")
              |> String.trim |> int_of_string) );
          ( "amtoine-gold",
            `Quick,
            test Day_3.gold
              (Day_3__Fs.read_file (data_dir ^ "amtoine/input.txt"))
              (Day_3__Fs.read_file (data_dir ^ "amtoine/gold-expected.txt")
              |> String.trim |> int_of_string) );
        ] );
    ]
