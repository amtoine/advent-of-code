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
      1
    } else {
      print $"($i) ($j)"
      is-visible $i $j $trees
    }
  }
}
| each {str collect} | split row "" | into int | math sum
