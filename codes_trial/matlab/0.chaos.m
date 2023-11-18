% warning('off', 'all');
% octave --no-gui 0.chaos.m

% this is a single line comment

%{
    this
    is
    a
    multi
    line
    comment 
%}

disp("Hello, World!");

something = 123;
something = "foo";
something = true;
something = {1, 2, 3};
something = struct("foo", "bar");
disp(something);

% map
myDict3 = containers.Map({"name", "country", "age"}, {"Alisa", "Finland", 25});
disp(myDict3("name"));
disp(["class(myDict3):", class(myDict3)]);

% structure
myDict2 = struct("name", "Alisa", "country", "Finland", "age", 25);
disp(myDict2.name);
disp(["class(myDict2):", class(myDict2)]);

% cell array
myArr = {1, 'mango', true, [2, 3, 4], struct("name", "Alisa", "country", "Finland", "age", 25)};
disp(myArr{1});
disp(["class(myArr):", class(myArr)]);

function sayHello(callbackFunction)
    disp("hello");
    callbackFunction();
end

sayHello(@() disp("how are you?"));

function result = getRectangleAreaV1(a, b)
    result = (a * b);
end

getRectangleAreaV2 = @(a, b) (a * b);

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
    % result = [cellfun(@(x) num2str(x), result, 'UniformOutput', false){:}]
    result = [result{:}];
    disp(result);
end

fruits = {'apple', 'mango', 'orange'};
for i = 1:1:length(fruits)
    disp(['Index: ', num2str(i), ', Value: ', fruits{i}]);
end

fruits = {'apple', 'mango', 'orange'};
cellfun(@(value, index) disp(['Index: ', num2str(index), ', Value: ', value]), fruits, num2cell(1:1:length(fruits)));

fruits = {'apple', 'mango', 'orange'};
arrayfun(@(index) disp(['Index: ', num2str(index), ', Value: ', fruits{index}]), 1:1:length(fruits));

% fruits = {'apple', 'mango', 'orange'};
% R2021a and later
% for [index, value] = enumerate(fruits)
%     disp(['Index: ', num2str(index), ', Value: ', value]);
% end

fruits = {'apple', 'mango', 'orange'};
cellfun(@(value, index) disp(['Index: ', num2str(index), ', Value: ', value]), fruits, num2cell(1:1:length(fruits)));

% disp(class(fruits));

myDict2 = struct('name', 'Alisa', 'country', 'Finland', 'age', 25);

% Iterate over fields and get key-value pairs
fields = fieldnames(myDict2);
for i = 1:1:length(fields)
    key = fields{i};
    value = myDict2.(key);
    fprintf('Key: %s, Value: %s\n', key, num2str(value));
end

function isOdd(number)
    if (mod(number, 2) == 0)
        disp("even")
        return
    end
    disp("odd")
end

age = 17;
% canDrive = (age < 17) ? ("true") : ("false");
canDrive = "";
if (age < 17) canDrive = "true"; else canDrive = "false"; end
disp(["asd", canDrive]);

disp(class(true));

hasDrivingLicense = true;
println("hasDrivingLicense: ", hasDrivingLicense);

disp(["asd", true])

% ===============================

myCellArray = {'apple', 'banana', 'cherry'};

index = 4;

if index <= numel(myCellArray)
    disp(myCellArray{index});
else
    disp('Index is out of bounds.');
end

% ===============================

myStruct = struct('field1', struct('field2', 'value'));

if isfield(myStruct, 'field1') && isfield(myStruct.field1, 'field2')
    value = myStruct.field1.field2;
    disp(value);
else
    disp('One of the fields does not exist.');
end

% ===============================

friend = struct( ...
    "name", "Alisa", ...
    "country", "Finland", ...
    "age", 25 ...
);

if isfield(friend, 'birthday')
    disp(friend.birthday);
else
    disp('Birthday field does not exist.');
end

% ===============================

fruits = {"apple", "mango", "orange"};

indexToAccess = 5;

if indexToAccess <= numel(fruits)
    disp(fruits{indexToAccess});
else
    disp('Index is out of bounds.');
end

% ===============================
