%{
Source:
    https://www.codewars.com/kata/54ff3102c1bad923760001f3
Title:
    Vowel Count
Description:
    Return the number (count) of vowels in the given string.
    We will consider a, e, i, o, u as vowels for this Kata (but not y).
    The input string will only consist of lower case letters and/or spaces.
%}

function countvowelsv1result = countvowelsv1(astring)
    astring = char(astring);
    splittedstringcellarray = {};
    for i = (1:1:length(astring))
        splittedstringcellarray{i} = astring(i);
    end
    countvowelsv1result = numel(splittedstringcellarray(cellfun(@(aletter) ~isempty(find(cellfun(@(avowel) strcmp(aletter, avowel), {"a", "i", "u", "e", "o", "A", "I", "U", "E", "O"}), 1)), splittedstringcellarray)));
end
disp(num2str(countvowelsv1("Hello World"))); %3

function countvowelsv2result = countvowelsv2(astring)
    astring = char(astring);
    splittedstringcellarray = {};
    for i = (1:1:length(astring))
        splittedstringcellarray{i} = astring(i);
    end
    countvowelsv2result = numel(splittedstringcellarray(cellfun(@(aletter) ~isempty(find(cellfun(@(avowel) strcmp(upper(aletter), avowel), {"A", "I", "U", "E", "O"}), 1)), splittedstringcellarray)));
end
disp(num2str(countvowelsv2("Hello World"))); %3

function countvowelsv3result = countvowelsv3(astring)
    astring = char(astring);
    splittedstringcellarray = {};
    for i = (1:1:length(astring))
        splittedstringcellarray{i} = astring(i);
    end
    countvowelsv3result = numel(splittedstringcellarray(cellfun(@(aletter) ~isempty(strfind("aiueoAIUEO", aletter)), splittedstringcellarray)));
end
disp(num2str(countvowelsv3("Hello World"))); %3

function countvowelsv4result = countvowelsv4(astring)
    astring = char(astring);
    splittedstringcellarray = {};
    for i = (1:1:length(astring))
        splittedstringcellarray{i} = astring(i);
    end
    countvowelsv4result = numel(splittedstringcellarray(cellfun(@(aletter) ~isempty(strfind("AIUEO", upper(aletter))), splittedstringcellarray)));
end
disp(num2str(countvowelsv4("Hello World"))); %3
