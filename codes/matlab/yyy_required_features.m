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

%{
x. variable can store dynamic data type and dynamic value, variable can inferred data type from value, value of variable can be reassign with different data type or has option to make variable can store dynamic data type and dynamic value
%}
something = "foo";
sprint("something: ", jsonstringify(something, struct("pretty", {true})));
something = 123;
sprint("something: ", jsonstringify(something, struct("pretty", {true})));
something = true;
sprint("something: ", jsonstringify(something, struct("pretty", {true})));
something = {};
sprint("something: ", jsonstringify(something, struct("pretty", {true})));
something = {1, 2, 3};
sprint("something: ", jsonstringify(something, struct("pretty", {true})));
something = struct("foo", {"bar"});
sprint("something: ", jsonstringify(something, struct("pretty", {true})));

%{
x. it is possible to access and modify variables defined outside of the current scope within nested functions, so it is possible to have closure too
%}
function getmodifiedindentlevelresult = getmodifiedindentlevel()
    indentlevel = 0;
    function changeindentlevelresult = changeindentlevel()
        indentlevel = indentlevel + 1;
        if (indentlevel < 5)
            changeindentlevel();
        end
        changeindentlevelresult = indentlevel;
    end
    getmodifiedindentlevelresult = changeindentlevel();
end
sprint("getmodifiedindentlevel(): ", {getmodifiedindentlevel()});
function createnewgameresult = createnewgame(initialcredit)
    currentcredit = initialcredit;
    sprint("initial credit: ", {initialcredit});
    function createnewgameinner()
        currentcredit = currentcredit - 1;
        if (currentcredit == 0)
            sprint("not enough credit");
            return;
        end
        sprint("playing game, ", {currentcredit}, " credit(s) remaining");
    end
    createnewgameresult = @createnewgameinner;
end
playgame = createnewgame(3);
playgame();
playgame();
playgame();

%{
x. object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure can store dynamic data type and dynamic value
%}
myobject = struct( ...
    "my_string", {"foo"}, ...
    "my_number", {123}, ...
    "my_boolean", {true}, ...
    "my_null", {{}}, ...
    "my_array", {{1, 2, 3}}, ...
    "my_object", {struct( ...
        "foo", {"bar"} ...
    )} ...
);
sprint("myobject: ", jsonstringify(myobject, struct("pretty", {true})));

%{
x. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
%}
myarray = {"foo", 123, true, {}, {1, 2, 3}, struct("foo", {"bar"})};
sprint("myarray: ", jsonstringify(myarray, struct("pretty", {true})));

%{
x. support passing functions as arguments to other functions
%}
function sayhello(callbackfunction)
    disp("hello");
    callbackfunction();
end
function sayhowareyou()
    disp("how are you?");
end
sayhello(@sayhowareyou);
sayhello(@() disp("how are you?"));

%{
x. support returning functions as values from other functions
%}
function multiplyresult = multiply(a)
    function multiplybyresult = multiplyby(b)
        multiplybyresult = (a * b);
    end
    multiplyresult = @multiplyby;
end
multiplyby2 = multiply(2);
multiplyby2result = multiplyby2(10);
sprint("multiplyby2result: ", {multiplyby2result});

%{
x. support assigning functions to variables
%}
function getrectangleareav1result = getrectangleareav1(rectanglewidth, rectanglelength)
    getrectangleareav1result = (rectanglewidth * rectanglelength);
end
sprint("getrectangleareav1(7, 5): ", {getrectangleareav1(7, 5)});
getrectangleareav2 = @(rectanglewidth, rectanglelength) (rectanglewidth * rectanglelength);
sprint("getrectangleareav2(7, 5): ", {getrectangleareav2(7, 5)});

%{
x. support storing functions in data structures like object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure or array/list/slice/ordered-list-data-structure
%}
myarray2 = { ...
    @(a, b) (a * b), ...
    "foo", ...
    123, ...
    true, ...
    {}, ...
    {1, 2, 3}, ...
    struct("foo", {"bar"}) ...
};
sprint("myArray2[0](7, 5): ", {myarray2{1}(7, 5)});
myobject2 = struct( ...
    "my_function", {@(a, b) (a * b)}, ...
    "my_string", {"foo"}, ...
    "my_number", {123}, ...
    "my_boolean", {true}, ...
    "my_null", {{}}, ...
    "my_array", {{1, 2, 3}}, ...
    "my_object", {struct( ...
        "foo", {"bar"} ...
    )} ...
);
sprint("myObject2[""my_function""](7, 5): ", {myobject2.("my_function")(7, 5)});
