<?php

$js_like_type = [
    "Null" => "Null",
    "Boolean" => "Boolean",
    "String" => "String",
    "Numeric" => "Numeric",
    "Object" => "Object",
    "Array" => "Array",
    "Function" => "Function"
];

function array_reduce_v2($callback_function, $an_array, $initial_value) {
    // JavaScript-like Array.reduce() function array_reduce_v2
    $result = $initial_value;
    $array_item_index = 0;
    foreach ($an_array as $object_key => $object_value) {
        $result = $callback_function($result, $object_value, $array_item_index, $an_array);
        $array_item_index += 1;
    }
    return $result;
};

function array_every($callback_function, $an_array) {
    // JavaScript-like Array.every() function array_every_v4
    $array_item_index = 0;
    foreach ($an_array as $object_key => $object_value) {
        if ($callback_function($object_value, $array_item_index, $an_array) === false) return false;
        $array_item_index += 1;
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
    return array_every((fn($object_value) => (is_like_js_string($object_value) === true)), array_keys($anything));
};

function is_like_js_function($anything) {
    return (is_callable($anything) === true);
};

function get_type($anything) {
    global $js_like_type;
    if (is_like_js_null($anything) === true) return $js_like_type["Null"];
    if (is_like_js_boolean($anything) === true) return $js_like_type["Boolean"];
    if (is_like_js_string($anything) === true) return $js_like_type["String"];
    if (is_like_js_numeric($anything) === true) return $js_like_type["Numeric"];
    if (is_like_js_object($anything) === true) return $js_like_type["Object"];
    if (is_like_js_array($anything) === true) return $js_like_type["Array"];
    if (is_like_js_function($anything) === true) return $js_like_type["Function"];
    return ('"' . gettype($anything) . '"');
};

function optional_chaining($anything, ...$array_index_or_object_key_or_function_argument_array) {
    // JavaScript-like Optional Chaining Operator (?.) function optional_chaining_v2
    global $js_like_type;
    if (get_type($anything) === $js_like_type["Function"]) return $anything(...$array_index_or_object_key_or_function_argument_array);
    if (((get_type($anything) !== $js_like_type["Object"]) && (get_type($anything) !== $js_like_type["Array"])) || (count($array_index_or_object_key_or_function_argument_array) === 0)) return $anything;
    return array_reduce_v2((function ($current_result, $current_item) use ($anything, $js_like_type) {
        if ((get_type($current_result) === $js_like_type["Null"]) && (get_type($anything) === $js_like_type["Object"]) && (get_type($current_item) === $js_like_type["String"])) return @$anything[((string) $current_item)];
        if ((get_type($current_result) === $js_like_type["Null"]) && (get_type($anything) === $js_like_type["Array"]) && (get_type($current_item) === $js_like_type["Numeric"]) && (((int) $current_item) >= 0) && (count($anything) > ((int) $current_item))) return @$anything[((int) $current_item)];
        if ((get_type($current_result) === $js_like_type["Object"]) && (get_type($current_item) === $js_like_type["String"])) return @$current_result[((string) $current_item)];
        if ((get_type($current_result) === $js_like_type["Array"]) && (get_type($current_item) === $js_like_type["Numeric"]) && (((int) $current_item) >= 0) && (count($current_result) > ((int) $current_item))) return @$current_result[((int) $current_item)];
        return null;
    }), $array_index_or_object_key_or_function_argument_array, null);
};

function pipe(...$rest_arguments) {
    global $js_like_type;
    $pipe_last_result = null;
    $pipe_result = array_reduce_v2((function ($current_result, $current_argument) use (&$pipe_last_result, $js_like_type) {
        $pipe_last_result = $current_result;
        if (get_type($current_result) === $js_like_type["Null"]) return $current_argument;
        if (get_type($current_argument) === $js_like_type["Function"]) return $current_argument($current_result);
        return null;
    }), $rest_arguments, null);
    if (get_type($pipe_result) === $js_like_type["Function"]) return $pipe_result($pipe_last_result);
    return $pipe_result;
};

function json_stringify($anything, $optional_argument = ["pretty" => false]) {
    // json_stringify_v4
    $pretty = (optional_chaining($optional_argument, "pretty") ?? false);
    $indent = str_repeat(" ", 4);
    $indent_level = 0;
    $json_stringify_inner = function ($anything_inner) use ($pretty, $indent, &$indent_level, &$json_stringify_inner) {
        global $js_like_type;
        if (get_type($anything_inner) === $js_like_type["Null"]) return "null";
        if (get_type($anything_inner) === $js_like_type["String"]) return '"' . $anything_inner . '"';
        if (get_type($anything_inner) === $js_like_type["Numeric"]) return ((string) $anything_inner);
        if ((get_type($anything_inner) === $js_like_type["Boolean"]) || ($anything_inner === true)) return "true";
        if ((get_type($anything_inner) === $js_like_type["Boolean"]) || ($anything_inner === false)) return "false";
        if (get_type($anything_inner) === $js_like_type["Object"]) {
            if (count($anything_inner) === 0) return "{}";
            $indent_level += 1;
            $result = (($pretty === true) ? ("{\n" . str_repeat($indent, $indent_level)) : "{ ");
            $object_entry_index = 0;
            foreach ($anything_inner as $object_key => $object_value) {
                $result .= ('"' . $object_key . '": ' . $json_stringify_inner($object_value));
                if (($object_entry_index + 1) !== count($anything_inner)) {
                    $result .= (($pretty === true) ? (",\n" . str_repeat($indent, $indent_level)) : ", ");
                }
                $object_entry_index += 1;
            }
            $indent_level -= 1;
            $result .= (($pretty === true) ? ("\n" . str_repeat($indent, $indent_level) . "}") : " }");
            return $result;
        }
        if (get_type($anything_inner) === $js_like_type["Array"]) {
            if (count($anything_inner) === 0) return "[]";
            $indent_level += 1;
            $result = (($pretty === true) ? ("[\n" . str_repeat($indent, $indent_level)) : "[");
            $array_item_index = 0;
            foreach ($anything_inner as $object_key => $object_value) {
                $result .= $json_stringify_inner($object_value);
                if (($array_item_index + 1) !== count($anything_inner)) {
                    $result .= (($pretty === true) ? (",\n" . str_repeat($indent, $indent_level)) : ", ");
                }
                $array_item_index += 1;
            }
            $indent_level -= 1;
            $result .= (($pretty === true) ? ("\n" . str_repeat($indent, $indent_level) . "]") : "]");
            return $result;
        }
        if (get_type($anything_inner) === $js_like_type["Function"]) return '"[object Function]"';
        return '"' . get_type($anything_inner) . '"';
    };
    return $json_stringify_inner($anything);
};

function string_interpolation(...$rest_arguments) {
    global $js_like_type;
    return array_reduce_v2((fn($current_result, $current_argument) => ($current_result . ((get_type($current_argument) === $js_like_type["String"]) ? ($current_argument) : (((get_type($current_argument) === $js_like_type["Array"]) && (count($current_argument) === 1)) ? (json_stringify(optional_chaining($current_argument, 0))) : (json_stringify($current_argument)))))), $rest_arguments, "");
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
