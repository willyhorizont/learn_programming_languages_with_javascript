<?php

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

echo("\n# basic conditional control flow\n");

$my_age = 10;
echo("\$my_age: " . $my_age . "\n");
if ($my_age > 24) {
    echo("you are old");
} elseif ($my_age > 17) {
    echo("you are young");
} else {
    echo("you are under age");
}

echo("\n// equal to (==)\n" . "\n");

$CORRECT_ANSWER = 100;
$my_answer = "100";
echo("\$my_answer: " . $my_answer . "\n");
echo("\$CORRECT_ANSWER: " . $CORRECT_ANSWER . "\n");
echo("(\$my_answer == \$CORRECT_ANSWER): " . "\n");
if ($my_answer == $CORRECT_ANSWER) {
    echo("Your answer is correct" . "\n");
} else {
    echo("Your answer is wrong" . "\n");
}

echo("\n// not equal to (!=)\n" . "\n");

$CORRECT_ANSWER = 100;
$my_answer = "25";
echo("\$my_answer: " . $my_answer . "\n");
echo("\$CORRECT_ANSWER: " . $CORRECT_ANSWER . "\n");
echo("(\$my_answer != \$CORRECT_ANSWER): " . "\n");
if ($my_answer != $CORRECT_ANSWER) {
    echo("Your answer is correct" . "\n");
} else {
    echo("Your answer is wrong" . "\n");
}

echo("\n// identical to (===)\n" . "\n");

$CORRECT_ANSWER = 100;
$my_answer = "100";
echo("\$my_answer: " . $my_answer . "\n");
echo("\$CORRECT_ANSWER: " . $CORRECT_ANSWER . "\n");
echo("(\$my_answer === \$CORRECT_ANSWER): " . "\n");
if ($my_answer === $CORRECT_ANSWER) {
    echo("Your answer is correct" . "\n");
} else {
    echo("Your answer is wrong" . "\n");
}

echo("\n// not identical to (!==)\n" . "\n");

$CORRECT_ANSWER = 100;
$my_answer = "25";
echo("\$my_answer: " . $my_answer . "\n");
echo("\$CORRECT_ANSWER: " . $CORRECT_ANSWER . "\n");
echo("(\$my_answer !== \$CORRECT_ANSWER): " . "\n");
if ($my_answer !== $CORRECT_ANSWER) {
    echo("Your answer is correct" . "\n");
} else {
    echo("Your answer is wrong" . "\n");
}

echo("\n// greater than (>)\n" . "\n");

$my_age = 70;
echo("\$my_age: " . $my_age . "\n");
echo("(\$my_age > 50): " . "\n");
if ($my_age > 50) echo("You are old" . "\n");

echo("\n// less than (<)\n" . "\n");

$my_age = 16;
echo("\$my_age: " . $my_age . "\n");
echo("(\$my_age < 20): " . "\n");
if ($my_age < 20) echo("You are young" . "\n");

echo("\n// greater than or equal to (>=)\n" . "\n");

$my_age = 73;
echo("\$my_age: " . $my_age . "\n");
echo("(\$my_age >= 65): " . "\n");
if ($my_age >= 65) echo("You are allowed to retire" . "\n");

echo("\n// less than or equal to (<=)\n" . "\n");

$my_age = 14; 
echo("\$my_age: " . $my_age . "\n");
echo("(\$my_age <= 16): " . "\n");
if ($my_age <= 16) echo("You are not allowed to drive" . "\n");

echo("\n// Logical AND [\"&&\", \"and\"]\n" . "\n");

$my_age = 17;
echo("\$my_age: " . $my_age . "\n");
$has_driving_license = false;
echo("\$has_driving_license: " . json_encode($has_driving_license) . "\n");
echo("((\$my_age >= 17) && (\$has_driving_license == true)): " . "\n");
echo(((($my_age >= 17) && ($has_driving_license == true)) ? "You are allowed to drive" : "You are not allowed to drive") . "\n");

$my_age = 17;
echo("\$my_age: " . $my_age . "\n");
$has_driving_license = true;
echo("\$has_driving_license: " . json_encode($has_driving_license) . "\n");
echo("((\$my_age >= 17) && (\$has_driving_license == true)): " . "\n");
echo(((($my_age >= 17) && ($has_driving_license == true)) ? "You are allowed to drive" : "You are not allowed to drive") . "\n");

$my_age = 17;
echo("\$my_age: " . $my_age . "\n");
$has_driving_license = false;
echo("\$has_driving_license: " . json_encode($has_driving_license) . "\n");
echo("((\$my_age >= 17) and (\$has_driving_license == true)): " . "\n");
echo(((($my_age >= 17) and ($has_driving_license == true)) ? "You are allowed to drive" : "You are not allowed to drive") . "\n");

$my_age = 17;
echo("\$my_age: " . $my_age . "\n");
$has_driving_license = true;
echo("\$has_driving_license: " . json_encode($has_driving_license) . "\n");
echo("((\$my_age >= 17) and (\$has_driving_license == true)): " . "\n");
echo(((($my_age >= 17) and ($has_driving_license == true)) ? "You are allowed to drive" : "You are not allowed to drive") . "\n");

echo("\n// Logical OR [\"||\", \"or\"]\n" . "\n");

$my_age = 2;
echo("\$my_age: " . $my_age . "\n");
echo("((\$my_age <= 3) || (\$my_age >= 65)): " . "\n");
if (($my_age <= 3) || ($my_age >= 65)) echo("You should stay home" . "\n");

$my_age = 89;
echo("\$my_age: " . $my_age . "\n");
echo("((\$my_age <= 3) || (\$my_age >= 65)): " . "\n");
if (($my_age <= 3) || ($my_age >= 65)) echo("You should stay home" . "\n");

$my_age = 2;
echo("\$my_age: " . $my_age . "\n");
echo("((\$my_age <= 3) or (\$my_age >= 65)): " . "\n");
if (($my_age <= 3) or ($my_age >= 65)) echo("You should stay home" . "\n");

$my_age = 89;
echo("\$my_age: " . $my_age . "\n");
echo("((\$my_age <= 3) or (\$my_age >= 65)): " . "\n");
if (($my_age <= 3) or ($my_age >= 65)) echo("You should stay home" . "\n");

echo("\n// Logical NOT (!)\n" . "\n");

$can_drive = false;
echo("\$can_drive: " . json_encode($can_drive) . "\n");
echo("!\$can_drive: " . json_encode(!$can_drive) . "\n");

$can_drive = true;
echo("\$can_drive: " . json_encode($can_drive) . "\n");
echo("!\$can_drive: " . json_encode(!$can_drive) . "\n");
