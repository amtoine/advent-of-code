# advent-of-code 2022
A collection of solutions for the advent of code event each year from 2015.
### This is the year 2022

## `nushell`
simply run the scripts provided in `./nushell/`

## Check the answers after submitting
once an answer has been submitting correctly, one can not poll the AOC website again...

the only way to verify that a script does the job is to pull the logged in page and parse the answers, which are now hardcoded in the page!

this is what the `check` script does:
- pull the answers from the website using the session cookie
- run the scripts in the solution directory
- compare the results with the true answers
- give nice error messages to the user

### usage
```bash
> ./check /path/to/nushell/scripts/ /path/to/inputs/ /path/to/aoc.asc
```
