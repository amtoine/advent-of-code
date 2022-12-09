#!/usr/bin/env nu

let VERSION = "0.72.0"


def point [p] {
  [$p.x $p.y] | str collect ", "
}


def grid [n: int, h, t] {
  seq ($n * -1 / 2) ($n / 2)
  | each {|i|
    seq ($n * -1 / 2) ($n / 2)
    | each {|j|
      if (($j == $h.x) and ($i == $h.y)) {
        "H"
      } else if (($j == $t.x) and ($i == $t.y)) {
        "T"
      } else if (($i == 0) and ($j == 0)) {
        "s"
      } else {
        "."
      }
    }
  }
  | each {str join " "}
}


def stay_close [h, t] {
  # vertical
  if ($h.x == $t.x) {
    if ($h.y - $t.y == 2) {
      {
        x: $h.x
        y: ($t.y + 1)
      }
    } else if ($h.y - $t.y == -2) {
      {
        x: $h.x
        y: ($t.y - 1)
      }
    } else {
      $t
    }
  # horizontal
  } else if ($h.y == $t.y) {
    if ($h.x - $t.x == 2) {
      {
        x: ($t.x + 1)
        y: $h.y
      }
    } else if ($h.x - $t.x == -2) {
      {
        x: ($t.x - 1)
        y: $h.y
      }
    } else {
      $t
    }
  # diagonal
  } else {
    if (($h.x == $t.x + 2) and ($h.y == $t.y + 2)) {
      {
        x: ($h.x - 1)
        y: ($h.y - 1)
      }
    } else if (($h.x == $t.x + 2) and ($h.y == $t.y - 2)) {
      {
        x: ($h.x - 1)
        y: ($h.y + 1)
      }
    } else if (($h.x == $t.x - 2) and ($h.y == $t.y - 2)) {
      {
        x: ($h.x + 1)
        y: ($h.y + 1)
      }
    } else if (($h.x == $t.x - 2) and ($h.y == $t.y + 2)) {
      {
        x: ($h.x + 1)
        y: ($h.y - 1)
      }
    } else if ($h.x == $t.x + 2) {
      {
        x: ($h.x - 1)
        y: $h.y
      }
    } else if ($h.x == $t.x - 2) {
      {
        x: ($h.x + 1)
        y: $h.y
      }
    } else if ($h.y == $t.y + 2) {
      {
        x: $h.x
        y: ($h.y - 1)
      }
    } else if ($h.y == $t.y - 2) {
      {
        x: $h.x
        y: ($h.y + 1)
      }
    } else {
      $t
    }
  }
}


# Day 6: Rope Bridge
# see https://adventofcode.com/2022/day/9
def main [
  input: string
   # the path to the input data locally 
   # - fetch it from https://adventofcode.com/2022/day/9/input
   # - see https://github.com/amtoine/advent-of-code/tree/main#get-the-input
  --gold: bool  # activate the second part of the challenge
] {
  if ((version).version != $VERSION) {
    print -e $"version should be ($VERSION), got ((version).version)"
    return
  }

  let steps = (
    open $input
    | lines
    | parse "{d} {n}"
    | upsert dx {|it|
      if ($it.d == "R") {
        1
      } else if ($it.d == "L") {
        -1
      } else {
        0
      }
    }
    | upsert dy {|it|
      if ($it.d == "U") {
        -1
      } else if ($it.d == "D") {
        1
      } else {
        0
      }
    }
    | into int n
  )

  if ($gold) {
    mut h = {x: 0, y: 0}
    mut t1 = {x: 0, y: 0}
    mut t2 = {x: 0, y: 0}
    mut t3 = {x: 0, y: 0}
    mut t4 = {x: 0, y: 0}
    mut t5 = {x: 0, y: 0}
    mut t6 = {x: 0, y: 0}
    mut t7 = {x: 0, y: 0}
    mut t8 = {x: 0, y: 0}
    mut t9 = {x: 0, y: 0}

    mut positions = []

    for step -n in $steps {
      print $step.index
      for i in (seq 1 $step.item.n) {
        $h.x = ($h.x + $step.item.dx)
        $h.y = ($h.y + $step.item.dy)
        $t1 = (stay_close $h $t1)
        $t2 = (stay_close $t1 $t2)
        $t3 = (stay_close $t2 $t3)
        $t4 = (stay_close $t3 $t4)
        $t5 = (stay_close $t4 $t5)
        $t6 = (stay_close $t5 $t6)
        $t7 = (stay_close $t6 $t7)
        $t8 = (stay_close $t7 $t8)
        $t9 = (stay_close $t8 $t9)
        $positions = ($positions | append $t9)
      }
    }

    $positions
    | uniq
    | length
  } else {
    mut h = {x: 0, y: 0}
    mut t = {x: 0, y: 0}

    mut positions = []

    for step -n in $steps {
      for i in (seq 1 $step.item.n) {
        $h.x = ($h.x + $step.item.dx)
        $h.y = ($h.y + $step.item.dy)
        $t = (stay_close $h $t)
        $positions = ($positions | append $t)
      }
    }

    $positions
    | uniq
    | length
  }
}
