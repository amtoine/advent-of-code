let data_dir = Sys.getcwd () ^ "/../../../../../../../data/2023/day_12/"

let test name speed f input expected =
  let input = Day_12__Fs.read_file (data_dir ^ input) |> String.trim in
  let expected =
    Day_12__Fs.read_file (data_dir ^ expected) |> String.trim |> int_of_string
  in
  (name, speed, fun () -> Alcotest.(check int) "same" expected (f input))

let () =
  Alcotest.run "Day 12: Hot Springs"
    [
      ( "examples",
        [
          test "silver" `Quick Day_12.silver "silver/input.txt"
            "silver/expected.txt";
          (* test "gold" Day_12.gold "gold/input.txt" "gold/expected.txt"; *)
          test "amtoine-silver" `Slow Day_12.silver "amtoine/input.txt"
            "amtoine/silver-expected.txt";
          (* test "amtoine-gold" Day_12.gold "amtoine/input.txt" *)
          (*   "amtoine/gold-expected.txt"; *)
        ] );
    ]
