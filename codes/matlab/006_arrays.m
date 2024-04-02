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

function srepeatresult = srepeat(astring, count)
    result = "";
    for i = (1:1:count)
        result = strcat(result, astring);
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
        if isstring(anythinginner)
            prettyjsonstringifyinnerresult = strcat("""", anythinginner, """");
            return;
        end
        if ischar(anythinginner)
            prettyjsonstringifyinnerresult = strcat("""", anythinginner, """");
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
            result = strcat("[", sprintf("\n"), srepeat(indentinner, indentlevel));
            for arrayitemindex = (1:1:numel(anythinginner))
                arrayitem = anythinginner{arrayitemindex};
                result = strcat(result, prettyjsonstringifyinner(arrayitem, indentinner));
                if (arrayitemindex ~= numel(anythinginner))
                    result = strcat(result, ",", sprintf("\n"), srepeat(indentinner, indentlevel));
                end
            end
            indentlevel = indentlevel - 1;
            result = strcat(result, sprintf("\n"), srepeat(indentinner, indentlevel), "]");
            prettyjsonstringifyinnerresult = result;
            return;
        end
        if isstruct(anythinginner)
            if (numel(fieldnames(anythinginner)) == 0)
                prettyjsonstringifyinnerresult = "{}";
                return;
            end
            indentlevel = indentlevel + 1;
            result = strcat("{", sprintf("\n"), srepeat(indentinner, indentlevel));
            objectkeys = fieldnames(anythinginner);
            for objectentryindex = (1:1:numel(objectkeys))
                objectkey = objectkeys{objectentryindex};
                objectvalue = anythinginner.(objectkey);
                result = strcat(result, """", objectkey, """: ", prettyjsonstringifyinner(objectvalue, indentinner));
                if (objectentryindex ~= numel(objectkeys))
                    result = strcat(result, ",", sprintf("\n"), srepeat(indentinner, indentlevel));
                end
            end
            indentlevel = indentlevel - 1;
            result = strcat(result, sprintf("\n"), srepeat(indentinner, indentlevel), "}");
            prettyjsonstringifyinnerresult = result;
            return;
        end
        prettyjsonstringifyinnerresult = "null";
    end
    prettyjsonstringifyresult = prettyjsonstringifyinner(anything, indent);
end

% in Matlab, JavaScript-like Array is called Cell-Array

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
    sprint("fruits, forEach loop, index: ", {arrayitemindex}, ", value: ", {arrayitem});
end
% fruits, forEach loop, index: 0, value: "apple"
% fruits, forEach loop, index: 1, value: "mango"
% fruits, forEach loop, index: 2, value: "orange"

% in Matlab, JavaScript-like Array of Objects is called Cell-Array of structs

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
    for objectentryindex = (1:1:numel(objectkeys))
        objectkey = objectkeys{objectentryindex};
        objectvalue = arrayitem.(objectkey);
        sprint("products, forEach loop, array item index: ", {arrayitemindex}, ", object iteration/entry index: ", {objectentryindex}, ", key: ", {objectkey}, ", value: ", {objectvalue});
    end
end
% products, forEach loop, array item index: 0, object iteration/entry index: 0, key: "id", value: "P1"
% products, forEach loop, array item index: 0, object iteration/entry index: 1, key: "name", value: "bubble gum"
% products, forEach loop, array item index: 1, object iteration/entry index: 0, key: "id", value: "P2"
% products, forEach loop, array item index: 1, object iteration/entry index: 1, key: "name", value: "potato chips"
