open Alcotest

let test_hello_with_name name () =
    let greeting = "Hello " ^ name ^ "!" in
    let expected = Printf.sprintf "Hello %s!" name in
    check string "same string" greeting expected

let suite = [
    "can greet Tom", `Quick, test_hello_with_name "Tom";
    "can greet John", `Quick, test_hello_with_name "John";
]

let () =
    Alcotest.run "Dummy" [ "Greeting", suite ]
