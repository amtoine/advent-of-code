# advent-of-code 2022
A collection of solutions for the advent of code event each year from 2015.
### This is the year 2022

## `nushell`
simply run the scripts provided in `./solutions/nushell/`
have a look at `<script> --help` :wink:

## Check the answers after submitting
once an answer has been submitting correctly, one can not poll the AOC website again...

the only way to verify that a script does the job is to pull the logged in page and parse the answers, which are now hardcoded in the page!

this is why i have now added all my inputs and the associated answers:
#### have a look at `inputs/<day>.txt` and `answers/<day>.json`!!

this is what the `check` script does:
- take the answers from `./answers/`
- run the scripts in the solution directory
- compare the results with the true answers
- give nice error messages to the user

### usage
```bash
> ./check /path/to/nushell/scripts/
```

### important notes
have a look at `./check --help`

> a solution script has to be executable and have the following signature:
> ```
>    > main {flags} <input>
> 
>    Flags:
>      --gold - activate the second part of the challenge
>      -h, --help - Display the help message for this command
> 
>    Parameters:
>      input <string>
> ```
