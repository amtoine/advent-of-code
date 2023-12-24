let data_dir = Sys.getcwd () ^ "/../../../../../_data/day_4/"

let test name f input expected =
  let input = Day_4__Fs.read_file (data_dir ^ input) in
  let expected =
    Day_4__Fs.read_file (data_dir ^ expected) |> String.trim |> int_of_string
  in
  (name, `Quick, fun () -> Alcotest.(check int) "same" expected (f input))

let () =
  Alcotest.run "Day 4: Scratchcards"
    [
      ( "examples",
        [
          test "silver" Day_4.silver "silver/input.txt" "silver/expected.txt";
          test "gold" Day_4.gold "gold/input.txt" "gold/expected.txt";
          test "amtoine-silver" Day_4.silver "amtoine/input.txt"
            "amtoine/silver-expected.txt";
          test "amtoine-gold" Day_4.gold "amtoine/input.txt"
            "amtoine/gold-expected.txt";
        ] );
    ]
