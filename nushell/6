#!/usr/bin/env nu

let VERSION = "0.72.0"


# Day 6: Tuning Trouble
# see https://adventofcode.com/2022/day/6
def main [
  input: string
   # the path to the input data locally 
   # - fetch it from https://adventofcode.com/2022/day/6/input
   # - see https://github.com/amtoine/advent-of-code/tree/main#get-the-input
  --gold: bool  # activate the second part of the challenge
] {
  if ((version).version != $VERSION) {
    print -e $"version should be ($VERSION), got ((version).version)"
    return
  }

  let window_size = if ($gold) {14} else {4}
  let windows = (
    open $input
    | split row ""
    | window $window_size
  )

  for -n window in $windows {
    if (($window.item | uniq -c | where count > 1 | length) == 0) {
      print ($window.index + $window_size)
      break
    }
  }
}