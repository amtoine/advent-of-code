#!/usr/bin/env nu

let VERSION = "0.72.0"


def is-visible [
  i: int
  j: int
  trees: list
] {
  let h = ($trees | get $i | get $j)
  let s = ($trees | length)

  let left = (
    seq ($j + 1) ($s - 1)
    | each {|k|
      $trees | get $i | get $k
    }
  )

  let right = (
    seq 0 ($j - 1)
    | each {|k|
      $trees | get $i | get $k
    }
  )

  let up = (
    seq 0 ($i - 1)
    | each {|k|
      $trees | get $k | get $j
    }
  )

  let down = (
    seq ($i + 1) ($s - 1)
    | each {|k|
      $trees | get $k | get $j
    }
  )

  if (($up | all ($it < $h)) or ($down| all ($it < $h)) or ($left | all ($it < $h)) or ($right | all ($it < $h))) {
    1
  } else {
    0
  }
}


def get_scenic_views [
  i: int
  j: int
  trees: list
] {
  let height = ($trees | get $i | get $j)
  let s = ($trees | length)

  mut right = 0
  for k in (seq ($j + 1) ($s - 1)) {
    let h = ($trees | get $i | get $k)
    $right = ($right + 1)
    if ($h >= $height) {
      break
    }
  }

  mut left = 0
  for k in (seq 0 ($j - 1) | reverse) {
    let h = ($trees | get $i | get $k)
    $left = ($left + 1)
    if ($h >= $height) {
      break
    }
  }

  mut up = 0
  for k in (seq 0 ($i - 1) | reverse) {
    let h = ($trees | get $k | get $j)
    $up = ($up + 1)
    if ($h >= $height) {
      break
    }
  }

  mut down = 0
  for k in (seq ($i + 1) ($s - 1)) {
    let h = ($trees | get $k | get $j)
    $down = ($down + 1)
    if ($h >= $height) {
      break
    }
  }

  $up * $left * $down * $right
}


# Day 8: Treetop Tree House
# see https://adventofcode.com/2022/day/8
def main [
  input: string
   # the path to the input data locally 
   # - fetch it from https://adventofcode.com/2022/day/8/input
   # - see https://github.com/amtoine/advent-of-code/tree/main#get-the-input
  --gold: bool  # activate the second part of the challenge
] {
  if ((version).version != $VERSION) {
    print -e $"version should be ($VERSION), got ((version).version)"
    return
  }

  let trees = (
    open inputs/8.txt
    | lines
    | each {split row ""}
  )

  let size = ($trees | length)

  $trees
  | par-each {|row i|
    $row
    | par-each {|el j|
      if (($i == 0) or ($i == ($size - 1)) or ($j == 0) or ($j == ($size - 1))) {
        if ($gold) {
          0
        } else {
          1
        }
      } else {
        if ($gold) {
          get_scenic_views $i $j $trees
        } else {
          is-visible $i $j $trees
        }
      }
    }
  }
  | if ($gold) {
    math max
  } else {
    each {str collect}
    | split row ""
    | into int
    | math sum
  }
}