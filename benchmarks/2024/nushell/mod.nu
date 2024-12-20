const ROOT = "../../../"
const NUSHELL = "solutions/2024/nushell/"

use ($ROOT | path join toolkit.nu) [ "aoc get-data", "aoc get-answers" ]
use std assert

use ($ROOT | path join $NUSHELL day_1)
use ($ROOT | path join $NUSHELL day_2)
use ($ROOT | path join $NUSHELL day_3)
use ($ROOT | path join $NUSHELL day_4)
use ($ROOT | path join $NUSHELL day_5)
use ($ROOT | path join $NUSHELL day_6)
use ($ROOT | path join $NUSHELL day_7)
use ($ROOT | path join $NUSHELL day_8)
use ($ROOT | path join $NUSHELL day_9)
use ($ROOT | path join $NUSHELL day_10)
use ($ROOT | path join $NUSHELL day_11)

def timeit [code: closure, ...args: any]: [ any -> record<res: any, time: duration> ] {
    let start_time = date now

    let res = $in | do $code ...$args

    { res: $res, time: ((date now) - $start_time) }
}

export def pull [
    --login: record<cookie: string, mail: string>,
    --force,
]: [
    list<int> -> table<day: int, input: string, silver: int, gold: int>,
    range -> table<day: int, input: string, silver: int, gold: int>
] {
    let days = $in

    let inputs = $days | enumerate | each { |d|
        print --no-newline $"pulling inputs: day ($d.item) \(($d.index + 1) / ($days | length)\)\r"
        { day: $d.item, input: (aoc get-data --login $login --year 2024 $d.item --force=$force) }
    }
    print ""
    let answers = $days | enumerate | each { |d|
        print --no-newline $"pulling answers: day ($d.item) \(($d.index + 1) / ($days | length)\)\r"
        { day: $d.item, answers: (aoc get-answers --login $login --year 2024 $d.item --force=$force) }
    }
    print ""

    $inputs | join $answers day | flatten
}

export def run []: [
    table<day: int, input: string, silver: int, gold: int>
    -> table<day: int, silver: string, silver_time: duration, gold: string, gold_time: duration>
] {
    let days = [
        [ day, silver, gold ];

        [ 1, { day_1 silver }, { day_1 gold } ],
        [ 2, { day_2 silver }, { day_2 gold } ],
        [ 3, { day_3 silver }, { day_3 gold } ],
        [ 4, { day_4 silver }, { day_4 gold } ],
        [ 5, { day_5 silver }, { day_5 gold } ],
        [ 6, { day_6 silver }, { day_6 gold } ],
        [ 7, { day_7 silver }, { day_7 gold } ],
        [ 8, { day_8 silver }, { day_8 gold } ],
        [ 9, { day_9 silver }, { day_9 gold } ],
        [ 10, { day_10 silver }, { day_10 gold } ],
        [ 11, { day_11 silver }, { day_11 gold } ],
    ]

    $in | join $days day | each { |it|
        print $"running day ($it.day) part silver..."
        let silver = try {
            let res = $it.input | timeit $it.silver_
            let status = if $res.res == $it.silver {
                "pass"
            } else {
                "fail"
            }
            { status: $status, time: $res.time }
        } catch { |e|
            { status: $e.debug, time: null }
        }

        let gold = if $it.gold != null {
            print $"running day ($it.day) part gold... "
            try {
                let res = $it.input | timeit $it.gold_
                let status = if $res.res == $it.gold {
                    "pass"
                } else {
                    "fail"
                }
                { status: $status, time: $res.time }
            } catch { |e|
                { status: $e.debug, time: null }
            }
        } else {
            { status: null, time: null }
        }

        {
            day: $it.day,
            silver: $silver.status,
            silver_time: $silver.time,
            gold: $gold.status,
            gold_time: $gold.time,
        }
    }
    | flatten
}

export def render []: [
    table<day: int, silver: string, silver_time: duration, gold: string, gold_time: duration> -> string
] {
    update silver {
        match $in {
            "pass" => ":green_circle:",
            "fail" => ":red_circle:",
            null => ":orange_circle:",
        }
    }
    | update gold {
        match $in {
            "pass" => ":green_circle:",
            "fail" => ":red_circle:",
            null => ":orange_circle:",
        }
    }
    | rename --column {
        "silver_time": '$t_{\text{silver}}$',
        "gold_time": '$t_{\text{gold}}$',
    }
    | to md --pretty
}

export def cpu []: [
    nothing -> record<
        "Architecture": string,
        "CPU(s)": string,
        "Model name": string,
        "Thread(s) per core": string,
        "Core(s) per socket": string,
        "Socket(s)": string,
        "CPU max MHz": string,
        "CPU min MHz": string,
        "BogoMIPS": string,
        "L1d cache": string,
        "L1i cache": string,
        "L2 cache": string,
        "L3 cache": string,
    >
] {
    ^lscpu
        | lines
        | parse "{k}: {v}"
        | str trim
        | where k !~ "Vuln"
        | transpose --header-row
        | into record
        | select ...[
            "Architecture", "CPU(s)", "Model name", "Thread(s) per core",
            "Core(s) per socket", "Socket(s)", "CPU max MHz", "CPU min MHz",
            "BogoMIPS", "L1d cache", "L1i cache", "L2 cache", "L3 cache"
        ]
}
