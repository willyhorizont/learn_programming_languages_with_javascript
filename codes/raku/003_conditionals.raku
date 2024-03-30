sub json-stringify($anything, Bool :$pretty = False) {
    use JSON::Fast;
    return to-json($anything, :pretty(True), :spacing(4)) if ($pretty === True);
    my $json-string = to-json($anything, :pretty(False));
    $json-string ~~ s:g/\,/\, /;
    $json-string ~~ s:g/\:/\: /;
    return $json-string;;
}

#`<<<
    Relational Operators / Comparison Operators:
    equal to [==, eq] *checks for equality after performing type coercion. It converts operands to the same type before making the comparison.
    not equal to [!=, ne] *checks for inequality after performing type coercion. It converts operands to the same type before making the comparison.
    strict equal to [===, eqv] *checks for strict equality without type coercion. It requires both the value and the type to be the same.
    strict not equal to [!==, !eqv] *checks for strict inequality without type coercion. It requires both the value and the type to be the same.
    greater than [>, gt]
    less than [<, lt]
    greater than or equal to [>=, ge]
    less than or equal to [<=, le]

    Logical Operators:
    Logical AND [&&, and]
    Logical OR [||, or]
    Logical NOT [!, not]
>>>

my $correct-answer;
my $my-age;
my $my-answer;
my $has-driving-license;
my $can-drive;

print("\n# basic conditional control flow\n", "\n");

$my-age = 10;
print("\$my-age: {json-stringify($my-age)}", "\n");
if ($my-age > 24) {
    print("you are old", "\n");
} elsif ($my-age > 17) {
    print("you are young", "\n");
} else {
    print("you are under age", "\n");
}

$my-age = 10;
print("\$my-age: {json-stringify($my-age)}", "\n");
# unless === if not True
unless ($my-age > 24) {
    print("you are young", "\n");
}

print("\n# equal to [==, eq]\n", "\n");

$my-answer = "100";
print("\$my-answer: {json-stringify($my-answer)}","\n");
$correct-answer = 100;
print("\$correct-answer: {json-stringify($correct-answer)}", "\n");
print("(\$my-answer == \$correct-answer):", "\n");
if ($my-answer == $correct-answer) {
    print("Your answer is correct", "\n");
} else {
    print("Your answer is wrong", "\n");
}

$my-answer = "100";
print("\$my-answer: {json-stringify($my-answer)}","\n");
$correct-answer = 100;
print("\$correct-answer: {json-stringify($correct-answer)}", "\n");
print("(\$my-answer eq \$correct-answer):", "\n");
if ($my-answer eq $correct-answer) {
    print("Your answer is correct", "\n");
} else {
    print("Your answer is wrong", "\n");
}

$my-answer = 100;
print("\$my-answer: {json-stringify($my-answer)}","\n");
$correct-answer = 100;
print("\$correct-answer: {json-stringify($correct-answer)}", "\n");
print("(\$my-answer == \$correct-answer):", "\n");
if ($my-answer == $correct-answer) {
    print("Your answer is correct", "\n");
} else {
    print("Your answer is wrong", "\n");
}

$my-answer = 100;
print("\$my-answer: {json-stringify($my-answer)}","\n");
$correct-answer = 100;
print("\$correct-answer: {json-stringify($correct-answer)}", "\n");
print("(\$my-answer eq \$correct-answer):", "\n");
if ($my-answer eq $correct-answer) {
    print("Your answer is correct", "\n");
} else {
    print("Your answer is wrong", "\n");
}

print("\n# not equal to [!=, ne]\n", "\n");

$my-answer = "25";
print("\$my-answer: {json-stringify($my-answer)}","\n");
$correct-answer = 100;
print("\$correct-answer: {json-stringify($correct-answer)}", "\n");
print("(\$my-answer != \$correct-answer):", "\n");
if ($my-answer != $correct-answer) {
    print("Your answer is correct", "\n");
} else {
    print("Your answer is wrong", "\n");
}

$my-answer = "25";
print("\$my-answer: {json-stringify($my-answer)}", "\n");
$correct-answer = 100;
print("\$correct-answer: {json-stringify($correct-answer)}", "\n");
print("(\$my-answer ne \$correct-answer):", "\n");
if ($my-answer ne $correct-answer) {
    print("Your answer is correct", "\n");
} else {
    print("Your answer is wrong", "\n");
}

$my-answer = 25;
print("\$my-answer: {json-stringify($my-answer)}","\n");
$correct-answer = 100;
print("\$correct-answer: {json-stringify($correct-answer)}", "\n");
print("(\$my-answer != \$correct-answer):", "\n");
if ($my-answer != $correct-answer) {
    print("Your answer is correct", "\n");
} else {
    print("Your answer is wrong", "\n");
}

$my-answer = 25;
print("\$my-answer: {json-stringify($my-answer)}","\n");
$correct-answer = 100;
print("\$correct-answer: {json-stringify($correct-answer)}", "\n");
print("(\$my-answer ne \$correct-answer):", "\n");
if ($my-answer ne $correct-answer) {
    print("Your answer is correct", "\n");
} else {
    print("Your answer is wrong", "\n");
}

print("\n# strict equal to [===, eqv]\n", "\n");

$my-answer = "100";
print("\$my-answer: {json-stringify($my-answer)}","\n");
$correct-answer = 100;
print("\$correct-answer: {json-stringify($correct-answer)}", "\n");
print("(\$my-answer === \$correct-answer):", "\n");
if ($my-answer === $correct-answer) {
    print("Your answer is correct", "\n");
} else {
    print("Your answer is wrong", "\n");
}

$my-answer = "100";
print("\$my-answer: {json-stringify($my-answer)}","\n");
$correct-answer = 100;
print("\$correct-answer: {json-stringify($correct-answer)}", "\n");
print("(\$my-answer eqv \$correct-answer):", "\n");
if ($my-answer eqv $correct-answer) {
    print("Your answer is correct", "\n");
} else {
    print("Your answer is wrong", "\n");
}

$my-answer = 100;
print("\$my-answer: {json-stringify($my-answer)}","\n");
$correct-answer = 100;
print("\$correct-answer: {json-stringify($correct-answer)}", "\n");
print("(\$my-answer === \$correct-answer):", "\n");
if ($my-answer === $correct-answer) {
    print("Your answer is correct", "\n");
} else {
    print("Your answer is wrong", "\n");
}

$my-answer = 100;
print("\$my-answer: {json-stringify($my-answer)}","\n");
$correct-answer = 100;
print("\$correct-answer: {json-stringify($correct-answer)}", "\n");
print("(\$my-answer eqv \$correct-answer):", "\n");
if ($my-answer eqv $correct-answer) {
    print("Your answer is correct", "\n");
} else {
    print("Your answer is wrong", "\n");
}

print("\n# strict not equal to [!==, !eqv]\n", "\n");

$my-answer = "25";
print("\$my-answer: {json-stringify($my-answer)}","\n");
$correct-answer = 100;
print("\$correct-answer: {json-stringify($correct-answer)}", "\n");
print("(\$my-answer !== \$correct-answer):", "\n");
if ($my-answer !== $correct-answer) {
    print("Your answer is correct", "\n");
} else {
    print("Your answer is wrong", "\n");
}

$my-answer = "25";
print("\$my-answer: {json-stringify($my-answer)}", "\n");
$correct-answer = 100;
print("\$correct-answer: {json-stringify($correct-answer)}", "\n");
print("(\$my-answer !eqv \$correct-answer):", "\n");
if ($my-answer !eqv $correct-answer) {
    print("Your answer is correct", "\n");
} else {
    print("Your answer is wrong", "\n");
}

$my-answer = 25;
print("\$my-answer: {json-stringify($my-answer)}","\n");
$correct-answer = 100;
print("\$correct-answer: {json-stringify($correct-answer)}", "\n");
print("(\$my-answer !== \$correct-answer):", "\n");
if ($my-answer !== $correct-answer) {
    print("Your answer is correct", "\n");
} else {
    print("Your answer is wrong", "\n");
}

$my-answer = 25;
print("\$my-answer: {json-stringify($my-answer)}","\n");
$correct-answer = 100;
print("\$correct-answer: {json-stringify($correct-answer)}", "\n");
print("(\$my-answer !eqv \$correct-answer):", "\n");
if ($my-answer !eqv $correct-answer) {
    print("Your answer is correct", "\n");
} else {
    print("Your answer is wrong", "\n");
}

print("\n# greater than [>, gt]\n", "\n");

$my-age = "70";
print("\$my-age: {json-stringify($my-age)}", "\n");
print("({json-stringify($my-age)} > 50):", "\n");
print("You are old", "\n") if ($my-age > 50);

$my-age = "70";
print("\$my-age: {json-stringify($my-age)}", "\n");
print("({json-stringify($my-age)} gt 50):", "\n");
print("You are old", "\n") if ($my-age gt 50);

$my-age = 70;
print("\$my-age: {json-stringify($my-age)}", "\n");
print("({json-stringify($my-age)} > 50):", "\n");
print("You are old", "\n") if ($my-age > 50);

$my-age = 70;
print("\$my-age: {json-stringify($my-age)}", "\n");
print("({json-stringify($my-age)} gt 50):", "\n");
print("You are old", "\n") if ($my-age gt 50);

print("\n# less than [<, lt]\n", "\n");

$my-age = "16";
print("\$my-age: {json-stringify($my-age)}", "\n");
print("({json-stringify($my-age)} < 20):", "\n");
print("You are young", "\n") if ($my-age < 20);

$my-age = "16";
print("\$my-age: {json-stringify($my-age)}", "\n");
print("({json-stringify($my-age)} lt 20):", "\n");
print("You are young", "\n") if ($my-age lt 20);

$my-age = 16;
print("\$my-age: {json-stringify($my-age)}", "\n");
print("({json-stringify($my-age)} < 20):", "\n");
print("You are young", "\n") if ($my-age < 20);

$my-age = 16;
print("\$my-age: {json-stringify($my-age)}", "\n");
print("({json-stringify($my-age)} lt 20):", "\n");
print("You are young", "\n") if ($my-age lt 20);

print("\n# greater than or equal to [>=, ge]\n", "\n");

$my-age = "73";
print("\$my-age: {json-stringify($my-age)}", "\n");
print("({json-stringify($my-age)} >= 65):", "\n");
print("You are allowed to retire", "\n") if ($my-age >= 65);

$my-age = "73";
print("\$my-age: {json-stringify($my-age)}", "\n");
print("({json-stringify($my-age)} ge 65):", "\n");
print("You are allowed to retire", "\n") if ($my-age ge 65);

$my-age = 73;
print("\$my-age: {json-stringify($my-age)}", "\n");
print("({json-stringify($my-age)} >= 65):", "\n");
print("You are allowed to retire", "\n") if ($my-age >= 65);

$my-age = 73;
print("\$my-age: {json-stringify($my-age)}", "\n");
print("({json-stringify($my-age)} ge 65):", "\n");
print("You are allowed to retire", "\n") if ($my-age ge 65);

print("\n# less than or equal to [<=, le]\n", "\n");

$my-age = "14"; 
print("\$my-age: {json-stringify($my-age)}", "\n");
print("({json-stringify($my-age)} <= 16):", "\n");
print("You are not allowed to drive", "\n") if ($my-age <= 16);

$my-age = "14"; 
print("\$my-age: {json-stringify($my-age)}", "\n");
print("({json-stringify($my-age)} le 16):", "\n");
print("You are not allowed to drive", "\n") if ($my-age le 16);

$my-age = 14; 
print("\$my-age: {json-stringify($my-age)}", "\n");
print("({json-stringify($my-age)} <= 16):", "\n");
print("You are not allowed to drive", "\n") if ($my-age <= 16);

$my-age = 14; 
print("\$my-age: {json-stringify($my-age)}", "\n");
print("({json-stringify($my-age)} le 16):", "\n");
print("You are not allowed to drive", "\n") if ($my-age le 16);

print("\n# Logical AND [&&, and]\n", "\n");

$my-age = 17;
print("\$my-age: {json-stringify($my-age)}", "\n");
$has-driving-license = False;
print("\$has-driving-license: {$has-driving-license}", "\n");
print("((\$my-age >= 17) && \$has-driving-license):", "\n");
print(((($my-age >= 17) && $has-driving-license === True) ?? "You are allowed to drive" !! "You are not allowed to drive"), "\n");

$my-age = 17;
print("\$my-age: {json-stringify($my-age)}", "\n");
$has-driving-license = True;
print("\$has-driving-license: {$has-driving-license}", "\n");
print("((\$my-age >= 17) && \$has-driving-license):", "\n");
print(((($my-age >= 17) && $has-driving-license === True) ?? "You are allowed to drive" !! "You are not allowed to drive"), "\n");

$my-age = 17;
print("\$my-age: {json-stringify($my-age)}", "\n");
$has-driving-license = False;
print("\$has-driving-license: {$has-driving-license}", "\n");
print("((\$my-age >= 17) and \$has-driving-license):", "\n");
print(((($my-age >= 17) and $has-driving-license === True) ?? "You are allowed to drive" !! "You are not allowed to drive"), "\n");

$my-age = 17;
print("\$my-age: {json-stringify($my-age)}", "\n");
$has-driving-license = True;
print("\$has-driving-license: {$has-driving-license}", "\n");
print("((\$my-age >= 17) and \$has-driving-license):", "\n");
print(((($my-age >= 17) and $has-driving-license === True) ?? "You are allowed to drive" !! "You are not allowed to drive"), "\n");

print("\n# Logical OR [||, or]\n", "\n");

$my-age = 2;
print("\$my-age: {json-stringify($my-age)}", "\n");
print("((\$my-age <= 3) || (\$my-age >= 65)):", "\n");
print("You should stay home", "\n") if (($my-age <= 3) || ($my-age >= 65));

$my-age = 89;
print("\$my-age: {json-stringify($my-age)}", "\n");
print("((\$my-age <= 3) || (\$my-age >= 65)):", "\n");
print("You should stay home", "\n") if (($my-age <= 3) || ($my-age >= 65));

$my-age = 2;
print("\$my-age: {json-stringify($my-age)}", "\n");
print("((\$my-age <= 3) or (\$my-age >= 65)):", "\n");
print("You should stay home", "\n") if (($my-age <= 3) or ($my-age >= 65));

$my-age = 89;
print("\$my-age: {json-stringify($my-age)}", "\n");
print("((\$my-age <= 3) or (\$my-age >= 65)):", "\n");
print("You should stay home", "\n") if (($my-age <= 3) or ($my-age >= 65));

print("\n# Logical NOT [!, not]\n", "\n");

$can-drive = False;
print("\$can-drive: {$can-drive}", "\n");
print("!\$can-drive: {!$can-drive}", "\n");

$can-drive = True;
print("\$can-drive: {$can-drive}", "\n");
print("!\$can-drive: {!$can-drive}", "\n");

$can-drive = False;
print("\$can-drive: {$can-drive}", "\n");
print("not \$can-drive: {not $can-drive}", "\n");

$can-drive = True;
print("\$can-drive: {$can-drive}", "\n");
print("not \$can-drive: {not $can-drive}", "\n");
