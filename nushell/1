#!/usr/bin/env nu

let VERSION = "0.72.0"


# Day 1: Calorie Counting
# see https://adventofcode.com/2022/day/1
def main [
  input: string
   # the path to the input data locally 
   # - fetch it from https://adventofcode.com/2022/day/1/input
   # - see https://github.com/amtoine/advent-of-code/tree/main#get-the-input
  --gold: bool  # activate the second part of the challenge
] {
  if ((version).version != $VERSION) {
    print -e $"version should be ($VERSION), got ((version).version)"
    return
  }

  open $input
  | lines
  | str replace "^$" ":"
  | str collect ":"
  | split column ":::"
  | transpose
  | get column1
  | each {|it|
    $it | split row ":" | into int | math sum
  }
  | if ($gold) {
      sort -r
      | take 3
      | math sum
    } else {
      math max
    }
}