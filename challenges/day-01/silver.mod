(*
    This is the solution for the first star of day 1.
    https://adventofcode.com/2021/day/1

    compiled with obnc version 0.16.1
    https://github.com/amtoine/obnc/releases/tag/v0.16.1
*)

MODULE silver;
IMPORT In, Out;
VAR count: INTEGER;
first, second: INTEGER;
BEGIN
    In.Int(first);
    In.Int(second);
    WHILE In.Done DO
        IF second > first THEN
            INC(count);
        END;
        first := second;
        In.Int(second);
    END;
    Out.String("Count: "); Out.Int(count, 5); Out.Ln();
END silver.
