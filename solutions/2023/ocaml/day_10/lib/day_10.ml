let parse input =
  String.split_on_char '\n' input
  |> List.map (fun s -> List.init (String.length s) (String.get s))

let find_start grid =
  let s =
    grid |> List.flatten |> List.find_index (fun c -> c = 'S') |> Option.get
  in
  let p = List.length @@ List.hd grid in
  (s / p, s mod p)

(** [get grid i j] is the element at position [(i, j)] in [grid]

    If both
    - [i] is [0] and [n] exclusive
    - [j] is [0] and [p] exclusive

    the [get grid i j] will be [Some], otherwise, [None].

    > where [n] and [p] are the height and width of the [grid] respectively.
 *)
let get grid i j =
  let n = List.length grid in
  let p = List.length @@ List.hd grid in
  if i >= 0 && i < n && j >= 0 && j < p then Some (List.nth (List.nth grid i) j)
  else None

type dir = Left | Right | Up | Down

(** [get_connected grid i j] is the list of all the pipes that are directly
    connected to [(i, j)] in [grid]

    If both
    - [i] is [0] and [n] exclusive
    - [j] is [0] and [p] exclusive

    the [get_connected grid i j] will be non-empty, otherwise, empty.

    > where [n] and [p] are the height and width of the [grid] respectively.
 *)
let get_connected grid i j =
  [
    (* left *)
    (i, j - 1, [ '-'; 'L'; 'F' ], Right);
    (* right *)
    (i, j + 1, [ '-'; 'J'; '7' ], Left);
    (* up *)
    (i - 1, j, [ '|'; '7'; 'F' ], Down);
    (* down *)
    (i + 1, j, [ '|'; 'L'; 'J' ], Up);
  ]
  |> List.filter_map (fun (i, j, expected, d) ->
         let c = get grid i j in
         if c = None then None
         else
           let c = Option.get c in
           if List.mem c expected then Some (i, j, d) else None)

(** [traverse_pipe grid dir i j] is [(ni, nj, nd)], where [(ni, nj)] is the new
    position after traversing the pipe coming from [dir] and `nd` is the new
    direction

    if the pipe at [(i, j)] cannot be traversed from [dir], [traverse_pipe grid dir i j]
    will be [None].
*)
let traverse_pipe grid dir i j =
  let pipe = get grid i j |> Option.get in
  let next =
    match (pipe, dir) with
    | '-', Left -> Some (i, j + 1, Left)
    | '-', Right -> Some (i, j - 1, Right)
    | '|', Up -> Some (i + 1, j, Up)
    | '|', Down -> Some (i - 1, j, Down)
    | 'L', Up -> Some (i, j + 1, Left)
    | 'L', Right -> Some (i - 1, j, Down)
    | 'F', Down -> Some (i, j + 1, Left)
    | 'F', Right -> Some (i + 1, j, Up)
    | 'J', Up -> Some (i, j - 1, Right)
    | 'J', Left -> Some (i - 1, j, Down)
    | '7', Down -> Some (i, j - 1, Right)
    | '7', Left -> Some (i + 1, j, Up)
    | _ -> None
  in
  if next = None then None
  else
    let ni, nj, _ = Option.get next in
    if
      List.mem (i, j)
        (get_connected grid ni nj |> List.map (fun (i, j, _) -> (i, j)))
    then next
    else None

(** [path grid i j d] is the full path to get back to the starting point

  Note that [(i, j)] is not the position of the starting point but the one of the
  first non-starting position.
  One could get the starting position from [(i, j)] and the direction [dir].
*)
let path grid i j d =
  let start = find_start grid in
  let rec aux grid acc i j d =
    if start = (i, j) then acc
    else
      let next = traverse_pipe grid d i j in
      if next = None then []
      else
        let new_i, new_j, d = Option.get next in
        aux grid ((i, j) :: acc) new_i new_j d
  in
  aux grid [] i j d

let silver input =
  let grid = parse input in
  let path =
    let i, j, d =
      (* picking only one of the possible starts should be enough *)
      let i, j = find_start grid in
      get_connected grid i j |> List.hd
    in
    path grid i j d
  in
  (* NOTE: the start position is not included in the path, hence the `+ 1` *)
  (List.length path + 1) / 2

let gold input = String.length input
