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

% Array

fruits = {"apple", "mango", "orange"};
sprint("fruits: ", {fruits});

sprint("fruits, length: ", {length(fruits)});
% fruits, length: 3

sprint("fruits, length: ", {numel(fruits)});
% fruits, length: 3

sprint("fruits, get mango: ", {fruits{2}});
% fruits, get mango: "mango"

sprint("fruits, first element: ", {fruits{1}});
% fruits, first element: "apple"

sprint("fruits, last element: ", {fruits{end}});
% fruits, last element: "orange"

for arrayitemindex = (1:1:numel(fruits))
    arrayitem = fruits{arrayitemindex};
    sprint("fruits, foreach loop, index: ", {arrayitemindex}, ", value: ", {arrayitem});
end
% fruits, foreach loop, index: 0, value: "apple"
% fruits, foreach loop, index: 1, value: "mango"
% fruits, foreach loop, index: 2, value: "orange"

% Array of Objects

products = { ...
    struct( ...
        "id", {"P1"}, ...
        "name", {"bubble gum"} ...
    ), ...
    struct( ...
        "id", {"P2"}, ...
        "name", {"potato chips"} ...
    ) ...
};
sprint("products: ", {prettyjsonstringify({products})});

for arrayitemindex = (1:1:numel(products))
    arrayitem = products{arrayitemindex};
    objectkeys = fieldnames(arrayitem);
    for entryindex = (1:1:numel(objectkeys))
        objectkey = objectkeys{entryindex};
        objectvalue = arrayitem.(objectkey);
        sprint("products, foreach loop, array item index: ", {arrayitemindex}, ", iteration/entry index: ", {entryindex}, ", key: ", {objectkey}, ", value: ", {objectvalue});
    end
end
% products, foreach loop, array item index: 0, iteration/entry index: 0, key: "id", value: "P1"
% products, foreach loop, array item index: 0, iteration/entry index: 1, key: "name", value: "bubble gum"
% products, foreach loop, array item index: 1, iteration/entry index: 0, key: "id", value: "P2"
% products, foreach loop, array item index: 1, iteration/entry index: 1, key: "name", value: "potato chips"
