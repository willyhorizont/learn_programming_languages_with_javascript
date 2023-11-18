<?php

// ? function statement or function declaration

function get_rectangle_area_v1($rectangle_width, $rectangle_length) {
    return $rectangle_width * $rectangle_length;
}
// call the function example: get_rectangle_area_v1(3, 4)

// ? function expression

$get_rectangle_area_v2 = function ($rectangle_width, $rectangle_length) {
    return $rectangle_width * $rectangle_length;
};
// call the function example: $get_rectangle_area_v2(3, 4)

// ? anonymous function

function ($rectangle_width, $rectangle_length) {
    return $rectangle_width * $rectangle_length;
};

// ? function expression with arrow function or named arrow function

$get_rectangle_area_v3 = fn($rectangle_width, $rectangle_length) => $rectangle_width * $rectangle_length;
// call the function example: $get_rectangle_area_v3(3, 4)

// ? anonymous arrow function

fn($rectangle_width, $rectangle_length) => $rectangle_width * $rectangle_length;

// ? Passing functions as arguments to other functions

function say_hello($callback_function) {
    echo("\nhello");
    $callback_function();
}

function say_how_are_you() {
    echo("\nhow are you?");
}

say_hello("say_how_are_you");

say_hello(function() {
    echo("\nhow are you?");
});

say_hello(fn() => print("\nhow are you?"));

// ? Assigning functions to variables or storing them in data structures

$get_rectangle_area_v2 = function ($rectangle_width, $rectangle_length) {
    return $rectangle_width * $rectangle_length;
};

$get_rectangle_area_v3 = fn($rectangle_width, $rectangle_length) => $rectangle_width * $rectangle_length;

$my_array_of_get_rectangle_area_functions = [
    "get_rectangle_area_v1",
    function ($rectangle_width, $rectangle_length) {
        return $rectangle_width * $rectangle_length;
    },
    fn($rectangle_width, $rectangle_length) => $rectangle_width * $rectangle_length
];

$get_rectangle_area_function_result1 = $my_array_of_get_rectangle_area_functions[0](3, 4);
$get_rectangle_area_function_result2 = $my_array_of_get_rectangle_area_functions[1](3, 4);
$get_rectangle_area_function_result3 = $my_array_of_get_rectangle_area_functions[2](3, 4);

function exponentiation($a, $b) {
    return $a ** $b;
}

$simple_calculator = [
    "exponentiation" => "exponentiation",
    "multiplication" => function ($a, $b) {
        return $a * $b;
    },
    "division" => fn ($a, $b) => $a / $b
];
$simple_calculator_result1 = $simple_calculator["exponentiation"](2, 4);
$simple_calculator_result2 = $simple_calculator["multiplication"](7, 5);
$simple_calculator_result3 = $simple_calculator["division"](81, 9);

// ? Returning functions as values from other functions (closure)

function multiply_v1($a) {
    $multiply_by = function ($b) use ($a) {
        return $a * $b;
    };
    return $multiply_by;
}
$multiply_by2 = multiply_v1(2);
$multiply_by2_result = $multiply_by2(10); // 20

function multiply_v2($a) {
    return function ($b) use ($a) {
        return $a * $b;
    };
}
$multiply_by3 = multiply_v2(3);
$multiply_by3_result = $multiply_by3(10); // 30

function multiply_v3($a) {
    return fn ($b) => $a * $b;
}
$multiply_by4 = multiply_v3(4);
$multiply_by4_result = $multiply_by4(10); // 40

$multiply_v4 = function ($a) {
    $multiply_by = function ($b) use ($a) {
        return $a * $b;
    };
    return $multiply_by;
};
$multiply_by5 = $multiply_v4(5);
$multiply_by5_result = $multiply_by5(10); // 50

$multiply_v5 = function ($a) {
    return function ($b) use ($a) {
        return $a * $b;
    };
};
$multiply_by6 = $multiply_v5(6);
$multiply_by6_result = $multiply_by6(10); // 60

$multiply_v6 = function ($a) {
    return fn ($b) => $a * $b;
};
$multiply_by7 = $multiply_v6(7);
$multiply_by7_result = $multiply_by7(10); // 70

$multiply_v6 = fn ($a) => fn ($b) => $a * $b;
$multiply_by8 = $multiply_v6(8);
$multiply_by8_result = $multiply_by8(10); // 80
