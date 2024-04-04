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

function ternaryresult = ternary(truecondition, valueifconditionistrue, valueifconditionisfalse)
    if (islogical(truecondition) && (truecondition == true))
        ternaryresult = valueifconditionistrue;
        return;
    end
    ternaryresult = valueifconditionisfalse;
end

function jsonstringifyresult = jsonstringify(anything, additionalparameter)
    indentlevel = 0;
    function jsonstringifyinnerresult = jsonstringifyinner(anythinginner, prettyinner, indentinner)
        if isempty(anythinginner)
            jsonstringifyinnerresult = "null";
            return;
        end
        if isstring(anythinginner)
            jsonstringifyinnerresult = strcat("""", anythinginner, """");
            return;
        end
        if ischar(anythinginner)
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
            result = ternary((pretty == true), strcat("[", sprintf("\n"), stringrepeat(indentinner, indentlevel)), "[");
            for arrayitemindex = (1:1:numel(anythinginner)) % (start:step:stop)
                arrayitem = anythinginner{arrayitemindex};
                result = strcat(result, jsonstringifyinner(arrayitem, prettyinner, indentinner));
                if (arrayitemindex ~= numel(anythinginner))
                    result = ternary((pretty == true), strcat(result, ",", sprintf("\n"), stringrepeat(indentinner, indentlevel)), strcat(result, ", "));
                end
            end
            indentlevel = indentlevel - 1;
            result = ternary((pretty == true), strcat(result, sprintf("\n"), stringrepeat(indentinner, indentlevel), "]"), strcat(result, "]"));
            jsonstringifyinnerresult = result;
            return;
        end
        if isstruct(anythinginner)
            if (numel(fieldnames(anythinginner)) == 0)
                jsonstringifyinnerresult = "{}";
                return;
            end
            indentlevel = indentlevel + 1;
            result = ternary((pretty == true), strcat("{", sprintf("\n"), stringrepeat(indentinner, indentlevel)), "{");
            objectkeys = fieldnames(anythinginner);
            for objectentryindex = (1:1:numel(objectkeys)) % (start:step:stop)
                objectkey = objectkeys{objectentryindex};
                objectvalue = anythinginner.(objectkey);
                result = strcat(result, """", objectkey, """: ", jsonstringifyinner(objectvalue, prettyinner, indentinner));
                if (objectentryindex ~= numel(objectkeys))
                    result = ternary((pretty == true), strcat(result, ",", sprintf("\n"), stringrepeat(indentinner, indentlevel)), strcat(result, ", "));
                end
            end
            indentlevel = indentlevel - 1;
            result = ternary((pretty == true), strcat(result, sprintf("\n"), stringrepeat(indentinner, indentlevel), "}"), strcat(result, "}"));
            jsonstringifyinnerresult = result;
            return;
        end
        jsonstringifyinnerresult = "null";
    end
    pretty = false;
    indent = "    ";
    if isempty(additionalparameter)
        jsonstringifyresult = jsonstringifyinner(anything, true, indent);
        return;
    end
    if isstruct(additionalparameter)
        pretty = optionalchaining(additionalparameter, "pretty");
        indent = optionalchaining(additionalparameter, "indent");
        pretty = ternary(isempty(pretty), false, pretty);
        indent = ternary(isempty(indent), "    ", indent);
        jsonstringifyresult = jsonstringifyinner(anything, pretty, indent);
        return;
    end
    if (islogical(additionalparameter) && (additionalparameter == true))
        pretty = true;
        jsonstringifyresult = jsonstringifyinner(anything, pretty, indent);
        return;
    end
    if (islogical(additionalparameter) && (additionalparameter == false))
        pretty = false;
        jsonstringifyresult = jsonstringifyinner(anything, pretty, indent);
        return;
    end
    jsonstringifyresult = jsonstringifyinner(anything, false, indent);
end

function sprint(varargin)
    currentresult = "";
    for parameterindex = (1:1:numel(varargin)) % (start:step:stop)
        parameter = varargin{parameterindex};
        if (iscell(parameter) && (numel(parameter) == 1))
            parameternew = jsonstringify(parameter{1}, false);
            parameternew = strrep(parameternew, """{", "{");
            parameternew = strrep(parameternew, """[", "[");
            parameternew = strrep(parameternew, "}""", "}");
            parameternew = strrep(parameternew, "]""", "]");
            currentresult = strcat(currentresult, parameternew);
            continue;
        end
        if (~isstring(parameter) && ~ischar(parameter))
            error("Non string argument must be wrapped in {}");
            continue;
        end
        currentresult = strcat(currentresult, parameter);
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

sprint(sprintf("\n"), "% JavaScript-like Array.every() in Matlab Cell-Array");

numbers = {12, 34, 27, 23, 65, 93, 36, 87, 4, 254};
sprint("numbers: ", jsonstringify(numbers, false));

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

sprint("% using Matlab Array.every() built-in function ""all"" and ""cellfun""");

isallnumberlessthan500 = all(cellfun(@(number) (number < 500), numbers));
sprint("is all number < 500: ", {isallnumberlessthan500});
% is all number < 500: true

isallnumbermorethan500 = all(cellfun(@(number) (number > 500), numbers));
sprint("is all number > 500: ", {isallnumbermorethan500});
% is all number > 500: false

sprint(sprintf("\n"), "% JavaScript-like Array.every() in Matlab Cell-Array of structs");

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

sprint("% using Matlab Array.every() built-in function ""all"" and ""cellfun""");

isallproductpricelessthan500 = all(cellfun(@(product) (product.("price") < 500), products));
sprint("is all product price < 500: ", {isallproductpricelessthan500});
% is all product price < 500: true

isallproductpricemorethan500 = all(cellfun(@(product) (product.("price") > 500), products));
sprint("is all product price > 500: ", {isallproductpricemorethan500});
% is all product price > 500: false
