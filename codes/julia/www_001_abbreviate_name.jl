#=
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
=#

abbreviate_name::Any = (complete_name::Any) -> (join(map(((any_name::Any) -> (uppercase(any_name[1]))::Any), (split(complete_name, " "))), "."))::Any
println(abbreviate_name("Sam Harris"))
# S.H
println(abbreviate_name("patrick feeney"))
# P.F
