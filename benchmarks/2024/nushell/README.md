# test solutions with the AoC API
with Nushell,
```nushell
use benchmarks/2024/nushell

let login = {
    cookie: "xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    mail: "xxxx@xxx.xxx"
}
let inputs_and_answers = <days> | nushell pull --login $login
let benchmarks = $inputs_and_answers | nushell run
```

> **Note**
>
> if the cookie has been encrypted, you can use
> ```nushell
> gpg --decrypt --armor <file> | from nuon
> ```

# results
```nushell
use benchmarks/2024/nushell

let login = {
    cookie: "xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    mail: "xxxx@xxx.xxx"
}
let inputs_and_answers = <days> | nushell pull --login $login

let results = {
    nushell: (version),
    cpu: (nushell cpu),
    results: ($inputs_and_answers | nushell run),
}

$results | to nuon -i 4 | save benchmarks/2024/nushell/<username>.nuon
```

## [@amtoine](https://github.com/amtoine)
| day | silver         | $t_{\text{silver}}$           | gold            | $t_{\text{gold}}$             |
| --- | -------------- | ----------------------------- | --------------- | ----------------------------- |
| 1   | :green_circle: | 22ms 309µs 300ns             | :green_circle:  | 55ms 566µs 231ns             |
| 2   | :green_circle: | 498ms 416µs 227ns            | :green_circle:  | 3sec 225ms 867µs 677ns       |
| 3   | :green_circle: | 8ms 602µs 739ns              | :green_circle:  | 66ms 649µs 439ns             |
| 4   | :green_circle: | 5min 47sec 538ms 98µs 343ns  | :green_circle:  | 2min 10sec 978ms 55µs 516ns  |
| 5   | :green_circle: | 810ms 747µs 858ns            | :orange_circle: |                               |
| 6   | :green_circle: | 756ms 571µs 417ns            | :green_circle:  | 33min 30sec 58ms 541µs 422ns |
| 7   | :green_circle: | 1min 44sec 747ms 847µs 772ns | :orange_circle: |                               |

## [@a-stevan](https://github.com/a-stevan)
| day | silver         | $t_{\text{silver}}$           | gold            | $t_{\text{gold}}$              |
| --- | -------------- | ----------------------------- | --------------- | ------------------------------ |
| 1   | :green_circle: | 11ms 705µs 871ns             | :green_circle:  | 31ms 148µs 107ns              |
| 2   | :green_circle: | 393ms 82µs 63ns              | :green_circle:  | 2sec 601ms 264µs 581ns        |
| 3   | :green_circle: | 4ms 715µs 375ns              | :green_circle:  | 36ms 176µs 708ns              |
| 4   | :green_circle: | 2min 43sec 556ms 139µs 992ns | :green_circle:  | 1min 1sec 935ms 872µs 837ns   |
| 5   | :green_circle: | 568ms 719µs 268ns            | :orange_circle: |                                |
| 6   | :green_circle: | 332ms 851µs 326ns            | :green_circle:  | 14min 22sec 725ms 619µs 168ns |
| 7   | :green_circle: | 56sec 643ms 676µs 780ns      | :orange_circle: |                                |
| 8   | :green_circle: | 40ms 354µs 82ns              | :green_circle:  | 247ms 389µs 896ns             |
| 9   | :green_circle: | 2min 59sec 443ms 650µs 180ns | :orange_circle: |                                |

> **Note**
>
> to generate the table
> ```nushell
> open <file> | get results | nushell render
> ```

