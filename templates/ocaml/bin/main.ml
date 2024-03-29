let () =
  let input_file =
    Sys.getcwd () ^ "/../../../../data/yyyy/day_x/" ^ Sys.argv.(2)
  in
  let input = Day_x__Fs.read_file input_file |> String.trim in
  let res =
    match Sys.argv.(1) with
    | "silver" -> Day_x.silver input
    | "gold" -> Day_x.gold input
    | x ->
        failwith
          ("unknown command '" ^ x ^ "'" ^ " (expected 'silver' or 'gold')")
  in
  print_int res
