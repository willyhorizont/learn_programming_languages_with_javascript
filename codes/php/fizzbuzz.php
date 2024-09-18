<?php

function json_stringify($anything, $optional_argument = ["pretty" => false]) {
    return (((@$optional_argument["pretty"] ?? false) === true) ? (str_replace("/\n$/", "", json_encode($anything, JSON_PRETTY_PRINT))) : (str_replace("{", "{ ", str_replace("}", " }", str_replace(",", ", ", str_replace(":", ": ", json_encode($anything)))))));
};

function array_every($callback_function, $an_array) {
    // JavaScript-like Array.every() function array_every_v4
    foreach ($an_array as $array_item_index => $array_item) {
        if ($callback_function($array_item, $array_item_index, $an_array) === false) return false;
    }
    return true;
};

function is_like_js_null($anything) {
    return (((gettype($anything) === "null") || (gettype($anything) === "NULL")) && (is_null($anything) === true) && (isset($anything) === false));
};

function is_like_js_boolean($anything) {
    return (((gettype($anything) === "boolean") || (gettype($anything) === "bool")) && (is_bool($anything) === true) && (($anything === true) || ($anything === false)));
};

function is_like_js_string($anything) {
    return ((gettype($anything) === "string") && (is_string($anything) === true));
};

function is_like_js_numeric($anything) {
    return (((gettype($anything) === "integer") || (gettype($anything) === "int") || (gettype($anything) === "float") || (gettype($anything) === "double")) && ((is_int($anything) === true) || (is_integer($anything) === true) || (is_float($anything) === true) || (is_double($anything) === true)) && (is_numeric($anything) === true));
};

function is_like_js_array($anything) {
    return ((gettype($anything) === "array") && (is_array($anything) === true));
};

function is_like_js_object($anything) {
    if (is_like_js_array($anything) === false) return false;
    return array_every(fn($array_item) => (is_like_js_string($array_item) === true), array_keys($anything));
};

function get_type($anything) {
    if (is_like_js_null($anything) === true) return "Null";
    if (is_like_js_boolean($anything) === true) return "Boolean";
    if (is_like_js_string($anything) === true) return "String";
    if (is_like_js_numeric($anything) === true) return "Numeric";
    if (is_like_js_object($anything) === true) return "Object";
    if (is_like_js_array($anything) === true) return "Array";
    return ucwords(strtolower(gettype($anything)));
};

function string_interpolation(...$rest_arguments) {
    return array_reduce($rest_arguments,  (fn($current_result, $current_argument) => ($current_result . ((get_type($current_argument) === "String") ? ($current_argument) : (((get_type($current_argument) === "Array") && (count($current_argument) === 1)) ? (json_stringify(@$current_argument[0])) : (json_stringify($current_argument)))))), "");
};

function console_log(...$rest_arguments) {
    echo string_interpolation(...$rest_arguments) . "\n";
};

console_log("\n// FizzBuzz(n) in PHP");

function fizzbuzz_v1($stop_number) {
    if (get_type($stop_number) !== "Numeric") throw new Exception("Argument should be a number");
    if ($stop_number < 1) throw new Exception("Argument should be > 0");
    $result = "";
    $number = 1;
    while (true) {
        if ($result === "") {
            $result = string_interpolation([$number]);
            if ($number >= $stop_number) break;
            $number += 1;
            continue;
        }
        if ((($number % 3) === 0) && (($number % 5) === 0)) {
            $result = string_interpolation($result, ", FizzBuzz");
            if ($number >= $stop_number) break;
            $number += 1;
            continue;
        }
        if (($number % 3) === 0) {
            $result = string_interpolation($result, ", Fizz");
            if ($number >= $stop_number) break;
            $number += 1;
            continue;
        }
        if (($number % 5) === 0) {
            $result = string_interpolation($result, ", Buzz");
            if ($number >= $stop_number) break;
            $number += 1;
            continue;
        }
        $result = string_interpolation($result, ", ", [$number]);
        if ($number >= $stop_number) break;
        $number += 1;
    }
    return $result;
};

function fizzbuzz_v2($stop_number) {
    if (get_type($stop_number) !== "Numeric") throw new Exception("Argument should be a number");
    if ($stop_number < 1) throw new Exception("Argument should be > 0");
    $result = "";
    $number = 1;
    while ($number <= $stop_number) {
        if ($result === "") {
            $result = string_interpolation([$number]);
            $number += 1;
            continue;
        }
        if ((($number % 3) === 0) && (($number % 5) === 0)) {
            $result = string_interpolation($result, ", FizzBuzz");
            $number += 1;
            continue;
        }
        if (($number % 3) === 0) {
            $result = string_interpolation($result, ", Fizz");
            $number += 1;
            continue;
        }
        if (($number % 5) === 0) {
            $result = string_interpolation($result, ", Buzz");
            $number += 1;
            continue;
        }
        $result = string_interpolation($result, ", ", [$number]);
        $number += 1;
    }
    return $result;
};

function fizzbuzz_v3($stop_number) {
    if (get_type($stop_number) !== "Numeric") throw new Exception("Argument should be a number");
    if ($stop_number < 1) throw new Exception("Argument should be > 0");
    $result = "";
    $number = 1;
    while (true) {
        if ($result === "") {
            $result = string_interpolation([$number]);
        } elseif ((($number % 3) === 0) && (($number % 5) === 0)) {
            $result = string_interpolation($result, ", FizzBuzz");
        } elseif (($number % 3) === 0) {
            $result = string_interpolation($result, ", Fizz");
        } elseif (($number % 5) === 0) {
            $result = string_interpolation($result, ", Buzz");
        } else {
            $result = string_interpolation($result, ", ", [$number]);
        }
        if ($number >= $stop_number) break;
        $number += 1;
    }
    return $result;
};

function fizzbuzz_v4($stop_number) {
    if (get_type($stop_number) !== "Numeric") throw new Exception("Argument should be a number");
    if ($stop_number < 1) throw new Exception("Argument should be > 0");
    $result = "";
    $number = 1;
    while ($number <= $stop_number) {
        if ($result === "") {
            $result = string_interpolation([$number]);
        } elseif ((($number % 3) === 0) && (($number % 5) === 0)) {
            $result = string_interpolation($result, ", FizzBuzz");
        } elseif (($number % 3) === 0) {
            $result = string_interpolation($result, ", Fizz");
        } elseif (($number % 5) === 0) {
            $result = string_interpolation($result, ", Buzz");
        } else {
            $result = string_interpolation($result, ", ", [$number]);
        }
        $number += 1;
    }
    return $result;
};

function fizzbuzz_v5($stop_number) {
    if (get_type($stop_number) !== "Numeric") throw new Exception("Argument should be a number");
    if ($stop_number < 1) throw new Exception("Argument should be > 0");
    $result = "";
    $number = 1;
    while (true) {
        $result = (($result === "")
            ? string_interpolation([$number])
            : (((($number % 3) === 0) && (($number % 5) === 0))
                ? string_interpolation($result, ", FizzBuzz")
                : ((($number % 3) === 0)
                    ? string_interpolation($result, ", Fizz")
                    : ((($number % 5) === 0)
                        ? string_interpolation($result, ", Buzz")
                        : string_interpolation($result, ", ", [$number])
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
    if (get_type($stop_number) !== "Numeric") throw new Exception("Argument should be a number");
    if ($stop_number < 1) throw new Exception("Argument should be > 0");
    $result = "";
    $number = 1;
    while ($number <= $stop_number) {
        $result = (($result === "")
            ? string_interpolation([$number])
            : (((($number % 3) === 0) && (($number % 5) === 0))
                ? string_interpolation($result, ", FizzBuzz")
                : ((($number % 3) === 0)
                    ? string_interpolation($result, ", Fizz")
                    : ((($number % 5) === 0)
                        ? string_interpolation($result, ", Buzz")
                        : string_interpolation($result, ", ", [$number])
                    )
                )
            )
        );
        $number += 1;
    }
    return $result;
};

function fizzbuzz_v7 ($stop_number) {
    if (get_type($stop_number) !== "Numeric") throw new Exception("Argument should be a number");
    if ($stop_number < 1) throw new Exception("Argument should be > 0");
    $result = "";
    $number = 1;
    while (true) {
        $result = (($result === "") ? string_interpolation([$number]) : (((($number % 3) === 0) && (($number % 5) === 0)) ? string_interpolation($result, ", FizzBuzz") : ((($number % 3) === 0) ? string_interpolation($result, ", Fizz") : ((($number % 5) === 0) ? string_interpolation($result, ", Buzz") : string_interpolation($result, ", ", [$number])))));
        if ($number >= $stop_number) break;
        $number += 1;
    }
    return $result;
};

function fizzbuzz_v8($stop_number) {
    if (get_type($stop_number) !== "Numeric") throw new Exception("Argument should be a number");
    if ($stop_number < 1) throw new Exception("Argument should be > 0");
    $result = "";
    $number = 1;
    while ($number <= $stop_number) {
        $result = (($result === "") ? string_interpolation([$number]) : (((($number % 3) === 0) && (($number % 5) === 0)) ? string_interpolation($result, ", FizzBuzz") : ((($number % 3) === 0) ? string_interpolation($result, ", Fizz") : ((($number % 5) === 0) ? string_interpolation($result, ", Buzz") : string_interpolation($result, ", ", [$number])))));
        $number += 1;
    }
    return $result;
};

function fizzbuzz_v9($stop_number) {
    if (get_type($stop_number) !== "Numeric") throw new Exception("Argument should be a number");
    if ($stop_number < 1) throw new Exception("Argument should be > 0");
    $result = "";
    foreach (range(1, $stop_number, 1) as $number) { // (start, stop, step)
        if ($result === "") {
            $result = string_interpolation([$number]);
            continue;
        }
        if ((($number % 3) === 0) && (($number % 5) === 0)) {
            $result = string_interpolation($result, ", FizzBuzz");
            continue;
        }
        if (($number % 3) === 0) {
            $result = string_interpolation($result, ", Fizz");
            continue;
        }
        if (($number % 5) === 0) {
            $result = string_interpolation($result, ", Buzz");
            continue;
        }
        $result = string_interpolation($result, ", ", [$number]);
    }
    return $result;
};

function fizzbuzz_v10($stop_number) {
    if (get_type($stop_number) !== "Numeric") throw new Exception("Argument should be a number");
    if ($stop_number < 1) throw new Exception("Argument should be > 0");
    $result = "";
    foreach (range(1, $stop_number, 1) as $number) { // (start, stop, step)
        if ($result === "") {
            $result = string_interpolation([$number]);
        } elseif ((($number % 3) === 0) && (($number % 5) === 0)) {
            $result = string_interpolation($result, ", FizzBuzz");
        } elseif (($number % 3) === 0) {
            $result = string_interpolation($result, ", Fizz");
        } elseif (($number % 5) === 0) {
            $result = string_interpolation($result, ", Buzz");
        } else {
            $result = string_interpolation($result, ", ", [$number]);
        }
    }
    return $result;
};

function fizzbuzz_v11($stop_number) {
    if (get_type($stop_number) !== "Numeric") throw new Exception("Argument should be a number");
    if ($stop_number < 1) throw new Exception("Argument should be > 0");
    $result = "";
    foreach (range(1, $stop_number, 1) as $number) { // (start, stop, step)
        $result = (($result === "")
            ? string_interpolation([$number])
            : (((($number % 3) === 0) && (($number % 5) === 0))
                ? string_interpolation($result, ", FizzBuzz")
                : ((($number % 3) === 0)
                    ? string_interpolation($result, ", Fizz")
                    : ((($number % 5) === 0)
                        ? string_interpolation($result, ", Buzz")
                        : string_interpolation($result, ", ", [$number])
                    )
                )
            )
        );
    }
    return $result;
};

function fizzbuzz_v12($stop_number) {
    if (get_type($stop_number) !== "Numeric") throw new Exception("Argument should be a number");
    if ($stop_number < 1) throw new Exception("Argument should be > 0");
    $result = "";
    foreach (range(1, $stop_number, 1) as $number) { // (start, stop, step)
        $result = (($result === "") ? string_interpolation([$number]) : (((($number % 3) === 0) && (($number % 5) === 0)) ? string_interpolation($result, ", FizzBuzz") : ((($number % 3) === 0) ? string_interpolation($result, ", Fizz") : ((($number % 5) === 0) ? string_interpolation($result, ", Buzz") : string_interpolation($result, ", ", [$number])))));
    }
    return $result;
};

function fizzbuzz_v13($stop_number) {
    if (get_type($stop_number) !== "Numeric") throw new Exception("Argument should be a number");
    if ($stop_number < 1) throw new Exception("Argument should be > 0");
    return array_reduce(range(1, $stop_number), fn($current_result, $current_number) => (($current_result === "") ? string_interpolation([$current_number]) : (((($current_number % 3) === 0) && (($current_number % 5) === 0)) ? string_interpolation($current_result, ", FizzBuzz") : ((($current_number % 3) === 0) ? string_interpolation($current_result, ", Fizz") : ((($current_number % 5) === 0) ? string_interpolation($current_result, ", Buzz") : string_interpolation($current_result, ", ", [$current_number]))))), "");
};

console_log('// using fizzbuzz function "fizzbuzz_v1"');
console_log(string_interpolation("FizzBuzz(36): ", [fizzbuzz_v1(36)]));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

console_log('// using fizzbuzz function "fizzbuzz_v2"');
console_log(string_interpolation("FizzBuzz(36): ", [fizzbuzz_v2(36)]));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

console_log('// using fizzbuzz function "fizzbuzz_v3"');
console_log(string_interpolation("FizzBuzz(36): ", [fizzbuzz_v3(36)]));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

console_log('// using fizzbuzz function "fizzbuzz_v4"');
console_log(string_interpolation("FizzBuzz(36): ", [fizzbuzz_v4(36)]));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

console_log('// using fizzbuzz function "fizzbuzz_v5"');
console_log(string_interpolation("FizzBuzz(36): ", [fizzbuzz_v5(36)]));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

console_log('// using fizzbuzz function "fizzbuzz_v6"');
console_log(string_interpolation("FizzBuzz(36): ", [fizzbuzz_v6(36)]));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

console_log('// using fizzbuzz function "fizzbuzz_v7"');
console_log(string_interpolation("FizzBuzz(36): ", [fizzbuzz_v7(36)]));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

console_log('// using fizzbuzz function "fizzbuzz_v8"');
console_log(string_interpolation("FizzBuzz(36): ", [fizzbuzz_v8(36)]));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

console_log('// using fizzbuzz function "fizzbuzz_v9"');
console_log(string_interpolation("FizzBuzz(36): ", [fizzbuzz_v9(36)]));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

console_log('// using fizzbuzz function "fizzbuzz_v10"');
console_log(string_interpolation("FizzBuzz(36): ", [fizzbuzz_v10(36)]));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

console_log('// using fizzbuzz function "fizzbuzz_v11"');
console_log(string_interpolation("FizzBuzz(36): ", [fizzbuzz_v11(36)]));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

console_log('// using fizzbuzz function "fizzbuzz_v12"');
console_log(string_interpolation("FizzBuzz(36): ", [fizzbuzz_v12(36)]));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

console_log('// using fizzbuzz function "fizzbuzz_v13"');
console_log(string_interpolation("FizzBuzz(36): ", [fizzbuzz_v13(36)]));
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz
