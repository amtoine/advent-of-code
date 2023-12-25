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

let rec count_uniq_sorted acc curr n l =
  match l with
  | [] -> (curr, n) :: acc
  | h :: t ->
      let new_acc, new_curr, new_n =
        if h <> curr then ((curr, n) :: acc, h, 1) else (acc, curr, n + 1)
      in
      count_uniq_sorted new_acc new_curr new_n t

let hand_type hand =
  let ty =
    List.sort (fun a b -> card_power b - card_power a) hand
    |> count_uniq_sorted [] ' ' 0
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

let gold input = String.length input
