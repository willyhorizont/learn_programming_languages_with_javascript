<?php

echo("\n// Factorial(n) in PHP" . "\n");

function factorial_v1($number) {
    if (is_numeric($number) === false) throw new Exception("Argument should be a number");
    if ($number < 0) throw new Exception("Argument should be >= 0");
    if ($number === 0) return 1;
    $result = 1;
    $i = $number;
    while (true) {
        $result *= $i;
        if ($i <= 1) break;
        $i -= 1;
    }
    return $result;
};

function factorial_v2($number) {
    if (is_numeric($number) === false) throw new Exception("Argument should be a number");
    if ($number < 0) throw new Exception("Argument should be >= 0");
    if ($number === 0) return 1;
    $result = 1;
    $i = $number;
    while ($i >= 1) {
        $result *= $i;
        $i -= 1;
    }
    return $result;
};

function factorial_v3($number) {
    if (is_numeric($number) === false) throw new Exception("Argument should be a number");
    if ($number < 0) throw new Exception("Argument should be >= 0");
    if ($number === 0) return 1;
    $result = 1;
    for ($i = $number; $i >= 1; $i -= 1) {
        $result *= $i;
    }
    return $result;
};

function factorial_v4($number) {
    if (is_numeric($number) === false) throw new Exception("Argument should be a number");
    if ($number < 0) throw new Exception("Argument should be >= 0");
    if ($number === 0) return 1;
    return ($number * factorial_v4($number - 1));
};

echo("// using factorial function \"factorial_v1\"" . "\n");
echo("Factorial(5): " . factorial_v1(5) . "\n");
// Factorial(5): 120

echo("// using factorial function \"factorial_v2\"" . "\n");
echo("Factorial(5): " . factorial_v2(5) . "\n");
// Factorial(5): 120

echo("// using factorial function \"factorial_v3\"" . "\n");
echo("Factorial(5): " . factorial_v3(5) . "\n");
// Factorial(5): 120

echo("// using factorial function \"factorial_v4\"" . "\n");
echo("Factorial(5): " . factorial_v4(5) . "\n");
// Factorial(5): 120
