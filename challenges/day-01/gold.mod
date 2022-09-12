(*
    This is the solution for the second star of day 1.
    https://adventofcode.com/2021/day/1

    compiled with obnc version 0.16.1
    https://github.com/amtoine/obnc/releases/tag/v0.16.1
*)

MODULE gold;
IMPORT In, Out;
VAR count: INTEGER;
first, second, third: INTEGER;
sum1, sum2: INTEGER;
BEGIN
    In.Int(first);
    In.Int(second);
    In.Int(third);
    sum1 := first + second + third;

    first := second;
    second := third;
    In.Int(third);
    sum2 := first + second + third;
    WHILE In.Done DO
        IF sum2 > sum1 THEN
            INC(count);
        END;
        sum1 := sum2;
        first := second;
        second := third;
        In.Int(third);
        sum2 := first + second + third;
    END;
    Out.String("Count: "); Out.Int(count, 5); Out.Ln();
END gold.
