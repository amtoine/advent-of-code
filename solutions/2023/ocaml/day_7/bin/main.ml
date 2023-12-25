let () =
  let input_file =
    Sys.getcwd () ^ "/../../../../data/2023/day_7/" ^ Sys.argv.(2)
  in
  let input = Day_7__Fs.read_file input_file |> String.trim in
  let res =
    match Sys.argv.(1) with
    | "silver" -> Day_7.silver input
    | "gold" -> Day_7.gold input
    | x ->
        failwith
          ("unknown command '" ^ x ^ "'" ^ " (expected 'silver' or 'gold')")
  in
  print_int res
