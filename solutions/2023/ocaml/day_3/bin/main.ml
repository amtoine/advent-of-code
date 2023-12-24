let () =
  let input_file = Sys.getcwd () ^ "/../../_data/day_3/" ^ Sys.argv.(2) in
  let input = Day_3__Fs.read_file input_file |> String.trim in
  let res =
    match Sys.argv.(1) with
    | "silver" -> Day_3.silver input
    | "gold" -> Day_3.gold input
    | x ->
        failwith
          ("unknown command '" ^ x ^ "'" ^ " (expected 'silver' or 'gold')")
  in
  print_int res
