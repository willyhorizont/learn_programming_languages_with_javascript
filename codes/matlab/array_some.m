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
    additionalparameter = varargin{1};
    if isstruct(additionalparameter)
        pretty = optionalchaining(additionalparameter, "pretty");
        indent = optionalchaining(additionalparameter, "indent");
        pretty = ternary(isempty(pretty), @() (prettydefault), @() (pretty));
        indent = ternary(isempty(indent), @() (indentdefault), @() (indent));
        jsonstringifyresult = jsonstringifyinner(anything, pretty, indent);
        return;
    end
    if (islogical(additionalparameter) && (additionalparameter == true))
        if (numel(varargin) >= 2)
            additionalparameter2 = varargin{2};
            if (isstring(additionalparameter2) || ischar(additionalparameter2))
                indent = additionalparameter2
            end
        end
        pretty = true;
        jsonstringifyresult = jsonstringifyinner(anything, pretty, indent);
        return;
    end
    if (islogical(additionalparameter) && (additionalparameter == false))
        pretty = false;
        jsonstringifyresult = jsonstringifyinner(anything, prettydefault, indentdefault);
        return;
    end
    jsonstringifyresult = jsonstringifyinner(anything, prettydefault, indentdefault);
end

function sprint(varargin)
    currentresult = "";
    for parameterindex = (1:1:numel(varargin)) % (start:step:stop)
        parameter = varargin{parameterindex};
        if (iscell(parameter) && (numel(parameter) == 1))
            parameternew = jsonstringify(parameter{1});
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

function arraysomev1result = arraysomev1(callbackfunction, anarray)
    % JavaScript-like Array.some() function
    isconditionmatch = false;
    for arrayitemindex = (1:1:numel(anarray)) % (start:step:stop)
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
    for arrayitemindex = (1:1:numel(anarray)) % (start:step:stop)
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
    for arrayitemindex = (1:1:numel(anarray)) % (start:step:stop)
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
    for arrayitemindex = (1:1:numel(anarray)) % (start:step:stop)
        arrayitem = anarray{arrayitemindex};
        if (callbackfunction(arrayitem, arrayitemindex, anarray) == true)
            arraysomev4result = true;
            return;
        end
    end
    arraysomev4result = false;
end

sprint(sprintf("\n"), "% JavaScript-like Array.some() in Matlab Cell-Array");

numbers = {12, 34, 27, 23, 65, 93, 36, 87, 4, 254};
sprint("numbers: ", jsonstringify(numbers));

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

sprint("% using Matlab Array.some() built-in function ""any"" and ""cellfun""");

isanynumberlessthan500 = any(cellfun(@(number) (number < 500), numbers));
sprint("is any number < 500: ", {isanynumberlessthan500});
% is any number < 500: true

isanynumbermorethan500 = any(cellfun(@(number) (number > 500), numbers));
sprint("is any number > 500: ", {isanynumbermorethan500});
% is any number > 500: false

sprint(sprintf("\n"), "% JavaScript-like Array.some() in Matlab Cell-Array of structs");

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

sprint("% using Matlab Array.some() built-in function ""any"" and ""cellfun""");

isanyproductpricelessthan500 = any(cellfun(@(product) (product.("price") < 500), products));
sprint("is any product price < 500: ", {isanyproductpricelessthan500});
% is any product price < 500: true

isanyproductpricemorethan500 = any(cellfun(@(product) (product.("price") > 500), products));
sprint("is any product price > 500: ", {isanyproductpricemorethan500});
% is any product price > 500: false
