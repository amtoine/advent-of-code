#!/usr/bin/env nu

let VERSION = "0.72.0"


# Day 11: Monkey in the Middle
# see https://adventofcode.com/2022/day/11
def main [
  input: string
   # the path to the input data locally 
   # - fetch it from https://adventofcode.com/2022/day/11/input
   # - see https://github.com/amtoine/advent-of-code/tree/main#get-the-input
  --gold: bool  # activate the second part of the challenge
] {
  if ((version).version != $VERSION) {
    print -e $"version should be ($VERSION), got ((version).version)"
    return
  }

  let data = (
    open $input
    | lines
    | split list ""
  )

  let rules = (
    $data
    | each {|it|
      {
        id: ($it | parse "Monkey {id}:" | get 0.id)
        op: ($it | parse "  Operation: new = old {op} {amount}" | get 0.op)
        val: ($it | parse "  Operation: new = old {op} {val}" | get 0.val)
        test: ($it | parse "  Test: divisible by {test}" | get 0.test)
        t: ($it | parse "    If true: throw to monkey {t}" | get 0.t)
        f: ($it | parse "    If false: throw to monkey {f}" | get 0.f)
      }
    }
    | into int id test t f
  )

  mut items = (
    $data
    | each {|it|
        $it | parse "  Starting items: {items}" | get 0.items | split row ", " | into int
    }
  )

  mut inspections = (
    $data
    | each {0}
  )

  let n = if ($gold) {10000} else {20}

  for round in (seq 1 $n) {
    for rule -n in $rules {
      let monkey = ($items | get $rule.index)

      for item in $monkey {
        mut worry = $item

        let op = $rule.item.op
        mut val = if ($rule.item.val == "old") {$worry} else {$rule.item.val}
        $val = ($val | into int)

        if ($op == "*") {
          $worry = ($worry * $val)
        } else if ($op == "+") {
          $worry = ($worry + $val)
        }

        let w = $worry
        $worry = (if ($gold) {
          if ($rule.item.val == "old") {
            # $w mod $rule.item.test
            # $w | math sqrt | math floor
            $w mod 2
          } else {
            $w mod $rule.item.test
            # $w // ($item | into int)
          }
        } else {
          $w // 3
        })

        let lw = $worry
        let test = if ($gold) {$lw == 0} else {($lw mod $rule.item.test) == 0}

        let recipient = if ($test) {$rule.item.t} else {$rule.item.f}

        $items = ($items | update $recipient ($items | get $recipient | append $worry))

        $inspections = ($inspections | update $rule.item.id (($inspections | get $rule.item.id) + 1))
      }

      $items = ($items | update $rule.index [])
    }
    if (($round == 1) or ($round == 20) or (($round mod 1000) == 0)) {
      print $round
      print $inspections
    }
  }

  $inspections
  | sort -r
  | take 2
  | reduce -f 1 {|it acc| $it * $acc}
}