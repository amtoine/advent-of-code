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
  let rec aux instructions network pos n =
    if pos = "ZZZ" then n
    else
      let i = n mod String.length instructions in
      let _, left, right =
        List.filter (fun (x, _, _) -> x = pos) network |> List.hd
      in
      let next = if String.get instructions i = 'L' then left else right in
      aux instructions network next (n + 1)
  in
  aux instructions network pos 0

let silver input =
  let instructions, network = parse input in
  move instructions network "AAA"

let gold input = String.length input
