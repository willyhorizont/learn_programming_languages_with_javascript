# Title:
#     Abbreviate a Two Word Name
# Instructions:
#     Write a function to convert a name into initials. This kata strictly takes two words with one space in between them.
#     The output should be two capital letters with a dot separating them.
#     It should look like this:
#     Sam Harris => S.H
#     patrick feeney => P.F

abbrev_name <- function(completeName) paste(unlist(lapply(strsplit(completeName, split = " "), function(name) toupper(substr(name, 1, 1)))), collapse = ".")
cat(paste(sep = "", abbrev_name("Sam Harris"), "\n"))
# S.H
cat(paste(sep = "", abbrev_name("patrick feeney"), "\n"))
# P.F