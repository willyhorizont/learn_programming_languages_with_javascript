<?php

echo("\n\n// FizzBuzz(n) in PHP");

function fizzbuzz_v1($stop_number) {
    if (is_numeric($stop_number) === false) return "argument should be a number";
    if ($stop_number < 1) return "argument should be greater than 0";
    $result = "";
    $number = 1;
    while (true) {
        if ($result === "") {
            $result = "$number";
            $number += 1;
            if ($number > $stop_number) break;
            continue;
        }
        if ((($number % 3) === 0) && (($number % 5) === 0)) {
            $result = "$result, FizzBuzz";
            $number += 1;
            if ($number > $stop_number) break;
            continue;
        }
        if (($number % 3) === 0) {
            $result = "$result, Fizz";
            $number += 1;
            if ($number > $stop_number) break;
            continue;
        }
        if (($number % 5) === 0) {
            $result = "$result, Buzz";
            $number += 1;
            if ($number > $stop_number) break;
            continue;
        }
        $result = "$result, $number";
        $number += 1;
        if ($number > $stop_number) break;
    }
    return $result;
};

function fizzbuzz_v2($stop_number) {
    if (is_numeric($stop_number) === false) return "argument should be a number";
    if ($stop_number < 1) return "argument should be greater than 0";
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
    if (is_numeric($stop_number) === false) return "argument should be a number";
    if ($stop_number < 1) return "argument should be greater than 0";
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
        $number += 1;
        if ($number > $stop_number) break;
    }
    return $result;
};

function fizzbuzz_v4($stop_number) {
    if (is_numeric($stop_number) === false) return "argument should be a number";
    if ($stop_number < 1) return "argument should be greater than 0";
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
    if (is_numeric($stop_number) === false) return "argument should be a number";
    if ($stop_number < 1) return "argument should be greater than 0";
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
        $number += 1;
        if ($number > $stop_number) break;
    }
    return $result;
};

function fizzbuzz_v6($stop_number) {
    if (is_numeric($stop_number) === false) return "argument should be a number";
    if ($stop_number < 1) return "argument should be greater than 0";
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
    if (is_numeric($stop_number) === false) return "argument should be a number";
    if ($stop_number < 1) return "argument should be greater than 0";
    $result = "";
    $number = 1;
    while (true) {
        $result = (($result === "") ? "$number" : (((($number % 3) === 0) && (($number % 5) === 0)) ? "$result, FizzBuzz" : ((($number % 3) === 0) ? "$result, Fizz" : ((($number % 5) === 0) ? "$result, Buzz" : "$result, $number"))));
        $number += 1;
        if ($number > $stop_number) break;
    }
    return $result;
};

function fizzbuzz_v8($stop_number) {
    if (is_numeric($stop_number) === false) return "argument should be a number";
    if ($stop_number < 1) return "argument should be greater than 0";
    $result = "";
    $number = 1;
    while ($number <= $stop_number) {
        $result = (($result === "") ? "$number" : (((($number % 3) === 0) && (($number % 5) === 0)) ? "$result, FizzBuzz" : ((($number % 3) === 0) ? "$result, Fizz" : ((($number % 5) === 0) ? "$result, Buzz" : "$result, $number"))));
        $number += 1;
    }
    return $result;
};

function fizzbuzz_v9($stop_number) {
    if (is_numeric($stop_number) === false) return "argument should be a number";
    if ($stop_number < 1) return "argument should be greater than 0";
    $result = "";
    for ($number = 1; $number <= $stop_number; $number += 1) {
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
    if (is_numeric($stop_number) === false) return "argument should be a number";
    if ($stop_number < 1) return "argument should be greater than 0";
    $result = "";
    for ($number = 1; $number <= $stop_number; $number += 1) {
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
    if (is_numeric($stop_number) === false) return "argument should be a number";
    if ($stop_number < 1) return "argument should be greater than 0";
    $result = "";
    for ($number = 1; $number <= $stop_number; $number += 1) {
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
    if (is_numeric($stop_number) === false) return "argument should be a number";
    if ($stop_number < 1) return "argument should be greater than 0";
    $result = "";
    for ($number = 1; $number <= $stop_number; $number += 1) {
        $result = (($result === "") ? "$number" : (((($number % 3) === 0) && (($number % 5) === 0)) ? "$result, FizzBuzz" : ((($number % 3) === 0) ? "$result, Fizz" : ((($number % 5) === 0) ? "$result, Buzz" : "$result, $number"))));
    }
    return $result;
};

$fizzbuzz_v13 = fn($stop_number) => ((is_numeric($stop_number) === false) ? "argument should be a number" : (($stop_number < 1) ? "argument should be greater than 0" : join(", ", array_map(fn($number) => (((($number % 3) === 0) && (($number % 5) === 0)) ? "FizzBuzz" : ((($number % 3) === 0) ? "Fizz" : ((($number % 5) === 0) ? "Buzz" : "$number"))), range(1, $stop_number)))));

$fizzbuzz_v14 = fn($stop_number) => ((is_numeric($stop_number) === false) ? "argument should be a number" : (($stop_number < 1) ? "argument should be greater than 0" : array_reduce(range(1, $stop_number), fn($current_result, $number) => (($current_result === "") ? "$number" : (((($number % 3) === 0) && (($number % 5) === 0)) ? "$current_result, FizzBuzz" : ((($number % 3) === 0) ? "$current_result, Fizz" : ((($number % 5) === 0) ? "$current_result, Buzz" : "$current_result, $number")))), "")));

echo("\n// using fizzbuzz function \"fizzbuzz_v1\"");
echo("\nFizzBuzz(36): " . fizzbuzz_v1(36));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("\n// using fizzbuzz function \"fizzbuzz_v2\"");
echo("\nFizzBuzz(36): " . fizzbuzz_v2(36));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("\n// using fizzbuzz function \"fizzbuzz_v3\"");
echo("\nFizzBuzz(36): " . fizzbuzz_v3(36));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("\n// using fizzbuzz function \"fizzbuzz_v4\"");
echo("\nFizzBuzz(36): " . fizzbuzz_v4(36));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("\n// using fizzbuzz function \"fizzbuzz_v5\"");
echo("\nFizzBuzz(36): " . fizzbuzz_v5(36));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("\n// using fizzbuzz function \"fizzbuzz_v6\"");
echo("\nFizzBuzz(36): " . fizzbuzz_v6(36));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("\n// using fizzbuzz function \"fizzbuzz_v7\"");
echo("\nFizzBuzz(36): " . fizzbuzz_v7(36));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("\n// using fizzbuzz function \"fizzbuzz_v8\"");
echo("\nFizzBuzz(36): " . fizzbuzz_v8(36));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("\n// using fizzbuzz function \"fizzbuzz_v9\"");
echo("\nFizzBuzz(36): " . fizzbuzz_v9(36));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("\n// using fizzbuzz function \"fizzbuzz_v10\"");
echo("\nFizzBuzz(36): " . fizzbuzz_v10(36));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("\n// using fizzbuzz function \"fizzbuzz_v11\"");
echo("\nFizzBuzz(36): " . fizzbuzz_v11(36));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("\n// using fizzbuzz function \"fizzbuzz_v12\"");
echo("\nFizzBuzz(36): " . fizzbuzz_v12(36));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("\n// using fizzbuzz function \"\$fizzbuzz_v13\"");
echo("\nFizzBuzz(36): " . $fizzbuzz_v13(36));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("\n// using fizzbuzz function \"\$fizzbuzz_v14\"");
echo("\nFizzBuzz(36): " . $fizzbuzz_v14(36));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz
