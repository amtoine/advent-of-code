```nushell
let res = python solutions/2024/python/day_11/main.py
    | lines
    | parse "{fn} for {b} done in {t}: {res}"
    | into int b res t
    | into duration t
```

plot the results with [GPLT](https://gitlab.isae-supaero.fr/a.stevan/gplt)
```
$res
    | group-by fn --to-table
    | update items { rename --column { b: x, t: y } }
    | rename --column { group: name, items: points }
    | to json
    | gplt plot $in --y-scale log
```
