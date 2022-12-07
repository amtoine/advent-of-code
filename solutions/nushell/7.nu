#!/usr/bin/env nu

let VERSION = "0.72.0"


let TOTAL = 70000000
let REQUIRED = 30000000


def build-fs [input: string] {
  let steps = (
    open $input
    | str replace --all "\\$ " "\n"
    | lines
    | skip 1
    | split list ""
    | each {|it|
      if ($it.0 =~ "^cd") {
        $it.0 | parse "{cmd} {goto}" | get 0
      } else {
        {
          cmd: "ls"
          content: (
            $it | skip 1 | each {|line| 
              if ($line =~ "^dir") {
                $line | parse "{type} {name}" | str trim
              } else {
                [[type]; ["file"]] | merge ($line | parse "{size} {name}") | str trim
              }
              | get 0
            }
          )
        }
      }
    }
  )

  mkdir /tmp/aoc/7
  let root = (mktemp -d /tmp/aoc/7/XXXXXX)

  mut path = ""

  for step in $steps {
    if ($step.cmd == "cd") {
      $path = (
        if ($step.goto == "/") {
          $root
        } else if ($step.goto != "/") {
          [$path $step.goto] | path join
        }
        | path expand
      )
    } else if ($step.cmd == "ls") {
      for file in $step.content {
        let filename = ([$path $file.name] | path join)
        if ($file.type == "dir") {
          mkdir $filename
        } else {
          $file.size | save $filename
        }
      }
    } else {
      error make {msg: "woopsie..."}
    }
  }

  $root
}


def init-sizes [directory: string] {
  ls $"($directory)/**/*"
  | where type == dir
  | select name
  | upsert depth {|it|
    $it.name | split row "/" | length
  }
  | sort-by depth -r
  | insert size {-1}
  | save $"($directory)/sizes.nuon"
}


def compute-one-size [directory: string] {
  let dirs = (open $"($directory)/sizes.nuon")

  let dir = (
    $dirs
    | where size == -1
    | get 0
  )

  let size = (
    $dir
    | ls $in.name
    | each {|el|
      if ($el.type == file) {
        open $el.name | into int
      } else {
        $dirs | where name == $el.name | get size.0
      }
    }
    | math sum
  )

  $dirs
  | update size {|it|
    if ($it.name == $dir.name) {$size} else {$it.size}
  }
  | save $"($directory)/sizes.nuon"
}


# Day 7: No Space Left On Device
# see https://adventofcode.com/2022/day/7
def main [
  input: string
   # the path to the input data locally 
   # - fetch it from https://adventofcode.com/2022/day/7/input
   # - see https://github.com/amtoine/advent-of-code/tree/main#get-the-input
  --gold: bool  # activate the second part of the challenge
] {
  if ((version).version != $VERSION) {
    print -e $"version should be ($VERSION), got ((version).version)"
    return
  }

  let dump = (build-fs $input)

  init-sizes $dump

  while not (open $"($dump)/sizes.nuon" | where size == -1 | is-empty) {
    compute-one-size $dump
  }

  if ($gold) {
    let used = (
      open $"($dump)/sizes.nuon"
      | where depth == 5
      | get size
      | math sum
    )
    let unused = ($TOTAL - $used)
    let to_free = ($REQUIRED - $unused)

    open $"($dump)/sizes.nuon"
    | where size >= $to_free
    | sort-by size
    | get 0.size
  } else {
    open $"($dump)/sizes.nuon"
    | where size <= 100000
    | get size
    | math sum
  }
}




