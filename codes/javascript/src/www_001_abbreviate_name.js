/*
    Source:
        https://www.codewars.com/kata/57eadb7ecd143f4c9c0000a3
    Title:
        Abbreviate a Two Word Name
    Description:
        Write a function to convert a name into initials. This kata strictly takes two words with one space in between them.
        The output should be two capital letters with a dot separating them.
        It should look like this:
        Sam Harris => S.H
        patrick feeney => P.F
*/

const abbreviateNameV1 = (completeName) => completeName.split(" ").map((anyName) => anyName[0].toUpperCase()).join(".");
console.log(abbreviateNameV1("Sam Harris"));
// S.H
console.log(abbreviateNameV1("patrick feeney"));
// P.F

const abbreviateNameV2 = (completeName) => completeName.split(" ").map((anyName) => anyName.charAt(0).toUpperCase()).join(".");
console.log(abbreviateNameV2("Sam Harris"));
// S.H
console.log(abbreviateNameV2("patrick feeney"));
// P.F
