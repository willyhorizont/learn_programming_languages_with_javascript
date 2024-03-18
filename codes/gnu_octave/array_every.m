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

function arrayeveryv1result = arrayeveryv1(callbackfunction, anarray)
    % JavaScript-like Array.every() function
    isconditionmatch = false;
    for arrayitemindex = (1:1:numel(anarray))
        arrayitem = anarray{arrayitemindex};
        isconditionmatch = callbackfunction(arrayitem, arrayitemindex, anarray);
        if (isconditionmatch == false)
            break;
        end
    end
    arrayeveryv1result = isconditionmatch;
end

function arrayeveryv2result = arrayeveryv2(callbackfunction, anarray)
    % JavaScript-like Array.every() function
    isconditionmatch = false;
    for arrayitemindex = (1:1:numel(anarray))
        arrayitem = anarray{arrayitemindex};
        isconditionmatch = callbackfunction(arrayitem, arrayitemindex, anarray);
        if (isconditionmatch == false)
            arrayeveryv2result = isconditionmatch;
            return;
        end
    end
    arrayeveryv2result = isconditionmatch;
end

function arrayeveryv3result = arrayeveryv3(callbackfunction, anarray)
    % JavaScript-like Array.every() function
    for arrayitemindex = (1:1:numel(anarray))
        arrayitem = anarray{arrayitemindex};
        isconditionmatch = callbackfunction(arrayitem, arrayitemindex, anarray);
        if (isconditionmatch == false)
            arrayeveryv3result = false;
            return;
        end
    end
    arrayeveryv3result = true;
end

function arrayeveryv4result = arrayeveryv4(callbackfunction, anarray)
    % JavaScript-like Array.every() function
    for arrayitemindex = (1:1:numel(anarray))
        arrayitem = anarray{arrayitemindex};
        if (callbackfunction(arrayitem, arrayitemindex, anarray) == false)
            arrayeveryv4result = false;
            return;
        end
    end
    arrayeveryv4result = true;
end

sprint(sprintf("\n"), "% JavaScript-like Array.every() in GNU Octave Cell Array");

numbers = {12, 34, 27, 23, 65, 93, 36, 87, 4, 254};
sprint("numbers: ", {numbers});

sprint("% using JavaScript-like Array.every() function ""arrayeveryv1""");

isallnumberlessthan500 = arrayeveryv1(@(number, varargin) (number < 500), numbers);
sprint("is all number < 500: ", {isallnumberlessthan500});
% is all number < 500: true

isallnumbermorethan500 = arrayeveryv1(@(number, varargin) (number > 500), numbers);
sprint("is all number > 500: ", {isallnumbermorethan500});
% is all number > 500: false

sprint("% using JavaScript-like Array.every() function ""arrayeveryv2""");

isallnumberlessthan500 = arrayeveryv2(@(number, varargin) (number < 500), numbers);
sprint("is all number < 500: ", {isallnumberlessthan500});
% is all number < 500: true

isallnumbermorethan500 = arrayeveryv2(@(number, varargin) (number > 500), numbers);
sprint("is all number > 500: ", {isallnumbermorethan500});
% is all number > 500: false

sprint("% using JavaScript-like Array.every() function ""arrayeveryv3""");

isallnumberlessthan500 = arrayeveryv3(@(number, varargin) (number < 500), numbers);
sprint("is all number < 500: ", {isallnumberlessthan500});
% is all number < 500: true

isallnumbermorethan500 = arrayeveryv3(@(number, varargin) (number > 500), numbers);
sprint("is all number > 500: ", {isallnumbermorethan500});
% is all number > 500: false

sprint("% using JavaScript-like Array.every() function ""arrayeveryv4""");

isallnumberlessthan500 = arrayeveryv4(@(number, varargin) (number < 500), numbers);
sprint("is all number < 500: ", {isallnumberlessthan500});
% is all number < 500: true

isallnumbermorethan500 = arrayeveryv4(@(number, varargin) (number > 500), numbers);
sprint("is all number > 500: ", {isallnumbermorethan500});
% is all number > 500: false

sprint("% using GNU Octave Array.every() built-in function ""all"" and ""cellfun""");

isallnumberlessthan500 = all(cellfun(@(number) (number < 500), numbers));
sprint("is all number < 500: ", {isallnumberlessthan500});
% is all number < 500: true

isallnumbermorethan500 = all(cellfun(@(number) (number > 500), numbers));
sprint("is all number > 500: ", {isallnumbermorethan500});
% is all number > 500: false

sprint(sprintf("\n"), "% JavaScript-like Array.every() in GNU Octave Cell Array of Structs");

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

sprint("% using JavaScript-like Array.every() function ""arrayeveryv1""");

isallproductpricelessthan500 = arrayeveryv1(@(product, varargin) (product.("price") < 500), products);
sprint("is all product price < 500: ", {isallproductpricelessthan500});
% is all product price < 500: true

isallproductpricemorethan500 = arrayeveryv1(@(product, varargin) (product.("price") > 500), products);
sprint("is all product price > 500: ", {isallproductpricemorethan500});
% is all product price > 500: false

sprint("% using JavaScript-like Array.every() function ""arrayeveryv2""");

isallproductpricelessthan500 = arrayeveryv2(@(product, varargin) (product.("price") < 500), products);
sprint("is all product price < 500: ", {isallproductpricelessthan500});
% is all product price < 500: true

isallproductpricemorethan500 = arrayeveryv2(@(product, varargin) (product.("price") > 500), products);
sprint("is all product price > 500: ", {isallproductpricemorethan500});
% is all product price > 500: false

sprint("% using JavaScript-like Array.every() function ""arrayeveryv3""");

isallproductpricelessthan500 = arrayeveryv3(@(product, varargin) (product.("price") < 500), products);
sprint("is all product price < 500: ", {isallproductpricelessthan500});
% is all product price < 500: true

isallproductpricemorethan500 = arrayeveryv3(@(product, varargin) (product.("price") > 500), products);
sprint("is all product price > 500: ", {isallproductpricemorethan500});
% is all product price > 500: false

sprint("% using JavaScript-like Array.every() function ""arrayeveryv4""");

isallproductpricelessthan500 = arrayeveryv4(@(product, varargin) (product.("price") < 500), products);
sprint("is all product price < 500: ", {isallproductpricelessthan500});
% is all product price < 500: true

isallproductpricemorethan500 = arrayeveryv4(@(product, varargin) (product.("price") > 500), products);
sprint("is all product price > 500: ", {isallproductpricemorethan500});
% is all product price > 500: false

sprint("% using GNU Octave Array.every() built-in function ""all"" and ""cellfun""");

isallproductpricelessthan500 = all(cellfun(@(product) (product.("price") < 500), products));
sprint("is all product price < 500: ", {isallproductpricelessthan500});
% is all product price < 500: true

isallproductpricemorethan500 = all(cellfun(@(product) (product.("price") > 500), products));
sprint("is all product price > 500: ", {isallproductpricemorethan500});
% is all product price > 500: false
