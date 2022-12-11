let data = (
  open inputs/11.txt
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


for round in (seq 1 10000) {
  print $round
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

      $worry = ($worry mod $rule.item.test)

      let test = ($worry == 0)
      # print $"($item) -> ($worry) \(($test)\)"

      let recipient = if ($test) {$rule.item.t} else {$rule.item.f}

      $items = ($items | update $recipient ($items | get $recipient | append $worry))

      $inspections = ($inspections | update $rule.item.id (($inspections | get $rule.item.id) + 1))
    }

    $items = ($items | update $rule.index [])
  }
}

# $items


$inspections | sort -r | take 2 | reduce -f 1 {|it acc| $it * $acc}