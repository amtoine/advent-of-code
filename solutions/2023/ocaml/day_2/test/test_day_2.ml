let data_dir = Sys.getcwd () ^ "/../../../../../../../data/2023/day_2/"

let test name f input expected =
  let input = Day_2__Fs.read_file (data_dir ^ input) |> String.trim in
  let expected =
    Day_2__Fs.read_file (data_dir ^ expected) |> String.trim |> int_of_string
  in
  (name, `Quick, fun () -> Alcotest.(check int) "same" expected (f input))

let () =
  Alcotest.run "Day 2: Cube Conundrum"
    [
      ( "examples",
        [
          test "silver" Day_2.silver "silver/input.txt" "silver/expected.txt";
          test "gold" Day_2.gold "gold/input.txt" "gold/expected.txt";
          test "amtoine-silver" Day_2.silver "amtoine/input.txt"
            "amtoine/silver-expected.txt";
          test "amtoine-gold" Day_2.gold "amtoine/input.txt"
            "amtoine/gold-expected.txt";
        ] );
    ]
