function stringifyresult = stringify(parameter)
    if isempty(parameter)
        stringifyresult = "null";
        return;
    end
    if ischar(parameter)
        stringifyresult = cstrcat("""", parameter, """");
        return;
    end
    if ischar(parameter)
        stringifyresult = cstrcat("""", parameter, """");
        return;
    end
    if isnumeric(parameter)
        stringifyresult = num2str(parameter);
        return;
    end
    if (islogical(parameter) && parameter == true)
        stringifyresult = "true";
        return;
    end
    if (islogical(parameter) && parameter == false)
        stringifyresult = "false";
        return;
    end
    if iscell(parameter)
        if isempty(parameter)
            stringifyresult = "[]";
            return;
        end
        currentresult = "[";
        for arrayitemindex = (1:1:numel(parameter))
            arrayitem = parameter{arrayitemindex};
            currentresult = cstrcat(currentresult, stringify(arrayitem));
            if (arrayitemindex ~= numel(parameter))
                currentresult = cstrcat(currentresult, ", ");
            end
        end
        stringifyresult = cstrcat(currentresult, "]");
        return;
    end
    if isstruct(parameter)
        if (numel(fieldnames(parameter)) == 0)
            stringifyresult = "{}";
            return;
        end
        currentresult = "{";
        objectkeys = fieldnames(parameter);
        for objectentryindex = (1:1:numel(objectkeys))
            objectkey = objectkeys{objectentryindex};
            objectvalue = parameter.(objectkey);
            currentresult = cstrcat(currentresult, """", objectkey, """: ", stringify(objectvalue));
            if (objectentryindex ~= numel(objectkeys))
                currentresult = cstrcat(currentresult, ",");
            end
        end
        stringifyresult = cstrcat(currentresult, "}");
        return;
    end
    stringifyresult = "null";
end

function sprint(varargin)
    currentresult = "";
    for parameterindex = (1:1:numel(varargin))
        parameter = varargin{parameterindex};
        if (iscell(parameter) && (numel(parameter) == 1))
            parameternew = stringify(parameter{1});
            parameternew = strrep(parameternew, """{", "{");
            parameternew = strrep(parameternew, """[", "[");
            parameternew = strrep(parameternew, "}""", "}");
            parameternew = strrep(parameternew, "]""", "]");
            currentresult = cstrcat(currentresult, parameternew);
            continue;
        end
        currentresult = cstrcat(currentresult, parameter);
    end
    disp(currentresult);
end

%{
    Relational Operators / Comparison Operators:
    equal to [==, eq(a, b), strcmp(a, b)]
    not equal to [~=, ne(a, b)]
    greater than [>, gt(a, b)]
    less than [<, lt(a, b)]
    greater than or equal to [>=, ge(a, b)]
    less than or equal to [<=, le(a,b )]

    Logical Operators:
    Logical AND [&&, and(a, b)]
    Logical OR [||, or(a, b)]
    Logical NOT [~), not(a)]
%}

CORRECTANSWER = 100;

sprint(sprintf("\n"), "% basic conditional control flow", sprintf("\n"));

myage = 10;
sprint("myage: ", {myage});
if (myage > 24)
    disp("you are old");
elseif (myage > 17)
    disp("you are young");
else
    disp("you are under age");
end

sprint(sprintf("\n"), "% equal to [==, eq(a, b), strcmp(a, b)]", sprintf("\n"));

myanswer = 100;
sprint("myanswer: ", {myanswer});
sprint("CORRECTANSWER: ", {CORRECTANSWER});
disp("(myanswer == CORRECTANSWER):");
if (myanswer == CORRECTANSWER)
    disp("Your answer is correct");
else
    disp("Your answer is wrong");
end

myanswer = 100;
sprint("myanswer: ", {myanswer});
sprint("CORRECTANSWER: ", {CORRECTANSWER});
disp("eq(myanswer, CORRECTANSWER):");
if eq(myanswer, CORRECTANSWER)
    disp("Your answer is correct");
else
    disp("Your answer is wrong");
end

myanswer = 100;
sprint("myanswer: ", {myanswer});
sprint("CORRECTANSWER: ", {CORRECTANSWER});
disp("strcmp(myanswer, CORRECTANSWER):");
if strcmp(myanswer, CORRECTANSWER)
    disp("Your answer is correct");
else
    disp("Your answer is wrong");
end

% this code throw an error
% myanswer = "100";
% sprint("myanswer: ", {myanswer});
% sprint("CORRECTANSWER: ", {CORRECTANSWER});
% disp("(myanswer == CORRECTANSWER):");
% if (myanswer == CORRECTANSWER)
%     disp("Your answer is correct");
% else
%     disp("Your answer is wrong");
% end

% this code throw an error
% myanswer = "100";
% sprint("myanswer: ", {myanswer});
% sprint("CORRECTANSWER: ", {CORRECTANSWER});
% disp("eq(myanswer, CORRECTANSWER):");
% if eq(myanswer, CORRECTANSWER)
%     disp("Your answer is correct");
% else
%     disp("Your answer is wrong");
% end

myanswer = "100";
sprint("myanswer: ", {myanswer});
sprint("CORRECTANSWER: ", {CORRECTANSWER});
disp("strcmp(myanswer, CORRECTANSWER):");
if strcmp(myanswer, CORRECTANSWER)
    disp("Your answer is correct");
else
    disp("Your answer is wrong");
end

sprint(sprintf("\n"), "% not equal to [~=, ne(a, b)]", sprintf("\n"));

myanswer = 25;
sprint("myanswer: ", {myanswer});
sprint("CORRECTANSWER: ", {CORRECTANSWER});
disp("(myanswer ~= CORRECTANSWER):");
if (myanswer ~= CORRECTANSWER)
    disp("Your answer is correct");
else
    disp("Your answer is wrong");
end

myanswer = 25;
sprint("myanswer: ", {myanswer});
sprint("CORRECTANSWER: ", {CORRECTANSWER});
disp("ne(myanswer, CORRECTANSWER):");
if ne(myanswer, CORRECTANSWER)
    disp("Your answer is correct");
else
    disp("Your answer is wrong");
end

% this code throw an error
% myanswer = "25";
% sprint("myanswer: ", {myanswer});
% sprint("CORRECTANSWER: ", {CORRECTANSWER});
% disp("(myanswer ~= CORRECTANSWER):");
% if (myanswer ~= CORRECTANSWER)
%     disp("Your answer is correct");
% else
%     disp("Your answer is wrong");
% end

% this code throw an error
% myanswer = "25";
% sprint("myanswer: ", {myanswer});
% sprint("CORRECTANSWER: ", {CORRECTANSWER});
% disp("ne(myanswer, CORRECTANSWER):");
% if ne(myanswer, CORRECTANSWER)
%     disp("Your answer is correct");
% else
%     disp("Your answer is wrong");
% end

sprint(sprintf("\n"), "% greater than [>, gt(a, b)]", sprintf("\n"));

myage = 70;
sprint("myage: ", {myage});
disp("(myage > 50):");
if (myage > 50)
    disp("You are old");
end

myage = 70;
sprint("myage: ", {myage});
disp("gt(myage, 50):");
if gt(myage, 50)
    disp("You are old");
end

sprint(sprintf("\n"), "% less than [<, lt(a, b)]", sprintf("\n"));

myage = 16;
sprint("myage: ", {myage});
disp("(myage < 20):");
if (myage < 20)
    disp("You are young");
end

myage = 16;
sprint("myage: ", {myage});
disp("lt(myage, 20):");
if lt(myage, 20)
    disp("You are young");
end

sprint(sprintf("\n"), "% greater than or equal to [>=, ge(a, b)]", sprintf("\n"));

myage = 73;
sprint("myage: ", {myage});
disp("(myage >= 65):");
if (myage >= 65)
    disp("You are allowed to retire");
end

myage = 73;
sprint("myage: ", {myage});
disp("ge(myage, 65):");
if ge(myage, 65)
    disp("You are allowed to retire");
end

sprint(sprintf("\n"), "% less than or equal to [<=, le(a,b )]", sprintf("\n"));

myage = 14;
sprint("myage: ", {myage});
disp("(myage <= 16):");
if (myage <= 16)
    disp("You are not allowed to drive");
end

myage = 14;
sprint("myage: ", {myage});
disp("le(myage, 16):");
if le(myage, 16)
    disp("You are not allowed to drive");
end

sprint(sprintf("\n"), "% Logical AND [&&, and(a, b)]", sprintf("\n"));

myage = 17;
sprint("myage: ", {myage});
hasdrivinglicense = false;
sprint("hasdrivinglicense: ", {hasdrivinglicense});
disp("((myage >= 17) && (hasdrivinglicense == true)):");
if ((myage >= 17) && (hasdrivinglicense == true))
    disp("You are allowed to drive");
else
    disp("You are not allowed to drive");
end

myage = 17;
sprint("myage: ", {myage});
hasdrivinglicense = true;
sprint("hasdrivinglicense: ", {hasdrivinglicense});
disp("((myage >= 17) && (hasdrivinglicense == true)):");
if ((myage >= 17) && (hasdrivinglicense == true))
    disp("You are allowed to drive");
else
    disp("You are not allowed to drive");
end

myage = 17;
sprint("myage: ", {myage});
hasdrivinglicense = false;
sprint("hasdrivinglicense: ", {hasdrivinglicense});
disp("and((myage >= 17), (hasdrivinglicense == true)):");
if and((myage >= 17), (hasdrivinglicense == true))
    disp("You are allowed to drive");
else
    disp("You are not allowed to drive");
end

myage = 17;
sprint("myage: ", {myage});
hasdrivinglicense = true;
sprint("hasdrivinglicense: ", {hasdrivinglicense});
disp("and((myage >= 17), (hasdrivinglicense == true)):");
if and((myage >= 17), (hasdrivinglicense == true))
    disp("You are allowed to drive");
else
    disp("You are not allowed to drive");
end

sprint(sprintf("\n"), "% Logical OR [||, or(a, b)]", sprintf("\n"));

myage = 2;
sprint("myage: ", {myage});
disp("((myage <= 3) || (myage >= 65)):");
if ((myage <= 3) || (myage >= 65))
    disp("You should stay home");
end

myage = 89;
sprint("myage: ", {myage});
disp("((myage <= 3) || (myage >= 65)):");
if ((myage <= 3) || (myage >= 65))
    disp("You should stay home");
end

myage = 2;
sprint("myage: ", {myage});
disp("or((myage <= 3), (myage >= 65)):");
if or((myage <= 3), (myage >= 65))
    disp("You should stay home");
end

myage = 89;
sprint("myage: ", {myage});
disp("or((myage <= 3), (myage >= 65)):");
if or((myage <= 3), (myage >= 65))
    disp("You should stay home");
end

sprint(sprintf("\n"), "% Logical NOT [~), not(a)]", sprintf("\n"));

candrive = false;
sprint("candrive: ", {candrive});
sprint("~candrive: ", {~candrive});

candrive = true;
sprint("candrive: ", {candrive});
sprint("~candrive: ", {~candrive});

candrive = false;
sprint("candrive: ", {candrive});
sprint("not(candrive): ", {not(candrive)});

candrive = true;
sprint("candrive: ", {candrive});
sprint("not(candrive): ", {not(candrive)});
