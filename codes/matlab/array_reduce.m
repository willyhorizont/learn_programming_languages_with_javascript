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
        for entryindex = (1:1:numel(objectkeys))
            objectkey = objectkeys{entryindex};
            objectvalue = parameter.(objectkey);
            currentresult = strcat(currentresult, """", objectkey, """: ", stringify(objectvalue));
            if (entryindex ~= numel(objectkeys))
                currentresult = strcat(currentresult, ",");
            end
        end
        stringifyresult = strcat(currentresult, "}");
        return;
    end
    stringifyresult = "null";
end

function sjoinresult = sjoin(varargin)
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
    sjoinresult = currentresult;
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
            for entryindex = (1:1:numel(objectkeys))
                objectkey = objectkeys{entryindex};
                objectvalue = anythinginner.(objectkey);
                result = strcat(result, """", objectkey, """: ", prettyjsonstringifyinner(objectvalue, indentinner));
                if (entryindex ~= numel(objectkeys))
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

function objectresult = object(varargin)
    newobject = struct();
    if (mod(numel(varargin), 2) ~= 0)
        error("Argument should be even");
    end
    for parameterindex = (1:1:numel(varargin))
        parameter = varargin{parameterindex};
        if (mod(parameterindex, 2) ~= 0)
            if isnumeric(parameter)
                continue;
            end
            if (~isstring(parameter) && ~ischar(parameter))
                error("Even argument should be a string");
            end
            continue;
        end
        objectkey = varargin{parameterindex - 1};
        if isnumeric(objectkey)
            objectkey = strrep(num2str(objectkey), ".", "point");
            objectkey = strrep(objectkey, "-", "negative");
            newobject.(strcat("number", objectkey)) = parameter;
            continue;
        end
        if isempty(regexp(objectkey, "^[a-zA-Z][a-zA-Z0-9_]*$", "once"))
            error("Error: Object Key must begin with a letter, Object key can only contain letters, digits, and underscores.");
        end
        try
            newobject.(objectkey) = parameter;
        catch exception
            error(strcat("Error: Object Key might be a reserved word or function name in Matlab. More Detail: ", exception.message));
        end
    end
    objectresult = newobject;
end

function spreadsyntaxobjectresult = spreadsyntaxobject(varargin)
    newobject = struct();
    for parameterindex = (1:1:numel(varargin))
        parameter = varargin{parameterindex};
        if isstruct(parameter)
            objectkeys = fieldnames(parameter);
            for entryindex = (1:1:numel(objectkeys))
                objectkey = objectkeys{entryindex};
                objectvalue = parameter.(objectkey);
                newobject.(objectkey) = objectvalue;
            end
            continue;
        end
        if iscell(parameter)
            for arrayitemindex = (1:1:numel(parameter))
                arrayitem = parameter{arrayitemindex};
                newobject.(strcat("index", num2str(arrayitemindex))) = arrayitem;
            end
            continue;
        end
    end
    spreadsyntaxobjectresult = newobject;
end

function spreadsyntaxarrayresult = spreadsyntaxarray(varargin)
    newarray = {};
    for parameterindex = (1:1:numel(varargin))
        parameter = varargin{parameterindex};
        if isstruct(parameter)
            objectkeys = fieldnames(parameter);
            if (numel(objectkeys) == 1)
                for entryindex = (1:1:numel(objectkeys))
                    objectkey = objectkeys{entryindex};
                    objectvalue = parameter.(objectkey);
                    newarray{end + 1} = objectvalue;
                end
                continue;
            end
            newarray{end + 1} = parameter;
            continue;
        end
        if iscell(parameter)
            for arrayitemindex = (1:1:numel(parameter))
                arrayitem = parameter{arrayitemindex};
                newarray{end + 1} = arrayitem;
            end
            continue;
        end
    end
    spreadsyntaxarrayresult = newarray;
end

function ternaryresult = ternary(truecondition, valueifconditionistrue, valueifconditionisfalse)
    if (islogical(truecondition) && truecondition == true)
        ternaryresult = valueifconditionistrue;
        return;
    end
    ternaryresult = valueifconditionisfalse;
end

% There's no JavaScript-like Array.reduce() in Matlab.
% But, we can create our own function to mimic it in Matlab.

function arrayreduceresult = arrayreduce(callbackfunction, anarray, initialvalue)
    % JavaScript-like Array.reduce() function
    currentresult = initialvalue;
    for arrayitemindex = (1:1:numel(anarray))
        arrayitem = anarray{arrayitemindex};
        currentresult = callbackfunction(currentresult, arrayitem, arrayitemindex, anarray);
    end
    arrayreduceresult = currentresult;
end

sprint(sprintf("\n"), "% JavaScript-like Array.reduce() in Matlab Cell-Array");

numbers = {36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3};
sprint("numbers: ", {numbers});

sprint("% using JavaScript-like Array.reduce() function ""arrayreduce""");

numberstotal = arrayreduce(@(currentresult, currentnumber, varargin) (currentresult + currentnumber), numbers, 0);
sprint("total number: ", {numberstotal});
% total number: 41.2

sprint(sprintf("\n"), "% JavaScript-like Array.reduce() in Matlab Cell-Array of structs");

products = { ...
    struct( ...
        "code", "pasta", ...
        "price", 321 ...
    ), ...
    struct( ...
        "code", "bubble_gum", ...
        "price", 233 ...
    ), ...
    struct( ...
        "code", "potato_chips", ...
        "price", 5 ...
    ), ...
    struct( ...
        "code", "towel", ...
        "price", 499 ...
    ) ...
};
sprint("products: ", prettyjsonstringify({products}));

sprint("% using JavaScript-like Array.reduce() function ""arrayreduce""");

productsgrouped = arrayreduce(@(currentresult, currentproduct, varargin) ternary((currentproduct.("price") > 100), spreadsyntaxobject(currentresult, object("expensive", spreadsyntaxarray(currentresult.("expensive"), object("currentproduct", currentproduct)))), spreadsyntaxobject(currentresult, object("cheap", spreadsyntaxarray(currentresult.("cheap"), object("currentproduct", currentproduct))))), products, object("expensive", {}, "cheap", {}));
sprint("grouped products: ", {prettyjsonstringify({productsgrouped})});
% grouped products: {
%     "expensive": [
%         {
%             "code": "pasta",
%             "price": 321
%         },
%         {
%             "code": "bubble_gum",
%             "price": 233
%         },
%         {
%             "code": "towel",
%             "price": 499
%         }
%     ],
%     "cheap": [
%         {
%             "code": "potato_chips",
%             "price": 5
%         }
%     ]
% }
