#!/usr/bin/env nu

let VERSION = "0.72.0"


# Day 10: Cathode-Ray Tube
# see https://adventofcode.com/2022/day/10
def main [
  input: string
   # the path to the input data locally 
   # - fetch it from https://adventofcode.com/2022/day/10/input
   # - see https://github.com/amtoine/advent-of-code/tree/main#get-the-input
  --gold: bool  # activate the second part of the challenge
] {
  if ((version).version != $VERSION) {
    print -e $"version should be ($VERSION), got ((version).version)"
    return
  }

  let instructions = (
    open $input
    | lines
    | split column " " op v
    | each {|it|
      if ($it.op == "addx") {
        [
          {
            op: "addx"
            v: 0
          },
          {
            op: "addx"
            v: $it.v
          }
        ]
      } else if ($it.op == "noop") {
        [
          {
            op: "noop"
            v: 0
          }
        ]
      } else {
        error make {msg: "something's fishy..."}
      }
    }
    | flatten
    | into int v
  )


  if ($gold) {
    mut x = 1
    mut total = 0
    mut pixel = {x: 0, y: 0}

    for instruction -n in $instructions {
      if ((($x - $pixel.x) | math abs) <= 1) {
        print -n "#"
      } else {
        print -n "."
      }
      $pixel.x = ($pixel.x + 1)
      $x = ($x + $instruction.item.v)
      let cycle = ($instruction.index + 1)

      if (($cycle mod 40) == 0) {
        print ""
        $pixel.x = 0
        $pixel.y = ($pixel.y + 1)
      }
    }
  } else {
    mut x = 1
    mut total = 0

    for instruction -n in $instructions {
      $x = ($x + $instruction.item.v)
      if ((($instruction.index + 2 - 20) mod 40) == 0) {
        let update = (($instruction.index + 2) * $x)
        $total = ($total + $update)
      }
    }
    $total
  }
}