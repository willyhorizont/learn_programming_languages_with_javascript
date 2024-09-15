<?php

function json_stringify($anything, $optional_argument = ["pretty" => false]) {
    $pretty = ($optional_argument["pretty"] ?? false);
    return (($pretty === true) ? (str_replace("/\n$/", "", json_encode($anything, JSON_PRETTY_PRINT))) : (str_replace("{", "{ ", str_replace("}", " }", str_replace(",", ", ", str_replace(":", ": ", json_encode($anything)))))));
};

function console_log(...$rest_arguments) {
    echo join("", $rest_arguments) . "\n";
};

function string_interpolation(...$rest_arguments) {
    return array_reduce($rest_arguments,  fn($current_result, $current_argument) => ($current_result . (((is_array($current_argument) === true) && count($current_argument) === 1) ? (json_stringify(@$current_argument[0])) : ($current_argument))), "");
};

// while loop

(function () {
    $i = 1;
    while (true) {
        if ($i === 2) {
            if ($i >= 5) break;
            $i += 1;
            continue;
        }
        console_log(string_interpolation("while loop v1, i is ", [$i]));
        if ($i >= 5) break;
        $i += 1;
    }
})();

(function () {
    $i = 1;
    while ($i <= 5) {
        if ($i === 2) {
            $i += 1;
            continue;
        }
        console_log(string_interpolation("while loop v2, i is ", [$i]));
        $i += 1;
    }
})();

// for loop

(function () {
    for ($i = 1; $i <= 10; $i += 1) {
        if ($i > 5) break;
        if ($i === 2) continue;
        console_log(string_interpolation("for loop, i is ", [$i]));
    }
})();

// for each loop

(function () {
    foreach (range(1, 10, 1) as $i) { // (start, stop, step)
        if ($i > 5) break;
        if ($i === 2) continue;
        console_log(string_interpolation("for each loop ascending, i is ", [$i]));
    }
})();

(function () {
    foreach (range(10, 1, 1) as $i) { // (start, stop, step)
        if ($i <= 5) break;
        if ($i === 9) continue;
        console_log(string_interpolation("for each loop descending, i is ", [$i]));
    }
})();
