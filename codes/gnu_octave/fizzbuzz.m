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
