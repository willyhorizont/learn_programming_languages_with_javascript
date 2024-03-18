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
        for entryindex = (1:1:numel(objectkeys))
            objectkey = objectkeys{entryindex};
            objectvalue = parameter.(objectkey);
            currentresult = cstrcat(currentresult, """", objectkey, """: ", stringify(objectvalue));
            if (entryindex ~= numel(objectkeys))
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

function srepeatresult = srepeat(astring, count)
    result = "";
    for i = (1:1:count)
        result = cstrcat(result, astring);
    end
    srepeatresult = result;
end

function prettyjsonstringifyresult = prettyjsonstringify(parameter)
    if ((nargin == 0) || (~iscell(parameter)) || (iscell(parameter) && isempty(parameter)))
        error("Argument should be wrapped in {}");
    end
    indent = "    ";
    if ((nargin == 2) && isstruct(parameter{2}) && isfield(parameter{2}, "indent"))
        indent = parameter{2}.indent;
    end
    anything = parameter{1};
    indentlevel = 0;
    function prettyjsonstringifyinnerresult = prettyjsonstringifyinner(anythinginner, indentinner)
        if isempty(anythinginner)
            prettyjsonstringifyinnerresult = "null";
            return;
        end
        if ischar(anythinginner)
            prettyjsonstringifyinnerresult = cstrcat("""", anythinginner, """");
            return;
        end
        if ischar(anythinginner)
            prettyjsonstringifyinnerresult = cstrcat("""", anythinginner, """");
            return;
        end
        if isnumeric(anythinginner)
            prettyjsonstringifyinnerresult = num2str(anythinginner);
            return;
        end
        if (islogical(anythinginner) && anythinginner == true)
            prettyjsonstringifyinnerresult = "true";
            return;
        end
        if (islogical(anythinginner) && anythinginner == false)
            prettyjsonstringifyinnerresult = "false";
            return;
        end
        if iscell(anythinginner)
            if isempty(anythinginner)
                prettyjsonstringifyinnerresult = "[]";
                return;
            end
            indentlevel = indentlevel + 1;
            result = cstrcat("[", sprintf("\n"), srepeat(indentinner, indentlevel));
            for arrayitemindex = (1:1:numel(anythinginner))
                arrayitem = anythinginner{arrayitemindex};
                result = cstrcat(result, prettyjsonstringifyinner(arrayitem, indentinner));
                if (arrayitemindex ~= numel(anythinginner))
                    result = cstrcat(result, ",", sprintf("\n"), srepeat(indentinner, indentlevel));
                end
            end
            indentlevel = indentlevel - 1;
            result = cstrcat(result, sprintf("\n"), srepeat(indentinner, indentlevel), "]");
            prettyjsonstringifyinnerresult = result;
            return;
        end
        if isstruct(anythinginner)
            if (numel(fieldnames(anythinginner)) == 0)
                prettyjsonstringifyinnerresult = "{}";
                return;
            end
            indentlevel = indentlevel + 1;
            result = cstrcat("{", sprintf("\n"), srepeat(indentinner, indentlevel));
            objectkeys = fieldnames(anythinginner);
            for entryindex = (1:1:numel(objectkeys))
                objectkey = objectkeys{entryindex};
                objectvalue = anythinginner.(objectkey);
                result = cstrcat(result, """", objectkey, """: ", prettyjsonstringifyinner(objectvalue, indentinner));
                if (entryindex ~= numel(objectkeys))
                    result = cstrcat(result, ",", sprintf("\n"), srepeat(indentinner, indentlevel));
                end
            end
            indentlevel = indentlevel - 1;
            result = cstrcat(result, sprintf("\n"), srepeat(indentinner, indentlevel), "}");
            prettyjsonstringifyinnerresult = result;
            return;
        end
        prettyjsonstringifyinnerresult = "null";
    end
    prettyjsonstringifyresult = prettyjsonstringifyinner(anything, indent);
end

friend = struct( ...
    "name", {"Alisa"}, ...
    "country", {"Finland"}, ...
    "age", {25} ...
);
sprint("friend: ", {prettyjsonstringify({friend})});

sprint("friend, get country: ", {friend.("country")});
% friend, get country: "Finland"

% iterate over and get each key-value pair and iteration/entry index
objectkeys = fieldnames(friend);
for entryindex = (1:1:numel(objectkeys))
    objectkey = objectkeys{entryindex};
    objectvalue = friend.(objectkey);
    sprint("friend, foreach loop, iteration/entry index: ", {entryindex}, ", key: ", {objectkey}, ", value: ", {objectvalue});
end
% friend, for loop and also foreach loop, iteration/entry index: 0, key: name, value: Alisa
% friend, for loop and also foreach loop, iteration/entry index: 1, key: country, value: Finland
% friend, for loop and also foreach loop, iteration/entry index: 2, key: age, value: 25
