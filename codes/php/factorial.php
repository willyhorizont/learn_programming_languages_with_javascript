<?php

echo("\n\n// Factorial(n) in PHP");

function factorial_v1($number) {
    if (is_numeric($number) === false) return "argument should be a number";
    if (($number > 1) === false) return 1;
    $result = 1;
    for ($i = $number; $i >= 1; $i -= 1) {
        $result *= $i;
    }
    return $result;
};

function factorial_v2($number) {
    if (is_numeric($number) === false) return "argument should be a number";
    if (($number > 1) === false) return 1;
    $result = 1;
    $i = $number;
    while (true) {
        $result *= $i;
        $i -= 1;
        if ($i <= 0) break;
    }
    return $result;
};

function factorial_v3($number) {
    if (is_numeric($number) === false) return "argument should be a number";
    if (($number > 1) === false) return 1;
    $result = 1;
    $i = $number;
    while ($i >= 1) {
        $result *= $i;
        $i -= 1;
    }
    return $result;
};

echo("\n// using factorial function \"factorial_v1\"");
echo("\nFactorial(5): " . factorial_v1(5));
// Factorial(5): 120

echo("\n// using factorial function \"factorial_v2\"");
echo("\nFactorial(5): " . factorial_v2(5));
// Factorial(5): 120

echo("\n// using factorial function \"factorial_v3\"");
echo("\nFactorial(5): " . factorial_v3(5));
// Factorial(5): 120
