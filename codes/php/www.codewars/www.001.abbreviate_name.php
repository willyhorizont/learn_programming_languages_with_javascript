<?php

/*
Title:
    Abbreviate a Two Word Name
Instructions:
    Write a function to convert a name into initials. This kata strictly takes two words with one space in between them.
    The output should be two capital letters with a dot separating them.
    It should look like this:
    Sam Harris => S.H
    patrick feeney => P.F
*/

function abbrevName($completeName) {
    return join(".", array_map(fn($name) => strtoupper($name[0]), explode(" ", $completeName)));
}
echo(abbrevName("Sam Harris") . "\n");
// S.H
echo(abbrevName("patrick feeney") . "\n");
// P.F
