def get_scenic_views [
  i: int
  j: int
  trees: list
] {
  let height = ($trees | get $i | get $j)
  let s = ($trees | length)

  # print ""
  print $"i, j: ($i), ($j)"
  # print $"height: ($height)"

  mut right = 0
  for k in (seq ($j + 1) ($s - 1)) {
    let h = ($trees | get $i | get $k)
    # print $"h: ($h)"
    $right = ($right + 1)
    if ($h >= $height) {
      # print "break"
      break
    }
    # related to https://github.com/nushell/nushell/issues/7384
  }
  # print $"right: ($right)"

  mut left = 0
  for k in (seq 0 ($j - 1) | reverse) {
    let h = ($trees | get $i | get $k)
    # print $"h: ($h)"
    $left = ($left + 1)
    if ($h >= $height) {
      # print "break"
      break
    }
  }
  # print $"left: ($left)"

  mut up = 0
  for k in (seq 0 ($i - 1) | reverse) {
    let h = ($trees | get $k | get $j)
    # print $"h: ($h)"
    $up = ($up + 1)
    if ($h >= $height) {
      # print "break"
      break
    }
  }
  # print $"up: ($up)"

  mut down = 0
  for k in (seq ($i + 1) ($s - 1)) {
    let h = ($trees | get $k | get $j)
    # print $"h: ($h)"
    $down = ($down + 1)
    if ($h >= $height) {
      # print "break"
      break
    }
  }
  # print $"down: ($down)"

  $up * $left * $down * $right
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
      0
    } else {
      let views = (get_scenic_views $i $j $trees)
      $views
    }
  }
}
| save res.json
# | each {str collect " "}
# | split row ""
# | into int
# | math max
