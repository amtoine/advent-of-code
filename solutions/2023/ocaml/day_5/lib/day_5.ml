let split_list_at v l =
  let rec aux v acc = function
    | [] -> [ acc ]
    | h :: t ->
        if h = v then acc :: aux v [] t else aux v (List.append acc [ h ]) t
  in
  aux v [] l

type map = { dst : int; src : int; len : int }

let parse input =
  let cleaned =
    String.trim input |> String.split_on_char '\n'
    |> List.filter (fun l -> Bool.not @@ String.ends_with ~suffix:"map:" l)
  in
  let seeds =
    List.nth (List.hd cleaned |> String.split_on_char ':') 1
    |> String.trim |> String.split_on_char ' ' |> List.map int_of_string
  in
  let maps =
    cleaned |> List.tl |> List.tl |> split_list_at ""
    |> List.map (fun m ->
           List.map
             (fun x ->
               let y = String.split_on_char ' ' x |> List.map int_of_string in
               { dst = List.nth y 0; src = List.nth y 1; len = List.nth y 2 })
             m)
  in
  (seeds, maps)

let silver input = String.length input
let gold input = String.length input
