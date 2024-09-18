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

/*
    Relational Operators / Comparison Operators:
    equal to (==) *checks for equality after performing type coercion. It converts operands to the same type before making the comparison.
    not equal to (!=) *checks for inequality after performing type coercion. It converts operands to the same type before making the comparison.
    identical to (===) *checks for strict equality without type coercion. It requires both the value and the type to be the same.
    not identical to (!==) *checks for strict inequality without type coercion. It requires both the value and the type to be the same.
    greater than (>)
    less than (<)
    greater than or equal to (>=)
    less than or equal to (<=)

    Logical Operators:
    Logical AND [&&, and]
    Logical OR [||, or]
    Logical NOT (!)
*/

console_log("\n// basic conditional control flow");

$my_age = 10;
console_log(string_interpolation('$my_age: ', [$my_age]));
if ($my_age > 24) {
    console_log("you are old");
} elseif ($my_age > 17) {
    console_log("you are young");
} else {
    console_log("you are under age");
}

console_log("\n// equal to (==)");

$CORRECT_ANSWER = 100;
$my_answer = "100";
console_log(string_interpolation('$my_answer: ', [$my_answer]));
console_log(string_interpolation('$CORRECT_ANSWER: ', [$CORRECT_ANSWER]));
console_log('($my_answer == $CORRECT_ANSWER): ');
if ($my_answer == $CORRECT_ANSWER) {
    console_log("Your answer is correct");
} else {
    console_log("Your answer is wrong");
}

console_log("\n// not equal to (!=)");

$CORRECT_ANSWER = 100;
$my_answer = "25";
console_log(string_interpolation('$my_answer: ', [$my_answer]));
console_log(string_interpolation('$CORRECT_ANSWER: ', [$CORRECT_ANSWER]));
console_log('($my_answer != $CORRECT_ANSWER): ');
if ($my_answer != $CORRECT_ANSWER) {
    console_log("Your answer is correct");
} else {
    console_log("Your answer is wrong");
}

console_log("\n// identical to (===)");

$CORRECT_ANSWER = 100;
$my_answer = "100";
console_log(string_interpolation('$my_answer: ', [$my_answer]));
console_log(string_interpolation('$CORRECT_ANSWER: ', [$CORRECT_ANSWER]));
console_log('($my_answer === $CORRECT_ANSWER): ');
if ($my_answer === $CORRECT_ANSWER) {
    console_log("Your answer is correct");
} else {
    console_log("Your answer is wrong");
}

console_log("\n// not identical to (!==)");

$CORRECT_ANSWER = 100;
$my_answer = "25";
console_log(string_interpolation('$my_answer: ', [$my_answer]));
console_log(string_interpolation('$CORRECT_ANSWER: ', [$CORRECT_ANSWER]));
console_log('($my_answer !== $CORRECT_ANSWER): ');
if ($my_answer !== $CORRECT_ANSWER) {
    console_log("Your answer is correct");
} else {
    console_log("Your answer is wrong");
}

console_log("\n// greater than (>)");

$my_age = 70;
console_log(string_interpolation('$my_age: ', [$my_age]));
console_log('($my_age > 50): ');
if ($my_age > 50) console_log("You are old");

console_log("\n// less than (<)");

$my_age = 16;
console_log(string_interpolation('$my_age: ', [$my_age]));
console_log('($my_age < 20): ');
if ($my_age < 20) console_log("You are young");

console_log("\n// greater than or equal to (>=)");

$my_age = 73;
console_log(string_interpolation('$my_age: ', [$my_age]));
console_log('($my_age >= 65): ');
if ($my_age >= 65) console_log("You are allowed to retire");

console_log("\n// less than or equal to (<=)");

$my_age = 14; 
console_log(string_interpolation('$my_age: ', [$my_age]));
console_log('($my_age <= 16): ');
if ($my_age <= 16) console_log("You are not allowed to drive");

console_log('\n// Logical AND ["&&", "and"]');

$my_age = 17;
console_log(string_interpolation('$my_age: ', [$my_age]));
$has_driving_license = false;
console_log(string_interpolation('$has_driving_license: ', [$has_driving_license]));
console_log('(($my_age >= 17) && ($has_driving_license === true)): ');
console_log(((($my_age >= 17) && ($has_driving_license === true)) ? "You are allowed to drive" : "You are not allowed to drive"));

$my_age = 17;
console_log(string_interpolation('$my_age: ', [$my_age]));
$has_driving_license = true;
console_log(string_interpolation('$has_driving_license: ', [$has_driving_license]));
console_log('(($my_age >= 17) && ($has_driving_license === true)): ');
console_log(((($my_age >= 17) && ($has_driving_license === true)) ? "You are allowed to drive" : "You are not allowed to drive"));

$my_age = 17;
console_log(string_interpolation('$my_age: ', [$my_age]));
$has_driving_license = false;
console_log(string_interpolation('$has_driving_license: ', [$has_driving_license]));
console_log('(($my_age >= 17) and ($has_driving_license === true)): ');
console_log(((($my_age >= 17) and ($has_driving_license === true)) ? "You are allowed to drive" : "You are not allowed to drive"));

$my_age = 17;
console_log(string_interpolation('$my_age: ', [$my_age]));
$has_driving_license = true;
console_log(string_interpolation('$has_driving_license: ', [$has_driving_license]));
console_log('(($my_age >= 17) and ($has_driving_license === true)): ');
console_log(((($my_age >= 17) and ($has_driving_license === true)) ? "You are allowed to drive" : "You are not allowed to drive"));

console_log('\n// Logical OR ["||", "or"]');

$my_age = 2;
console_log(string_interpolation('$my_age: ', [$my_age]));
console_log('(($my_age <= 3) || ($my_age >= 65)): ');
if (($my_age <= 3) || ($my_age >= 65)) console_log("You should stay home");

$my_age = 89;
console_log(string_interpolation('$my_age: ', [$my_age]));
console_log('(($my_age <= 3) || ($my_age >= 65)): ');
if (($my_age <= 3) || ($my_age >= 65)) console_log("You should stay home");

$my_age = 2;
console_log(string_interpolation('$my_age: ', [$my_age]));
console_log('(($my_age <= 3) or ($my_age >= 65)): ');
if (($my_age <= 3) or ($my_age >= 65)) console_log("You should stay home");

$my_age = 89;
console_log(string_interpolation('$my_age: ', [$my_age]));
console_log('(($my_age <= 3) or ($my_age >= 65)): ');
if (($my_age <= 3) or ($my_age >= 65)) console_log("You should stay home");

console_log("\n// Logical NOT (!)");

$can_drive = false;
console_log(string_interpolation('$can_drive: ', [$can_drive]));
console_log(string_interpolation('!$can_drive: ', [!$can_drive]));

$can_drive = true;
console_log(string_interpolation('$can_drive: ', [$can_drive]));
console_log(string_interpolation('!$can_drive: ', [!$can_drive]));
