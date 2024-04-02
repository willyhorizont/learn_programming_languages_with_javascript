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

val abbreviateNameV1 = ((completeName: String) => (completeName.split(" ").map((aName: String) => aName(0).toString.toUpperCase()).mkString(".")): String)
println(abbreviateNameV1("Sam Harris"))
// S.H
println(abbreviateNameV1("patrick feeney"))
// P.F

val abbreviateNameV2 = ((completeName: String) => (completeName.split(" ").map((aName: String) => aName.charAt(0).toString.toUpperCase()).mkString(".")): String)
println(abbreviateNameV2("Sam Harris"))
// S.H
println(abbreviateNameV2("patrick feeney"))
// P.F
