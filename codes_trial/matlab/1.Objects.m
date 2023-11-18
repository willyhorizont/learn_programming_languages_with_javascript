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

friend = struct( ...
    "name", "Alisa", ...
    "country", "Finland", ...
    "age", 25 ...
);

println("friend, get country: ", friend.country);
% friend, get country: Finland

% iterate over and get each key-value pair and iteration/entry index
objectEntries = fieldnames(friend);
for entryIndex = 1:1:length(objectEntries)
    objectKey = objectEntries{entryIndex};
    objectValue = friend.(objectKey);
    println("products, for loop, index: ", entryIndex, ", key: ", objectKey, ", value: ", objectValue);
end
% products, for loop, index: 1, key: name, value: Alisa
% products, for loop, index: 2, key: country, value: Finland
% products, for loop, index: 3, key: age, value: 25
