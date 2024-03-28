%{
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
%}

abbreviatename = @(completename) strjoin(cellfun(@(aname) upper(aname(1)), strsplit(completename, " "), "UniformOutput", false), ".");
disp(abbreviatename("Sam Harris"));
% S.H
disp(abbreviatename("patrick feeney"));
% P.F
