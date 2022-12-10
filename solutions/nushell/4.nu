#!/usr/bin/env nu

let VERSION = "0.72.0"


# Day 4: Camp Cleanup
# see https://adventofcode.com/2022/day/4
def main [
  input: string
   # the path to the input data locally 
   # - fetch it from https://adventofcode.com/2022/day/4/input
   # - see https://github.com/amtoine/advent-of-code/tree/main#get-the-input
  --gold: bool  # activate the second part of the challenge
] {
  if ((version).version != $VERSION) {
    print -e $"version should be ($VERSION), got ((version).version)"
    return
  }

  open $input
  | lines
  | split column "," first second
  | upsert f {|it| $it.first | split row "-" | into int}
  | upsert s {|it| $it.second | split row "-" | into int}
  | if ($gold) {
    upsert overlap {|it|
      (
        (($it.f.0 >= $it.s.0) && ($it.f.0 <= $it.s.1)) ||
        (($it.f.1 >= $it.s.0) && ($it.f.1 <= $it.s.1)) ||
        (($it.s.0 >= $it.f.0) && ($it.s.0 <= $it.f.1)) ||
        (($it.s.1 >= $it.f.0) && ($it.s.1 <= $it.f.1))
      )
    }
    | get overlap
  } else {
    upsert f_in_s {|it|
      ($it.f.0 >= $it.s.0) && ($it.f.1 <= $it.s.1)
    }
    | upsert s_in_f {|it|
      ($it.s.0 >= $it.f.0) && ($it.s.1 <= $it.f.1)
    }
    | upsert in {|it|
      $it.s_in_f || $it.f_in_s
    }
    | get in
  }
  | into int
  | math sum
}