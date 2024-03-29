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

function bool_to_string($anything) {
    if (is_bool($anything) === false) throw new Exception("Expecting Boolean as argument");
    return (($anything === true) ? "true" : "false");
}

print("\n# basic conditional control flow\n");

$my_age = 10;
echo("\n" . "\$my_age: " . $my_age);
if ($my_age > 24) {
    print("you are old");
} elseif ($my_age > 17) {
    print("you are young");
} else {
    print("you are under age");
}

echo("\n\n// equal to (==)\n");

$CORRECT_ANSWER = 100;
$my_answer = "100";
echo("\n" . "\$my_answer: " . $my_answer);
echo("\n" . "\$CORRECT_ANSWER: " . $CORRECT_ANSWER);
echo("\n(\$my_answer == \$CORRECT_ANSWER): ");
if ($my_answer == $CORRECT_ANSWER) {
    echo("\n" . "Your answer is correct");
} else {
    echo("\n" . "Your answer is wrong");
}

echo("\n\n// not equal to (!=)\n");

$CORRECT_ANSWER = 100;
$my_answer = "25";
echo("\n" . "\$my_answer: " . $my_answer);
echo("\n" . "\$CORRECT_ANSWER: " . $CORRECT_ANSWER);
echo("\n(\$my_answer != \$CORRECT_ANSWER): ");
if ($my_answer != $CORRECT_ANSWER) {
    echo("\n" . "Your answer is correct");
} else {
    echo("\n" . "Your answer is wrong");
}

echo("\n\n// identical to (===)\n");

$CORRECT_ANSWER = 100;
$my_answer = "100";
echo("\n" . "\$my_answer: " . $my_answer);
echo("\n" . "\$CORRECT_ANSWER: " . $CORRECT_ANSWER);
echo("\n(\$my_answer === \$CORRECT_ANSWER): ");
if ($my_answer === $CORRECT_ANSWER) {
    echo("\n" . "Your answer is correct");
} else {
    echo("\n" . "Your answer is wrong");
}

echo("\n\n// not identical to (!==)\n");

$CORRECT_ANSWER = 100;
$my_answer = "25";
echo("\n" . "\$my_answer: " . $my_answer);
echo("\n" . "\$CORRECT_ANSWER: " . $CORRECT_ANSWER);
echo("\n(\$my_answer !== \$CORRECT_ANSWER): ");
if ($my_answer !== $CORRECT_ANSWER) {
    echo("\n" . "Your answer is correct");
} else {
    echo("\n" . "Your answer is wrong");
}

echo("\n\n// greater than (>)\n");

$my_age = 70;
echo("\n" . "\$my_age: " . $my_age);
echo("\n(\$my_age > 50): ");
if ($my_age > 50) echo("\n" . "You are old");

echo("\n\n// less than (<)\n");

$my_age = 16;
echo("\n" . "\$my_age: " . $my_age);
echo("\n(\$my_age < 20): ");
if ($my_age < 20) echo("\n" . "You are young");

echo("\n\n// greater than or equal to (>=)\n");

$my_age = 73;
echo("\n" . "\$my_age: " . $my_age);
echo("\n(\$my_age >= 65): ");
if ($my_age >= 65) echo("\n" . "You are allowed to retire");

echo("\n\n// less than or equal to (<=)\n");

$my_age = 14; 
echo("\n" . "\$my_age: " . $my_age);
echo("\n(\$my_age <= 16): ");
if ($my_age <= 16) echo("\n" . "You are not allowed to drive");

echo("\n\n// Logical AND [\"&&\", \"and\"]\n");

$my_age = 17;
echo("\n" . "\$my_age: " . $my_age);
$has_driving_license = false;
echo("\n" . "\$has_driving_license: " . bool_to_string($has_driving_license));
echo("\n((\$my_age >= 17) && (\$has_driving_license == true)): ");
echo(((($my_age >= 17) && ($has_driving_license == true)) ? "\n" . "You are allowed to drive" : "\n" . "You are not allowed to drive"));

$my_age = 17;
echo("\n" . "\$my_age: " . $my_age);
$has_driving_license = true;
echo("\n" . "\$has_driving_license: " . bool_to_string($has_driving_license));
echo("\n((\$my_age >= 17) && (\$has_driving_license == true)): ");
echo(((($my_age >= 17) && ($has_driving_license == true)) ? "\n" . "You are allowed to drive" : "\n" . "You are not allowed to drive"));

$my_age = 17;
echo("\n" . "\$my_age: " . $my_age);
$has_driving_license = false;
echo("\n" . "\$has_driving_license: " . bool_to_string($has_driving_license));
echo("\n((\$my_age >= 17) and (\$has_driving_license == true)): ");
echo(((($my_age >= 17) and ($has_driving_license == true)) ? "\n" . "You are allowed to drive" : "\n" . "You are not allowed to drive"));

$my_age = 17;
echo("\n" . "\$my_age: " . $my_age);
$has_driving_license = true;
echo("\n" . "\$has_driving_license: " . bool_to_string($has_driving_license));
echo("\n((\$my_age >= 17) and (\$has_driving_license == true)): ");
echo(((($my_age >= 17) and ($has_driving_license == true)) ? "\n" . "You are allowed to drive" : "\n" . "You are not allowed to drive"));

echo("\n\n// Logical OR [\"||\", \"or\"]\n");

$my_age = 2;
echo("\n" . "\$my_age: " . $my_age);
echo("\n((\$my_age <= 3) || (\$my_age >= 65)): ");
if (($my_age <= 3) || ($my_age >= 65)) echo("\n" . "You should stay home");

$my_age = 89;
echo("\n" . "\$my_age: " . $my_age);
echo("\n((\$my_age <= 3) || (\$my_age >= 65)): ");
if (($my_age <= 3) || ($my_age >= 65)) echo("\n" . "You should stay home");

$my_age = 2;
echo("\n" . "\$my_age: " . $my_age);
echo("\n((\$my_age <= 3) or (\$my_age >= 65)): ");
if (($my_age <= 3) or ($my_age >= 65)) echo("\n" . "You should stay home");

$my_age = 89;
echo("\n" . "\$my_age: " . $my_age);
echo("\n((\$my_age <= 3) or (\$my_age >= 65)): ");
if (($my_age <= 3) or ($my_age >= 65)) echo("\n" . "You should stay home");

echo("\n\n// Logical NOT (!)\n");

$can_drive = false;
echo("\n" . "\$can_drive: " . bool_to_string($can_drive));
echo("\n!\$can_drive: " . bool_to_string(!$can_drive));

$can_drive = true;
echo("\n" . "\$can_drive: " . bool_to_string($can_drive));
echo("\n!\$can_drive: " . bool_to_string(!$can_drive));
