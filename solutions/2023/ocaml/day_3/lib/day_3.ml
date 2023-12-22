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

let silver input = String.length input

let gold input = String.length input
