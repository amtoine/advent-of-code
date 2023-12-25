let parse input =
  String.split_on_char '\n' input
  |> List.map (fun l ->
         let parsed = String.split_on_char ' ' l in
         let hand = List.hd parsed in
         ( List.init (String.length hand) (String.get hand),
           int_of_string @@ List.nth parsed 1 ))

let card_power c =
  match c with
  | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' -> int_of_char c - 48 - 1
  | 'T' -> 9
  | 'J' -> 10
  | 'Q' -> 11
  | 'K' -> 12
  | 'A' -> 13
  | _ -> failwith ("invalid card '" ^ String.make 1 c ^ "'")

let rec pow x n = if n = 0 then 1 else x * pow x (n - 1)

(** compute the raw power of a hand, without taking it's type into account

  this is to disambiguate hands that have the same type.

  this function interprets the hand as a number written in base 13, because
  there are 13 possible cards.
 *)
let hand_power hand =
  let rec aux u n =
    match u with [] -> 0 | h :: t -> (card_power h * pow 13 n) + aux t (n - 1)
  in
  aux hand (List.length hand - 1)

(** uniq a list and count its elements

    the input list needs to be sorted.
 *)
let count_uniq_sorted l =
  let rec aux acc curr n l =
    match l with
    | [] -> (curr, n) :: acc
    | h :: t ->
        let new_acc, new_curr, new_n =
          if h <> curr then ((curr, n) :: acc, h, 1) else (acc, curr, n + 1)
        in
        aux new_acc new_curr new_n t
  in
  aux [] ' ' 0 l

let hand_type hand =
  let ty =
    List.sort (fun a b -> card_power b - card_power a) hand
    |> count_uniq_sorted
    |> List.filter_map (fun (_, n) -> if n >= 2 then Some n else None)
  in
  match ty with
  | [] -> 0
  | [ 2 ] -> 1
  | [ 2; 2 ] -> 2
  | [ 3 ] -> 3
  | [ 2; 3 ] | [ 3; 2 ] -> 4
  | [ 4 ] -> 5
  | [ 5 ] -> 6
  | _ -> failwith "invalid hand"

let hand_type_gold hand =
  let h =
    hand
    |> List.sort (fun a b -> card_power b - card_power a)
    |> count_uniq_sorted
    |> List.filter (fun (_, c) -> c > 0)
    |> List.sort (fun (_, n1) (_, n2) -> n2 - n1)
  in
  let js = List.filter (fun (c, _) -> c = 'J') h in
  let nb_js = if List.is_empty js then 0 else List.hd js |> snd in
  let not_a_j = List.filter (fun (c, _) -> c <> 'J') h in
  let x =
    if nb_js = 0 then not_a_j
    else if List.is_empty not_a_j then [ ('J', 5) ]
    else
      let c, n = List.hd not_a_j in
      (c, n + nb_js) :: List.tl not_a_j
  in
  let ty =
    x |> List.filter_map (fun (_, n) -> if n >= 2 then Some n else None)
  in
  match ty with
  | [] -> 0
  | [ 2 ] -> 1
  | [ 2; 2 ] -> 2
  | [ 3 ] -> 3
  | [ 2; 3 ] | [ 3; 2 ] -> 4
  | [ 4 ] -> 5
  | [ 5 ] -> 6
  | _ -> failwith "invalid hand"

let silver input =
  parse input
  |> List.map (fun (h, v) -> (hand_type h, hand_power h, v))
  |> List.sort (fun (ty_1, pw_1, _) (ty_2, pw_2, _) ->
         if ty_2 > ty_1 then 1
         else if ty_2 < ty_1 then -1
         else if pw_2 > pw_1 then 1
         else if pw_2 < pw_1 then -1
         else 0)
  |> List.rev
  |> List.mapi (fun i (_, _, v) -> v * (i + 1))
  |> List.fold_left ( + ) 0

let gold input =
  parse input
  |> List.map (fun (h, v) -> (hand_type_gold h, hand_power h, v))
  |> List.sort (fun (ty_1, pw_1, _) (ty_2, pw_2, _) ->
         if ty_2 > ty_1 then 1
         else if ty_2 < ty_1 then -1
         else if pw_2 > pw_1 then 1
         else if pw_2 < pw_1 then -1
         else 0)
  |> List.rev
  |> List.mapi (fun i (_, _, v) -> v * (i + 1))
  |> List.fold_left ( + ) 0
