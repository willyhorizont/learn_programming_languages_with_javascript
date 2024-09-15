function repeat_string_result = repeat_string(a_string, multiplier)
    result = "";
    for to_repeat = 1:1:multiplier % (start:step:stop)
        result = cstrcat(result, a_string);
    end
    repeat_string_result = result;
end

% fprintf("hello\nworld"); % zxc: asd
disp(num2str(true)); % zxc: asd
disp(sprintf("hello\nworld")); % zxc: asd
disp(cstrcat("zxc: ", "asd")); % zxc: asd
disp(plus("zxc: ", "asd")); % zxc: asd
disp(append("zxc: ", "asd")); % zxc: asd
disp(["zxc: ", "asd"]); % "zxc: "    "asd"
disp({1, 2, 3}); % "zxc: "    "asd"

function pretty_json_stringify_result = pretty_json_stringify(anything)
    indent = "    ";
    indent_level = 0;
    function pretty_json_stringify_inner_result = pretty_json_stringify_inner(anything_inner, indent_inner)
        if (isempty(anything_inner))
            disp("isempty(anything_inner)");
            pretty_json_stringify_inner_result = "null";
            return;
        end
        if (ischar(anything_inner))
            disp("ischar(anything_inner)");
            pretty_json_stringify_inner_result = ['"', anything_inner, '"'];
            return;
        end
        if (isnumeric(anything_inner))
            disp("isnumeric(anything_inner)");
            pretty_json_stringify_inner_result = strrep(num2str(anything_inner), ',', '.');
            return;
        end
        if (islogical(anything_inner) && anything_inner == true)
            disp("anything_inner == true");
            pretty_json_stringify_inner_result = "true";
            return;
        end
        if (islogical(anything_inner) && anything_inner == false)
            disp("anything_inner == false");
            pretty_json_stringify_inner_result = "false";
            return;
        end
        if (iscell(anything_inner))
            if (isempty(anything_inner))
                disp("isempty(anything_inner)");
                pretty_json_stringify_inner_result = "[]";
                return;
            end
            disp("iscell(anything_inner)");
            indent_level = indent_level + 1;
            result = cstrcat("[", sprintf("\n"), repeat_string(indent_inner, indent_level));
            % result = ["[", sprintf("\n"), repmat(indent_inner, 1, indent_level)];
            % result = cstrcat("[", sprintf("\n"), repmat(indent_inner, 1, indent_level));
            for array_item_index = 1:numel(anything_inner) % (start:step:stop)
                array_item = anything_inner{array_item_index};
                result = cstrcat(result, pretty_json_stringify_inner(array_item, indent_inner));
                if (array_item_index ~= numel(anything_inner))
                    result = cstrcat(result, ",", sprintf("\n"), repeat_string(indent_inner, indent_level));
                    % result = cstrcat(result, ",", sprintf("\n"), repmat(indent_inner, 1, indent_level));
                end
            end
            indent_level = indent_level - 1;
            result = cstrcat(result, sprintf("\n"), repeat_string(indent_inner, indent_level), "]");
            % result = cstrcat(result, sprintf("\n"), repmat(indent_inner, 1, indent_level), "]");
            pretty_json_stringify_inner_result = result;
            return;
        end
        if (isstruct(anything_inner))
            if (numel(fieldnames(anything_inner)) == 0)
                disp("numel(fieldnames(anything_inner)) == 0");
                pretty_json_stringify_inner_result = "{}";
                return;
            end
            disp("isstruct(anything_inner)");
            indent_level = indent_level + 1;
            result = cstrcat("{", sprintf("\n"), repeat_string(indent_inner, indent_level));
            % result = cstrcat("{", sprintf("\n"), repmat(indent_inner, 1, indent_level));
            % result = ["{", sprintf("\n"), repmat(indent_inner, 1, indent_level)];
            object_entries = fieldnames(anything_inner);
            for object_entry_index = 1:numel(object_entries) % (start:step:stop)
                object_key = object_entries{object_entry_index};
                object_value = anything_inner.(object_key);
                result = cstrcat(result, """", object_key, """: ", pretty_json_stringify_inner(object_value, indent_inner));
                if (object_entry_index ~= numel(object_entries))
                    result = cstrcat(result, ",", sprintf("\n"), repeat_string(indent_inner, indent_level));
                    % result = cstrcat(result, ",", sprintf("\n"), repmat(indent_inner, 1, indent_level));
                end
            end
            indent_level = indent_level - 1;
            result = cstrcat(result, sprintf("\n"), repeat_string(indent_inner, indent_level), "}");
            % result = cstrcat(result, sprintf("\n"), repmat(indent_inner, 1, indent_level), "}");
            pretty_json_stringify_inner_result = result;
            return;
        end
        disp("default");
        pretty_json_stringify_inner_result = "null";
    end
    pretty_json_stringify_result = pretty_json_stringify_inner(anything, indent);
end

something = {1, 2, 3}; % cell array
disp(cstrcat("something: ", pretty_json_stringify(something)));
something = struct("foo", {"bar"});
disp(cstrcat("something: ", pretty_json_stringify(something)));

function result = giveMeRespect1(argument)
    % Custom Error
    if ~strcmp(argument, 'respect')
        error("You should give me ""respect""!");
    end
    result = 'Thank you for giving me "respect"!';
end

try
    disp(giveMeRespect1('love'));
catch exception
    disp(cstrcat('Error: ', exception.message));
end

function result = giveMeRespect2(argument)
    % Custom Error
    if ~strcmp(argument, 'respect')
        exception = MException('Program:generic', 'You should give me "respect"!');
        throw(exception);
    end
    result = 'Thank you for giving me "respect"!';
end

try
    disp(giveMeRespect2('love'));
catch exception
    disp(cstrcat('Error: ', exception.message));
end

disp(cstrcat("zxc: ", "asd")); % zxc: asd
disp(plus("zxc: ", "asd")); % zxc: asd
disp(append("zxc: ", "asd")); % zxc: asd
disp(["zxc: ", "asd"]); % "zxc: "    "asd"
disp({1, 2, 3}); % "zxc: "    "asd"

function pretty_json_stringify_result = pretty_json_stringify2(argument)
    if ((nargin == 0) || (~iscell(argument)))
        pretty_json_stringify_result = "";
        return;
    end
    indent = "    ";
    if ((nargin == 2) && isstruct(argument{2}) && isfield(argument{2}, "indent"))
        indent = argument{2}.indent;
    end
    anything = argument{1};
    indent_level = 0;
    function pretty_json_stringify_inner_result = pretty_json_stringify_inner(anything_inner, indent_inner)
        if (isempty(anything_inner))
            disp("isempty(anything_inner)");
            pretty_json_stringify_inner_result = "null";
            return;
        end
        if (ischar(anything_inner))
            disp("ischar(anything_inner)");
            pretty_json_stringify_inner_result = ['"', anything_inner, '"'];
            return;
        end
        if (isnumeric(anything_inner))
            disp("isnumeric(anything_inner)");
            pretty_json_stringify_inner_result = strrep(num2str(anything_inner), ',', '.');
            return;
        end
        if (islogical(anything_inner) && anything_inner == true)
            disp("anything_inner == true");
            pretty_json_stringify_inner_result = "true";
            return;
        end
        if (islogical(anything_inner) && anything_inner == false)
            disp("anything_inner == false");
            pretty_json_stringify_inner_result = "false";
            return;
        end
        if (iscell(anything_inner))
            if (isempty(anything_inner))
                disp("isempty(anything_inner)");
                pretty_json_stringify_inner_result = "[]";
                return;
            end
            disp("iscell(anything_inner)");
            indent_level = indent_level + 1;
            result = cstrcat("[", sprintf("\n"), repeat_string(indent_inner, indent_level));
            for array_item_index = 1:numel(anything_inner) % (start:step:stop)
                array_item = anything_inner{array_item_index};
                result = cstrcat(result, pretty_json_stringify_inner(array_item, indent_inner));
                if (array_item_index ~= numel(anything_inner))
                    result = cstrcat(result, ",", sprintf("\n"), repeat_string(indent_inner, indent_level));
                end
            end
            indent_level = indent_level - 1;
            result = cstrcat(result, sprintf("\n"), repeat_string(indent_inner, indent_level), "]");
            pretty_json_stringify_inner_result = result;
            return;
        end
        if (isstruct(anything_inner))
            if (numel(fieldnames(anything_inner)) == 0)
                disp("numel(fieldnames(anything_inner)) == 0");
                pretty_json_stringify_inner_result = "{}";
                return;
            end
            disp("isstruct(anything_inner)");
            indent_level = indent_level + 1;
            result = cstrcat("{", sprintf("\n"), repeat_string(indent_inner, indent_level));
            object_entries = fieldnames(anything_inner);
            for object_entry_index = 1:numel(object_entries) % (start:step:stop)
                object_key = object_entries{object_entry_index};
                object_value = anything_inner.(object_key);
                result = cstrcat(result, """", object_key, """: ", pretty_json_stringify_inner(object_value, indent_inner));
                if (object_entry_index ~= numel(object_entries))
                    result = cstrcat(result, ",", sprintf("\n"), repeat_string(indent_inner, indent_level));
                end
            end
            indent_level = indent_level - 1;
            result = cstrcat(result, sprintf("\n"), repeat_string(indent_inner, indent_level), "}");
            pretty_json_stringify_inner_result = result;
            return;
        end
        disp("default");
        pretty_json_stringify_inner_result = "null";
    end
    pretty_json_stringify_result = pretty_json_stringify_inner(anything, indent);
end

function get_modified_indent_level_result = get_modified_indent_level()
    indent_level = 0;
    function change_indent_level_result = change_indent_level()
        indent_level = indent_level + 1;
        if (indent_level < 5)
            change_indent_level();
        end
        change_indent_level_result = indent_level;
    end
    get_modified_indent_level_result = change_indent_level();
end
disp(["get_modified_indent_level: ", get_modified_indent_level()]);

function create_new_game_result = create_new_game(initial_credit)
    current_credit = initial_credit;
    disp(["initial credit: ", initial_credit]);
    function create_new_game_inner()
        current_credit = current_credit - 1;
        if (current_credit == 0)
            disp(["not enough credit"]);
        else
            disp(["playing game, ", current_credit," credit(s) remaining"]);
        end
    end
    create_new_game_result = @create_new_game_inner;
end
play_game = create_new_game(3);
play_game();
play_game();
play_game();


%{
    Relational Operators / Comparison Operators:
    equal to (==) *checks for equality after performing type coercion. It converts operands to the same type before making the comparison.
    not equal to (~=) *checks for inequality after performing type coercion. It converts operands to the same type before making the comparison.
    greater than (>)
    less than (<)
    greater than or equal to (>=)
    less than or equal to (<=)

    Logical Operators:
    Logical AND (&&)
    Logical OR (||)
    Logical NOT (~) 

    if elseif end
    true false
%}

for i = (1:1:5) % (start:step:stop)
    disp(i);
end

n = 1;
while n <= 5
    disp(n);
    n = n + 1;
    % continue;
    % break;
end

function bool2stringresult = bool2string(abool)
    if (islogical(abool) && (abool == true))
        bool2stringresult = "true";
        return;
    end
    if (islogical(abool) && (abool == false))
        bool2stringresult = "false";
        return;
    end
    bool2stringresult = "not bool";
end

something = {"asd", "zxc", "qwe"};
disp(cstrcat("something{2}: ", something{2}));
disp(cstrcat("num2str(length(something)): ", num2str(length(something))));

str1 = "Hello, World!";
% str1 = 'Hello, World!';
str1 = char(str1);
disp(cstrcat("str1: ", str1));
str1length = length(str1);
disp(cstrcat("num2str(str1length): ", num2str(str1length)));
str1firstchar = str1(1);
% str1firstchar = str1{1}(1);
% str1firstchar = char(str1);
% str1firstchar = str1firstchar(1);
disp(cstrcat("str1firstchar: ", str1firstchar));
% str1substr = str1{1}(3:4);
str1substr = str1(3:4);
disp(cstrcat("str1substr: ", str1substr));
str1concat = cstrcat(str1, ' Hi!');
disp(cstrcat("str1concat: ", str1concat));
str1findexof = strfind("fg gds ab dgdgab dgdg bab", 'ab');
disp(cstrcat("str1findexof: ", num2str(str1findexof(1))));
str1include = length(strfind("fg gds ab dgdgab dgdg bab", 'ab')) > 0;
disp(cstrcat("str1include: ", bool2string(str1include)));
str1rep = strrep(str1, 'Hello', 'Yo');
disp(cstrcat("str1rep: ", str1rep));
str1split = strsplit('asd zxc', ' ');
disp(cstrcat("str1split: ", str1split{:}));
str1up = upper(str1);
disp(cstrcat("str1up: ", str1up));
str1low = lower(str1);
disp(cstrcat("str1low: ", str1low));

str2c = 'lorem ipsum';
disp(cstrcat("str2c: ", str2c));
str2s = string(str2c);
disp(cstrcat("str2s: ", str2s));

mydict = struct( ...
    "asd", {"foo"}, ...
    "zxc", {123}, ...
    "qwe", {"rty"} ...
);
disp(cstrcat("mydict.asd: ", mydict.asd));
disp(cstrcat("isfield(mydict, 'asd'): ", bool2string(isfield(mydict, 'asd'))));
mydict = rmfield(mydict, 'zxc');
disp(cstrcat("isfield(mydict, 'zxc'): ", bool2string(isfield(mydict, 'zxc'))));
disp(cstrcat("object.keys() fieldnames(mydict): ", fieldnames(mydict)));

function getrectangleareav1result = getrectangleareav1(rectanglewidth, rectanglelength)
    getrectangleareav1result = rectanglewidth * rectanglelength;
end
disp(num2str(getrectangleareav1(7, 5)));

getrectangleareav2 = @(rectanglewidth, rectanglelength) rectanglewidth * rectanglelength;
disp(num2str(getrectangleareav2(7, 5)));

function consolelog(varargin)
    newarray = {};
    for argumentindex = (1:1:numel(varargin)) % (start:step:stop)
        argument = varargin{argumentindex};
        if (iscell(argument) && (numel(argument) == 1))
            argumentnew = jsonstringify(argument{1});
            argumentnew = strrep(argumentnew, """{", "{");
            argumentnew = strrep(argumentnew, """[", "[");
            argumentnew = strrep(argumentnew, "}""", "}");
            argumentnew = strrep(argumentnew, "]""", "]");
            newarray{end + 1} = argumentnew;
            continue;
        end
        if (~ischar(argument) && ~ischar(argument))
            error("Non string argument must be wrapped in {}");
            continue;
        end
        newarray{end + 1} = argument;
    end
    disp(strjoin(newarray, ''));
end
