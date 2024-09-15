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

function newallowedobjectkeygeneratorresult = newallowedobjectkeygenerator()
    iterator = 1;
    function generateallowedobjectkeyinnerresult = generateallowedobjectkeyinner(anything)
        if isnumeric(anything)
            anything = strrep(num2str(anything), ".", "point");
            anything = strrep(anything, "-", "negative");
            generateallowedobjectkeyinnerresult = cstrcat("key", anything);
            return;
        end
        newobjectkeystring = jsonstringify(anything);
        if ischar(anything) || ischar(anything)
            if regexp(anything, "^[0-9]*$")
                anything = strrep(num2str(anything), ".", "point");
                anything = strrep(anything, "-", "negative");
                generateallowedobjectkeyinnerresult = cstrcat("key", anything);
                return;
            end
        end
        allowedobjectkey = regexprep(newobjectkeystring, "^[^a-zA-Z]+|[^a-zA-Z0-9_]", "");
        if (allowedobjectkey ~= "")
            generateallowedobjectkeyinnerresult = allowedobjectkey;
            return;
        end
        generateallowedobjectkeyinnerresult = cstrcat("key", num2str(iterator));
        iterator = iterator + 1;
    end
    newallowedobjectkeygeneratorresult = @generateallowedobjectkeyinner;
end
generateallowedobjectkey = newallowedobjectkeygenerator();

function spreadobjectresult = spreadobject(varargin)
    newobject = struct();
    for argumentindex = (1:1:numel(varargin)) % (start:step:stop)
        argument = varargin{argumentindex};
        if isstruct(argument)
            objectkeys = fieldnames(argument);
            for objectentryindex = (1:1:numel(objectkeys)) % (start:step:stop)
                objectkey = objectkeys{objectentryindex};
                objectvalue = argument.(objectkey);
                newobject.(objectkey) = objectvalue;
            end
            continue;
        end
        if iscell(argument)
            for arrayitemindex = (1:1:numel(argument)) % (start:step:stop)
                arrayitem = argument{arrayitemindex};
                newobject.(cstrcat("index", num2str(arrayitemindex))) = arrayitem;
            end
            continue;
        end
    end
    spreadobjectresult = newobject;
end

function arraymapv1result = arraymapv1(callbackfunction, anarray)
    % JavaScript-like Array.map() function
    newarray = {};
    for arrayitemindex = (1:1:numel(anarray)) % (start:step:stop)
        arrayitem = anarray{arrayitemindex};
        newarrayitem = callbackfunction(arrayitem, arrayitemindex, anarray);
        newarray{end + 1} = newarrayitem;
    end
    arraymapv1result = newarray;
end

function arraymapv2result = arraymapv2(callbackfunction, anarray)
    % JavaScript-like Array.map() function
    newarray = {};
    for arrayitemindex = (1:1:numel(anarray)) % (start:step:stop)
        arrayitem = anarray{arrayitemindex};
        newarray{end + 1} = callbackfunction(arrayitem, arrayitemindex, anarray);
    end
    arraymapv2result = newarray;
end

sprint(sprintf("\n"), "% JavaScript-like Array.map() in GNU Octave Cell-Array");

numbers = {12, 34, 27, 23, 65, 93, 36, 87, 4, 254};
sprint("numbers: ", jsonstringify(numbers));

sprint("% using JavaScript-like Array.map() function ""arraymapv1""");

numberslabeled = arraymapv1(@(number, varargin) ternary((mod(number, 2) == 0), @() (struct(generateallowedobjectkey(number), {"even"})), @() (struct(generateallowedobjectkey(number), {"odd"}))), numbers);
sprint("labeled numbers: ", jsonstringify(numberslabeled, struct("pretty", {true})));
% labeled numbers: [
%     {
%         "key12": "even"
%     },
%     {
%         "key34": "even"
%     },
%     {
%         "key27": "odd"
%     },
%     {
%         "key23": "odd"
%     },
%     {
%         "key65": "odd"
%     },
%     {
%         "key93": "odd"
%     },
%     {
%         "key36": "even"
%     },
%     {
%         "key87": "odd"
%     },
%     {
%         "key4": "even"
%     },
%     {
%         "key254": "even"
%     }
% ]

sprint("% using JavaScript-like Array.map() function ""arraymapv2""");

numberslabeled = arraymapv2(@(number, varargin) ternary((mod(number, 2) == 0), @() (struct(generateallowedobjectkey(number), {"even"})), @() (struct(generateallowedobjectkey(number), {"odd"}))), numbers);
sprint("labeled numbers: ", jsonstringify(numberslabeled, struct("pretty", {true})));
% labeled numbers: [
%     {
%         "key12": "even"
%     },
%     {
%         "key34": "even"
%     },
%     {
%         "key27": "odd"
%     },
%     {
%         "key23": "odd"
%     },
%     {
%         "key65": "odd"
%     },
%     {
%         "key93": "odd"
%     },
%     {
%         "key36": "even"
%     },
%     {
%         "key87": "odd"
%     },
%     {
%         "key4": "even"
%     },
%     {
%         "key254": "even"
%     }
% ]

sprint("% using GNU Octave Array.map() built-in function ""cellfun""");

numberslabeled = cellfun(@(number) ternary((mod(number, 2) == 0), @() (struct(generateallowedobjectkey(number), {"even"})), @() (struct(generateallowedobjectkey(number), {"odd"}))), numbers, "UniformOutput", false);
sprint("labeled numbers: ", jsonstringify(numberslabeled, struct("pretty", {true})));
% labeled numbers: [
%     {
%         "key12": "even"
%     },
%     {
%         "key34": "even"
%     },
%     {
%         "key27": "odd"
%     },
%     {
%         "key23": "odd"
%     },
%     {
%         "key65": "odd"
%     },
%     {
%         "key93": "odd"
%     },
%     {
%         "key36": "even"
%     },
%     {
%         "key87": "odd"
%     },
%     {
%         "key4": "even"
%     },
%     {
%         "key254": "even"
%     }
% ]

sprint(sprintf("\n"), "% JavaScript-like Array.map() in GNU Octave Cell-Array of structs");

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

sprint("% using JavaScript-like Array.map() function ""arraymapv1""");

productslabeled = arraymapv1(@(product, varargin) spreadobject(product, struct("label", {ternary((product.("price") > 100), @() ("expensive"), @() ("cheap"))})), products);
sprint("labeled products: ", jsonstringify(productslabeled, struct("pretty", {true})));
% labeled products: [
%     {
%         "code": "pasta",
%         "price": 321,
%         "label": "expensive"
%     },
%     {
%         "code": "bubble_gum",
%         "price": 233,
%         "label": "expensive"
%     },
%     {
%         "code": "potato_chips",
%         "price": 5,
%         "label": "cheap"
%     },
%     {
%         "code": "towel",
%         "price": 499,
%         "label": "expensive"
%     }
% ]

sprint("% using JavaScript-like Array.map() function ""arraymapv2""");

productslabeled = arraymapv2(@(product, varargin) spreadobject(product, struct("label", {ternary((product.("price") > 100), @() ("expensive"), @() ("cheap"))})), products);
sprint("labeled products: ", jsonstringify(productslabeled, struct("pretty", {true})));
% labeled products: [
%     {
%         "code": "pasta",
%         "price": 321,
%         "label": "expensive"
%     },
%     {
%         "code": "bubble_gum",
%         "price": 233,
%         "label": "expensive"
%     },
%     {
%         "code": "potato_chips",
%         "price": 5,
%         "label": "cheap"
%     },
%     {
%         "code": "towel",
%         "price": 499,
%         "label": "expensive"
%     }
% ]

sprint("% using GNU Octave Array.map() built-in function ""cellfun""");

productslabeled = cellfun(@(product) spreadobject(product, struct("label", {ternary((product.("price") > 100), @() ("expensive"), @() ("cheap"))})), products, "UniformOutput", false);
sprint("labeled products: ", jsonstringify(productslabeled, struct("pretty", {true})));
% labeled products: [
%     {
%         "code": "pasta",
%         "price": 321,
%         "label": "expensive"
%     },
%     {
%         "code": "bubble_gum",
%         "price": 233,
%         "label": "expensive"
%     },
%     {
%         "code": "potato_chips",
%         "price": 5,
%         "label": "cheap"
%     },
%     {
%         "code": "towel",
%         "price": 499,
%         "label": "expensive"
%     }
% ]
