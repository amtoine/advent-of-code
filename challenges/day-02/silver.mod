(*
    This is the solution for the first star of day 2.
    https://adventofcode.com/2021/day/2

    compiled with obnc version 0.16.1
    https://github.com/amtoine/obnc/releases/tag/v0.16.1
*)

MODULE silver;
IMPORT In, Out;
VAR instruction: ARRAY 32 OF CHAR;
value, product: INTEGER;
depth, distance: INTEGER;

    PROCEDURE move (VAR depth, distance: INTEGER; value: INTEGER);
    BEGIN
        IF instruction = "forward" THEN
            distance := distance + value;
        ELSIF instruction = "down" THEN
            depth := depth + value;
        ELSE (* up *)
            depth := depth - value;
        END;
    END move;

BEGIN
    depth := 0;
    distance := 0;
    In.Name(instruction);
    In.Int(value);

    WHILE In.Done DO
        move(depth, distance, value);
        In.Name(instruction);
        In.Int(value);
    END;
    product := depth * distance;
    Out.Int(product, 10);
    Out.Ln();
END silver.
