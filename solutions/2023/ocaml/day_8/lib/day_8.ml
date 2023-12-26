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

let move_gold instructions network pos =
  let rec aux pos n =
    if String.ends_with ~suffix:"Z" pos then n
    else
      let i = n mod String.length instructions |> String.get instructions in
      let next =
        let _, left, right =
          List.filter (fun (x, _, _) -> x = pos) network |> List.hd
        in
        if i = 'L' then left else right
      in
      aux next (n + 1)
  in
  aux pos 0

let rec gcd u v = if v <> 0 then gcd v (u mod v) else abs u

let lcm m n =
  match (m, n) with 0, _ | _, 0 -> 0 | m, n -> abs (m * n) / gcd m n

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
  let periods = List.map (fun p -> move_gold instructions network p) pos in
  List.fold_left lcm 1 periods
