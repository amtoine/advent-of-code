let explode s = List.init (String.length s) (String.get s)

let filter_digits = List.filter (
    fun c -> List.mem c ['1'; '2'; '3'; '4'; '5'; '6'; '7'; '8'; '9'; '0']
)

let rec combine_first_last = function
    | [] -> None
    | [e] -> Some (e ^ e)
    | [e1;e2] -> Some (e1 ^ e2)
    | e1 :: _ :: r -> combine_first_last (e1::r)

let safe_substring s i l =
    if i >= (String.length s) then
        ""
    else
        String.sub s i (min (String.length s - i) l)

let filter_digits_extended input =
    let rec aux chars i = match chars with
        | [] -> []
        | h :: t -> let h2 = match h with
            | "o" -> (
                if (safe_substring input i 3) = "one" then
                    Some "1"
                else
                    None
            )
            | "t" -> (
                if (safe_substring input i 3) = "two" then
                    Some "2"
                else if (safe_substring input i 5) = "three" then
                    Some "3"
                else
                    None
            )
            | "f" -> (
                if (safe_substring input i 4) = "four" then
                    Some "4"
                else if (safe_substring input i 4) = "five" then
                    Some "5"
                else
                    None
            )
            | "s" -> (
                if (safe_substring input i 3) = "six" then
                    Some "6"
                else if (safe_substring input i 5) = "seven" then
                    Some "7"
                else
                    None
            )
            | "e" -> (
                if (safe_substring input i 5) = "eight" then
                    Some "8"
                else
                    None
            )
            | "n" -> (
                if (safe_substring input i 4) = "nine" then
                    Some "9"
                else
                    None
            )
            | "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" -> Some h
            | _ -> None
            in h2 :: aux t (i + 1)
        in aux (explode input |> List.map (String.make 1)) 0

let silver input =
    String.split_on_char '\n' input
        |> List.map (fun l -> l
            |> explode
            |> filter_digits
            |> List.map (String.make 1)
        )
        |> List.filter_map combine_first_last
        |> List.map int_of_string
        |> List.fold_left (+) 0

let gold input =
    String.split_on_char '\n' input
        |> List.map (fun l ->
            filter_digits_extended l |> List.filter_map Fun.id
        )
        |> List.filter_map combine_first_last
        |> List.map int_of_string
        |> List.fold_left (+) 0
