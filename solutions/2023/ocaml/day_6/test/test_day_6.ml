let data_dir = Sys.getcwd () ^ "/../../../../../../../data/2023/day_6/"

let test name f input expected =
  let input = Day_6__Fs.read_file (data_dir ^ input) |> String.trim in
  let expected =
    Day_6__Fs.read_file (data_dir ^ expected) |> String.trim |> int_of_string
  in
  (name, `Quick, fun () -> Alcotest.(check int) "same" expected (f input))

let () =
  Alcotest.run "Day 6: Wait For It"
    [
      ( "examples",
        [
          test "silver" Day_6.silver "silver/input.txt" "silver/expected.txt";
          test "gold" Day_6.gold "gold/input.txt" "gold/expected.txt";
          test "amtoine-silver" Day_6.silver "amtoine/input.txt"
            "amtoine/silver-expected.txt";
          test "amtoine-gold" Day_6.gold "amtoine/input.txt"
            "amtoine/gold-expected.txt";
        ] );
    ]
