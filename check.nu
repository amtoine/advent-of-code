#!/usr/bin/env nu


# runs all the solutions on the official inputs for amtoine (that's me)
# compares the result of both the silver and the gold levels against the
# official unique solutions for amtoine (that's me, again)
#
# a solution script has to be executable and have the following signature:
#    > main {flags} <input>
#
#    Flags:
#      --gold - activate the second part of the challenge
#      -h, --help - Display the help message for this command
#    
#    Parameters:
#      input <string>
def main [
  scripts_dir: string  # the path to the solution scripts, e.g. "solutions/nushell"
  inputs_dir: string = "inputs"  # the location of the challenge inputs,
    # fetched from https://adventofcode.com/2022/day/<day>/input
  answers_dir: string = "answers"  # the location of the challenge answers,
    # parsed from https://adventofcode.com/2022/day/<day> once <day> is completed
] {
  ls $scripts_dir
  | each {|script id|
    print $"(ansi yellow_bold)Day ($id + 1)(ansi reset):"

    let answers = (open $"($answers_dir)/($id + 1).json")

    print -n $"  (ansi default_dimmed)Running silver...(ansi reset) "
    let silver = (^$script.name $"($inputs_dir)/($id + 1).txt")
    print "ok"
    print -n $"  (ansi default_dimmed)Running gold...(ansi reset) "
    let gold = (^$script.name $"($inputs_dir)/($id + 1).txt" --gold)
    print "ok"

    mut good = true
    if ($silver != $answers.silver) {
      print -n $"(ansi red_bold)silver bad(ansi reset): (ansi red)expected ($answers.silver), got ($silver)(ansi reset)"
      $good = false
      print ""
    }
    if ($gold != $answers.gold) {
      print -n $"(ansi red_bold)gold bad(ansi reset): (ansi red)expected ($answers.gold), got ($gold)(ansi reset)"
      $good = false
      print ""
    }

    if ($good) {
      print $"(ansi green_bold)good(ansi reset)"
    }
  }
}