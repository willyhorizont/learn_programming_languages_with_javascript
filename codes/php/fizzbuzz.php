<?php

echo("\n// FizzBuzz(n) in PHP" . "\n");

function fizzbuzz_v1($stop_number) {
    if (is_numeric($stop_number) === false) throw new Exception("Argument should be a number");
    if ($stop_number < 1) throw new Exception("Argument should be > 0");
    $result = "";
    $number = 1;
    while (true) {
        if ($result === "") {
            $result = "$number";
            if ($number >= $stop_number) break;
            $number += 1;
            continue;
        }
        if ((($number % 3) === 0) && (($number % 5) === 0)) {
            $result = "$result, FizzBuzz";
            if ($number >= $stop_number) break;
            $number += 1;
            continue;
        }
        if (($number % 3) === 0) {
            $result = "$result, Fizz";
            if ($number >= $stop_number) break;
            $number += 1;
            continue;
        }
        if (($number % 5) === 0) {
            $result = "$result, Buzz";
            if ($number >= $stop_number) break;
            $number += 1;
            continue;
        }
        $result = "$result, $number";
        if ($number >= $stop_number) break;
        $number += 1;
    }
    return $result;
};

function fizzbuzz_v2($stop_number) {
    if (is_numeric($stop_number) === false) throw new Exception("Argument should be a number");
    if ($stop_number < 1) throw new Exception("Argument should be > 0");
    $result = "";
    $number = 1;
    while ($number <= $stop_number) {
        if ($result === "") {
            $result = "$number";
            $number += 1;
            continue;
        }
        if ((($number % 3) === 0) && (($number % 5) === 0)) {
            $result = "$result, FizzBuzz";
            $number += 1;
            continue;
        }
        if (($number % 3) === 0) {
            $result = "$result, Fizz";
            $number += 1;
            continue;
        }
        if (($number % 5) === 0) {
            $result = "$result, Buzz";
            $number += 1;
            continue;
        }
        $result = "$result, $number";
        $number += 1;
    }
    return $result;
};

function fizzbuzz_v3($stop_number) {
    if (is_numeric($stop_number) === false) throw new Exception("Argument should be a number");
    if ($stop_number < 1) throw new Exception("Argument should be > 0");
    $result = "";
    $number = 1;
    while (true) {
        if ($result === "") {
            $result = "$number";
        } elseif ((($number % 3) === 0) && (($number % 5) === 0)) {
            $result = "$result, FizzBuzz";
        } elseif (($number % 3) === 0) {
            $result = "$result, Fizz";
        } elseif (($number % 5) === 0) {
            $result = "$result, Buzz";
        } else {
            $result = "$result, $number";
        }
        if ($number >= $stop_number) break;
        $number += 1;
    }
    return $result;
};

function fizzbuzz_v4($stop_number) {
    if (is_numeric($stop_number) === false) throw new Exception("Argument should be a number");
    if ($stop_number < 1) throw new Exception("Argument should be > 0");
    $result = "";
    $number = 1;
    while ($number <= $stop_number) {
        if ($result === "") {
            $result = "$number";
        } elseif ((($number % 3) === 0) && (($number % 5) === 0)) {
            $result = "$result, FizzBuzz";
        } elseif (($number % 3) === 0) {
            $result = "$result, Fizz";
        } elseif (($number % 5) === 0) {
            $result = "$result, Buzz";
        } else {
            $result = "$result, $number";
        }
        $number += 1;
    }
    return $result;
};

function fizzbuzz_v5($stop_number) {
    if (is_numeric($stop_number) === false) throw new Exception("Argument should be a number");
    if ($stop_number < 1) throw new Exception("Argument should be > 0");
    $result = "";
    $number = 1;
    while (true) {
        $result = (($result === "")
            ? "$number"
            : (((($number % 3) === 0) && (($number % 5) === 0))
                ? "$result, FizzBuzz"
                : ((($number % 3) === 0)
                    ? "$result, Fizz"
                    : ((($number % 5) === 0)
                        ? "$result, Buzz"
                        : "$result, $number"
                    )
                )
            )
        );
        if ($number >= $stop_number) break;
        $number += 1;
    }
    return $result;
};

function fizzbuzz_v6($stop_number) {
    if (is_numeric($stop_number) === false) throw new Exception("Argument should be a number");
    if ($stop_number < 1) throw new Exception("Argument should be > 0");
    $result = "";
    $number = 1;
    while ($number <= $stop_number) {
        $result = (($result === "")
            ? "$number"
            : (((($number % 3) === 0) && (($number % 5) === 0))
                ? "$result, FizzBuzz"
                : ((($number % 3) === 0)
                    ? "$result, Fizz"
                    : ((($number % 5) === 0)
                        ? "$result, Buzz"
                        : "$result, $number"
                    )
                )
            )
        );
        $number += 1;
    }
    return $result;
};

function fizzbuzz_v7 ($stop_number) {
    if (is_numeric($stop_number) === false) throw new Exception("Argument should be a number");
    if ($stop_number < 1) throw new Exception("Argument should be > 0");
    $result = "";
    $number = 1;
    while (true) {
        $result = (($result === "") ? "$number" : (((($number % 3) === 0) && (($number % 5) === 0)) ? "$result, FizzBuzz" : ((($number % 3) === 0) ? "$result, Fizz" : ((($number % 5) === 0) ? "$result, Buzz" : "$result, $number"))));
        if ($number >= $stop_number) break;
        $number += 1;
    }
    return $result;
};

function fizzbuzz_v8($stop_number) {
    if (is_numeric($stop_number) === false) throw new Exception("Argument should be a number");
    if ($stop_number < 1) throw new Exception("Argument should be > 0");
    $result = "";
    $number = 1;
    while ($number <= $stop_number) {
        $result = (($result === "") ? "$number" : (((($number % 3) === 0) && (($number % 5) === 0)) ? "$result, FizzBuzz" : ((($number % 3) === 0) ? "$result, Fizz" : ((($number % 5) === 0) ? "$result, Buzz" : "$result, $number"))));
        $number += 1;
    }
    return $result;
};

function fizzbuzz_v9($stop_number) {
    if (is_numeric($stop_number) === false) throw new Exception("Argument should be a number");
    if ($stop_number < 1) throw new Exception("Argument should be > 0");
    $result = "";
    foreach (range(1, $stop_number, 1) as $number) { // (start, stop, step)
        if ($result === "") {
            $result = "$number";
            continue;
        }
        if ((($number % 3) === 0) && (($number % 5) === 0)) {
            $result = "$result, FizzBuzz";
            continue;
        }
        if (($number % 3) === 0) {
            $result = "$result, Fizz";
            continue;
        }
        if (($number % 5) === 0) {
            $result = "$result, Buzz";
            continue;
        }
        $result = "$result, $number";
    }
    return $result;
};

function fizzbuzz_v10($stop_number) {
    if (is_numeric($stop_number) === false) throw new Exception("Argument should be a number");
    if ($stop_number < 1) throw new Exception("Argument should be > 0");
    $result = "";
    foreach (range(1, $stop_number, 1) as $number) { // (start, stop, step)
        if ($result === "") {
            $result = "$number";
        } elseif ((($number % 3) === 0) && (($number % 5) === 0)) {
            $result = "$result, FizzBuzz";
        } elseif (($number % 3) === 0) {
            $result = "$result, Fizz";
        } elseif (($number % 5) === 0) {
            $result = "$result, Buzz";
        } else {
            $result = "$result, $number";
        }
    }
    return $result;
};

function fizzbuzz_v11($stop_number) {
    if (is_numeric($stop_number) === false) throw new Exception("Argument should be a number");
    if ($stop_number < 1) throw new Exception("Argument should be > 0");
    $result = "";
    foreach (range(1, $stop_number, 1) as $number) { // (start, stop, step)
        $result = (($result === "")
            ? "$number"
            : (((($number % 3) === 0) && (($number % 5) === 0))
                ? "$result, FizzBuzz"
                : ((($number % 3) === 0)
                    ? "$result, Fizz"
                    : ((($number % 5) === 0)
                        ? "$result, Buzz"
                        : "$result, $number"
                    )
                )
            )
        );
    }
    return $result;
};

function fizzbuzz_v12($stop_number) {
    if (is_numeric($stop_number) === false) throw new Exception("Argument should be a number");
    if ($stop_number < 1) throw new Exception("Argument should be > 0");
    $result = "";
    foreach (range(1, $stop_number, 1) as $number) { // (start, stop, step)
        $result = (($result === "") ? "$number" : (((($number % 3) === 0) && (($number % 5) === 0)) ? "$result, FizzBuzz" : ((($number % 3) === 0) ? "$result, Fizz" : ((($number % 5) === 0) ? "$result, Buzz" : "$result, $number"))));
    }
    return $result;
};

function fizzbuzz_v13($stop_number) {
    if (is_numeric($stop_number) === false) throw new Exception("Argument should be a number");
    if ($stop_number < 1) throw new Exception("Argument should be > 0");
    return array_reduce(range(1, $stop_number), fn($current_result, $current_number) => (($current_result === "") ? "$current_number" : (((($current_number % 3) === 0) && (($current_number % 5) === 0)) ? "$current_result, FizzBuzz" : ((($current_number % 3) === 0) ? "$current_result, Fizz" : ((($current_number % 5) === 0) ? "$current_result, Buzz" : "$current_result, $current_number")))), "");
};

echo("// using fizzbuzz function \"fizzbuzz_v1\"" . "\n");
echo("FizzBuzz(36): " . fizzbuzz_v1(36) . "\n");
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("// using fizzbuzz function \"fizzbuzz_v2\"" . "\n");
echo("FizzBuzz(36): " . fizzbuzz_v2(36) . "\n");
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("// using fizzbuzz function \"fizzbuzz_v3\"" . "\n");
echo("FizzBuzz(36): " . fizzbuzz_v3(36) . "\n");
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("// using fizzbuzz function \"fizzbuzz_v4\"" . "\n");
echo("FizzBuzz(36): " . fizzbuzz_v4(36) . "\n");
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("// using fizzbuzz function \"fizzbuzz_v5\"" . "\n");
echo("FizzBuzz(36): " . fizzbuzz_v5(36) . "\n");
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("// using fizzbuzz function \"fizzbuzz_v6\"" . "\n");
echo("FizzBuzz(36): " . fizzbuzz_v6(36) . "\n");
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("// using fizzbuzz function \"fizzbuzz_v7\"" . "\n");
echo("FizzBuzz(36): " . fizzbuzz_v7(36) . "\n");
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("// using fizzbuzz function \"fizzbuzz_v8\"" . "\n");
echo("FizzBuzz(36): " . fizzbuzz_v8(36) . "\n");
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("// using fizzbuzz function \"fizzbuzz_v9\"" . "\n");
echo("FizzBuzz(36): " . fizzbuzz_v9(36) . "\n");
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("// using fizzbuzz function \"fizzbuzz_v10\"" . "\n");
echo("FizzBuzz(36): " . fizzbuzz_v10(36) . "\n");
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("// using fizzbuzz function \"fizzbuzz_v11\"" . "\n");
echo("FizzBuzz(36): " . fizzbuzz_v11(36) . "\n");
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("// using fizzbuzz function \"fizzbuzz_v12\"" . "\n");
echo("FizzBuzz(36): " . fizzbuzz_v12(36) . "\n");
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("// using fizzbuzz function \"\$fizzbuzz_v13\"" . "\n");
echo("FizzBuzz(36): " . fizzbuzz_v13(36) . "\n");
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz
