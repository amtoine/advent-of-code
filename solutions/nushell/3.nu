#!/usr/bin/env nu

let VERSION = "0.72.0"

let priorities = (
  seq char a z
  | append (seq char A Z)
  | wrap char
  | merge (
    seq 1 (2 * 26) | wrap priority
  )
)

def get-priority [char: string] {
  if ($char == "a") {
    1
  } else if ($char == "b") {
    2
  } else if ($char == "c") {
    3
  } else if ($char == "d") {
    4
  } else if ($char == "e") {
    5
  } else if ($char == "f") {
    6
  } else if ($char == "g") {
    7
  } else if ($char == "h") {
    8
  } else if ($char == "i") {
    9
  } else if ($char == "j") {
    10
  } else if ($char == "k") {
    11
  } else if ($char == "l") {
    12
  } else if ($char == "m") {
    13
  } else if ($char == "n") {
    14
  } else if ($char == "o") {
    15
  } else if ($char == "p") {
    16
  } else if ($char == "q") {
    17
  } else if ($char == "r") {
    18
  } else if ($char == "s") {
    19
  } else if ($char == "t") {
    20
  } else if ($char == "u") {
    21
  } else if ($char == "v") {
    22
  } else if ($char == "w") {
    23
  } else if ($char == "x") {
    24
  } else if ($char == "y") {
    25
  } else if ($char == "z") {
    26
  } else if ($char == "A") {
    27
  } else if ($char == "B") {
    28
  } else if ($char == "C") {
    29
  } else if ($char == "D") {
    30
  } else if ($char == "E") {
    31
  } else if ($char == "F") {
    32
  } else if ($char == "G") {
    33
  } else if ($char == "H") {
    34
  } else if ($char == "I") {
    35
  } else if ($char == "J") {
    36
  } else if ($char == "K") {
    37
  } else if ($char == "L") {
    38
  } else if ($char == "M") {
    39
  } else if ($char == "N") {
    40
  } else if ($char == "O") {
    41
  } else if ($char == "P") {
    42
  } else if ($char == "Q") {
    43
  } else if ($char == "R") {
    44
  } else if ($char == "S") {
    45
  } else if ($char == "T") {
    46
  } else if ($char == "U") {
    47
  } else if ($char == "V") {
    48
  } else if ($char == "W") {
    49
  } else if ($char == "X") {
    50
  } else if ($char == "Y") {
    51
  } else if ($char == "Z") {
    52
  } else {
    -1
  }
}


# Day 3: Rucksack Reorganization
# see https://adventofcode.com/2022/day/3
def main [
  input: string
   # the path to the input data locally 
   # - fetch it from https://adventofcode.com/2022/day/3/input
   # - see https://github.com/amtoine/advent-of-code/tree/main#get-the-input
  --gold: bool  # activate the second part of the challenge
] {
  if ((version).version != $VERSION) {
    print -e $"version should be ($VERSION), got ((version).version)"
    return
  }

  open $input
  | lines
  | if ($gold) {
    wrap groups
    | update groups {|it| $it.groups | split row ""}
    | group 3
    | wrap groups
    | upsert badge {|it|
      $it.groups.groups.0
      | each {|letter|
        if (($letter in $it.groups.groups.1) and ($letter in $it.groups.groups.2)) {
          $letter | str trim
        }
      }
    }
    | update badge {|it| $it.badge | take 1 | str collect}
    | upsert priorities {|it|
      #$priorities | where char == "A" | get priority | str collect
      get-priority $it.badge
    }
  } else {
    wrap content
    | upsert len {|it| $it.content | str length}
    | upsert first {|it| $it.content | split row "" | take ($it.len / 2)}
    | upsert second {|it| $it.content | split row "" | skip ($it.len / 2) | take ($it.len / 2)}
    | upsert common {|it|
      $it.first
      | each {|letter|
        if ($letter in $it.second) {
          $letter | str trim
        }
      }
    }
    | update common {|it| $it.common | take 1 | str collect}
    | upsert priorities {|it|
      #$priorities | where char == "A" | get priority | str collect
      get-priority $it.common
    }
  }
  | math sum
  | get priorities
}