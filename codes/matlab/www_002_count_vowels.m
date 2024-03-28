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

function splitstringresult = splitstring(astring)
    astring = char(astring);
    currentsplitstringresult = {};
    for i = (1:1:length(astring))
        currentsplitstringresult{i} = astring(i);
    end
    splitstringresult = currentsplitstringresult;
end

function countvowelsv1result = countvowelsv1(astring)
    splittedstring = splitstring(astring);
    countvowelsv1result = numel(splittedstring(cellfun(@(acharacter) ~isempty(find(cellfun(@(avowel) strcmp(acharacter, avowel), {"a", "i", "u", "e", "o", "A", "I", "U", "E", "O"}), 1)), splittedstring)));
end
disp(num2str(countvowelsv1("Hello World"))); %3

function countvowelsv2result = countvowelsv2(astring)
    splittedstring = splitstring(astring);
    countvowelsv2result = numel(splittedstring(cellfun(@(acharacter) ~isempty(find(cellfun(@(avowel) strcmp(upper(acharacter), avowel), {"A", "I", "U", "E", "O"}), 1)), splittedstring)));
end
disp(num2str(countvowelsv2("Hello World"))); %3

function countvowelsv3result = countvowelsv3(astring)
    splittedstring = splitstring(astring);
    countvowelsv3result = numel(splittedstring(cellfun(@(acharacter) ~isempty(strfind("aiueoAIUEO", acharacter)), splittedstring)));
end
disp(num2str(countvowelsv3("Hello World"))); %3

function countvowelsv4result = countvowelsv4(astring)
    splittedstring = splitstring(astring);
    countvowelsv4result = numel(splittedstring(cellfun(@(acharacter) ~isempty(strfind("AIUEO", upper(acharacter))), splittedstring)));
end
disp(num2str(countvowelsv4("Hello World"))); %3
