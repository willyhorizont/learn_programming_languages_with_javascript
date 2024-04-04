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

function ternaryresult = ternary(truecondition, valueifconditionistrue, valueifconditionisfalse)
    if (islogical(truecondition) && (truecondition == true))
        ternaryresult = valueifconditionistrue;
        return;
    end
    ternaryresult = valueifconditionisfalse;
end

function jsonstringifyresult = jsonstringify(anything, additionalparameter)
    indentlevel = 0;
    function jsonstringifyinnerresult = jsonstringifyinner(anythinginner, prettyinner, indentinner)
        if isempty(anythinginner)
            jsonstringifyinnerresult = "null";
            return;
        end
        if ischar(anythinginner)
            jsonstringifyinnerresult = cstrcat("""", anythinginner, """");
            return;
        end
        if ischar(anythinginner)
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
            result = ternary((pretty == true), cstrcat("[", sprintf("\n"), stringrepeat(indentinner, indentlevel)), "[");
            for arrayitemindex = (1:1:numel(anythinginner)) % (start:step:stop)
                arrayitem = anythinginner{arrayitemindex};
                result = cstrcat(result, jsonstringifyinner(arrayitem, prettyinner, indentinner));
                if (arrayitemindex ~= numel(anythinginner))
                    result = ternary((pretty == true), cstrcat(result, ",", sprintf("\n"), stringrepeat(indentinner, indentlevel)), cstrcat(result, ", "));
                end
            end
            indentlevel = indentlevel - 1;
            result = ternary((pretty == true), cstrcat(result, sprintf("\n"), stringrepeat(indentinner, indentlevel), "]"), cstrcat(result, "]"));
            jsonstringifyinnerresult = result;
            return;
        end
        if isstruct(anythinginner)
            if (numel(fieldnames(anythinginner)) == 0)
                jsonstringifyinnerresult = "{}";
                return;
            end
            indentlevel = indentlevel + 1;
            result = ternary((pretty == true), cstrcat("{", sprintf("\n"), stringrepeat(indentinner, indentlevel)), "{");
            objectkeys = fieldnames(anythinginner);
            for objectentryindex = (1:1:numel(objectkeys)) % (start:step:stop)
                objectkey = objectkeys{objectentryindex};
                objectvalue = anythinginner.(objectkey);
                result = cstrcat(result, """", objectkey, """: ", jsonstringifyinner(objectvalue, prettyinner, indentinner));
                if (objectentryindex ~= numel(objectkeys))
                    result = ternary((pretty == true), cstrcat(result, ",", sprintf("\n"), stringrepeat(indentinner, indentlevel)), cstrcat(result, ", "));
                end
            end
            indentlevel = indentlevel - 1;
            result = ternary((pretty == true), cstrcat(result, sprintf("\n"), stringrepeat(indentinner, indentlevel), "}"), cstrcat(result, "}"));
            jsonstringifyinnerresult = result;
            return;
        end
        jsonstringifyinnerresult = "null";
    end
    pretty = false;
    indent = "    ";
    if isempty(additionalparameter)
        jsonstringifyresult = jsonstringifyinner(anything, true, indent);
        return;
    end
    if isstruct(additionalparameter)
        pretty = optionalchaining(additionalparameter, "pretty");
        indent = optionalchaining(additionalparameter, "indent");
        pretty = ternary(isempty(pretty), false, pretty);
        indent = ternary(isempty(indent), "    ", indent);
        jsonstringifyresult = jsonstringifyinner(anything, pretty, indent);
        return;
    end
    if (islogical(additionalparameter) && (additionalparameter == true))
        pretty = true;
        jsonstringifyresult = jsonstringifyinner(anything, pretty, indent);
        return;
    end
    if (islogical(additionalparameter) && (additionalparameter == false))
        pretty = false;
        jsonstringifyresult = jsonstringifyinner(anything, pretty, indent);
        return;
    end
    jsonstringifyresult = jsonstringifyinner(anything, false, indent);
end

function sprint(varargin)
    currentresult = "";
    for parameterindex = (1:1:numel(varargin)) % (start:step:stop)
        parameter = varargin{parameterindex};
        if (iscell(parameter) && (numel(parameter) == 1))
            parameternew = jsonstringify(parameter{1}, false);
            parameternew = strrep(parameternew, """{", "{");
            parameternew = strrep(parameternew, """[", "[");
            parameternew = strrep(parameternew, "}""", "}");
            parameternew = strrep(parameternew, "]""", "]");
            currentresult = cstrcat(currentresult, parameternew);
            continue;
        end
        if (~ischar(parameter) && ~ischar(parameter))
            error("Non string argument must be wrapped in {}");
            continue;
        end
        currentresult = cstrcat(currentresult, parameter);
    end
    disp(currentresult);
end

sprint(sprintf("\n"), "% Factorial(n) in GNU Octave");

function factorialv1result = factorialv1(number)
    if ~isnumeric(number)
        error("Argument should be a number");
    end
    if (number < 0)
        error("Argument should be >= 0");
    end
    if (number == 0)
        factorialv1result = 1;
        return;
    end
    currentresult = 1;
    i = number;
    while (true)
        currentresult = currentresult * i;
        if (i <= 1)
            break;
        end
        i = (i - 1);
    end
    factorialv1result = currentresult;
end

function factorialv2result = factorialv2(number)
    if ~isnumeric(number)
        error("Argument should be a number");
    end
    if (number < 0)
        error("Argument should be >= 0");
    end
    if (number == 0)
        factorialv2result = 1;
        return;
    end
    currentresult = 1;
    i = number;
    while (i >= 1)
        currentresult = currentresult * i;
        i = (i - 1);
    end
    factorialv2result = currentresult;
end

function factorialv3result = factorialv3(number)
    if ~isnumeric(number)
        error("Argument should be a number");
    end
    if (number < 0)
        error("Argument should be >= 0");
    end
    if (number == 0)
        factorialv3result = 1;
        return;
    end
    currentresult = 1;
    for i = (number:-1:1) % (start:step:stop)
        currentresult = currentresult * i;
    end
    factorialv3result = currentresult;
end

function factorialv4result = factorialv4(number)
    if ~isnumeric(number)
        error("Argument should be a number");
    end
    if (number < 0)
        error("Argument should be >= 0");
    end
    if (number == 0)
        factorialv4result = 1;
        return;
    end
    factorialv4result = (number * factorialv4(number - 1));
end

sprint("# using factorial function ""factorialv1""");
sprint("Factorial(5): ", {factorialv1(5)});
% Factorial(5): 120

sprint("# using factorial function ""factorialv2""");
sprint("Factorial(5): ", {factorialv2(5)});
% Factorial(5): 120

sprint("# using factorial function ""factorialv3""");
sprint("Factorial(5): ", {factorialv3(5)});
% Factorial(5): 120

sprint("# using factorial function ""factorialv4""");
sprint("Factorial(5): ", {factorialv4(5)});
% Factorial(5): 120
