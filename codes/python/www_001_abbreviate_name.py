'''
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
'''

abbreviate_name = lambda complete_name: ".".join(map(lambda a_name: a_name[0].upper(), complete_name.split(" ")))
print(abbreviate_name("Sam Harris"))
# S.H
print(abbreviate_name("patrick feeney"))
# P.F
