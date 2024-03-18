<?php

echo("\n\n// Custom Error and Error Handling in PHP");

function give_me_respect($parameter) {
    // Custom Error
    if ($parameter !== "respect") throw new Exception("Exception: You should give me \"respect\"!");
    return "Thank you for giving me \"respect\"!";
};

// Error Handling
try {
    $response = give_me_respect("boo!");
    echo("\n" . $response);
} catch (Exception $an_exception) {
    echo("\n" . $an_exception->getMessage());
}
echo("\n" . "I'm sorry!");

// Without Error Handling
$response = give_me_respect("boo!");
// this will never executed
echo("\n" . $response);
echo("\n" . "I'm sorry!");
