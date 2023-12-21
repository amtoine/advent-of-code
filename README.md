# advent-of-code
A collection of solutions for the advent of code event each year from 2015.

## Disclaimer
This repo contains my personal solutions to the challenges in the "Advent of Code" events.
You might get spoiled.
You are warned!

Otherwise, enjoy my solutions :wink:

## The list of events
| year                                  | OCaml              | Nushell                                                                       | Oberon                                                                 |
| ------------------------------------- | ------------------ | ----------------------------------------------------------------------------- | ---------------------------------------------------------------------- |
| [2023](https://adventofcode.com/2023) | [here](2023/ocaml) |                                                                               |                                                                        |
| [2022](https://adventofcode.com/2022) |                    | [here](https://github.com/amtoine/advent-of-code/tree/2022/solutions/nushell) |                                                                        |
| [2021](https://adventofcode.com/2021) |                    |                                                                               | [here](https://github.com/amtoine/advent-of-code/tree/2021/challenges) |
| [2020](https://adventofcode.com/2020) |                    |                                                                               |                                                                        |
| [2019](https://adventofcode.com/2019) |                    |                                                                               |                                                                        |
| [2018](https://adventofcode.com/2018) |                    |                                                                               |                                                                        |
| [2017](https://adventofcode.com/2017) |                    |                                                                               |                                                                        |
| [2016](https://adventofcode.com/2016) |                    |                                                                               |                                                                        |
| [2015](https://adventofcode.com/2015) |                    |                                                                               |                                                                        |

## Get the input
the input for the challenges is different for each user and thus requires a session cookie.

### get the cookie
please follow the steps in [wimglenn/advent-of-code-wim#1](https://github.com/wimglenn/advent-of-code-wim/issues/1) to get your personal session cookie :thumbsup:

### store the cookie
according to [this sub reddit](https://www.reddit.com/r/adventofcode/comments/z9dhtd/please_include_your_contact_info_in_the_useragent/),
one should also include their email in the metadata of the GET requests :ok_hand:

please store your information in a NUON file with the following format:
```nushell
{
    cookie: "xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    mail: "xxxx@xxx.xxx"
}
```

i also recommend encrypting this sensitive file with
```shell
gpg --symmetric --armor --cipher-algo <algo> <file>
```
to have it available as a `.asc` file.

### fetch the data
with Nushell,
```nushell
use toolkit.nu
toolkit aoc get-data --help
```
