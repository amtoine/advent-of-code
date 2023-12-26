let parse input =
  String.split_on_char '\n' input
  |> List.map (fun s -> s |> String.split_on_char ' ' |> List.map int_of_string)

(** [next s] is [n], where [n] is the element that _comes next_ in the sequence [s]

    # Example

    consider [s = [10; 13; 16; 21; 30; 45; 68]], if we compute the successive
    sequences of consecutive differences between terms until we get to the
    [[0; 0; ...; 0]] sequence, we get:
    [
    10  13  16  21  30  45 ??
       3   3   5   9  15
         0   2   4   6
           2   2   2
             0   0
    ]

    we can compute the unknown next element of [s], called [??], by adding a [0]
    at the end of the last _0_ sequence and then going back up
    [
    10  13  16  21  30  45  68
       3   3   5   9  15  23
         0   2   4   6   8
           2   2   2   2
             0   0   0
    ]

    note that [68] is exactly the sum of all the last elements of each stage,
    which is what [next s] computes.

    see _Why don't they teach Newton's calculus of 'What comes next?'_ (https://youtu.be/4AuV93LOPcE)
*)
let next s =
  let rec aux acc s =
    if List.fold_left ( + ) 0 s = 0 then acc
    else
      let new_acc = (List.hd @@ List.rev s) :: acc in
      let new_s =
        List.map2
          (fun a b -> b - a)
          (List.rev @@ List.tl @@ List.rev s)
          (List.tl s)
      in
      aux new_acc new_s
  in
  let last = aux [] s in
  List.fold_left ( + ) 0 last

let silver input =
  let sequences = parse input in
  List.fold_left ( + ) 0 (List.map next sequences)

let gold input = String.length input
