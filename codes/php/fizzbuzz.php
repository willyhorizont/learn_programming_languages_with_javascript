<?php

echo("\n\n// FizzBuzz(n) in PHP");

function fizzbuzz_v1($stop_number) {
    if (is_numeric($stop_number) === false) throw new Exception("Argument should be a number");
    if ($stop_number < 1) throw new Exception("Argument should be > 0");
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
        $number += 1;
        if ($number > $stop_number) break;
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
        $number += 1;
        if ($number > $stop_number) break;
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
        $number += 1;
        if ($number > $stop_number) break;
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
    if (is_numeric($stop_number) === false) throw new Exception("Argument should be a number");
    if ($stop_number < 1) throw new Exception("Argument should be > 0");
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
    if (is_numeric($stop_number) === false) throw new Exception("Argument should be a number");
    if ($stop_number < 1) throw new Exception("Argument should be > 0");
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
    if (is_numeric($stop_number) === false) throw new Exception("Argument should be a number");
    if ($stop_number < 1) throw new Exception("Argument should be > 0");
    $result = "";
    for ($number = 1; $number <= $stop_number; $number += 1) {
        $result = (($result === "") ? "$number" : (((($number % 3) === 0) && (($number % 5) === 0)) ? "$result, FizzBuzz" : ((($number % 3) === 0) ? "$result, Fizz" : ((($number % 5) === 0) ? "$result, Buzz" : "$result, $number"))));
    }
    return $result;
};

function fizzbuzz_v13($stop_number) {
    if (is_numeric($stop_number) === false) throw new Exception("Argument should be a number");
    if ($stop_number < 1) throw new Exception("Argument should be > 0");
    return array_reduce(range(1, $stop_number), fn($result, $number) => (($result === "") ? "$number" : (((($number % 3) === 0) && (($number % 5) === 0)) ? "$result, FizzBuzz" : ((($number % 3) === 0) ? "$result, Fizz" : ((($number % 5) === 0) ? "$result, Buzz" : "$result, $number")))), "");
};

echo("\n// using fizzbuzz function \"fizzbuzz_v1\"");
echo("\n" . "FizzBuzz(36): " . fizzbuzz_v1(36));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("\n// using fizzbuzz function \"fizzbuzz_v2\"");
echo("\n" . "FizzBuzz(36): " . fizzbuzz_v2(36));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("\n// using fizzbuzz function \"fizzbuzz_v3\"");
echo("\n" . "FizzBuzz(36): " . fizzbuzz_v3(36));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("\n// using fizzbuzz function \"fizzbuzz_v4\"");
echo("\n" . "FizzBuzz(36): " . fizzbuzz_v4(36));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("\n// using fizzbuzz function \"fizzbuzz_v5\"");
echo("\n" . "FizzBuzz(36): " . fizzbuzz_v5(36));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("\n// using fizzbuzz function \"fizzbuzz_v6\"");
echo("\n" . "FizzBuzz(36): " . fizzbuzz_v6(36));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("\n// using fizzbuzz function \"fizzbuzz_v7\"");
echo("\n" . "FizzBuzz(36): " . fizzbuzz_v7(36));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("\n// using fizzbuzz function \"fizzbuzz_v8\"");
echo("\n" . "FizzBuzz(36): " . fizzbuzz_v8(36));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("\n// using fizzbuzz function \"fizzbuzz_v9\"");
echo("\n" . "FizzBuzz(36): " . fizzbuzz_v9(36));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("\n// using fizzbuzz function \"fizzbuzz_v10\"");
echo("\n" . "FizzBuzz(36): " . fizzbuzz_v10(36));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("\n// using fizzbuzz function \"fizzbuzz_v11\"");
echo("\n" . "FizzBuzz(36): " . fizzbuzz_v11(36));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("\n// using fizzbuzz function \"fizzbuzz_v12\"");
echo("\n" . "FizzBuzz(36): " . fizzbuzz_v12(36));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

echo("\n// using fizzbuzz function \"\$fizzbuzz_v13\"");
echo("\n" . "FizzBuzz(36): " . fizzbuzz_v13(36));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz
