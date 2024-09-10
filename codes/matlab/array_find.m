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

% There's no JavaScript-like Array.find() in Matlab.
% But, we can create our own function to mimic it in Matlab.

function arrayfindv1result = arrayfindv1(callbackfunction, anarray)
    % JavaScript-like Array.find() function
    datafound = {};
    for arrayitemindex = (1:1:numel(anarray)) % (start:step:stop)
        arrayitem = anarray{arrayitemindex};
        isconditionmatch = callbackfunction(arrayitem, arrayitemindex, anarray);
        if (isconditionmatch == true)
            datafound = arrayitem;
            break;
        end
    end
    arrayfindv1result = datafound;
end

function arrayfindv2result = arrayfindv2(callbackfunction, anarray)
    % JavaScript-like Array.find() function
    datafound = {};
    for arrayitemindex = (1:1:numel(anarray)) % (start:step:stop)
        arrayitem = anarray{arrayitemindex};
        if (callbackfunction(arrayitem, arrayitemindex, anarray) == true)
            datafound = arrayitem;
            break;
        end
    end
    arrayfindv2result = datafound;
end

function arrayfindv3result = arrayfindv3(callbackfunction, anarray)
    % JavaScript-like Array.find() function
    for arrayitemindex = (1:1:numel(anarray)) % (start:step:stop)
        arrayitem = anarray{arrayitemindex};
        isconditionmatch = callbackfunction(arrayitem, arrayitemindex, anarray);
        if (isconditionmatch == true)
            arrayfindv3result = arrayitem;
            return;
        end
    end
    arrayfindv3result = {};
end

function arrayfindv4result = arrayfindv4(callbackfunction, anarray)
    % JavaScript-like Array.find() function
    for arrayitemindex = (1:1:numel(anarray)) % (start:step:stop)
        arrayitem = anarray{arrayitemindex};
        if (callbackfunction(arrayitem, arrayitemindex, anarray) == true)
            arrayfindv4result = arrayitem;
            return;
        end
    end
    arrayfindv4result = {};
end

sprint(sprintf("\n"), "% JavaScript-like Array.find() in Matlab Cell-Array");

numbers = {12, 34, 27, 23, 65, 93, 36, 87, 4, 254};
sprint("numbers: ", jsonstringify(numbers));

sprint("% using JavaScript-like Array.find() function ""arrayfindv1""");

evennumberfound = arrayfindv1(@(number, varargin) (mod(number, 2) == 0), numbers);
sprint("even number found: ", {evennumberfound});
% even number found: 12

oddnumberfound = arrayfindv1(@(number, varargin) (mod(number, 2) ~= 0), numbers);
sprint("odd number found: ", {oddnumberfound});
% odd number found: 27

sprint("% using JavaScript-like Array.find() function ""arrayfindv2""");

evennumberfound = arrayfindv2(@(number, varargin) (mod(number, 2) == 0), numbers);
sprint("even number found: ", {evennumberfound});
% even number found: 12

oddnumberfound = arrayfindv2(@(number, varargin) (mod(number, 2) ~= 0), numbers);
sprint("odd number found: ", {oddnumberfound});
% odd number found: 27

sprint("% using JavaScript-like Array.find() function ""arrayfindv3""");

evennumberfound = arrayfindv3(@(number, varargin) (mod(number, 2) == 0), numbers);
sprint("even number found: ", {evennumberfound});
% even number found: 12

oddnumberfound = arrayfindv3(@(number, varargin) (mod(number, 2) ~= 0), numbers);
sprint("odd number found: ", {oddnumberfound});
% odd number found: 27

sprint("% using JavaScript-like Array.find() function ""arrayfindv4""");

evennumberfound = arrayfindv4(@(number, varargin) (mod(number, 2) == 0), numbers);
sprint("even number found: ", {evennumberfound});
% even number found: 12

oddnumberfound = arrayfindv4(@(number, varargin) (mod(number, 2) ~= 0), numbers);
sprint("odd number found: ", {oddnumberfound});
% odd number found: 27

sprint(sprintf("\n"), "% JavaScript-like Array.find() in Matlab Cell-Array of structs");

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

sprint("% using JavaScript-like Array.find() function ""arrayfindv1""");

producttofind = "bubble_gum";
sprint("product to find: ", {producttofind});

productfound = arrayfindv1(@(product, varargin) strcmp(product.("code"), producttofind), products);
sprint("product found: ", jsonstringify(productfound, struct("pretty", {true})));
% product found: {
%     "code": "bubble_gum",
%     "price": 233
% }

sprint("% using JavaScript-like Array.find() function ""arrayfindv2""");

productfound = arrayfindv2(@(product, varargin) strcmp(product.("code"), producttofind), products);
sprint("product found: ", jsonstringify(productfound, struct("pretty", {true})));
% product found: {
%     "code": "bubble_gum",
%     "price": 233
% }

sprint("% using JavaScript-like Array.find() function ""arrayfindv3""");

productfound = arrayfindv3(@(product, varargin) strcmp(product.("code"), producttofind), products);
sprint("product found: ", jsonstringify(productfound, struct("pretty", {true})));
% product found: {
%     "code": "bubble_gum",
%     "price": 233
% }

sprint("% using JavaScript-like Array.find() function ""arrayfindv4""");

productfound = arrayfindv4(@(product, varargin) strcmp(product.("code"), producttofind), products);
sprint("product found: ", jsonstringify(productfound, struct("pretty", {true})));
% product found: {
%     "code": "bubble_gum",
%     "price": 233
% }
