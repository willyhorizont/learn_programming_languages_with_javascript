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

% Array

fruits = {"apple", "mango", "orange"};

println("fruits, length: ", length(fruits));
% fruits, length: 3

println("fruits, get mango: ", fruits{2});
% fruits, get mango: mango

println("fruits, first element: ", fruits{1});
% fruits, first element: apple

println("fruits, last element: ", fruits{end});
% fruits, last element: banana

for arrayItemIndex = 1:1:length(fruits)
    arrayItem = fruits{arrayItemIndex};
    println("fruits, for loop, index: ", arrayItemIndex, ", value: ", arrayItem);
end
% fruits, for loop, index: 1, value: apple
% fruits, for loop, index: 2, value: mango
% fruits, for loop, index: 3, value: orange

% Array of Objects

products = { ...
    struct( ...
        "id", "P1", ...
        "name", "bubble gum" ...
    ), ...
    struct( ...
        "id", "P2", ...
        "name", "potato chips" ...
    ) ...
};

for arrayItemIndex = 1:1:length(products)
    arrayItem = products{arrayItemIndex};
    objectEntries = fieldnames(arrayItem);
    for entryIndex = 1:1:length(objectEntries)
        objectKey = objectEntries{entryIndex};
        objectValue = arrayItem.(objectKey);
        println("products, for loop, index: ", arrayItemIndex, ", key: ", objectKey, ", value: ", objectValue);
    end
end
% products, for loop, index: 1, key: id, value: P1
% products, for loop, index: 1, key: name, value: bubble gum
% products, for loop, index: 2, key: id, value: P2
% products, for loop, index: 2, key: name, value: potato chips
