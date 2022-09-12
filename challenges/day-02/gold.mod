(*
    This is the solution for the second star of day 2.
    https://adventofcode.com/2021/day/2

    compiled with obnc version 0.16.1
    https://github.com/amtoine/obnc/releases/tag/v0.16.1
*)

MODULE gold;
IMPORT In, Out;
VAR instruction: ARRAY 32 OF CHAR;
value, product: INTEGER;
aim, depth, distance: INTEGER;

    PROCEDURE move (VAR aim, depth, distance: INTEGER; value: INTEGER);
    BEGIN
        IF instruction = "forward" THEN
            distance := distance + value;
            depth := depth + aim * value;
        ELSIF instruction = "down" THEN
            aim := aim + value;
        ELSE (* up *)
            aim := aim - value;
        END;
    END move;

BEGIN
    depth := 0;
    distance := 0;
    In.Name(instruction);
    In.Int(value);

    WHILE In.Done DO
        move(aim, depth, distance, value);
        In.Name(instruction);
        In.Int(value);
    END;
    product := depth * distance;
    Out.Int(product, 10);
    Out.Ln();
END gold.
