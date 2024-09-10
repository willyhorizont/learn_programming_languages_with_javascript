function stringrepeatresult = stringrepeat(astring, count)
    result = "";
    for i = (1:1:count) % (start:step:stop)
        result = strcat(result, astring);
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
        if ((isempty(currentresult) && isstruct(anything) && (isstring(currentitem) || ischar(currentitem))) && isfield(anything, currentitem))
            arrayreducecallbackresult = anything.(currentitem);
            return;
        end
        if (isempty(currentresult) && iscell(anything) && isnumeric(currentitem) && (currentitem >= 1) && (numel(anything) > currentitem))
            arrayreducecallbackresult = anything{currentitem};
            return;
        end
        if ((isstruct(currentresult) && (isstring(currentitem) || ischar(currentitem))) && isfield(currentresult, currentitem))
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
        if (isstring(anythinginner) || ischar(anythinginner))
            jsonstringifyinnerresult = strcat("""", anythinginner, """");
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
            result = ternary((pretty == true), @() (strcat("[", sprintf("\n"), stringrepeat(indentinner, indentlevel))), @() ("["));
            for arrayitemindex = (1:1:numel(anythinginner)) % (start:step:stop)
                arrayitem = anythinginner{arrayitemindex};
                result = strcat(result, jsonstringifyinner(arrayitem, prettyinner, indentinner));
                if (arrayitemindex ~= numel(anythinginner))
                    result = ternary((pretty == true), @() (strcat(result, ",", sprintf("\n"), stringrepeat(indentinner, indentlevel))), @() (strcat(result, ", ")));
                end
            end
            indentlevel = indentlevel - 1;
            result = ternary((pretty == true), @() (strcat(result, sprintf("\n"), stringrepeat(indentinner, indentlevel), "]")), @() (strcat(result, "]")));
            jsonstringifyinnerresult = result;
            return;
        end
        if isstruct(anythinginner)
            if (numel(fieldnames(anythinginner)) == 0)
                jsonstringifyinnerresult = "{}";
                return;
            end
            indentlevel = indentlevel + 1;
            result = ternary((pretty == true), @() (strcat("{", sprintf("\n"), stringrepeat(indentinner, indentlevel))), @() ("{"));
            objectkeys = fieldnames(anythinginner);
            for objectentryindex = (1:1:numel(objectkeys)) % (start:step:stop)
                objectkey = objectkeys{objectentryindex};
                objectvalue = anythinginner.(objectkey);
                result = strcat(result, """", objectkey, """: ", jsonstringifyinner(objectvalue, prettyinner, indentinner));
                if (objectentryindex ~= numel(objectkeys))
                    result = ternary((pretty == true), @() (strcat(result, ",", sprintf("\n"), stringrepeat(indentinner, indentlevel))), @() (strcat(result, ", ")));
                end
            end
            indentlevel = indentlevel - 1;
            result = ternary((pretty == true), @() (strcat(result, sprintf("\n"), stringrepeat(indentinner, indentlevel), "}")), @() (strcat(result, "}")));
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
    additionalparameter = varargin{1};
    if isstruct(additionalparameter)
        pretty = optionalchaining(additionalparameter, "pretty");
        indent = optionalchaining(additionalparameter, "indent");
        pretty = ternary(isempty(pretty), @() (prettydefault), @() (pretty));
        indent = ternary(isempty(indent), @() (indentdefault), @() (indent));
        jsonstringifyresult = jsonstringifyinner(anything, pretty, indent);
        return;
    end
    if (islogical(additionalparameter) && (additionalparameter == true))
        if (numel(varargin) >= 2)
            additionalparameter2 = varargin{2};
            if (isstring(additionalparameter2) || ischar(additionalparameter2))
                indent = additionalparameter2
            end
        end
        pretty = true;
        jsonstringifyresult = jsonstringifyinner(anything, pretty, indent);
        return;
    end
    if (islogical(additionalparameter) && (additionalparameter == false))
        pretty = false;
        jsonstringifyresult = jsonstringifyinner(anything, prettydefault, indentdefault);
        return;
    end
    jsonstringifyresult = jsonstringifyinner(anything, prettydefault, indentdefault);
end

function sprint(varargin)
    currentresult = "";
    for parameterindex = (1:1:numel(varargin)) % (start:step:stop)
        parameter = varargin{parameterindex};
        if (iscell(parameter) && (numel(parameter) == 1))
            parameternew = jsonstringify(parameter{1});
            parameternew = strrep(parameternew, """{", "{");
            parameternew = strrep(parameternew, """[", "[");
            parameternew = strrep(parameternew, "}""", "}");
            parameternew = strrep(parameternew, "]""", "]");
            currentresult = strcat(currentresult, parameternew);
            continue;
        end
        if (~isstring(parameter) && ~ischar(parameter))
            error("Non string argument must be wrapped in {}");
            continue;
        end
        currentresult = strcat(currentresult, parameter);
    end
    disp(currentresult);
end

sprint(sprintf("\n"), "% FizzBuzz(n) in Matlab");

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
            currentresult = strcat(currentresult, ", FizzBuzz");
            if (number >= stopnumber)
                break;
            end
            number = (number + 1);
            continue;
        end
        if (mod(number, 3) == 0)
            currentresult = strcat(currentresult, ", Fizz");
            if (number >= stopnumber)
                break;
            end
            number = (number + 1);
            continue;
        end
        if (mod(number, 5) == 0)
            currentresult = strcat(currentresult, ", Buzz");
            if (number >= stopnumber)
                break;
            end
            number = (number + 1);
            continue;
        end
        currentresult = strcat(currentresult, ", ", num2str(number));
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
            currentresult = strcat(currentresult, ", FizzBuzz");
            number = (number + 1);
            continue;
        end
        if (mod(number, 3) == 0)
            currentresult = strcat(currentresult, ", Fizz");
            number = (number + 1);
            continue;
        end
        if (mod(number, 5) == 0)
            currentresult = strcat(currentresult, ", Buzz");
            number = (number + 1);
            continue;
        end
        currentresult = strcat(currentresult, ", ", num2str(number));
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
            currentresult = strcat(currentresult, ", FizzBuzz");
        elseif (mod(number, 3) == 0)
            currentresult = strcat(currentresult, ", Fizz");
        elseif (mod(number, 5) == 0)
            currentresult = strcat(currentresult, ", Buzz");
        else
            currentresult = strcat(currentresult, ", ", num2str(number));
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
            currentresult = strcat(currentresult, ", FizzBuzz");
        elseif (mod(number, 3) == 0)
            currentresult = strcat(currentresult, ", Fizz");
        elseif (mod(number, 5) == 0)
            currentresult = strcat(currentresult, ", Buzz");
        else
            currentresult = strcat(currentresult, ", ", num2str(number));
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
            currentresult = strcat(currentresult, ", FizzBuzz");
            continue;
        end
        if (mod(number, 3) == 0)
            currentresult = strcat(currentresult, ", Fizz");
            continue;
        end
        if (mod(number, 5) == 0)
            currentresult = strcat(currentresult, ", Buzz");
            continue;
        end
        currentresult = strcat(currentresult, ", ", num2str(number));
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
            currentresult = strcat(currentresult, ", FizzBuzz");
        elseif (mod(number, 3) == 0)
            currentresult = strcat(currentresult, ", Fizz");
        elseif (mod(number, 5) == 0)
            currentresult = strcat(currentresult, ", Buzz");
        else
            currentresult = strcat(currentresult, ", ", num2str(number));
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
