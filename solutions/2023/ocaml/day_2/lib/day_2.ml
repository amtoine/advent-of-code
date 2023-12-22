let parse input =
    let (id, draws) = match (String.split_on_char ':' input) with
        | [id; draws] -> (id, draws)
        | _ -> failwith "woopsie on ':'" in
    let id = match (String.split_on_char ' ' id) with
        | [_; id] -> int_of_string id
        | _ -> failwith "woopsie on ' ' for id" in
    let draws = String.split_on_char ';' draws
        |> List.map (String.split_on_char ',')
        |> List.flatten
        |> List.map String.trim
        |> List.map (fun draw ->
            match (String.split_on_char ' ' draw) with
                | [n; t] -> (int_of_string n, t)
                | _ -> failwith "woopsie on ' ' for draw"
        ) in
    (id, draws)

let invalid_draw (n, c) = match c with
    | "blue" -> n > 14
    | "red" -> n > 12
    | "green" -> n > 13
    | _ -> true

let silver input =
    String.trim input
        |> String.split_on_char '\n'
        |> List.map parse
        |> List.filter_map (fun x ->
            if (List.exists invalid_draw (snd x)) then None else Some (fst x)
        )
        |> List.fold_left (+) 0

let gold input = String.length input
