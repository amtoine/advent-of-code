let () =
  let input_file =
    Sys.getcwd () ^ "/../../../../data/2023/day_1/" ^ Sys.argv.(2)
  in
  let input = Day_1__Fs.read_file input_file |> String.trim in
  let res =
    match Sys.argv.(1) with
    | "silver" -> Day_1.silver input
    | "gold" -> Day_1.gold input
    | x ->
        failwith
          ("unknown command '" ^ x ^ "'" ^ " (expected 'silver' or 'gold')")
  in
  print_int res
