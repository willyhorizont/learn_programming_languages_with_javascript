using Printf
using Statistics

#=
Title:
    Abbreviate a Two Word Name
Instructions:
    Write a function to convert a name into initials. This kata strictly takes two words with one space in between them.
    The output should be two capital letters with a dot separating them.
    It should look like this:
    Sam Harris => S.H
    patrick feeney => P.F
=#

abbrevname = (complete_name) -> join(map(((name) -> uppercase(name[1])), split(complete_name, " ")), ".")
println(abbrevname("Sam Harris"))
# S.H
println(abbrevname("patrick feeney"))
# P.F