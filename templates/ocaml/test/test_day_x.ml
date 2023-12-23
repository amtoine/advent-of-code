let test f input expected () = Alcotest.(check int) "same" expected (f input)
let data_dir = Sys.getcwd () ^ "/../../../../../_data/day_x/"

let () =
  Alcotest.run xxx
    [
      ( "examples",
        [
          ( "silver",
            `Quick,
            test Day_x.silver
              (Day_x__Fs.read_file (data_dir ^ "silver.txt"))
              xxx );
          (* "gold", `Quick, test Day_x.gold (Day_x__Fs.read_file (data_dir ^ "gold.txt")) xxx; *)
        ] );
    ]
