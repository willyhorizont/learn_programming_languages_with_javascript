use strict;
use warnings;

sub pretty_json_stringify {
    my ($anything) = @_;
    use JSON;
    my $pretty_json_string = JSON->new->allow_nonref->pretty->encode($anything);
    $pretty_json_string =~ s/   /    /g;
    $pretty_json_string =~ s/\n$//g;
    return $pretty_json_string;
}

=begin
    Relational Operators / Comparison Operators:
    equal to [==, eq]
    not equal to [!=, ne]
    greater than [>, gt]
    less than [<, lt]
    greater than or equal to [>=, ge]
    less than or equal to [<=, le]

    Logical Operators:
    Logical AND [&&, and]
    Logical OR [||, or]
    Logical NOT [!, not]
=cut

sub bool_to_string {
    my ($anything) = @_;
    return ($anything ? "true" : "false");
}

my $correct_answer;
my $my_age;
my $my_answer;
my $has_driving_license;
my $can_drive;

print("\n# basic conditional control flow\n\n");

$my_age = 10;
print("\$my_age: " . pretty_json_stringify($my_age) . "\n");
if ($my_age > 24) {
    print("you are old\n");
} elsif ($my_age > 17) {
    print("you are young\n");
} else {
    print("you are under age\n");
}

$my_age = 10;
print("\$my_age: " . pretty_json_stringify($my_age) . "\n");
unless ($my_age <= 24) {
    print("you are old\n");
} else {
    print("you are young\n");
}

print("\n# equal to [==, eq]\n\n");

$my_answer = "100";
print("\$my_answer: " . pretty_json_stringify($my_answer) . "\n");
$correct_answer = 100;
print("\$correct_answer: " . pretty_json_stringify($correct_answer) . "\n");
print("(\$my_answer == \$correct_answer):\n");
if ($my_answer == $correct_answer) {
    print("Your answer is correct\n");
} else {
    print("Your answer is wrong\n");
}

$my_answer = "100";
print("\$my_answer: " . pretty_json_stringify($my_answer) . "\n");
$correct_answer = 100;
print("\$correct_answer: " . pretty_json_stringify($correct_answer) . "\n");
print("(\$my_answer eq \$correct_answer):\n");
if ($my_answer eq $correct_answer) {
    print("Your answer is correct\n");
} else {
    print("Your answer is wrong\n");
}

$my_answer = 100;
print("\$my_answer: " . pretty_json_stringify($my_answer) . "\n");
$correct_answer = 100;
print("\$correct_answer: " . pretty_json_stringify($correct_answer) . "\n");
print("(\$my_answer == \$correct_answer):\n");
if ($my_answer == $correct_answer) {
    print("Your answer is correct\n");
} else {
    print("Your answer is wrong\n");
}

$my_answer = 100;
print("\$my_answer: " . pretty_json_stringify($my_answer) . "\n");
$correct_answer = 100;
print("\$correct_answer: " . pretty_json_stringify($correct_answer) . "\n");
print("(\$my_answer eq \$correct_answer):\n");
if ($my_answer eq $correct_answer) {
    print("Your answer is correct\n");
} else {
    print("Your answer is wrong\n");
}

print("\n# not equal to [!=, ne]\n\n");

$my_answer = "25";
print("\$my_answer: " . pretty_json_stringify($my_answer) . "\n");
$correct_answer = 100;
print("\$correct_answer: " . pretty_json_stringify($correct_answer) . "\n");
print("(\$my_answer != \$correct_answer):\n");
if ($my_answer != $correct_answer) {
    print("Your answer is correct\n");
} else {
    print("Your answer is wrong\n");
}

$my_answer = "25";
print("\$my_answer: " . pretty_json_stringify($my_answer) . "\n");
$correct_answer = 100;
print("\$correct_answer: " . pretty_json_stringify($correct_answer) . "\n");
print("(\$my_answer ne \$correct_answer):\n");
if ($my_answer ne $correct_answer) {
    print("Your answer is correct\n");
} else {
    print("Your answer is wrong\n");
}

$my_answer = 25;
print("\$my_answer: " . pretty_json_stringify($my_answer) . "\n");
$correct_answer = 100;
print("\$correct_answer: " . pretty_json_stringify($correct_answer) . "\n");
print("(\$my_answer != \$correct_answer):\n");
if ($my_answer != $correct_answer) {
    print("Your answer is correct\n");
} else {
    print("Your answer is wrong\n");
}

$my_answer = 25;
print("\$my_answer: " . pretty_json_stringify($my_answer) . "\n");
$correct_answer = 100;
print("\$correct_answer: " . pretty_json_stringify($correct_answer) . "\n");
print("(\$my_answer ne \$correct_answer):\n");
if ($my_answer ne $correct_answer) {
    print("Your answer is correct\n");
} else {
    print("Your answer is wrong\n");
}

print("\n# greater than [>, gt]\n\n");

$my_age = "70";
print("\$my_age: " . pretty_json_stringify($my_age) . "\n");
print("(" . pretty_json_stringify($my_age) . " > 50):\n");
print("You are old\n") if ($my_age > 50);

$my_age = "70";
print("\$my_age: " . pretty_json_stringify($my_age) . "\n");
print("(" . pretty_json_stringify($my_age) . " gt 50):\n");
print("You are old\n") if ($my_age gt 50);

$my_age = 70;
print("\$my_age: " . pretty_json_stringify($my_age) . "\n");
print("(" . pretty_json_stringify($my_age) . " > 50):\n");
print("You are old\n") if ($my_age > 50);

$my_age = 70;
print("\$my_age: " . pretty_json_stringify($my_age) . "\n");
print("(" . pretty_json_stringify($my_age) . " gt 50):\n");
print("You are old\n") if ($my_age gt 50);

print("\n# less than [<, lt]\n\n");

$my_age = "16";
print("\$my_age: " . pretty_json_stringify($my_age) . "\n");
print("(" . pretty_json_stringify($my_age) . " < 20):\n");
print("You are young\n") if ($my_age < 20);

$my_age = "16";
print("\$my_age: " . pretty_json_stringify($my_age) . "\n");
print("(" . pretty_json_stringify($my_age) . " lt 20):\n");
print("You are young\n") if ($my_age lt 20);

$my_age = 16;
print("\$my_age: " . pretty_json_stringify($my_age) . "\n");
print("(" . pretty_json_stringify($my_age) . " < 20):\n");
print("You are young\n") if ($my_age < 20);

$my_age = 16;
print("\$my_age: " . pretty_json_stringify($my_age) . "\n");
print("(" . pretty_json_stringify($my_age) . " lt 20):\n");
print("You are young\n") if ($my_age lt 20);

print("\n# greater than or equal to [>=, ge]\n\n");

$my_age = "73";
print("\$my_age: " . pretty_json_stringify($my_age) . "\n");
print("(" . pretty_json_stringify($my_age) . " >= 65):\n");
print("You are allowed to retire\n") if ($my_age >= 65);

$my_age = "73";
print("\$my_age: " . pretty_json_stringify($my_age) . "\n");
print("(" . pretty_json_stringify($my_age) . " ge 65):\n");
print("You are allowed to retire\n") if ($my_age ge 65);

$my_age = 73;
print("\$my_age: " . pretty_json_stringify($my_age) . "\n");
print("(" . pretty_json_stringify($my_age) . " >= 65):\n");
print("You are allowed to retire\n") if ($my_age >= 65);

$my_age = 73;
print("\$my_age: " . pretty_json_stringify($my_age) . "\n");
print("(" . pretty_json_stringify($my_age) . " ge 65):\n");
print("You are allowed to retire\n") if ($my_age ge 65);

print("\n# less than or equal to [<=, le]\n\n");

$my_age = "14"; 
print("\$my_age: " . pretty_json_stringify($my_age) . "\n");
print("(" . pretty_json_stringify($my_age) . " <= 16):\n");
print("You are not allowed to drive\n") if ($my_age <= 16);

$my_age = "14"; 
print("\$my_age: " . pretty_json_stringify($my_age) . "\n");
print("(" . pretty_json_stringify($my_age) . " le 16):\n");
print("You are not allowed to drive\n") if ($my_age le 16);

$my_age = 14; 
print("\$my_age: " . pretty_json_stringify($my_age) . "\n");
print("(" . pretty_json_stringify($my_age) . " <= 16):\n");
print("You are not allowed to drive\n") if ($my_age <= 16);

$my_age = 14; 
print("\$my_age: " . pretty_json_stringify($my_age) . "\n");
print("(" . pretty_json_stringify($my_age) . " le 16):\n");
print("You are not allowed to drive\n") if ($my_age le 16);

print("\n# Logical AND [&&, and]\n\n");

$my_age = 17;
print("\$my_age: " . pretty_json_stringify($my_age) . "\n");
$has_driving_license = 0;
print("\$has_driving_license: " . bool_to_string($has_driving_license) . "\n");
print("((\$my_age >= 17) && \$has_driving_license):\n");
print(((($my_age >= 17) && $has_driving_license) ? "You are allowed to drive\n" : "You are not allowed to drive\n"));

$my_age = 17;
print("\$my_age: " . pretty_json_stringify($my_age) . "\n");
$has_driving_license = 1;
print("\$has_driving_license: " . bool_to_string($has_driving_license) . "\n");
print("((\$my_age >= 17) && \$has_driving_license):\n");
print(((($my_age >= 17) && $has_driving_license) ? "You are allowed to drive\n" : "You are not allowed to drive\n"));

$my_age = 17;
print("\$my_age: " . pretty_json_stringify($my_age) . "\n");
$has_driving_license = 0;
print("\$has_driving_license: " . bool_to_string($has_driving_license) . "\n");
print("((\$my_age >= 17) and \$has_driving_license):\n");
print(((($my_age >= 17) and $has_driving_license) ? "You are allowed to drive\n" : "You are not allowed to drive\n"));

$my_age = 17;
print("\$my_age: " . pretty_json_stringify($my_age) . "\n");
$has_driving_license = 1;
print("\$has_driving_license: " . bool_to_string($has_driving_license) . "\n");
print("((\$my_age >= 17) and \$has_driving_license):\n");
print(((($my_age >= 17) and $has_driving_license) ? "You are allowed to drive\n" : "You are not allowed to drive\n"));

print("\n# Logical OR [||, or]\n\n");

$my_age = 2;
print("\$my_age: " . pretty_json_stringify($my_age) . "\n");
print("((\$my_age <= 3) || (\$my_age >= 65)):\n");
print("You should stay home\n") if (($my_age <= 3) || ($my_age >= 65));

$my_age = 89;
print("\$my_age: " . pretty_json_stringify($my_age) . "\n");
print("((\$my_age <= 3) || (\$my_age >= 65)):\n");
print("You should stay home\n") if (($my_age <= 3) || ($my_age >= 65));

$my_age = 2;
print("\$my_age: " . pretty_json_stringify($my_age) . "\n");
print("((\$my_age <= 3) or (\$my_age >= 65)):\n");
print("You should stay home\n") if (($my_age <= 3) or ($my_age >= 65));

$my_age = 89;
print("\$my_age: " . pretty_json_stringify($my_age) . "\n");
print("((\$my_age <= 3) or (\$my_age >= 65)):\n");
print("You should stay home\n") if (($my_age <= 3) or ($my_age >= 65));

print("\n# Logical NOT [!, not]\n\n");

$can_drive = 0;
print("\$can_drive: " . bool_to_string($can_drive) . "\n");
print("!\$can_drive: " . bool_to_string(!$can_drive) . "\n");

$can_drive = 1;
print("\$can_drive: " . bool_to_string($can_drive) . "\n");
print("!\$can_drive: " . bool_to_string(!$can_drive) . "\n");

$can_drive = 0;
print("\$can_drive: " . bool_to_string($can_drive) . "\n");
print("not \$can_drive: " . bool_to_string(not $can_drive) . "\n");

$can_drive = 1;
print("\$can_drive: " . bool_to_string($can_drive) . "\n");
print("not \$can_drive: " . bool_to_string(not $can_drive) . "\n");
