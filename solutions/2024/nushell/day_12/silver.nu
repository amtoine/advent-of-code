use std repeat

export def main []: [ string -> int ] {
    let garden = $in | lines | str join '' | split chars
    let dimensions = { h: ($in | lines | length), w: ($in | lines | first | split chars | length) }

    def foo [i: int, j: int, visited: list<bool>] {
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

    generate { |visited|
        if ($visited | all { $in }) {
            return {}
        }

        let curr = $visited
            | enumerate
            | where not $it.item
            | first
            | get index

        let res = $curr | foo ($in // $dimensions.w) ($in mod $dimensions.w) $visited

        {
            out: { plant: ($garden | get $curr), region: ($res | drop nth ($res | length | $in - 1)) },
            next: ($visited | wrap before | merge ($res | last | wrap after) | each { $in.before or $in.after }),
        }
    } (false | repeat ($dimensions.w * $dimensions.h)) | tee { table --expand | print }

    0
}
