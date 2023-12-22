- go to one of the OCaml solution, e.g. with the `toolkit.nu`
```nushell
toolkit jump  # and then type 'ocaml'
```
- create a local switch if not already done
```nushell
opam switch create . --deps-only --with-test --with-doc
```
- install all dependencies to the switch
```nushell
open dune-deps | lines | opam install $in -y
```

then you can
- run the tests with `dune test`
- run the _toplevel_ with `dune utop`
- run the binary on some input
```nushell
dune exec day_x <level> <input>
```
> **Note**
> - `level` will be either `gold` or `silver`
> - `input` will typically be `silver.txt`, `gold.txt` and my personal inputs should also be available `amtoine.txt`
