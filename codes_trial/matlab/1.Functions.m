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

% ? function statement or function declaration

function result = getRectangleAreaV1(rectangleWidth, rectangleLength)
    result = rectangleWidth * rectangleLength;
end
% call the function example: getRectangleAreaV1(3, 4)

% ? function expression with anonymous function

getRectangleAreaV2 = @(rectangleWidth, rectangleLength) rectangleWidth * rectangleLength;
% call the function example: getRectangleAreaV2(3, 4)

% ? anonymous function
@(rectangleWidth, rectangleLength) rectangleWidth * rectangleLength;

% ? Passing functions as arguments to other functions

function sayHello(callbackFunction)
    println("hello");
    callbackFunction();
end

function sayHowAreYou()
    println("how are you?");
end

sayHello(@sayHowAreYou);

sayHello(@() println("how are you?"));

% ? Assigning functions to variables or storing them in data structures

getRectangleAreaV2 = @(rectangleWidth, rectangleLength) rectangleWidth * rectangleLength;

myArrayOfGetRectangleAreaFunctions = { ...
    @getRectangleAreaV1, ...
    @(rectangleWidth, rectangleLength) rectangleWidth * rectangleLength ...
};
getRectangleAreaFunctionResult1 = myArrayOfGetRectangleAreaFunctions{1}(3, 4);
getRectangleAreaFunctionResult2 = myArrayOfGetRectangleAreaFunctions{2}(3, 4);

function result = exponentiation(a, b)
    result = a ^ b;
end

simpleCalculator = struct( ...
    "exponentiation", @exponentiation, ...
    "addition", @(a, b) a + b ...
);
simpleCalculatorResult1 = simpleCalculator.exponentiation(2, 4);
simpleCalculatorResult2 = simpleCalculator.addition(9, 3);

% ? Returning functions as values from other functions (closure)

function result = multiplyV1(a)
    multiplyBy = @(b) a * b;
    result = multiplyBy;
end
multiplyBy2 = multiplyV1(2);
multiplyBy2Result = multiplyBy2(10); % 20

function result = multiplyV2(a)
    result = @(b) a * b;
end
multiplyBy3 = multiplyV2(3);
multiplyBy3Result = multiplyBy3(10); % 30

multiplyV3 = @(a) @(b) a * b;
multiplyBy4 = multiplyV3(4);
multiplyBy4Result = multiplyBy4(10); % 40
