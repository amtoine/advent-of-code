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

let get_gear_positions_gold input =
    let lines = String.split_on_char '\n' input in
    let n = List.length lines in
    let p = List.hd lines |> String.length in
    List.init n Fun.id |> List.map (fun i ->
        List.init p Fun.id |> List.map (fun j ->
            (i, j)
        )
    )
    |> List.flatten
    |> List.filter (fun (i, j) -> (get input i j p) = '*')

let rec remove_last = function
    | [] -> []
    | [_] -> []
    | h :: t -> h :: remove_last t

let get_numbers input =
    let rec aux line curr id = match line with
        | [] -> []
        | h :: t -> match h with
            | "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" ->
                aux t (curr ^ h) id
            | _ ->
                let numbers = List.init (String.length curr) (fun _ -> Some ((int_of_string curr), id)) in
                numbers :: [None] :: (aux t "" (id + 1)) in
    let lines = String.split_on_char '\n' input
        |> List.map (fun l ->
            let chars =
                List.init (String.length l) (fun i -> String.get l i |> String.make 1)
            in List.append chars ["."]
        ) in
    let p = List.hd lines |> List.length in
        List.mapi (fun i l -> aux l "" (i * p) |> List.flatten |> remove_last) lines

let next_to i j n p = [
    (i - 1, j - 1);
    (i - 1, j);
    (i - 1, j + 1);
    (i, j - 1);
    (i, j + 1);
    (i + 1, j - 1);
    (i + 1, j);
    (i + 1, j + 1);
] |> List.filter (fun (i, j) -> (i >= 0) && (i < n) && (j >= 0) && (j < p))

let silver input =
    let input = String.trim input in
    let numbers = get_numbers input in
    let gears = get_gear_positions input in
    let n = List.length numbers in
    let p = List.hd numbers |> List.length in
    List.map (fun (i, j) ->
        List.map (fun (i, j) -> List.nth (List.nth numbers i) j) (next_to i j n p)
    ) gears
        |> List.flatten
        |> List.filter_map Fun.id
        |> List.sort_uniq (fun a b ->
            if (snd a) = (snd b) then
                0
            else if (snd a) < (snd b) then
                1
            else
                -1
        )
        |> List.map fst
        |> List.fold_left (+) 0

let gold input =
    let input = String.trim input in
    let numbers = get_numbers input in
    let gears = get_gear_positions input in
    let n = List.length numbers in
    let p = List.hd numbers |> List.length in
    List.map (fun (i, j) ->
        let part_numbers =
            List.map (fun (i, j) -> List.nth (List.nth numbers i) j) (next_to i j n p)
                |> List.filter_map Fun.id
                |> List.map fst
                |> List.sort_uniq (fun a b -> if a = b then 0 else if a < b then 1 else -1)
        in
        if (List.length part_numbers) = 2 then
            (List.hd part_numbers) * (List.nth part_numbers 1)
        else
            0
    ) gears
        |> List.fold_left (+) 0
