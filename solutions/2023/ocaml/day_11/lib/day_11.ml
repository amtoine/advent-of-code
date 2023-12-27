type point = Space | Galaxy
type universe = { n : int; p : int; points : point list list }

let show_universe universe =
  List.iter
    (fun r ->
      List.iter
        (fun x ->
          let c = match x with Space -> '.' | Galaxy -> '#' in
          Printf.printf "%c" c)
        r;
      Printf.printf "\n%!")
    universe.points

let parse input =
  let points =
    String.split_on_char '\n' input
    |> List.mapi (fun i r ->
           List.init (String.length r) (String.get r)
           |> List.mapi (fun j c ->
                  match c with
                  | '.' -> Space
                  | '#' -> Galaxy
                  | _ ->
                      failwith
                        ("invalid universe point at (" ^ string_of_int i ^ ", "
                       ^ string_of_int j ^ ")")))
  in
  let n, p = (List.length points, List.hd points |> List.length) in
  { n; p; points }

let get universe i j = List.nth (List.nth universe.points j) i

(** [empty_lines universe] is [(h, v)] where [h] is the list of indices of the
    empty rows and [v] is the list of indices of the empty columns in the
    universe. *)
let empty_lines universe =
  let vertical =
    List.init universe.p (fun j ->
        List.init universe.n (fun i -> get universe i j)
        |> List.for_all (fun p -> p = Space))
    |> List.mapi (fun i b -> if b then Some i else None)
    |> List.filter_map Fun.id
  in
  let horizontal =
    List.init universe.n (fun i ->
        List.init universe.p (fun j -> get universe i j)
        |> List.for_all (fun p -> p = Space))
    |> List.mapi (fun i b -> if b then Some i else None)
    |> List.filter_map Fun.id
  in
  (horizontal, vertical)

let rec insert x i = function
  | [] -> if i = 0 then [ x ] else failwith "i larger than size of list"
  | h :: t -> if i = 0 then h :: x :: t else h :: insert x (i - 1) t

let rec dilate n = function
  | [] -> []
  | h :: t -> List.init n (fun _ -> h) @ dilate n t

let expand universe factor =
  let h, v = empty_lines universe in
  let h, v = (dilate (factor - 1) h, dilate (factor - 1) v) in
  let empty_row = List.init universe.p (fun _ -> Space) in
  let points =
    List.fold_left
      (fun acc i -> insert empty_row i acc)
      universe.points (List.rev v)
    |> List.map (fun r ->
           List.fold_left (fun acc i -> insert Space i acc) r (List.rev h))
  in
  { n = universe.n + List.length v; p = universe.p + List.length h; points }

let get_galaxies universe =
  universe.points
  |> List.mapi (fun i r ->
         List.mapi
           (fun j x -> match x with Space -> None | Galaxy -> Some (i, j))
           r
         |> List.filter_map Fun.id)
  |> List.flatten

let distance (i1, j1) (i2, j2) = abs (i2 - i1) + abs (j2 - j1)

let silver_gold input factor =
  let universe = expand (parse input) factor in
  let galaxies = get_galaxies universe in
  let x =
    List.mapi
      (fun i gi ->
        List.mapi (fun j gj -> if i = j then 0 else distance gi gj) galaxies)
      galaxies
    |> List.flatten |> List.fold_left ( + ) 0
  in
  x / 2

let silver input = silver_gold input 2
let gold_1 input = silver_gold input 10
let gold_2 input = silver_gold input 100
let gold input = silver_gold input 1_000_000
