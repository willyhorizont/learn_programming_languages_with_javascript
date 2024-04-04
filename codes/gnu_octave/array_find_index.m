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
        if ischar(anythinginner)
            jsonstringifyinnerresult = cstrcat("""", anythinginner, """");
            return;
        end
        if ischar(anythinginner)
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
            result = ternary((pretty == true), cstrcat("[", sprintf("\n"), stringrepeat(indentinner, indentlevel)), "[");
            for arrayitemindex = (1:1:numel(anythinginner)) % (start:step:stop)
                arrayitem = anythinginner{arrayitemindex};
                result = cstrcat(result, jsonstringifyinner(arrayitem, prettyinner, indentinner));
                if (arrayitemindex ~= numel(anythinginner))
                    result = ternary((pretty == true), cstrcat(result, ",", sprintf("\n"), stringrepeat(indentinner, indentlevel)), cstrcat(result, ", "));
                end
            end
            indentlevel = indentlevel - 1;
            result = ternary((pretty == true), cstrcat(result, sprintf("\n"), stringrepeat(indentinner, indentlevel), "]"), cstrcat(result, "]"));
            jsonstringifyinnerresult = result;
            return;
        end
        if isstruct(anythinginner)
            if (numel(fieldnames(anythinginner)) == 0)
                jsonstringifyinnerresult = "{}";
                return;
            end
            indentlevel = indentlevel + 1;
            result = ternary((pretty == true), cstrcat("{", sprintf("\n"), stringrepeat(indentinner, indentlevel)), "{");
            objectkeys = fieldnames(anythinginner);
            for objectentryindex = (1:1:numel(objectkeys)) % (start:step:stop)
                objectkey = objectkeys{objectentryindex};
                objectvalue = anythinginner.(objectkey);
                result = cstrcat(result, """", objectkey, """: ", jsonstringifyinner(objectvalue, prettyinner, indentinner));
                if (objectentryindex ~= numel(objectkeys))
                    result = ternary((pretty == true), cstrcat(result, ",", sprintf("\n"), stringrepeat(indentinner, indentlevel)), cstrcat(result, ", "));
                end
            end
            indentlevel = indentlevel - 1;
            result = ternary((pretty == true), cstrcat(result, sprintf("\n"), stringrepeat(indentinner, indentlevel), "}"), cstrcat(result, "}"));
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
            currentresult = cstrcat(currentresult, parameternew);
            continue;
        end
        if (~ischar(parameter) && ~ischar(parameter))
            error("Non string argument must be wrapped in {}");
            continue;
        end
        currentresult = cstrcat(currentresult, parameter);
    end
    disp(currentresult);
end

function arrayfindindexv1result = arrayfindindexv1(callbackfunction, anarray)
    % JavaScript-like Array.findIndex() function
    datafoundindex = -1;
    for arrayitemindex = (1:1:numel(anarray)) % (start:step:stop)
        arrayitem = anarray{arrayitemindex};
        isconditionmatch = callbackfunction(arrayitem, arrayitemindex, anarray);
        if (isconditionmatch == true)
            datafoundindex = arrayitemindex;
            break;
        end
    end
    arrayfindindexv1result = datafoundindex;
end

function arrayfindindexv2result = arrayfindindexv2(callbackfunction, anarray)
    % JavaScript-like Array.findIndex() function
    datafoundindex = -1;
    for arrayitemindex = (1:1:numel(anarray)) % (start:step:stop)
        arrayitem = anarray{arrayitemindex};
        if (callbackfunction(arrayitem, arrayitemindex, anarray) == true)
            datafoundindex = arrayitemindex;
            break;
        end
    end
    arrayfindindexv2result = datafoundindex;
end

function arrayfindindexv3result = arrayfindindexv3(callbackfunction, anarray)
    % JavaScript-like Array.findIndex() function
    for arrayitemindex = (1:1:numel(anarray)) % (start:step:stop)
        arrayitem = anarray{arrayitemindex};
        isconditionmatch = callbackfunction(arrayitem, arrayitemindex, anarray);
        if (isconditionmatch == true)
            arrayfindindexv3result = arrayitemindex;
            return;
        end
    end
    arrayfindindexv3result = -1;
end

function arrayfindindexv4result = arrayfindindexv4(callbackfunction, anarray)
    % JavaScript-like Array.findIndex() function
    for arrayitemindex = (1:1:numel(anarray)) % (start:step:stop)
        arrayitem = anarray{arrayitemindex};
        if (callbackfunction(arrayitem, arrayitemindex, anarray) == true)
            arrayfindindexv4result = arrayitemindex;
            return;
        end
    end
    arrayfindindexv4result = -1;
end

sprint(sprintf("\n"), "% JavaScript-like Array.findIndex() in GNU Octave Cell-Array");

numbers = {12, 34, 27, 23, 65, 93, 36, 87, 4, 254};
sprint("numbers: ", jsonstringify(numbers, false));

numbertofind = 27;
sprint("number to find: ", {numbertofind});

sprint("% using JavaScript-like Array.findIndex() function ""arrayfindindexv1""");

numberfoundindex = arrayfindindexv1(@(number, varargin) (number == numbertofind), numbers);
sprint("number found index: ", {numberfoundindex});
% number found index: 3

sprint("% using JavaScript-like Array.findIndex() function ""arrayfindindexv2""");

numberfoundindex = arrayfindindexv2(@(number, varargin) (number == numbertofind), numbers);
sprint("number found index: ", {numberfoundindex});
% number found index: 3

sprint("% using JavaScript-like Array.findIndex() function ""arrayfindindexv3""");

numberfoundindex = arrayfindindexv3(@(number, varargin) (number == numbertofind), numbers);
sprint("number found index: ", {numberfoundindex});
% number found index: 3

sprint("% using JavaScript-like Array.findIndex() function ""arrayfindindexv4""");

numberfoundindex = arrayfindindexv4(@(number, varargin) (number == numbertofind), numbers);
sprint("number found index: ", {numberfoundindex});
% number found index: 3

sprint("% using GNU Octave Array.findIndex() built-in function ""find"" and ""cellfun""");

numberfoundindex = find(cellfun(@(number) (number == numbertofind), numbers), 1);
sprint("number found index: ", {numberfoundindex});
% number found index: 3

sprint(sprintf("\n"), "% JavaScript-like Array.findIndex() in GNU Octave Cell-Array of structs");

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

sprint("% using JavaScript-like Array.findIndex() function ""arrayfindindexv1""");

producttofind = "pasta";
sprint("product to find: ", {producttofind});

productfoundindex = arrayfindindexv1(@(product, varargin) strcmp(product.("code"), producttofind), products);
sprint("product found index: ", {productfoundindex});
% product found index: 1

sprint("% using JavaScript-like Array.findIndex() function ""arrayfindindexv2""");

productfoundindex = arrayfindindexv2(@(product, varargin) strcmp(product.("code"), producttofind), products);
sprint("product found index: ", {productfoundindex});
% product found index: 1

sprint("% using JavaScript-like Array.findIndex() function ""arrayfindindexv3""");

productfoundindex = arrayfindindexv3(@(product, varargin) strcmp(product.("code"), producttofind), products);
sprint("product found index: ", {productfoundindex});
% product found index: 1

sprint("% using JavaScript-like Array.findIndex() function ""arrayfindindexv4""");

productfoundindex = arrayfindindexv4(@(product, varargin) strcmp(product.("code"), producttofind), products);
sprint("product found index: ", {productfoundindex});
% product found index: 1

sprint("% using GNU Octave Array.findIndex() built-in function ""find"" and ""cellfun""");

productfoundindex = find(cellfun(@(product) strcmp(product.("code"), producttofind), products), 1);
sprint("product found index: ", {productfoundindex});
% product found index: 1
