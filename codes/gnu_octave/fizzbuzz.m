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

sprint(sprintf("\n"), "% FizzBuzz(n) in GNU Octave");

function fizzbuzzv1result = fizzbuzzv1(stopnumber)
    if ~isnumeric(stopnumber)
        error("Argument should be a number");
    end
    if (stopnumber < 1)
        error("Argument should be > 0");
    end
    currentresult = "";
    number = 1;
    while (true)
        if strcmp(currentresult, "")
            currentresult = num2str(number);
            if (number >= stopnumber)
                break;
            end
            number = (number + 1);
            continue;
        end
        if ((mod(number, 3) == 0) && (mod(number, 5) == 0))
            currentresult = cstrcat(currentresult, ", FizzBuzz");
            if (number >= stopnumber)
                break;
            end
            number = (number + 1);
            continue;
        end
        if (mod(number, 3) == 0)
            currentresult = cstrcat(currentresult, ", Fizz");
            if (number >= stopnumber)
                break;
            end
            number = (number + 1);
            continue;
        end
        if (mod(number, 5) == 0)
            currentresult = cstrcat(currentresult, ", Buzz");
            if (number >= stopnumber)
                break;
            end
            number = (number + 1);
            continue;
        end
        currentresult = cstrcat(currentresult, ", ", num2str(number));
        if (number >= stopnumber)
            break;
        end
        number = (number + 1);
    end
    fizzbuzzv1result = currentresult;
end

function fizzbuzzv2result = fizzbuzzv2(stopnumber)
    if ~isnumeric(stopnumber)
        error("Argument should be a number");
    end
    if (stopnumber < 1)
        error("Argument should be > 0");
    end
    currentresult = "";
    number = 1;
    while (number <= stopnumber)
        if strcmp(currentresult, "")
            currentresult = num2str(number);
            number = (number + 1);
            continue;
        end
        if ((mod(number, 3) == 0) && (mod(number, 5) == 0))
            currentresult = cstrcat(currentresult, ", FizzBuzz");
            number = (number + 1);
            continue;
        end
        if (mod(number, 3) == 0)
            currentresult = cstrcat(currentresult, ", Fizz");
            number = (number + 1);
            continue;
        end
        if (mod(number, 5) == 0)
            currentresult = cstrcat(currentresult, ", Buzz");
            number = (number + 1);
            continue;
        end
        currentresult = cstrcat(currentresult, ", ", num2str(number));
        number = (number + 1);
    end
    fizzbuzzv2result = currentresult;
end

function fizzbuzzv3result = fizzbuzzv3(stopnumber)
    if ~isnumeric(stopnumber)
        error("Argument should be a number");
    end
    if (stopnumber < 1)
        error("Argument should be > 0");
    end
    currentresult = "";
    number = 1;
    while (true)
        if strcmp(currentresult, "")
            currentresult = num2str(number);
        elseif ((mod(number, 3) == 0) && (mod(number, 5) == 0))
            currentresult = cstrcat(currentresult, ", FizzBuzz");
        elseif (mod(number, 3) == 0)
            currentresult = cstrcat(currentresult, ", Fizz");
        elseif (mod(number, 5) == 0)
            currentresult = cstrcat(currentresult, ", Buzz");
        else
            currentresult = cstrcat(currentresult, ", ", num2str(number));
        end
        if (number >= stopnumber)
            break;
        end
        number = (number + 1);
    end
    fizzbuzzv3result = currentresult;
end

function fizzbuzzv4result = fizzbuzzv4(stopnumber)
    if ~isnumeric(stopnumber)
        error("Argument should be a number");
    end
    if (stopnumber < 1)
        error("Argument should be > 0");
    end
    currentresult = "";
    number = 1;
    while (number <= stopnumber)
        if strcmp(currentresult, "")
            currentresult = num2str(number);
        elseif ((mod(number, 3) == 0) && (mod(number, 5) == 0))
            currentresult = cstrcat(currentresult, ", FizzBuzz");
        elseif (mod(number, 3) == 0)
            currentresult = cstrcat(currentresult, ", Fizz");
        elseif (mod(number, 5) == 0)
            currentresult = cstrcat(currentresult, ", Buzz");
        else
            currentresult = cstrcat(currentresult, ", ", num2str(number));
        end
        number = (number + 1);
    end
    fizzbuzzv4result = currentresult;
end

function fizzbuzzv5result = fizzbuzzv5(stopnumber)
    if ~isnumeric(stopnumber)
        error("Argument should be a number");
    end
    if (stopnumber < 1)
        error("Argument should be > 0");
    end
    currentresult = "";
    number = 1;

    for number = (1:1:stopnumber) % (start:step:stop)
        if strcmp(currentresult, "")
            currentresult = num2str(number);
            continue;
        end
        if ((mod(number, 3) == 0) && (mod(number, 5) == 0))
            currentresult = cstrcat(currentresult, ", FizzBuzz");
            continue;
        end
        if (mod(number, 3) == 0)
            currentresult = cstrcat(currentresult, ", Fizz");
            continue;
        end
        if (mod(number, 5) == 0)
            currentresult = cstrcat(currentresult, ", Buzz");
            continue;
        end
        currentresult = cstrcat(currentresult, ", ", num2str(number));
    end
    fizzbuzzv5result = currentresult;
end

function fizzbuzzv6result = fizzbuzzv6(stopnumber)
    if ~isnumeric(stopnumber)
        error("Argument should be a number");
    end
    if (stopnumber < 1)
        error("Argument should be > 0");
    end
    currentresult = "";
    number = 1;

    for number = (1:1:stopnumber) % (start:step:stop)
        if strcmp(currentresult, "")
            currentresult = num2str(number);
        elseif ((mod(number, 3) == 0) && (mod(number, 5) == 0))
            currentresult = cstrcat(currentresult, ", FizzBuzz");
        elseif (mod(number, 3) == 0)
            currentresult = cstrcat(currentresult, ", Fizz");
        elseif (mod(number, 5) == 0)
            currentresult = cstrcat(currentresult, ", Buzz");
        else
            currentresult = cstrcat(currentresult, ", ", num2str(number));
        end
    end
    fizzbuzzv6result = currentresult;
end

sprint("# using fizzbuzz function ""fizzbuzzv1""");
sprint("FizzBuzz(36): ", fizzbuzzv1(36));
% FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

sprint("# using fizzbuzz function ""fizzbuzzv2""");
sprint("FizzBuzz(36): ", fizzbuzzv2(36));
% FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

sprint("# using fizzbuzz function ""fizzbuzzv3""");
sprint("FizzBuzz(36): ", fizzbuzzv3(36));
% FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

sprint("# using fizzbuzz function ""fizzbuzzv4""");
sprint("FizzBuzz(36): ", fizzbuzzv4(36));
% FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

sprint("# using fizzbuzz function ""fizzbuzzv5""");
sprint("FizzBuzz(36): ", fizzbuzzv5(36));
% FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

sprint("# using fizzbuzz function ""fizzbuzzv6""");
sprint("FizzBuzz(36): ", fizzbuzzv6(36));
% FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz
