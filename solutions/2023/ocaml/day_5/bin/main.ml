let () =
  let input_file = Sys.getcwd () ^ "/../../_data/day_5/" ^ Sys.argv.(2) in
  let input = Day_5__Fs.read_file input_file in
  let res =
    match Sys.argv.(1) with
    | "silver" -> Day_5.silver input
    | "gold" -> Day_5.gold input
    | x ->
        failwith
          ("unknown command '" ^ x ^ "'" ^ " (expected 'silver' or 'gold')")
  in
  print_int res
