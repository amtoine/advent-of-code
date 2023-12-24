let parse input =
  let id, draws =
    match String.split_on_char ':' input with
    | [ id; draws ] -> (id, draws)
    | _ -> failwith "woopsie on ':'"
  in
  let id =
    match String.split_on_char ' ' id with
    | [ _; id ] -> int_of_string id
    | _ -> failwith "woopsie on ' ' for id"
  in
  let draws =
    String.split_on_char ';' draws
    |> List.map (String.split_on_char ',')
    |> List.flatten |> List.map String.trim
    |> List.map (fun draw ->
           match String.split_on_char ' ' draw with
           | [ n; t ] -> (int_of_string n, t)
           | _ -> failwith "woopsie on ' ' for draw")
  in
  (id, draws)

let invalid_draw (n, c) =
  match c with
  | "blue" -> n > 14
  | "red" -> n > 12
  | "green" -> n > 13
  | _ -> true

let power draw =
  let aux c draw =
    List.filter (fun d -> snd d = c) draw
    |> List.map fst |> List.fold_left max 0
  in
  let blue = aux "blue" draw in
  let red = aux "red" draw in
  let green = aux "green" draw in
  blue * red * green

let silver input =
  String.split_on_char '\n' input
  |> List.map parse
  |> List.filter_map (fun x ->
         if List.exists invalid_draw (snd x) then None else Some (fst x))
  |> List.fold_left ( + ) 0

let gold input =
  String.split_on_char '\n' input
  |> List.map parse |> List.map snd |> List.map power |> List.fold_left ( + ) 0
