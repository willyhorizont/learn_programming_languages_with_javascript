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

let abbreviateName = { (completeName: String) -> String in completeName.split(separator: " ").map { (aName: Substring) -> String in aName.first!.uppercased() }.joined(separator: ".") }
print(abbreviateName("Sam Harris"))
// S.H
print(abbreviateName("patrick feeney"))
// P.F
