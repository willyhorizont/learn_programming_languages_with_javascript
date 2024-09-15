function stringrepeatresult = stringrepeat(astring, count)
    result = "";
    for i = (1:1:count) % (start:step:stop)
        result = strcat(result, astring);
    end
    stringrepeatresult = result;
end

function arrayreduceresult = arrayreduce(callbackfunction, anarray, initialvalue)
    % JavaScript-like Array.reduce() function
    currentresult = initialvalue;
    for arrayitemindex = (1:1:numel(anarray)) % (start:step:stop)
        arrayitem = anarray{arrayitemindex};
        currentresult = callbackfunction(currentresult, arrayitem, arrayitemindex, anarray);
    end
    arrayreduceresult = currentresult;
end

function optionalchainingresult = optionalchaining(anything, varargin)
    % JavaScript-like Optional Chaining Operator (?.) function
    % varargin == objectpropertiesarray
    if ((~isstruct(anything) && ~iscell(anything)) || isempty(varargin))
        optionalchainingresult = anything;
        return;
    end
    function arrayreducecallbackresult = arrayreducecallback(currentresult, currentitem, varargin)
        % varargin == (arrayitemindex, anarray)
        if ((isempty(currentresult) && isstruct(anything) && (isstring(currentitem) || ischar(currentitem))) && isfield(anything, currentitem))
            arrayreducecallbackresult = anything.(currentitem);
            return;
        end
        if (isempty(currentresult) && iscell(anything) && isnumeric(currentitem) && (currentitem >= 1) && (numel(anything) > currentitem))
            arrayreducecallbackresult = anything{currentitem};
            return;
        end
        if ((isstruct(currentresult) && (isstring(currentitem) || ischar(currentitem))) && isfield(currentresult, currentitem))
            arrayreducecallbackresult = currentresult.(currentitem);
            return;
        end
        if (iscell(currentresult) && isnumeric(currentitem) && (currentitem >= 1) && (numel(currentresult) > currentitem))
            arrayreducecallbackresult = currentresult{currentitem};
            return;
        end
        arrayreducecallbackresult = {};
    end
    optionalchainingresult = arrayreduce(@arrayreducecallback, varargin, {});
end

function ternaryresult = ternary(truecondition, callbackfunctionifconditiontrue, callbackfunctionifconditionfalse)
    if (islogical(truecondition) && (truecondition == true))
        ternaryresult = callbackfunctionifconditiontrue();
        return;
    end
    ternaryresult = callbackfunctionifconditionfalse();
end

function jsonstringifyresult = jsonstringify(anything, varargin)
    indentlevel = 0;
    function jsonstringifyinnerresult = jsonstringifyinner(anythinginner, prettyinner, indentinner)
        if isempty(anythinginner)
            jsonstringifyinnerresult = "null";
            return;
        end
        if (isstring(anythinginner) || ischar(anythinginner))
            jsonstringifyinnerresult = strcat("""", anythinginner, """");
            return;
        end
        if isnumeric(anythinginner)
            jsonstringifyinnerresult = num2str(anythinginner);
            return;
        end
        if (islogical(anythinginner) && (anythinginner == true))
            jsonstringifyinnerresult = "true";
            return;
        end
        if (islogical(anythinginner) && (anythinginner == false))
            jsonstringifyinnerresult = "false";
            return;
        end
        if iscell(anythinginner)
            if isempty(anythinginner)
                jsonstringifyinnerresult = "[]";
                return;
            end
            indentlevel = indentlevel + 1;
            result = ternary((pretty == true), @() (strcat("[", sprintf("\n"), stringrepeat(indentinner, indentlevel))), @() ("["));
            for arrayitemindex = (1:1:numel(anythinginner)) % (start:step:stop)
                arrayitem = anythinginner{arrayitemindex};
                result = strcat(result, jsonstringifyinner(arrayitem, prettyinner, indentinner));
                if (arrayitemindex ~= numel(anythinginner))
                    result = ternary((pretty == true), @() (strcat(result, ",", sprintf("\n"), stringrepeat(indentinner, indentlevel))), @() (strcat(result, ", ")));
                end
            end
            indentlevel = indentlevel - 1;
            result = ternary((pretty == true), @() (strcat(result, sprintf("\n"), stringrepeat(indentinner, indentlevel), "]")), @() (strcat(result, "]")));
            jsonstringifyinnerresult = result;
            return;
        end
        if isstruct(anythinginner)
            if (numel(fieldnames(anythinginner)) == 0)
                jsonstringifyinnerresult = "{}";
                return;
            end
            indentlevel = indentlevel + 1;
            result = ternary((pretty == true), @() (strcat("{", sprintf("\n"), stringrepeat(indentinner, indentlevel))), @() ("{"));
            objectkeys = fieldnames(anythinginner);
            for objectentryindex = (1:1:numel(objectkeys)) % (start:step:stop)
                objectkey = objectkeys{objectentryindex};
                objectvalue = anythinginner.(objectkey);
                result = strcat(result, """", objectkey, """: ", jsonstringifyinner(objectvalue, prettyinner, indentinner));
                if (objectentryindex ~= numel(objectkeys))
                    result = ternary((pretty == true), @() (strcat(result, ",", sprintf("\n"), stringrepeat(indentinner, indentlevel))), @() (strcat(result, ", ")));
                end
            end
            indentlevel = indentlevel - 1;
            result = ternary((pretty == true), @() (strcat(result, sprintf("\n"), stringrepeat(indentinner, indentlevel), "}")), @() (strcat(result, "}")));
            jsonstringifyinnerresult = result;
            return;
        end
        jsonstringifyinnerresult = "null";
    end
    prettydefault = false;
    indentdefault = "    ";
    pretty = prettydefault;
    indent = indentdefault;
    if isempty(varargin)
        jsonstringifyresult = jsonstringifyinner(anything, prettydefault, indentdefault);
        return;
    end
    optionalargument = varargin{1};
    if (islogical(optionalargument) && (optionalargument == false))
        jsonstringifyresult = jsonstringifyinner(anything, prettydefault, indentdefault);
        return;
    end
    if isstruct(optionalargument)
        pretty = optionalchaining(optionalargument, "pretty");
        indent = optionalchaining(optionalargument, "indent");
        pretty = ternary(isempty(pretty), @() (prettydefault), @() (pretty));
        indent = ternary(isempty(indent), @() (indentdefault), @() (indent));
        jsonstringifyresult = jsonstringifyinner(anything, pretty, indent);
        return;
    end
    if (islogical(optionalargument) && (optionalargument == true))
        if (numel(varargin) >= 2)
            optionalargument2 = varargin{2};
            if (isstring(optionalargument2) || ischar(optionalargument2))
                indent = optionalargument2
            end
        end
        pretty = optionalargument;
        jsonstringifyresult = jsonstringifyinner(anything, pretty, indent);
        return;
    end
    jsonstringifyresult = jsonstringifyinner(anything, prettydefault, indentdefault);
end

function sprint(varargin)
    currentresult = "";
    for argumentindex = (1:1:numel(varargin)) % (start:step:stop)
        argument = varargin{argumentindex};
        if (iscell(argument) && (numel(argument) == 1))
            argumentnew = jsonstringify(argument{1});
            argumentnew = strrep(argumentnew, """{", "{");
            argumentnew = strrep(argumentnew, """[", "[");
            argumentnew = strrep(argumentnew, "}""", "}");
            argumentnew = strrep(argumentnew, "]""", "]");
            currentresult = strcat(currentresult, argumentnew);
            continue;
        end
        if (~isstring(argument) && ~ischar(argument))
            error("Non string argument must be wrapped in {}");
            continue;
        end
        currentresult = strcat(currentresult, argument);
    end
    disp(currentresult);
end

function arrayfilterv1result = arrayfilterv1(callbackfunction, anarray)
    % JavaScript-like Array.filter() function
    datafiltered = {};
    for arrayitemindex = (1:1:numel(anarray)) % (start:step:stop)
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
    for arrayitemindex = (1:1:numel(anarray)) % (start:step:stop)
        arrayitem = anarray{arrayitemindex};
        if (callbackfunction(arrayitem, arrayitemindex, anarray) == true)
            datafiltered{end + 1} = arrayitem;
        end
    end
    arrayfilterv2result = datafiltered;
end

sprint(sprintf("\n"), "% JavaScript-like Array.filter() in Matlab Cell-Array");

numbers = {12, 34, 27, 23, 65, 93, 36, 87, 4, 254};
sprint("numbers: ", jsonstringify(numbers));

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

sprint("% using Matlab Array.filter() built-in function ""cellfun"" and logical indexing syntax");

numberseven = numbers(cellfun(@(number) (mod(number, 2) == 0), numbers));
sprint("even numbers only: ", {numberseven});
% even numbers only: [12, 34, 36, 4, 254]

numbersodd = numbers(cellfun(@(number) (mod(number, 2) ~= 0), numbers));
sprint("odd numbers only: ", {numbersodd});
% odd numbers only: [27, 23, 65, 93, 87]

sprint(sprintf("\n"), "% JavaScript-like Array.filter() in Matlab Cell-Array of structs");

products = { ...
    struct( ...
        "code", {"pasta"}, ...
        "price", {321} ...
    ), ...
    struct( ...
        "code", {"bubble_gum"}, ...
        "price", {233} ...
    ), ...
    struct( ...
        "code", {"potato_chips"}, ...
        "price", {5} ...
    ), ...
    struct( ...
        "code", {"towel"}, ...
        "price", {499} ...
    ) ...
};
sprint("products: ", jsonstringify(products, struct("pretty", {true})));

sprint("% using JavaScript-like Array.filter() function ""arrayfilterv1""");

productsbelow100 = arrayfilterv1(@(product, varargin) (product.("price") <= 100), products);
sprint("products with price <= 100 only: ", jsonstringify(productsbelow100, struct("pretty", {true})));
% products with price <= 100 only: [
%     {
%         "code": "potato_chips",
%         "price": 5
%     }
% ]

productsabove100 = arrayfilterv1(@(product, varargin) (product.("price") > 100), products);
sprint("products with price > 100 only: ", jsonstringify(productsabove100, struct("pretty", {true})));
% products with price > 100 only: [
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
sprint("products with price <= 100 only: ", jsonstringify(productsbelow100, struct("pretty", {true})));
% products with price <= 100 only: [
%     {
%         "code": "potato_chips",
%         "price": 5
%     }
% ]

productsabove100 = arrayfilterv2(@(product, varargin) (product.("price") > 100), products);
sprint("products with price > 100 only: ", jsonstringify(productsabove100, struct("pretty", {true})));
% products with price > 100 only: [
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

sprint("% using Matlab Array.filter() built-in function ""cellfun"" and logical indexing syntax");

productsbelow100 = products(cellfun(@(product) (product.("price") <= 100), products));
sprint("products with price <= 100 only: ", jsonstringify(productsbelow100, struct("pretty", {true})));
% products with price <= 100 only: [
%     {
%         "code": "potato_chips",
%         "price": 5
%     }
% ]

productsabove100 = products(cellfun(@(product) (product.("price") > 100), products));
sprint("products with price > 100 only: ", jsonstringify(productsabove100, struct("pretty", {true})));
% products with price > 100 only: [
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
