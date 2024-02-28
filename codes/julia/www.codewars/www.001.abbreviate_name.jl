using Printf
using Statistics

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

abbreviate_name = (complete_name) -> join(map(((name) -> uppercase(name[1])), split(complete_name, " ")), ".")
println(abbreviate_name("Sam Harris"))
# S.H
println(abbreviate_name("patrick feeney"))
# P.F
