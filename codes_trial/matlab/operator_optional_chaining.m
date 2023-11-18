function println(varargin)
    result = {};
    for parameterIndex = 1:1:length(varargin)
        if isa(varargin{parameterIndex}, "double")
            result = [result, num2str(varargin{parameterIndex})];
            continue
        end
        if (varargin{parameterIndex} == true)
            result = [result, "true"];
            continue
        end
        if (varargin{parameterIndex} == false)
            result = [result, "false"];
            continue
        end
        result = [result, varargin{parameterIndex}];
    end
    result = [result{:}];
    disp(result);
end

function prettyJsonStringifyResult = prettyJsonStringify(parameter)
    if ((nargin == 0) || (isa(parameter, "cell") == false))
        prettyJsonStringifyResult = "";
        return
    end
    indent = "    ";
    if ((nargin == 2) && (isa(parameter{2}, "struct") == true) && isfield(parameter{2}, "indent") == true)
        indent = parameter.indent;
    end
    anything = parameter{1};
    indentLevel = 0;
    function prettyJsonStringifyInnerFunctionResult = prettyJsonStringifyInnerFunction(anything, indent)
        if (anything == "null")
            prettyJsonStringifyInnerFunctionResult = "null";
            return
        end
        if (anything == "undefined")
            prettyJsonStringifyInnerFunctionResult = "undefined";
            return
        end
        if (isa(anything, "char") == true)
            prettyJsonStringifyInnerFunctionResult = ["""", anything, """"];
            return
        end
        if (isa(anything, "double") == true)
            prettyJsonStringifyInnerFunctionResult = num2str(anything);
            return
        end
        if (anything == true)
            prettyJsonStringifyInnerFunctionResult = "true";
            return
        end
        if (anything == false)
            prettyJsonStringifyInnerFunctionResult = "false";
            return
        end
        if (isa(anything, "cell") == true)
            prettyJsonStringifyInnerFunctionResult = "cell";
            return
        end
        if (isa(anything, "struct") == true)
            prettyJsonStringifyInnerFunctionResult = "struct";
            return
        end
        prettyJsonStringifyInnerFunctionResult = "undefined";
    end
    prettyJsonStringifyResult = prettyJsonStringifyInnerFunction(anything, indent);
end
% asd = prettyJsonStringify({"qwe", 2});
% println("hello ", asd);
% println(asd);
% println(class({1, 2, 3}));
% disp(class("asd"));

println("\n\% JavaScript-like Optional Chaining Operator (?.) in MATLAB");

% There's no JavaScript-like Optional Chaining Operator (?.) in MATLAB.
% But, we can create our own function to mimic it in MATLAB.

JSON_OBJECT = { ...
    struct( ...
        "foo", struct( ...
            "bar", "baz" ...
        ) ...
    ), ...
    struct( ...
        "fruits", {"apple", "mango", "banana"} ...
    ) ...
};
