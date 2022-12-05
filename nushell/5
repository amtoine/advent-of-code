#!/usr/bin/env nu

let VERSION = "0.72.0"


# Day 5: Supply Stacks
# see https://adventofcode.com/2022/day/5
def main [
  input: string
   # the path to the input data locally 
   # - fetch it from https://adventofcode.com/2022/day/5/input
   # - see https://github.com/amtoine/advent-of-code/tree/main#get-the-input
  --gold: bool  # activate the second part of the challenge
] {
  if ((version).version != $VERSION) {
    print -e $"version should be ($VERSION), got ((version).version)"
    return
  }

  mut crates = (
    open $input
    | lines
    | find "["
    | str replace --all -s "    " ":"
    | str replace --all -s "] [" ":"
    | str replace --all -s " [" ":"
    | str replace --all -s "] " ":"
    | str replace --all -s "]" ""
    | str replace --all -s "[" ""
    | split column ":"
    | transpose -i
    | to csv
    | lines
    | skip 1
    | each {$in | split row "," | reverse}
  )

  let rules = (
    open $input
    | lines
    | parse "move {qut} from {from} to {to}"
    | into int qut from to
  )


  def move [
    crates: list
    rule: list
  ] {
    let q = ($rule.qut | into int)
    let f = ([$rule.from -1] | math sum)
    let t = ([$rule.to -1] | math sum)

    mut less = ($crates | get $f)

    let move = ($less | reverse | take $q)

    $less = ($less | take (($less | length) - $q))

    mut more = ($crates | get $t)
    $more = ($more | append (
      if ($gold) {$move | reverse} else {$move}))

    let from = $less
    let to = $more

    $crates
    | each {|crate id|
      if ($id == $f) {
        $from
      } else if ($id == $t) {
        $to
      } else {
        $crate
      }
    }
  }


  for rule in $rules {
    $crates = (move $crates $rule)
  }

  $crates | each {reverse | take 1 | str collect} | str collect
}