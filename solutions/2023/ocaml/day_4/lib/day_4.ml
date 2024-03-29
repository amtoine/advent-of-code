(** parse a list of numbers with format "x x x x x" *)
let parse_numbers numbers =
  String.split_on_char ' ' numbers
  |> List.filter (fun x -> x <> "")
  |> List.map int_of_string

(** parse a card with format "...: x x x x | x x x x x" *)
let parse_card card =
  let raw = List.nth (String.split_on_char ':' card) 1 in
  let winner_and_user = String.split_on_char '|' raw in
  ( parse_numbers (List.nth winner_and_user 0),
    parse_numbers (List.nth winner_and_user 1) )

(** compute x to the power of p

    p should be positive.
*)
let rec pow x p = if p = 0 then 1 else x * pow x (p - 1)

let silver input =
  let lines = String.split_on_char '\n' input in
  List.map
    (fun l ->
      let w, u = parse_card l in
      let n = List.filter (fun x -> List.mem x w) u |> List.length in
      if n >= 1 then pow 2 (n - 1) else 0)
    lines
  |> List.fold_left ( + ) 0

let gold input =
  let wins =
    String.split_on_char '\n' input
    |> List.map (fun l ->
           let w, u = parse_card l in
           List.filter (fun x -> List.mem x w) u)
    |> List.map List.length
  in
  let n = List.length wins in
  let cards : int array = Array.make n 1 in
  List.iteri
    (fun i w ->
      List.init w Fun.id
      |> List.iter (fun j -> cards.(i + j + 1) <- cards.(i + j + 1) + cards.(i)))
    wins;
  Array.fold_left ( + ) 0 cards
