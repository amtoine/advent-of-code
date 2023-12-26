let data_dir = Sys.getcwd () ^ "/../../../../../../../data/2023/day_10/"

let test name f input expected =
  let input = Day_10__Fs.read_file (data_dir ^ input) |> String.trim in
  let expected =
    Day_10__Fs.read_file (data_dir ^ expected) |> String.trim |> int_of_string
  in
  (name, `Quick, fun () -> Alcotest.(check int) "same" expected (f input))

let () =
  Alcotest.run "Day 10: Pipe Maze"
    [
      ( "examples",
        [
          test "silver-1" Day_10.silver "silver/1/input.txt" "silver/1/expected.txt";
          test "silver-2" Day_10.silver "silver/2/input.txt" "silver/2/expected.txt";
          test "gold-1" Day_10.gold "gold/1/input.txt" "gold/1/expected.txt";
          test "gold-2" Day_10.gold "gold/2/input.txt" "gold/2/expected.txt";
          test "gold-3" Day_10.gold "gold/3/input.txt" "gold/3/expected.txt";
          test "gold-4" Day_10.gold "gold/4/input.txt" "gold/4/expected.txt";
          test "gold-5" Day_10.gold "gold/5/input.txt" "gold/5/expected.txt";
          test "amtoine-silver" Day_10.silver "amtoine/input.txt"
            "amtoine/silver-expected.txt";
          (* test "amtoine-gold" Day_10.gold "amtoine/input.txt" *)
          (*   "amtoine/gold-expected.txt"; *)
        ] );
    ]
