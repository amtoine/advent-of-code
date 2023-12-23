(** parse a list of numbers with format "x x x x x" *)
let parse_numbers numbers =
    String.split_on_char ' ' numbers
        |> List.filter (fun x -> x <> "")
        |> List.map int_of_string

(** parse a card with format "...: x x x x | x x x x x" *)
let parse_card card =
    let raw = List.nth (String.split_on_char ':' card) 1 in
    let winner_and_user = String.split_on_char '|' raw in (
        parse_numbers (List.nth winner_and_user 0),
        parse_numbers (List.nth winner_and_user 1)
    )

let silver input = String.length input

let gold input = String.length input
