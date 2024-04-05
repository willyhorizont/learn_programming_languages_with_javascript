<?php

echo("\n// Custom Error and Error Handling in PHP" . "\n");

function give_me_respect($parameter) {
    // Custom Error
    if ($parameter !== "respect") throw new Exception("Exception: You should give me \"respect\"!");
    return "Thank you for giving me \"respect\"!";
};

// Error Handling
try {
    $response = give_me_respect("boo!");
    echo($response . "\n");
} catch (Exception $an_exception) {
    echo($an_exception->getMessage() . "\n");
}
echo("I'm sorry!" . "\n");

// Without Error Handling
$response = give_me_respect("boo!");
// this will never executed
echo($response . "\n");
echo("I'm sorry!" . "\n");
