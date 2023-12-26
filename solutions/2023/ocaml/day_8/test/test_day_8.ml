let data_dir = Sys.getcwd () ^ "/../../../../../../../data/2023/day_8/"

let test name f input expected =
  let input = Day_8__Fs.read_file (data_dir ^ input) |> String.trim in
  let expected =
    Day_8__Fs.read_file (data_dir ^ expected) |> String.trim |> int_of_string
  in
  (name, `Quick, fun () -> Alcotest.(check int) "same" expected (f input))

let () =
  Alcotest.run "Day 8: Haunted Wasteland"
    [
      ( "examples",
        [
          test "silver-1" Day_8.silver "silver/1/input.txt" "silver/1/expected.txt";
          test "silver-2" Day_8.silver "silver/2/input.txt" "silver/2/expected.txt";
          (* test "gold" Day_8.gold "gold/input.txt" "gold/expected.txt"; *)
          test "amtoine-silver" Day_8.silver "amtoine/input.txt"
            "amtoine/silver-expected.txt";
          (* test "amtoine-gold" Day_8.gold "amtoine/input.txt" *)
          (*   "amtoine/gold-expected.txt"; *)
        ] );
    ]
