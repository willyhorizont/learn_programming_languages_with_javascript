function stringrepeatresult = stringrepeat(astring, count)
    result = "";
    for i = (1:1:count) % (start:step:stop)
        result = cstrcat(result, astring);
    end
    stringrepeatresult = result;
end

function arrayreduceresult = arrayreduce(callbackfunction, anarray, initialvalue)
    % JavaScript-like Array.reduce() function
    currentresult = initialvalue;
    for arrayitemindex = (1:1:numel(anarray)) % (start:step:stop)
        arrayitem = anarray{arrayitemindex};
        currentresult = callbackfunction(currentresult, arrayitem, arrayitemindex, anarray);
    end
    arrayreduceresult = currentresult;
end

function optionalchainingresult = optionalchaining(anything, varargin)
    % JavaScript-like Optional Chaining Operator (?.) function
    % varargin == objectpropertiesarray
    if ((~isstruct(anything) && ~iscell(anything)) || isempty(varargin))
        optionalchainingresult = anything;
        return;
    end
    function arrayreducecallbackresult = arrayreducecallback(currentresult, currentitem, varargin)
        % varargin == (arrayitemindex, anarray)
        if ((isempty(currentresult) && isstruct(anything) && (ischar(currentitem) || ischar(currentitem))) && isfield(anything, currentitem))
            arrayreducecallbackresult = anything.(currentitem);
            return;
        end
        if (isempty(currentresult) && iscell(anything) && isnumeric(currentitem) && (currentitem >= 1) && (numel(anything) > currentitem))
            arrayreducecallbackresult = anything{currentitem};
            return;
        end
        if ((isstruct(currentresult) && (ischar(currentitem) || ischar(currentitem))) && isfield(currentresult, currentitem))
            arrayreducecallbackresult = currentresult.(currentitem);
            return;
        end
        if (iscell(currentresult) && isnumeric(currentitem) && (currentitem >= 1) && (numel(currentresult) > currentitem))
            arrayreducecallbackresult = currentresult{currentitem};
            return;
        end
        arrayreducecallbackresult = {};
    end
    optionalchainingresult = arrayreduce(@arrayreducecallback, varargin, {});
end

function ternaryresult = ternary(truecondition, callbackfunctionifconditiontrue, callbackfunctionifconditionfalse)
    if (islogical(truecondition) && (truecondition == true))
        ternaryresult = callbackfunctionifconditiontrue();
        return;
    end
    ternaryresult = callbackfunctionifconditionfalse();
end

function jsonstringifyresult = jsonstringify(anything, varargin)
    indentlevel = 0;
    function jsonstringifyinnerresult = jsonstringifyinner(anythinginner, prettyinner, indentinner)
        if isempty(anythinginner)
            jsonstringifyinnerresult = "null";
            return;
        end
        if (ischar(anythinginner) || ischar(anythinginner))
            jsonstringifyinnerresult = cstrcat("""", anythinginner, """");
            return;
        end
        if isnumeric(anythinginner)
            jsonstringifyinnerresult = num2str(anythinginner);
            return;
        end
        if (islogical(anythinginner) && (anythinginner == true))
            jsonstringifyinnerresult = "true";
            return;
        end
        if (islogical(anythinginner) && (anythinginner == false))
            jsonstringifyinnerresult = "false";
            return;
        end
        if iscell(anythinginner)
            if isempty(anythinginner)
                jsonstringifyinnerresult = "[]";
                return;
            end
            indentlevel = indentlevel + 1;
            result = ternary((pretty == true), @() (cstrcat("[", sprintf("\n"), stringrepeat(indentinner, indentlevel))), @() ("["));
            for arrayitemindex = (1:1:numel(anythinginner)) % (start:step:stop)
                arrayitem = anythinginner{arrayitemindex};
                result = cstrcat(result, jsonstringifyinner(arrayitem, prettyinner, indentinner));
                if (arrayitemindex ~= numel(anythinginner))
                    result = ternary((pretty == true), @() (cstrcat(result, ",", sprintf("\n"), stringrepeat(indentinner, indentlevel))), @() (cstrcat(result, ", ")));
                end
            end
            indentlevel = indentlevel - 1;
            result = ternary((pretty == true), @() (cstrcat(result, sprintf("\n"), stringrepeat(indentinner, indentlevel), "]")), @() (cstrcat(result, "]")));
            jsonstringifyinnerresult = result;
            return;
        end
        if isstruct(anythinginner)
            if (numel(fieldnames(anythinginner)) == 0)
                jsonstringifyinnerresult = "{}";
                return;
            end
            indentlevel = indentlevel + 1;
            result = ternary((pretty == true), @() (cstrcat("{", sprintf("\n"), stringrepeat(indentinner, indentlevel))), @() ("{"));
            objectkeys = fieldnames(anythinginner);
            for objectentryindex = (1:1:numel(objectkeys)) % (start:step:stop)
                objectkey = objectkeys{objectentryindex};
                objectvalue = anythinginner.(objectkey);
                result = cstrcat(result, """", objectkey, """: ", jsonstringifyinner(objectvalue, prettyinner, indentinner));
                if (objectentryindex ~= numel(objectkeys))
                    result = ternary((pretty == true), @() (cstrcat(result, ",", sprintf("\n"), stringrepeat(indentinner, indentlevel))), @() (cstrcat(result, ", ")));
                end
            end
            indentlevel = indentlevel - 1;
            result = ternary((pretty == true), @() (cstrcat(result, sprintf("\n"), stringrepeat(indentinner, indentlevel), "}")), @() (cstrcat(result, "}")));
            jsonstringifyinnerresult = result;
            return;
        end
        jsonstringifyinnerresult = "null";
    end
    prettydefault = false;
    indentdefault = "    ";
    pretty = prettydefault;
    indent = indentdefault;
    if isempty(varargin)
        jsonstringifyresult = jsonstringifyinner(anything, prettydefault, indentdefault);
        return;
    end
    optionalargument = varargin{1};
    if (islogical(optionalargument) && (optionalargument == false))
        jsonstringifyresult = jsonstringifyinner(anything, prettydefault, indentdefault);
        return;
    end
    if isstruct(optionalargument)
        pretty = optionalchaining(optionalargument, "pretty");
        indent = optionalchaining(optionalargument, "indent");
        pretty = ternary(isempty(pretty), @() (prettydefault), @() (pretty));
        indent = ternary(isempty(indent), @() (indentdefault), @() (indent));
        jsonstringifyresult = jsonstringifyinner(anything, pretty, indent);
        return;
    end
    if (islogical(optionalargument) && (optionalargument == true))
        if (numel(varargin) >= 2)
            optionalargument2 = varargin{2};
            if (ischar(optionalargument2) || ischar(optionalargument2))
                indent = optionalargument2
            end
        end
        pretty = optionalargument;
        jsonstringifyresult = jsonstringifyinner(anything, pretty, indent);
        return;
    end
    jsonstringifyresult = jsonstringifyinner(anything, prettydefault, indentdefault);
end

function sprint(varargin)
    currentresult = "";
    for argumentindex = (1:1:numel(varargin)) % (start:step:stop)
        argument = varargin{argumentindex};
        if (iscell(argument) && (numel(argument) == 1))
            argumentnew = jsonstringify(argument{1});
            argumentnew = strrep(argumentnew, """{", "{");
            argumentnew = strrep(argumentnew, """[", "[");
            argumentnew = strrep(argumentnew, "}""", "}");
            argumentnew = strrep(argumentnew, "]""", "]");
            currentresult = cstrcat(currentresult, argumentnew);
            continue;
        end
        if (~ischar(argument) && ~ischar(argument))
            error("Non string argument must be wrapped in {}");
            continue;
        end
        currentresult = cstrcat(currentresult, argument);
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
    less than or equal to [<=, le(a, b)]

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

sprint(sprintf("\n"), "% less than or equal to [<=, le(a, b)]", sprintf("\n"));

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
