let () =
  let input_file = Sys.getcwd () ^ "/../../_data/day_2/" ^ Sys.argv.(2) in
  let input = Day_2__Fs.read_file input_file in
  let res =
    match Sys.argv.(1) with
    | "silver" -> Day_2.silver input
    | "gold" -> Day_2.gold input
    | x ->
        failwith
          ("unknown command '" ^ x ^ "'" ^ " (expected 'silver' or 'gold')")
  in
  print_int res
