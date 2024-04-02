function stringifyresult = stringify(parameter)
    if isempty(parameter)
        stringifyresult = "null";
        return;
    end
    if isstring(parameter)
        stringifyresult = strcat("""", parameter, """");
        return;
    end
    if ischar(parameter)
        stringifyresult = strcat("""", parameter, """");
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
            currentresult = strcat(currentresult, stringify(arrayitem));
            if (arrayitemindex ~= numel(parameter))
                currentresult = strcat(currentresult, ", ");
            end
        end
        stringifyresult = strcat(currentresult, "]");
        return;
    end
    if isstruct(parameter)
        if (numel(fieldnames(parameter)) == 0)
            stringifyresult = "{}";
            return;
        end
        currentresult = "{";
        objectkeys = fieldnames(parameter);
        for objectentryindex = (1:1:numel(objectkeys))
            objectkey = objectkeys{objectentryindex};
            objectvalue = parameter.(objectkey);
            currentresult = strcat(currentresult, """", objectkey, """: ", stringify(objectvalue));
            if (objectentryindex ~= numel(objectkeys))
                currentresult = strcat(currentresult, ",");
            end
        end
        stringifyresult = strcat(currentresult, "}");
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
            currentresult = strcat(currentresult, parameternew);
            continue;
        end
        currentresult = strcat(currentresult, parameter);
    end
    disp(currentresult);
end

function srepeatresult = srepeat(astring, count)
    result = "";
    for i = (1:1:count)
        result = strcat(result, astring);
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
        if isstring(anythinginner)
            prettyjsonstringifyinnerresult = strcat("""", anythinginner, """");
            return;
        end
        if ischar(anythinginner)
            prettyjsonstringifyinnerresult = strcat("""", anythinginner, """");
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
            result = strcat("[", sprintf("\n"), srepeat(indentinner, indentlevel));
            for arrayitemindex = (1:1:numel(anythinginner))
                arrayitem = anythinginner{arrayitemindex};
                result = strcat(result, prettyjsonstringifyinner(arrayitem, indentinner));
                if (arrayitemindex ~= numel(anythinginner))
                    result = strcat(result, ",", sprintf("\n"), srepeat(indentinner, indentlevel));
                end
            end
            indentlevel = indentlevel - 1;
            result = strcat(result, sprintf("\n"), srepeat(indentinner, indentlevel), "]");
            prettyjsonstringifyinnerresult = result;
            return;
        end
        if isstruct(anythinginner)
            if (numel(fieldnames(anythinginner)) == 0)
                prettyjsonstringifyinnerresult = "{}";
                return;
            end
            indentlevel = indentlevel + 1;
            result = strcat("{", sprintf("\n"), srepeat(indentinner, indentlevel));
            objectkeys = fieldnames(anythinginner);
            for objectentryindex = (1:1:numel(objectkeys))
                objectkey = objectkeys{objectentryindex};
                objectvalue = anythinginner.(objectkey);
                result = strcat(result, """", objectkey, """: ", prettyjsonstringifyinner(objectvalue, indentinner));
                if (objectentryindex ~= numel(objectkeys))
                    result = strcat(result, ",", sprintf("\n"), srepeat(indentinner, indentlevel));
                end
            end
            indentlevel = indentlevel - 1;
            result = strcat(result, sprintf("\n"), srepeat(indentinner, indentlevel), "}");
            prettyjsonstringifyinnerresult = result;
            return;
        end
        prettyjsonstringifyinnerresult = "null";
    end
    prettyjsonstringifyresult = prettyjsonstringifyinner(anything, indent);
end

function spreadsyntaxobjectresult = spreadsyntaxobject(varargin)
    newobject = struct();
    for parameterindex = (1:1:numel(varargin))
        parameter = varargin{parameterindex};
        if isstruct(parameter)
            objectkeys = fieldnames(parameter);
            for objectentryindex = (1:1:numel(objectkeys))
                objectkey = objectkeys{objectentryindex};
                objectvalue = parameter.(objectkey);
                newobject.(objectkey) = objectvalue;
            end
            continue;
        end
        if iscell(parameter)
            for arrayitemindex = (1:1:numel(parameter))
                arrayitem = parameter{arrayitemindex};
                newobject.(strcat("index", num2str(arrayitemindex))) = arrayitem;
            end
            continue;
        end
    end
    spreadsyntaxobjectresult = newobject;
end

function spreadsyntaxarrayresult = spreadsyntaxarray(varargin)
    newarray = {};
    for parameterindex = (1:1:numel(varargin))
        parameter = varargin{parameterindex};
        if isstruct(parameter)
            objectkeys = fieldnames(parameter);
            if (numel(objectkeys) == 1)
                for objectentryindex = (1:1:numel(objectkeys))
                    objectkey = objectkeys{objectentryindex};
                    objectvalue = parameter.(objectkey);
                    newarray{end + 1} = objectvalue;
                end
                continue;
            end
            newarray{end + 1} = parameter;
            continue;
        end
        if iscell(parameter)
            for arrayitemindex = (1:1:numel(parameter))
                arrayitem = parameter{arrayitemindex};
                newarray{end + 1} = arrayitem;
            end
            continue;
        end
    end
    spreadsyntaxarrayresult = newarray;
end

sprint(sprintf("\n"), "% JavaScript-like Spread Syntax (...) in Matlab");

% There's no JavaScript-like Spread Syntax (...) in Matlab.
% But, we can create our own function to mimic it in Matlab.

fruits = {"Mango", "Melon", "Banana"};
sprint("fruits: ", {fruits});

vegetables = {"Carrot", "Tomato"};
sprint("vegetables: ", {vegetables});

countrycapitalsinasia = struct( ...
    "Thailand", {"Bangkok"}, ...
    "China", {"Beijing"}, ...
    "Japan", {"Tokyo"} ...
);
sprint("countrycapitalsinasia: ", {prettyjsonstringify({countrycapitalsinasia})});

countrycapitalsineurope = struct( ...
    "France", {"Paris"}, ...
    "England", {"London"} ...
);
sprint("countrycapitalsineurope: ", {prettyjsonstringify({countrycapitalsineurope})});

sprint(sprintf("\n"), "% [...array1, ...array2]:", sprintf("\n"));

combination1 = spreadsyntaxarray(fruits, vegetables);
sprint("combination1: ", prettyjsonstringify({combination1}));
% combination1: [
%     "Mango",
%     "Melon",
%     "Banana",
%     "Carrot",
%     "Tomato"
% ]

combination2 = spreadsyntaxarray(fruits, {"Cucumber", "Cabbage"});
sprint("combination2: ", prettyjsonstringify({combination2}));
% combination2: [
%     "Mango",
%     "Melon",
%     "Banana",
%     "Cucumber",
%     "Cabbage"
% ]

sprint(sprintf("\n"), "% { ...object1, ...object2 }:", sprintf("\n"));

combination3 = spreadsyntaxobject(countrycapitalsinasia, countrycapitalsineurope);
sprint("combination3: ", prettyjsonstringify({combination3}));
% combination3: {
%     "Thailand": "Bangkok",
%     "China": "Beijing",
%     "Japan": "Tokyo",
%     "France": "Paris",
%     "England": "London"
% }

combination4 = spreadsyntaxobject(countrycapitalsinasia, struct("Germany", {"Berlin"}, "Italy", {"Rome"}));
sprint("combination4: ", prettyjsonstringify({combination4}));
% combination4: {
%     "Thailand": "Bangkok",
%     "China": "Beijing",
%     "Japan": "Tokyo",
%     "Germany": "Berlin",
%     "Italy": "Rome"
% }

sprint(sprintf("\n"), "% [...array1, array2] || [...array1, newArrayItem1, newArrayItem2]:", sprintf("\n"));

combination5 = spreadsyntaxarray(fruits, struct("vegetables", {vegetables}));
sprint("combination5: ", prettyjsonstringify({combination5}));
% combination5: [
%     "Mango",
%     "Melon",
%     "Banana",
%     [
%         "Carrot",
%         "Tomato"
%     ]
% ]

combination6 = spreadsyntaxarray(fruits, struct("vegetables", {{"Cucumber", "Cabbage"}}));
sprint("combination6: ", prettyjsonstringify({combination6}));
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

combination7 = spreadsyntaxarray(fruits, struct("countrycapitalsinasia", {countrycapitalsinasia}));
sprint("combination7: ", prettyjsonstringify({combination7}));
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

combination8 = spreadsyntaxarray(fruits, struct("countrycapitalsineurope", {struct("Germany", {"Berlin"}, "Italy", {"Rome"})}));
sprint("combination8: ", prettyjsonstringify({combination8}));
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

combination9 = spreadsyntaxobject(countrycapitalsinasia, struct("countrycapitalsineurope", {countrycapitalsineurope}));
sprint("combination9: ", prettyjsonstringify({combination9}));
% combination9: {
%     "Thailand": "Bangkok",
%     "China": "Beijing",
%     "Japan": "Tokyo",
%     "countrycapitalsineurope": {
%         "France": "Paris",
%         "England": "London"
%     }
% }

combination10 = spreadsyntaxobject(countrycapitalsinasia, struct("countrycapitalsineurope", {struct("Germany", {"Berlin"}, "Italy", {"Rome"})}));
sprint("combination10: ", prettyjsonstringify({combination10}));
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

combination11 = spreadsyntaxobject(countrycapitalsinasia, struct("vegetables", {vegetables}));
sprint("combination11: ", prettyjsonstringify({combination11}));
% combination11: {
%     "Thailand": "Bangkok",
%     "China": "Beijing",
%     "Japan": "Tokyo",
%     "vegetables": [
%         "Carrot",
%         "Tomato"
%     ]
% }

combination12 = spreadsyntaxobject(countrycapitalsinasia, struct("vegetables", {{"Cucumber", "Cabbage"}}));
sprint("combination12: ", prettyjsonstringify({combination12}));
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

combination13 = spreadsyntaxobject(countrycapitalsinasia, vegetables);
sprint("combination13: ", prettyjsonstringify({combination13}));
% combination13: {
%     "Thailand": "Bangkok",
%     "China": "Beijing",
%     "Japan": "Tokyo",
%     "index1": "Carrot",
%     "index2": "Tomato"
% }

combination14 = spreadsyntaxobject(countrycapitalsinasia, {"Cucumber", "Cabbage"});
sprint("combination14: ", prettyjsonstringify({combination14}));
% combination14: {
%     "Thailand": "Bangkok",
%     "China": "Beijing",
%     "Japan": "Tokyo",
%     "index1": "Carrot",
%     "index2": "Tomato"
% }

% sprint(sprintf("\n"), "% [...array1, ...object1]: % this combination throw an error in JavaScript", sprintf("\n"));

% this combination throw an error in JavaScript
% combinationerrorinjavascript1 = spreadsyntaxarray(fruits, countrycapitalsinasia);
% sprint("combinationerrorinjavascript1: ", prettyjsonstringify({combinationerrorinjavascript1}));

% this combination throw an error in JavaScript
% combinationerrorinjavascript2 = spreadsyntaxarray(fruits, struct("Germany", {"Berlin"}, "Italy", {"Rome"}));
% sprint("combinationerrorinjavascript2: ", prettyjsonstringify({combinationerrorinjavascript2}));
