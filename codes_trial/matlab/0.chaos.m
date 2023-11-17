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

% map
myDict3 = containers.Map({"name", "country", "age"}, {"Alisa", "Finland", 25});
disp(myDict3("name"));

something = 123;
something = "foo";
something = true;
something = {1, 2, 3};
something = struct("foo", "bar");
disp(something);

% structure
myDict2 = struct("name", "Alisa", "country", "Finland", "age", 25);
disp(myDict2.name);

% cell array
myArr = {1, 'mango', true, [2, 3, 4], struct("name", "Alisa", "country", "Finland", "age", 25)};
disp(myArr{1});

function sayHello(callbackFunction)
    disp("hello");
    callbackFunction();
end

sayHello(@() disp("how are you?"));

input("\b");
