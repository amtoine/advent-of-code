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
    let channel = open_in (Sys.getcwd () ^ "/" ^ filename) in
        read_channel channel

let () = print_int (Day_1.silver (read_file (Sys.argv.(1))))