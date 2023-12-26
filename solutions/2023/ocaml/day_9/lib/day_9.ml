let parse input =
  String.split_on_char '\n' input
  |> List.map (fun s -> s |> String.split_on_char ' ' |> List.map int_of_string)

let next s =
  let rec aux acc s =
    if List.fold_left ( + ) 0 s = 0 then acc
    else
      let new_acc = (List.hd @@ List.rev s) :: acc in
      let new_s =
        List.map2
          (fun a b -> b - a)
          (List.rev @@ List.tl @@ List.rev s)
          (List.tl s)
      in
      aux new_acc new_s
  in
  let last = aux [] s in
  List.fold_left ( + ) 0 last

let silver input =
  let sequences = parse input in
  List.fold_left ( + ) 0 (List.map next sequences)

let gold input = String.length input
