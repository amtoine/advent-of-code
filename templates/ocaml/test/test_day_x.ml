let data_dir = Sys.getcwd () ^ "/../../../../../_data/day_x/"

let test name f input expected =
  let input = Day_x__Fs.read_file (data_dir ^ input) |> String.trim in
  let expected =
    Day_x__Fs.read_file (data_dir ^ expected) |> String.trim |> int_of_string
  in
  (name, `Quick, fun () -> Alcotest.(check int) "same" expected (f input))

let () =
  Alcotest.run xxx
    [
      ( "examples",
        [
          test "silver" Day_x.silver "silver/input.txt" "silver/expected.txt";
          (* test "gold" Day_x.gold "gold/input.txt" "gold/expected.txt"; *)
          (* test "amtoine-silver" Day_x.silver "amtoine/input.txt" *)
          (*   "amtoine/silver-expected.txt"; *)
          (* test "amtoine-gold" Day_x.gold "amtoine/input.txt" *)
          (*   "amtoine/gold-expected.txt"; *)
        ] );
    ]
