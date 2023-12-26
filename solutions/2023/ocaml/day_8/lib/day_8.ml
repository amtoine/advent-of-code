let parse input =
  let lines = String.split_on_char '\n' input in
  let instructions = List.hd lines in
  let network =
    lines |> List.tl |> List.tl
    |> List.map (fun s ->
           Scanf.sscanf s "%s = (%s@, %s@)" (fun n l r -> (n, l, r)))
  in
  (instructions, network)

let move instructions network pos =
  let rec aux pos n =
    if pos = "ZZZ" then n
    else
      let i = n mod String.length instructions in
      let _, left, right =
        List.filter (fun (x, _, _) -> x = pos) network |> List.hd
      in
      let next = if String.get instructions i = 'L' then left else right in
      aux next (n + 1)
  in
  aux pos 0

let network_to_ht network =
  let ht = Hashtbl.create (List.length network) in
  let () = List.iter (fun (k, l, r) -> Hashtbl.add ht k (l, r)) network in
  ht

let move_gold instructions network pos =
  let rec aux pos n =
    if List.for_all (fun p -> String.ends_with ~suffix:"Z" p) pos then n
    else
      let i = n mod String.length instructions |> String.get instructions in
      let next =
        List.map
          (fun p ->
            let left, right = Hashtbl.find network p in
            if i = 'L' then left else right)
          pos
      in
      aux next (n + 1)
  in
  aux pos 0

let silver input =
  let instructions, network = parse input in
  move instructions network "AAA"

let gold input =
  let instructions, network = parse input in
  let pos =
    network
    |> List.filter (fun (x, _, _) -> String.ends_with ~suffix:"A" x)
    |> List.map (fun (x, _, _) -> x)
  in
  move_gold instructions (network_to_ht network) pos
