use std repeat

export def main []: [ string -> int ] {
    let garden = $in | lines | str join '' | split chars
    let dimensions = { h: ($in | lines | length), w: ($in | lines | first | split chars | length) }

    def get-neighbouring-region [
        i: int, j: int, visited: list<bool>
    ]: [ nothing -> table<i: int, j: int> ] {
        let type = $garden | get ($i * $dimensions.w + $j)

        generate { |state|
            if ($state.next | is-empty) {
                return { out: $state.visited }
            }

            let curr = $state.next.0
            let neighbours = [[-1, 0], [1, 0], [0, 1], [0, -1]]
                | each {{ i: ($curr.i - $in.0), j: ($curr.j - $in.1) }}
                | where { |it|
                    let inside = (
                        $it.i >= 0 and $it.i < $dimensions.h and
                        $it.j >= 0 and $it.j < $dimensions.w
                    )
                    if not $inside {
                        return false
                    }
                    let pos = $it.i * $dimensions.w + $it.j
                    (($garden | get $pos) == $type) and not ($state.visited | get $pos)
                }

            {
                out: $curr,
                next: {
                    next: ($state.next | skip 1 | append $neighbours)
                    visited: ($state.visited | update ($curr.i * $dimensions.w + $curr.j) true),
                },
            }

        } {
            next: [ { i: $i, j: $j } ],
            visited: $visited,
        }
        | uniq
    }

    let plants = generate { |visited|
        if ($visited | all { $in }) {
            return {}
        }

        let curr = $visited
            | enumerate
            | where not $it.item
            | first
            | get index
        let plant = $garden | get $curr
        let curr = { i: ($curr // $dimensions.w), j: ($curr mod $dimensions.w) }

        print --no-newline $"building region for ($plant) at \(($curr.i), ($curr.j)\): ($visited | where not $it | length) unvisited\r"
        let res = get-neighbouring-region $curr.i $curr.j $visited

        {
            out: { plant: $plant, region: ($res | drop nth ($res | length | $in - 1)) },
            next: ($visited | wrap before | merge ($res | last | wrap after) | each { $in.before or $in.after }),
        }
    } (false | repeat ($dimensions.w * $dimensions.h))
    print ''

    let res = $plants
        | enumerate
        | each { |it|
            print --no-newline $"area and perimeter: ($it.index + 1) / ($plants | length)\r"
            let area = $it.item.region | length

            let no_fences = $it.item.region | enumerate | each { |ri|
                $it.item.region | enumerate | skip ($ri.index + 1) | each { |rj|
                    if (($ri.item.i - $rj.item.i | math abs) + ($ri.item.j - $rj.item.j | math abs)) == 1 {
                        1
                    } else {
                        0
                    }
                }
            } | flatten

            let no_fences = if ($no_fences | is-empty) {
                0
            } else {
                $no_fences | math sum
            }
            let perimeter = $area * 4 - $no_fences * 2

            $area * $perimeter
        }
        | math sum
    print ''

    $res
}
