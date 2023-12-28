type record = char list

let parse input =
  String.split_on_char '\n' input
  |> List.map (fun record ->
         match String.split_on_char ' ' record with
         | [ r; s ] ->
             let r = List.init (String.length r) (String.get r) in
             let s = String.split_on_char ',' s |> List.map int_of_string in
             let n = List.filter (fun c -> c = '?') r |> List.length in
             (r, s, n)
         | _ -> failwith "unreachable")

let rec binary n =
  if n = 0 then []
  else if n = 1 then [ [ 0 ]; [ 1 ] ]
  else
    let b = binary (n - 1) in
    let z = List.map (fun x -> 0 :: x) b in
    let o = List.map (fun x -> 1 :: x) b in
    z @ o

let rec fill_template_record (template : record) values =
  match template with
  | [] -> []
  | h :: t when h = '?' ->
      let h = if List.hd values = 1 then '#' else '.' in
      h :: fill_template_record t (List.tl values)
  | h :: t -> h :: fill_template_record t values

let count_in_record (record : record) =
  let rec aux c n acc = function
    | [] -> if c = '#' then n :: acc else acc
    | h :: t ->
        if c = '#' then
          if h = c then aux c (n + 1) acc t else aux h 1 (n :: acc) t
        else aux h 1 acc t
  in
  if List.is_empty record then []
  else aux (List.hd record) 0 [] record |> List.rev

let silver input =
  parse input
  |> List.map (fun (t, g, n) ->
         binary n
         |> List.map (fill_template_record t)
         |> List.map count_in_record
         |> List.filter (fun f -> f = g)
         |> List.length)
  |> List.fold_left ( + ) 0

let gold input = String.length input
