# # Examples
# ```nushell
# # if `asc.nuon` is a GPG-encrypted file containing with the following signature
# # ```nushell
# # record<cookie: string, mail: string>
# # ```
# aoc get-data 1 --year 2022 --login (
#     gpg --quiet --decrypt aoc.nuon.asc | from nuon
# )
# ```
export def "aoc get-data" [
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

# jump to a solution
export def --env jump [] {
    let res = ls solutions/*/*/* | get name | find --invert "/_data/" | input list
    if $res == null {
        return
    }

    cd $res
}
