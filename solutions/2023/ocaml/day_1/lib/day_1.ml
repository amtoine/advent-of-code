let read_channel channel =
    let buffer = Buffer.create 4096 in
    let rec loop () =
        let line = input_line channel in
        Buffer.add_string buffer line;
        Buffer.add_char buffer '\n';
        loop ()
    in
        try loop () with
            End_of_file -> Buffer.contents buffer

let read_file filename =
    let channel = open_in filename in
        read_channel channel

let explode s = List.init (String.length s) (String.get s)

let filter_digits = List.filter (
    fun c -> List.mem c ['1'; '2'; '3'; '4'; '5'; '6'; '7'; '8'; '9'; '0']
)

let rec combine_first_last = function
    | [] -> None
    | [e] -> Some (e ^ e)
    | [e1;e2] -> Some (e1 ^ e2)
    | e1 :: _ :: r -> combine_first_last (e1::r)

let silver input =
    String.split_on_char '\n' input
        |> List.map (fun l -> l
            |> explode
            |> filter_digits
            |> List.map (fun c -> String.make 1 c)
        )
        |> List.filter_map combine_first_last
        |> List.map int_of_string
        |> List.fold_left (+) 0
