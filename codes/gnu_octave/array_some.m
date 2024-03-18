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

function arraysomev1result = arraysomev1(callbackfunction, anarray)
    % JavaScript-like Array.some() function
    isconditionmatch = false;
    for arrayitemindex = (1:1:numel(anarray))
        arrayitem = anarray{arrayitemindex};
        isconditionmatch = callbackfunction(arrayitem, arrayitemindex, anarray);
        if (isconditionmatch == true)
            break;
        end
    end
    arraysomev1result = isconditionmatch;
end

function arraysomev2result = arraysomev2(callbackfunction, anarray)
    % JavaScript-like Array.some() function
    isconditionmatch = false;
    for arrayitemindex = (1:1:numel(anarray))
        arrayitem = anarray{arrayitemindex};
        isconditionmatch = callbackfunction(arrayitem, arrayitemindex, anarray);
        if (isconditionmatch == true)
            arraysomev2result = isconditionmatch;
            return;
        end
    end
    arraysomev2result = isconditionmatch;
end

function arraysomev3result = arraysomev3(callbackfunction, anarray)
    % JavaScript-like Array.some() function
    for arrayitemindex = (1:1:numel(anarray))
        arrayitem = anarray{arrayitemindex};
        isconditionmatch = callbackfunction(arrayitem, arrayitemindex, anarray);
        if (isconditionmatch == true)
            arraysomev3result = true;
            return;
        end
    end
    arraysomev3result = false;
end

function arraysomev4result = arraysomev4(callbackfunction, anarray)
    % JavaScript-like Array.some() function
    for arrayitemindex = (1:1:numel(anarray))
        arrayitem = anarray{arrayitemindex};
        if (callbackfunction(arrayitem, arrayitemindex, anarray) == true)
            arraysomev4result = true;
            return;
        end
    end
    arraysomev4result = false;
end

sprint(sprintf("\n"), "% JavaScript-like Array.some() in GNU Octave Cell Array");

numbers = {12, 34, 27, 23, 65, 93, 36, 87, 4, 254};
sprint("numbers: ", {numbers});

sprint("% using JavaScript-like Array.some() function ""arraysomev1""");

isanynumberlessthan500 = arraysomev1(@(number, varargin) (number < 500), numbers);
sprint("is any number < 500: ", {isanynumberlessthan500});
% is any number < 500: true

isanynumbermorethan500 = arraysomev1(@(number, varargin) (number > 500), numbers);
sprint("is any number > 500: ", {isanynumbermorethan500});
% is any number > 500: false

sprint("% using JavaScript-like Array.some() function ""arraysomev2""");

isanynumberlessthan500 = arraysomev2(@(number, varargin) (number < 500), numbers);
sprint("is any number < 500: ", {isanynumberlessthan500});
% is any number < 500: true

isanynumbermorethan500 = arraysomev2(@(number, varargin) (number > 500), numbers);
sprint("is any number > 500: ", {isanynumbermorethan500});
% is any number > 500: false

sprint("% using JavaScript-like Array.some() function ""arraysomev3""");

isanynumberlessthan500 = arraysomev3(@(number, varargin) (number < 500), numbers);
sprint("is any number < 500: ", {isanynumberlessthan500});
% is any number < 500: true

isanynumbermorethan500 = arraysomev3(@(number, varargin) (number > 500), numbers);
sprint("is any number > 500: ", {isanynumbermorethan500});
% is any number > 500: false

sprint("% using JavaScript-like Array.some() function ""arraysomev4""");

isanynumberlessthan500 = arraysomev4(@(number, varargin) (number < 500), numbers);
sprint("is any number < 500: ", {isanynumberlessthan500});
% is any number < 500: true

isanynumbermorethan500 = arraysomev4(@(number, varargin) (number > 500), numbers);
sprint("is any number > 500: ", {isanynumbermorethan500});
% is any number > 500: false

sprint("% using GNU Octave Array.some() built-in function ""any"" and ""cellfun""");

isanynumberlessthan500 = any(cellfun(@(number) (number < 500), numbers));
sprint("is any number < 500: ", {isanynumberlessthan500});
% is any number < 500: true

isanynumbermorethan500 = any(cellfun(@(number) (number > 500), numbers));
sprint("is any number > 500: ", {isanynumbermorethan500});
% is any number > 500: false

sprint(sprintf("\n"), "% JavaScript-like Array.some() in GNU Octave Cell Array of Structs");

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

sprint("% using JavaScript-like Array.some() function ""arraysomev1""");

isanyproductpricelessthan500 = arraysomev1(@(product, varargin) (product.("price") < 500), products);
sprint("is any product price < 500: ", {isanyproductpricelessthan500});
% is any product price < 500: true

isanyproductpricemorethan500 = arraysomev1(@(product, varargin) (product.("price") > 500), products);
sprint("is any product price > 500: ", {isanyproductpricemorethan500});
% is any product price > 500: false

sprint("% using JavaScript-like Array.some() function ""arraysomev2""");

isanyproductpricelessthan500 = arraysomev2(@(product, varargin) (product.("price") < 500), products);
sprint("is any product price < 500: ", {isanyproductpricelessthan500});
% is any product price < 500: true

isanyproductpricemorethan500 = arraysomev2(@(product, varargin) (product.("price") > 500), products);
sprint("is any product price > 500: ", {isanyproductpricemorethan500});
% is any product price > 500: false

sprint("% using JavaScript-like Array.some() function ""arraysomev3""");

isanyproductpricelessthan500 = arraysomev3(@(product, varargin) (product.("price") < 500), products);
sprint("is any product price < 500: ", {isanyproductpricelessthan500});
% is any product price < 500: true

isanyproductpricemorethan500 = arraysomev3(@(product, varargin) (product.("price") > 500), products);
sprint("is any product price > 500: ", {isanyproductpricemorethan500});
% is any product price > 500: false

sprint("% using JavaScript-like Array.some() function ""arraysomev4""");

isanyproductpricelessthan500 = arraysomev4(@(product, varargin) (product.("price") < 500), products);
sprint("is any product price < 500: ", {isanyproductpricelessthan500});
% is any product price < 500: true

isanyproductpricemorethan500 = arraysomev4(@(product, varargin) (product.("price") > 500), products);
sprint("is any product price > 500: ", {isanyproductpricemorethan500});
% is any product price > 500: false

sprint("% using GNU Octave Array.some() built-in function ""any"" and ""cellfun""");

isanyproductpricelessthan500 = any(cellfun(@(product) (product.("price") < 500), products));
sprint("is any product price < 500: ", {isanyproductpricelessthan500});
% is any product price < 500: true

isanyproductpricemorethan500 = any(cellfun(@(product) (product.("price") > 500), products));
sprint("is any product price > 500: ", {isanyproductpricemorethan500});
% is any product price > 500: false
