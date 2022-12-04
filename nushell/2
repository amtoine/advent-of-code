#!/usr/bin/env nu

let VERSION = "0.72.0"


# convert a game code into a result
#
# 0 is a draw
# 1 is a loose
# 2 is a win
#
# because, if o and m are the plays of the players,
# o is the other's play, m is mine,
# and 1 is Rock, 2 is Paper and 3 is Scissors,
# then (o - m + 3) % 3 gives the above codes
def f [x: int] {
  if ($x == 0) {
    3
  } else if ($x == 1) {
    0
  } else if ($x == 2) {
    6
  } else {
    -1
  }
}


# Day 2: Rock Paper Scissors
# see https://adventofcode.com/2022/day/2
def main [
  input: string
   # the path to the input data locally 
   # - fetch it from https://adventofcode.com/2022/day/2/input
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
    parse "{other} {todo}"
  } else {
    parse "{other} {me}"
  }
  | str replace "A" 1 other
  | str replace "B" 2 other
  | str replace "C" 3 other
  | if ($gold) {
    str replace "X" 0 todo
    | str replace "Y" 3 todo
    | str replace "Z" 6 todo
    | into int other todo
    | upsert me {|it|
      if ($it.todo == 0) {
        ($it.other + 2) mod 3
      } else if ($it.todo == 3) {
        $it.other
      } else if ($it.todo == 6) {
        ($it.other + 1) mod 3
      } else {
      }
    }
    | update me {|it| if ($it.me == 0) {3} else {$it.me}}
  } else {
    str replace "X" 1 me
    | str replace "Y" 2 me
    | str replace "Z" 3 me
    | into int other me
  }
  | upsert result {|it| ($it.other - $it.me + 3) mod 3}
  | update result {|it| f $it.result}
  | upsert final {|it| $it.me + $it.result}
  | math sum
  | get final
}