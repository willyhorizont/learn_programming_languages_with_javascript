function stringrepeatresult = stringrepeat(astring, count)
    result = "";
    for i = (1:1:count) % (start:step:stop)
        result = cstrcat(result, astring);
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
        if ((isempty(currentresult) && isstruct(anything) && (ischar(currentitem) || ischar(currentitem))) && isfield(anything, currentitem))
            arrayreducecallbackresult = anything.(currentitem);
            return;
        end
        if (isempty(currentresult) && iscell(anything) && isnumeric(currentitem) && (currentitem >= 1) && (numel(anything) > currentitem))
            arrayreducecallbackresult = anything{currentitem};
            return;
        end
        if ((isstruct(currentresult) && (ischar(currentitem) || ischar(currentitem))) && isfield(currentresult, currentitem))
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
        if (ischar(anythinginner) || ischar(anythinginner))
            jsonstringifyinnerresult = cstrcat("""", anythinginner, """");
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
            result = ternary((pretty == true), @() (cstrcat("[", sprintf("\n"), stringrepeat(indentinner, indentlevel))), @() ("["));
            for arrayitemindex = (1:1:numel(anythinginner)) % (start:step:stop)
                arrayitem = anythinginner{arrayitemindex};
                result = cstrcat(result, jsonstringifyinner(arrayitem, prettyinner, indentinner));
                if (arrayitemindex ~= numel(anythinginner))
                    result = ternary((pretty == true), @() (cstrcat(result, ",", sprintf("\n"), stringrepeat(indentinner, indentlevel))), @() (cstrcat(result, ", ")));
                end
            end
            indentlevel = indentlevel - 1;
            result = ternary((pretty == true), @() (cstrcat(result, sprintf("\n"), stringrepeat(indentinner, indentlevel), "]")), @() (cstrcat(result, "]")));
            jsonstringifyinnerresult = result;
            return;
        end
        if isstruct(anythinginner)
            if (numel(fieldnames(anythinginner)) == 0)
                jsonstringifyinnerresult = "{}";
                return;
            end
            indentlevel = indentlevel + 1;
            result = ternary((pretty == true), @() (cstrcat("{", sprintf("\n"), stringrepeat(indentinner, indentlevel))), @() ("{"));
            objectkeys = fieldnames(anythinginner);
            for objectentryindex = (1:1:numel(objectkeys)) % (start:step:stop)
                objectkey = objectkeys{objectentryindex};
                objectvalue = anythinginner.(objectkey);
                result = cstrcat(result, """", objectkey, """: ", jsonstringifyinner(objectvalue, prettyinner, indentinner));
                if (objectentryindex ~= numel(objectkeys))
                    result = ternary((pretty == true), @() (cstrcat(result, ",", sprintf("\n"), stringrepeat(indentinner, indentlevel))), @() (cstrcat(result, ", ")));
                end
            end
            indentlevel = indentlevel - 1;
            result = ternary((pretty == true), @() (cstrcat(result, sprintf("\n"), stringrepeat(indentinner, indentlevel), "}")), @() (cstrcat(result, "}")));
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
            if (ischar(optionalargument2) || ischar(optionalargument2))
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
            currentresult = cstrcat(currentresult, argumentnew);
            continue;
        end
        if (~ischar(argument) && ~ischar(argument))
            error("Non string argument must be wrapped in {}");
            continue;
        end
        currentresult = cstrcat(currentresult, argument);
    end
    disp(currentresult);
end

function arrayeveryv1result = arrayeveryv1(callbackfunction, anarray)
    % JavaScript-like Array.every() function
    isconditionmatch = false;
    for arrayitemindex = (1:1:numel(anarray)) % (start:step:stop)
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
    for arrayitemindex = (1:1:numel(anarray)) % (start:step:stop)
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
    for arrayitemindex = (1:1:numel(anarray)) % (start:step:stop)
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
    for arrayitemindex = (1:1:numel(anarray)) % (start:step:stop)
        arrayitem = anarray{arrayitemindex};
        if (callbackfunction(arrayitem, arrayitemindex, anarray) == false)
            arrayeveryv4result = false;
            return;
        end
    end
    arrayeveryv4result = true;
end

sprint(sprintf("\n"), "% JavaScript-like Array.every() in GNU Octave Cell-Array");

numbers = {12, 34, 27, 23, 65, 93, 36, 87, 4, 254};
sprint("numbers: ", jsonstringify(numbers));

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

sprint(sprintf("\n"), "% JavaScript-like Array.every() in GNU Octave Cell-Array of structs");

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
