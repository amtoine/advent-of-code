let get input i j p = String.get input (i * (p + 1) + j);;

let get_gear_positions input =
    let lines = String.split_on_char '\n' input in
    let n = List.length lines in
    let p = List.hd lines |> String.length in
    List.init n Fun.id |> List.map (fun i ->
        List.init p Fun.id |> List.map (fun j ->
            (i, j)
        )
    )
    |> List.flatten
    |> List.filter (fun (i, j) ->
        List.mem (get input i j p) [
            '0'; '1'; '2'; '3'; '4'; '5'; '6'; '7'; '8'; '9'; '.'
        ] |> Bool.not
    )

let get_numbers input =
    let rec aux line curr = match line with
        | [] -> []
        | h :: t -> match h with
            | "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" ->
                aux t (curr ^ h)
            | _ ->
                let numbers = List.init (String.length curr) (fun _ -> Some (int_of_string curr)) in
                numbers :: [None] :: (aux t "") in
    String.split_on_char '\n' input
        |> List.map (fun l ->
            List.init (String.length l) (fun i -> String.get l i |> String.make 1)
        )
        |> List.map (fun l -> aux l "" |> List.flatten)

let silver input = String.length input

let gold input = String.length input
