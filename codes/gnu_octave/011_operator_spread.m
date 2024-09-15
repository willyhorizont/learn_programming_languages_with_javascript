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

sprint(sprintf("\n"), "% JavaScript-like Spread Syntax (...) in GNU Octave");

% There's no JavaScript-like Spread Syntax (...) in GNU Octave.
% But, we can create our own function to mimic it in GNU Octave.

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

function spreadarrayresult = spreadarray(varargin)
    newarray = {};
    for argumentindex = (1:1:numel(varargin)) % (start:step:stop)
        argument = varargin{argumentindex};
        if isstruct(argument)
            objectkeys = fieldnames(argument);
            if (numel(objectkeys) == 1)
                for objectentryindex = (1:1:numel(objectkeys)) % (start:step:stop)
                    objectkey = objectkeys{objectentryindex};
                    objectvalue = argument.(objectkey);
                    newarray{end + 1} = objectvalue;
                end
                continue;
            end
            newarray{end + 1} = argument;
            continue;
        end
        if iscell(argument)
            for arrayitemindex = (1:1:numel(argument)) % (start:step:stop)
                arrayitem = argument{arrayitemindex};
                newarray{end + 1} = arrayitem;
            end
            continue;
        end
    end
    spreadarrayresult = newarray;
end

fruits = {"Mango", "Melon", "Banana"};
sprint("fruits: ", jsonstringify(fruits));

vegetables = {"Carrot", "Tomato"};
sprint("vegetables: ", jsonstringify(vegetables));

countrycapitalsinasia = struct( ...
    "Thailand", {"Bangkok"}, ...
    "China", {"Beijing"}, ...
    "Japan", {"Tokyo"} ...
);
sprint("countrycapitalsinasia: ", jsonstringify(countrycapitalsinasia, struct("pretty", {true})));

countrycapitalsineurope = struct( ...
    "France", {"Paris"}, ...
    "England", {"London"} ...
);
sprint("countrycapitalsineurope: ", jsonstringify(countrycapitalsineurope, struct("pretty", {true})));

sprint(sprintf("\n"), "% [...array1, ...array2]:", sprintf("\n"));

combination1 = spreadarray(fruits, vegetables);
sprint("combination1: ", jsonstringify(combination1, struct("pretty", {true})));
% combination1: [
%     "Mango",
%     "Melon",
%     "Banana",
%     "Carrot",
%     "Tomato"
% ]

combination2 = spreadarray(fruits, {"Cucumber", "Cabbage"});
sprint("combination2: ", jsonstringify(combination2, struct("pretty", {true})));
% combination2: [
%     "Mango",
%     "Melon",
%     "Banana",
%     "Cucumber",
%     "Cabbage"
% ]

sprint(sprintf("\n"), "% { ...object1, ...object2 }:", sprintf("\n"));

combination3 = spreadobject(countrycapitalsinasia, countrycapitalsineurope);
sprint("combination3: ", jsonstringify(combination3, struct("pretty", {true})));
% combination3: {
%     "Thailand": "Bangkok",
%     "China": "Beijing",
%     "Japan": "Tokyo",
%     "France": "Paris",
%     "England": "London"
% }

combination4 = spreadobject(countrycapitalsinasia, struct("Germany", {"Berlin"}, "Italy", {"Rome"}));
sprint("combination4: ", jsonstringify(combination4, struct("pretty", {true})));
% combination4: {
%     "Thailand": "Bangkok",
%     "China": "Beijing",
%     "Japan": "Tokyo",
%     "Germany": "Berlin",
%     "Italy": "Rome"
% }

sprint(sprintf("\n"), "% [...array1, array2] || [...array1, newArrayItem1, newArrayItem2]:", sprintf("\n"));

combination5 = spreadarray(fruits, struct("vegetables", {vegetables}));
sprint("combination5: ", jsonstringify(combination5, struct("pretty", {true})));
% combination5: [
%     "Mango",
%     "Melon",
%     "Banana",
%     [
%         "Carrot",
%         "Tomato"
%     ]
% ]

combination6 = spreadarray(fruits, struct("vegetables", {{"Cucumber", "Cabbage"}}));
sprint("combination6: ", jsonstringify(combination6, struct("pretty", {true})));
% combination6: [
%     "Mango",
%     "Melon",
%     "Banana",
%     [
%         "Cucumber",
%         "Cabbage"
%     ]
% ]

sprint(sprintf("\n"), "% [...array1, object1] || [...array1, newArrayItem1, newArrayItem2]:", sprintf("\n"));

combination7 = spreadarray(fruits, struct("countrycapitalsinasia", {countrycapitalsinasia}));
sprint("combination7: ", jsonstringify(combination7, struct("pretty", {true})));
% combination7: [
%     "Mango",
%     "Melon",
%     "Banana",
%     {
%         "Thailand": "Bangkok",
%         "China": "Beijing",
%         "Japan": "Tokyo"
%     }
% ]

combination8 = spreadarray(fruits, struct("countrycapitalsineurope", {struct("Germany", {"Berlin"}, "Italy", {"Rome"})}));
sprint("combination8: ", jsonstringify(combination8, struct("pretty", {true})));
% combination8: [
%     "Mango",
%     "Melon",
%     "Banana",
%     {
%         "Germany": "Berlin",
%         "Italy": "Rome"
%     }
% ]

sprint(sprintf("\n"), "% { ...object1, object2 } || { ...object1, objectKey: objectValue }:", sprintf("\n"));

combination9 = spreadobject(countrycapitalsinasia, struct("countrycapitalsineurope", {countrycapitalsineurope}));
sprint("combination9: ", jsonstringify(combination9, struct("pretty", {true})));
% combination9: {
%     "Thailand": "Bangkok",
%     "China": "Beijing",
%     "Japan": "Tokyo",
%     "countrycapitalsineurope": {
%         "France": "Paris",
%         "England": "London"
%     }
% }

combination10 = spreadobject(countrycapitalsinasia, struct("countrycapitalsineurope", {struct("Germany", {"Berlin"}, "Italy", {"Rome"})}));
sprint("combination10: ", jsonstringify(combination10, struct("pretty", {true})));
% combination10: {
%     "Thailand": "Bangkok",
%     "China": "Beijing",
%     "Japan": "Tokyo",
%     "countrycapitalsineurope": {
%         "Germany": "Berlin",
%         "Italy": "Rome"
%     }
% }

sprint(sprintf("\n"), "% { ...object1, array2 } || { ...object1, objectKey: objectValue }:", sprintf("\n"));

combination11 = spreadobject(countrycapitalsinasia, struct("vegetables", {vegetables}));
sprint("combination11: ", jsonstringify(combination11, struct("pretty", {true})));
% combination11: {
%     "Thailand": "Bangkok",
%     "China": "Beijing",
%     "Japan": "Tokyo",
%     "vegetables": [
%         "Carrot",
%         "Tomato"
%     ]
% }

combination12 = spreadobject(countrycapitalsinasia, struct("vegetables", {{"Cucumber", "Cabbage"}}));
sprint("combination12: ", jsonstringify(combination12, struct("pretty", {true})));
% combination12: {
%     "Thailand": "Bangkok",
%     "China": "Beijing",
%     "Japan": "Tokyo",
%     "vegetables": [
%         "Cucumber",
%         "Cabbage"
%     ]
% }

sprint(sprintf("\n"), "% { ...object1, ...array2 }:", sprintf("\n"));

combination13 = spreadobject(countrycapitalsinasia, vegetables);
sprint("combination13: ", jsonstringify(combination13, struct("pretty", {true})));
% combination13: {
%     "Thailand": "Bangkok",
%     "China": "Beijing",
%     "Japan": "Tokyo",
%     "index1": "Carrot",
%     "index2": "Tomato"
% }

combination14 = spreadobject(countrycapitalsinasia, {"Cucumber", "Cabbage"});
sprint("combination14: ", jsonstringify(combination14, struct("pretty", {true})));
% combination14: {
%     "Thailand": "Bangkok",
%     "China": "Beijing",
%     "Japan": "Tokyo",
%     "index1": "Carrot",
%     "index2": "Tomato"
% }

% sprint(sprintf("\n"), "% [...array1, ...object1]: % this combination throw an error in JavaScript", sprintf("\n"));

% this combination throw an error in JavaScript
% combinationerrorinjavascript1 = spreadarray(fruits, countrycapitalsinasia);
% sprint("combinationerrorinjavascript1: ", jsonstringify(combinationerrorinjavascript1, struct("pretty", {true})));

% this combination throw an error in JavaScript
% combinationerrorinjavascript2 = spreadarray(fruits, struct("Germany", {"Berlin"}, "Italy", {"Rome"}));
% sprint("combinationerrorinjavascript2: ", jsonstringify(combinationerrorinjavascript2, struct("pretty", {true})));
