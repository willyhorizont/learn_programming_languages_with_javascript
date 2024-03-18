% ? function statement or function declaration

function getrectangleareav1result = getrectangleareav1(rectanglewidth, rectanglelength)
    getrectangleareav1result = (rectanglewidth * rectanglelength);
end
% call the function example: getrectangleareav1(7, 5)

% ? function expression

getrectangleareav2 = @(rectanglewidth, rectanglelength) (rectanglewidth * rectanglelength);
% call the function example: getrectangleareav2(7, 5)

% ? anonymous function

@(rectanglewidth, rectanglelength) (rectanglewidth * rectanglelength);

% ? Passing functions as arguments to other functions

function sayhello(callbackfunction)
    disp("hello");
    callbackfunction();
end

function sayhowareyou()
    disp("how are you?");
end

sayhello(@sayhowareyou);

sayhello(@() disp("how are you?"));

% ? Assigning functions to variables or storing them in data structures

getrectangleareav2 = @(rectanglewidth, rectanglelength) (rectanglewidth * rectanglelength);

myarrayofgetrectangleareafunctions = { ...
    @getrectangleareav1, ...
    getrectangleareav2, ...
    @(rectanglewidth, rectanglelength) (rectanglewidth * rectanglelength) ...
};
getrectangleareafunctionresult1 = myarrayofgetrectangleareafunctions{1}(7, 5);
getrectangleareafunctionresult2 = myarrayofgetrectangleareafunctions{2}(7, 5);
getrectangleareafunctionresult3 = myarrayofgetrectangleareafunctions{3}(7, 5);

function exponentiationresult = exponentiation(a, b)
    exponentiationresult = (a ^ b);
end

simplecalculator = struct( ...
    "exponentiation", {@exponentiation}, ...
    "multiplication", {@(a, b) (a * b)} ...
);
simplecalculatorresult1 = simplecalculator.("exponentiation")(2, 4);
simplecalculatorresult2 = simplecalculator.("multiplication")(7, 5);

function multiplyresult = multiplyv1(a)
    function multiplybyresult = multiplyby(b)
        multiplybyresult = (a * b);
    end
    multiplyresult = @multiplyby;
end
multiplyby2 = multiplyv1(2);
multiplyby2result = multiplyby2(10); % 20

function multiplyresult = multiplyv2(a)
    multiplyresult = @(b) (a * b);
end
multiplyby3 = multiplyv2(3);
multiplyby3result = multiplyby3(10); % 30

multiplyv3 = @(a) (@(b) (a * b));
multiplyby4 = multiplyv3(4);
multiplyby4result = multiplyby4(10); % 40
