let () =
  let input_file =
    Sys.getcwd () ^ "/../../../../data/2023/day_9/" ^ Sys.argv.(2)
  in
  let input = Day_9__Fs.read_file input_file |> String.trim in
  let res =
    match Sys.argv.(1) with
    | "silver" -> Day_9.silver input
    | "gold" -> Day_9.gold input
    | x ->
        failwith
          ("unknown command '" ^ x ^ "'" ^ " (expected 'silver' or 'gold')")
  in
  print_int res
