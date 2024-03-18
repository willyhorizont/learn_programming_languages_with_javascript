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

function arrayfilterv1result = arrayfilterv1(callbackfunction, anarray)
    % JavaScript-like Array.filter() function
    datafiltered = {};
    for arrayitemindex = (1:1:numel(anarray))
        arrayitem = anarray{arrayitemindex};
        isconditionmatch = callbackfunction(arrayitem, arrayitemindex, anarray);
        if (isconditionmatch == true)
            datafiltered{end + 1} = arrayitem;
        end
    end
    arrayfilterv1result = datafiltered;
end

function arrayfilterv2result = arrayfilterv2(callbackfunction, anarray)
    % JavaScript-like Array.filter() function
    datafiltered = {};
    for arrayitemindex = (1:1:numel(anarray))
        arrayitem = anarray{arrayitemindex};
        if (callbackfunction(arrayitem, arrayitemindex, anarray) == true)
            datafiltered{end + 1} = arrayitem;
        end
    end
    arrayfilterv2result = datafiltered;
end

sprint(sprintf("\n"), "% JavaScript-like Array.filter() in GNU Octave Cell Array");

numbers = {12, 34, 27, 23, 65, 93, 36, 87, 4, 254};
sprint("numbers: ", {numbers});

sprint("% using JavaScript-like Array.filter() function ""arrayfilterv1""");

numberseven = arrayfilterv1(@(number, varargin) (mod(number, 2) == 0), numbers);
sprint("even numbers only: ", {numberseven});
% even numbers only: [12, 34, 36, 4, 254]

numbersodd = arrayfilterv1(@(number, varargin) (mod(number, 2) ~= 0), numbers);
sprint("odd numbers only: ", {numbersodd});
% odd numbers only: [27, 23, 65, 93, 87]

sprint("% using JavaScript-like Array.filter() function ""arrayfilterv2""");

numberseven = arrayfilterv2(@(number, varargin) (mod(number, 2) == 0), numbers);
sprint("even numbers only: ", {numberseven});
% even numbers only: [12, 34, 36, 4, 254]

numbersodd = arrayfilterv2(@(number, varargin) (mod(number, 2) ~= 0), numbers);
sprint("odd numbers only: ", {numbersodd});
% odd numbers only: [27, 23, 65, 93, 87]

sprint("% using GNU Octave Array.filter() built-in function ""cellfun"" and logical indexing syntax");

numberseven = numbers(cellfun(@(number) (mod(number, 2) == 0), numbers));
sprint("even numbers only: ", {numberseven});
% even numbers only: [12, 34, 36, 4, 254]

numbersodd = numbers(cellfun(@(number) (mod(number, 2) ~= 0), numbers));
sprint("odd numbers only: ", {numbersodd});
% odd numbers only: [27, 23, 65, 93, 87]

sprint(sprintf("\n"), "% JavaScript-like Array.filter() in GNU Octave Cell Array of Structs");

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

sprint("% using JavaScript-like Array.filter() function ""arrayfilterv1""");

productsbelow100 = arrayfilterv1(@(product, varargin) (product.("price") <= 100), products);
sprint("products with price <= 100 only: ", prettyjsonstringify({productsbelow100}));
% products with price <= 100 only: [
%     {
%         "code": "potato_chips",
%         "price": 5
%     }
% ]

productsabove100 = arrayfilterv1(@(product, varargin) (product.("price") >= 100), products);
sprint("products with price >= 100 only: ", prettyjsonstringify({productsabove100}));
% products with price >= 100 only: [
%     {
%         "code": "pasta",
%         "price": 321
%     },
%     {
%         "code": "bubble_gum",
%         "price": 233
%     },
%     {
%         "code": "towel",
%         "price": 499
%     }
% ]

sprint("% using JavaScript-like Array.filter() function ""arrayfilterv2""");

productsbelow100 = arrayfilterv2(@(product, varargin) (product.("price") <= 100), products);
sprint("products with price <= 100 only: ", prettyjsonstringify({productsbelow100}));
% products with price <= 100 only: [
%     {
%         "code": "potato_chips",
%         "price": 5
%     }
% ]

productsabove100 = arrayfilterv2(@(product, varargin) (product.("price") >= 100), products);
sprint("products with price >= 100 only: ", prettyjsonstringify({productsabove100}));
% products with price >= 100 only: [
%     {
%         "code": "pasta",
%         "price": 321
%     },
%     {
%         "code": "bubble_gum",
%         "price": 233
%     },
%     {
%         "code": "towel",
%         "price": 499
%     }
% ]

sprint("% using GNU Octave Array.filter() built-in function ""cellfun"" and logical indexing syntax");

productsbelow100 = products(cellfun(@(product) (product.("price") <= 100), products));
sprint("products with price <= 100 only: ", prettyjsonstringify({productsbelow100}));
% products with price <= 100 only: [
%     {
%         "code": "potato_chips",
%         "price": 5
%     }
% ]

productsabove100 = products(cellfun(@(product) (product.("price") >= 100), products));
sprint("products with price >= 100 only: ", prettyjsonstringify({productsabove100}));
% products with price >= 100 only: [
%     {
%         "code": "pasta",
%         "price": 321
%     },
%     {
%         "code": "bubble_gum",
%         "price": 233
%     },
%     {
%         "code": "towel",
%         "price": 499
%     }
% ]
