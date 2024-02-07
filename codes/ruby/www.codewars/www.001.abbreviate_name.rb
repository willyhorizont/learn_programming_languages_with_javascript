=begin
Title:
    Abbreviate a Two Word Name
Instructions:
    Write a function to convert a name into initials. This kata strictly takes two words with one space in between them.
    The output should be two capital letters with a dot separating them.
    It should look like this:
    Sam Harris => S.H
    patrick feeney => P.F
=end

def abbrev_name(complete_name)
    return complete_name.split(" ").map { |name| name[0].upcase }.join(".")
end
print(abbrev_name("Sam Harris"), "\n")
# S.H
print(abbrev_name("patrick feeney"), "\n")
# P.F
