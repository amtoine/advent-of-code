# get the data of the day for an authenticated user
#
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
    day: int,  # the day of the event
    --year: int,  # the year to consider
    --login: record<cookie: string, mail: string>,  # the credentials to AoC
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

# get the number of stars for each day of a given year for an authenticated user
#
# # Examples
# ```nushell
# # if `asc.nuon` is a GPG-encrypted file containing with the following signature
# # ```nushell
# # record<cookie: string, mail: string>
# # ```
# aoc get-stars --year 2022 --login (
#     gpg --quiet --decrypt aoc.nuon.asc | from nuon
# )
# ```
export def "aoc get-stars" [
    --year: int,  # the year to consider
    --login: record<cookie: string, mail: string>,  # the credentials to AoC
]: nothing -> table<day: int, stars: int> {
    let url = $"https://adventofcode.com/($year)"

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
        | lines
        | parse --regex '.*\<a aria-label="Day (?<day>\d+)(?<stars>.*)" href=.*'
        | into int day
        | sort-by day
        | update stars {
            if ($in | str contains "one") {
                1
            } else if ($in | str contains "two") {
                2
            } else {
                0
            }
        }
}

# jump to a solution
export def --env jump [] {
    let res = ls solutions/*/*/* | get name | find --invert "/_data/" | input list --fuzzy
    if $res == null {
        return
    }

    cd $res
}

export def "init ocaml" [year: int, day: int]: nothing -> nothing {
    let day = $"day_($day)"
    let target = ("solutions" | path join ($year | into string) "ocaml" $day)

    mkdir $target
    cp ("templates" | path join "ocaml" "*") $target --recursive

    # NOTE: this should work in `do { ... }`
    ls ($target | path join "**/*")
        | find day_x
        | get name
        | ansi strip
        | wrap old
        | insert new {|it| $it.old | str replace day_x $day}
        | each { mv $in.old $in.new }

    do {
        cd $target

        ^sd Day_x ($day | str capitalize) **/*
        ^sd day_x $day **/*

        mkdir ("../../_data" | path join $day)
    }
}
