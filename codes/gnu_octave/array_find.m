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

% There's no JavaScript-like Array.find() in GNU Octave.
% But, we can create our own function to mimic it in GNU Octave.

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

sprint(sprintf("\n"), "% JavaScript-like Array.find() in GNU Octave Cell-Array");

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

sprint(sprintf("\n"), "% JavaScript-like Array.find() in GNU Octave Cell-Array of structs");

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
