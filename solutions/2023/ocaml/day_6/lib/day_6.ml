let parse input =
  let time_distance = String.split_on_char '\n' input in
  let time =
    List.nth (List.hd time_distance |> String.split_on_char ':') 1
    |> String.split_on_char ' '
    |> List.filter (fun x -> x <> "")
    |> List.map int_of_string
  in
  let distance =
    List.nth (List.nth time_distance 1 |> String.split_on_char ':') 1
    |> String.split_on_char ' '
    |> List.filter (fun x -> x <> "")
    |> List.map int_of_string
  in
  List.combine time distance

let silver input =
  let races = parse input in
  List.map
    (fun (t, d) ->
      let delta = float_of_int ((t * t) - (4 * d)) in
      let s_delta = sqrt delta in
      let t = float_of_int t in
      let t_1 = int_of_float @@ floor (((t -. s_delta) /. 2.) +. 1.) in
      let t_2 = int_of_float @@ ceil (((t +. s_delta) /. 2.) -. 1.) in
      t_2 - t_1 + 1)
    races
  |> List.fold_left ( * ) 1

let parse_gold input =
  let time_distance = String.split_on_char '\n' input in
  let time =
    List.nth (List.hd time_distance |> String.split_on_char ':') 1
    |> String.split_on_char ' '
    |> List.filter (fun x -> x <> "")
    |> List.fold_left ( ^ ) "" |> int_of_string
  in
  let distance =
    List.nth (List.nth time_distance 1 |> String.split_on_char ':') 1
    |> String.split_on_char ' '
    |> List.filter (fun x -> x <> "")
    |> List.fold_left ( ^ ) "" |> int_of_string
  in
  (time, distance)

let gold input =
  let t, d = parse_gold input in
  let delta = float_of_int ((t * t) - (4 * d)) in
  let s_delta = sqrt delta in
  let t = float_of_int t in
  let t_1 = int_of_float @@ floor (((t -. s_delta) /. 2.) +. 1.) in
  let t_2 = int_of_float @@ ceil (((t +. s_delta) /. 2.) -. 1.) in
  t_2 - t_1 + 1
