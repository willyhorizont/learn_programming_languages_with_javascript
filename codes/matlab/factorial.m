function stringifyresult = stringify(parameter)
    if isempty(parameter)
        stringifyresult = "null";
        return;
    end
    if isstring(parameter)
        stringifyresult = strcat("""", parameter, """");
        return;
    end
    if ischar(parameter)
        stringifyresult = strcat("""", parameter, """");
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
            currentresult = strcat(currentresult, stringify(arrayitem));
            if (arrayitemindex ~= numel(parameter))
                currentresult = strcat(currentresult, ", ");
            end
        end
        stringifyresult = strcat(currentresult, "]");
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
            currentresult = strcat(currentresult, """", objectkey, """: ", stringify(objectvalue));
            if (objectentryindex ~= numel(objectkeys))
                currentresult = strcat(currentresult, ",");
            end
        end
        stringifyresult = strcat(currentresult, "}");
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
            currentresult = strcat(currentresult, parameternew);
            continue;
        end
        currentresult = strcat(currentresult, parameter);
    end
    disp(currentresult);
end

sprint(sprintf("\n"), "% Factorial(n) in Matlab");

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
