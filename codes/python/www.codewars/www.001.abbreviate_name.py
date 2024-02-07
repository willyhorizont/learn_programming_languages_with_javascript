'''
Title:
    Abbreviate a Two Word Name
Instructions:
    Write a function to convert a name into initials. This kata strictly takes two words with one space in between them.
    The output should be two capital letters with a dot separating them.
    It should look like this:
    Sam Harris => S.H
    patrick feeney => P.F
'''

abbrev_name = lambda complete_name: ".".join(map(lambda name: name[0].upper(), complete_name.split(" ")))
print(abbrev_name("Sam Harris"))
# S.H
print(abbrev_name("patrick feeney"))
# P.F