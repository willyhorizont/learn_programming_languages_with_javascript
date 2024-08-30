# Source:
#     https://www.codewars.com/kata/57eadb7ecd143f4c9c0000a3
# Title:
#     Abbreviate a Two Word Name
# Description:
#     Write a function to convert a name into initials. This kata strictly takes two words with one space in between them.
#     The output should be two capital letters with a dot separating them.
#     It should look like this:
#     Sam Harris => S.H
#     patrick feeney => P.F

abbreviate_name <- function(complete_name) paste(unlist(lapply(strsplit(complete_name, split = " "), function(a_name) toupper(substr(a_name, 1, 1)))), collapse = ".")
cat(paste(sep = "", abbreviate_name("Sam Harris"), "\n"))
# S.H
cat(paste(sep = "", abbreviate_name("patrick feeney"), "\n"))
# P.F
