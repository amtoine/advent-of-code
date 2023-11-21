# advent-of-code
A collection of solutions for the advent of code event each year from 2015.

## Disclaimer
This repo contains my personal solutions to the challenges in the "Advent of Code" events.
You might get spoiled.
You are warned!

Otherwise, enjoy my solutions :wink:

## Some templates to gain time
see the [templates](https://github.com/amtoine/advent-of-code/tree/templates)

## My solutions
| year    | challenges                    | location                                                    | language  |
| ------- | ----------------------------- | ----------------------------------------------------------- | --------- |
| 2022    | https://adventofcode.com/2022 | [2022](https://github.com/amtoine/advent-of-code/tree/2022) | nushell   |
| 2021    | https://adventofcode.com/2021 | [2021](https://github.com/amtoine/advent-of-code/tree/2021) | Oberon-07 |

## The list of events
| year    | advent of code                |
| ------- | ----------------------------- |
| current | https://adventofcode.com/     |
| 2022    | https://adventofcode.com/2022 |
| 2021    | https://adventofcode.com/2021 |
| 2020    | https://adventofcode.com/2020 |
| 2019    | https://adventofcode.com/2019 |
| 2018    | https://adventofcode.com/2018 |
| 2017    | https://adventofcode.com/2017 |
| 2016    | https://adventofcode.com/2016 |
| 2015    | https://adventofcode.com/2015 |

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
i personally use the following `nushell` function:
```bash
def "aoc get-data" [
    day: int,
    --login: record<cookie: string, mail: string>,
    --year: int,
]: nothing -> string {
    let url = $'https://adventofcode.com/($year)/day/($day)/input'

    let header = [
        Cookie $'session=($login.cookie)'
        User-Agent $'email: ($login.mail)'
    ]

    let res = http get --headers $header --full --allow-errors $url
    if $res.status != 200 {
        error make --unspanned {
          msg: $res.body
        }
    }

    $res.body
}
```
used for instance as
```nushell
aoc get-data 1 --year 2022 --login (gpg --quiet --decrypt ~/.aoc.asc | from nuon)
```
