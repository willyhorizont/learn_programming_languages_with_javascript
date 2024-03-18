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

function arrayfindindexv1result = arrayfindindexv1(callbackfunction, anarray)
    % JavaScript-like Array.findIndex() function
    datafoundindex = -1;
    for arrayitemindex = (1:1:numel(anarray))
        arrayitem = anarray{arrayitemindex};
        isconditionmatch = callbackfunction(arrayitem, arrayitemindex, anarray);
        if (isconditionmatch == true)
            datafoundindex = arrayitemindex;
            break;
        end
    end
    arrayfindindexv1result = datafoundindex;
end

function arrayfindindexv2result = arrayfindindexv2(callbackfunction, anarray)
    % JavaScript-like Array.findIndex() function
    datafoundindex = -1;
    for arrayitemindex = (1:1:numel(anarray))
        arrayitem = anarray{arrayitemindex};
        if (callbackfunction(arrayitem, arrayitemindex, anarray) == true)
            datafoundindex = arrayitemindex;
            break;
        end
    end
    arrayfindindexv2result = datafoundindex;
end

function arrayfindindexv3result = arrayfindindexv3(callbackfunction, anarray)
    % JavaScript-like Array.findIndex() function
    for arrayitemindex = (1:1:numel(anarray))
        arrayitem = anarray{arrayitemindex};
        isconditionmatch = callbackfunction(arrayitem, arrayitemindex, anarray);
        if (isconditionmatch == true)
            arrayfindindexv3result = arrayitemindex;
            return;
        end
    end
    arrayfindindexv3result = -1;
end

function arrayfindindexv4result = arrayfindindexv4(callbackfunction, anarray)
    % JavaScript-like Array.findIndex() function
    for arrayitemindex = (1:1:numel(anarray))
        arrayitem = anarray{arrayitemindex};
        if (callbackfunction(arrayitem, arrayitemindex, anarray) == true)
            arrayfindindexv4result = arrayitemindex;
            return;
        end
    end
    arrayfindindexv4result = -1;
end

sprint(sprintf("\n"), "% JavaScript-like Array.findIndex() in Matlab Cell Array");

numbers = {12, 34, 27, 23, 65, 93, 36, 87, 4, 254};
sprint("numbers: ", {numbers});

numbertofind = 27;
sprint("number to find: ", {numbertofind});

sprint("% using JavaScript-like Array.findIndex() function ""arrayfindindexv1""");

numberfoundindex = arrayfindindexv1(@(number, varargin) (number == numbertofind), numbers);
sprint("number found index: ", {numberfoundindex});
% number found index: 3

sprint("% using JavaScript-like Array.findIndex() function ""arrayfindindexv2""");

numberfoundindex = arrayfindindexv2(@(number, varargin) (number == numbertofind), numbers);
sprint("number found index: ", {numberfoundindex});
% number found index: 3

sprint("% using JavaScript-like Array.findIndex() function ""arrayfindindexv3""");

numberfoundindex = arrayfindindexv3(@(number, varargin) (number == numbertofind), numbers);
sprint("number found index: ", {numberfoundindex});
% number found index: 3

sprint("% using JavaScript-like Array.findIndex() function ""arrayfindindexv4""");

numberfoundindex = arrayfindindexv4(@(number, varargin) (number == numbertofind), numbers);
sprint("number found index: ", {numberfoundindex});
% number found index: 3

sprint("% using Matlab Array.findIndex() built-in function ""find"" and ""cellfun""");

numberfoundindex = find(cellfun(@(number) (number == numbertofind), numbers), 1);
sprint("number found index: ", {numberfoundindex});
% number found index: 3

sprint(sprintf("\n"), "% JavaScript-like Array.findIndex() in Matlab Cell Array of Structs");

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

sprint("% using JavaScript-like Array.findIndex() function ""arrayfindindexv1""");

producttofind = "pasta";
sprint("product to find: ", {producttofind});

productfoundindex = arrayfindindexv1(@(product, varargin) strcmp(product.("code"), producttofind), products);
sprint("product found index: ", {productfoundindex});
% product found index: 1

sprint("% using JavaScript-like Array.findIndex() function ""arrayfindindexv2""");

productfoundindex = arrayfindindexv2(@(product, varargin) strcmp(product.("code"), producttofind), products);
sprint("product found index: ", {productfoundindex});
% product found index: 1

sprint("% using JavaScript-like Array.findIndex() function ""arrayfindindexv3""");

productfoundindex = arrayfindindexv3(@(product, varargin) strcmp(product.("code"), producttofind), products);
sprint("product found index: ", {productfoundindex});
% product found index: 1

sprint("% using JavaScript-like Array.findIndex() function ""arrayfindindexv4""");

productfoundindex = arrayfindindexv4(@(product, varargin) strcmp(product.("code"), producttofind), products);
sprint("product found index: ", {productfoundindex});
% product found index: 1

sprint("% using Matlab Array.findIndex() built-in function ""find"" and ""cellfun""");

productfoundindex = find(cellfun(@(product) strcmp(product.("code"), producttofind), products), 1);
sprint("product found index: ", {productfoundindex});
% product found index: 1
