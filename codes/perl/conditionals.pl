=begin
Relational Operators / Comparison Operators:
equal to [==, eq]
not equal to [!=, ne]
greater than [>, gt]
less than [<, lt]
greater then or equal to [>=, ge]
less then or equal to [<=, le]

Logical Operators:
Logical AND [&&, and]
Logical OR [||, or]
Logical NOT [!, not]
=cut

sub print_bool {
    my ($val) = @_;
    return $val ? "true" : "false";
}

my $CORRECT_ANSWER = 100;

my $my_age;
my $my_answer;
my $has_driving_license;
my $can_drive;

print("\n# equal to [==, eq]\n");

$my_answer = "100";
print("\$my_answer: " . $my_answer . "\n");
print("\$CORRECT_ANSWER: " . $CORRECT_ANSWER . "\n");
print("(\$my_answer == \$CORRECT_ANSWER): " . "\n");
if ($my_answer == $CORRECT_ANSWER) {
    print("Your answer is correct" . "\n");
} else {
    print("Your answer is wrong" . "\n");
}

$my_answer = "100";
print("\$my_answer: " . $my_answer . "\n");
print("\$CORRECT_ANSWER: " . $CORRECT_ANSWER . "\n");
print("(\$my_answer eq \$CORRECT_ANSWER): " . "\n");
if ($my_answer eq $CORRECT_ANSWER) {
    print("Your answer is correct" . "\n");
} else {
    print("Your answer is wrong" . "\n");
}

$my_answer = 100;
print("\$my_answer: " . $my_answer . "\n");
print("\$CORRECT_ANSWER: " . $CORRECT_ANSWER . "\n");
print("(\$my_answer == \$CORRECT_ANSWER): " . "\n");
if ($my_answer == $CORRECT_ANSWER) {
    print("Your answer is correct" . "\n");
} else {
    print("Your answer is wrong" . "\n");
}

$my_answer = 100;
print("\$my_answer: " . $my_answer . "\n");
print("\$CORRECT_ANSWER: " . $CORRECT_ANSWER . "\n");
print("(\$my_answer eq \$CORRECT_ANSWER): " . "\n");
if ($my_answer eq $CORRECT_ANSWER) {
    print("Your answer is correct" . "\n");
} else {
    print("Your answer is wrong" . "\n");
}

print("\n# not equal to [!=, ne]\n");

$my_answer = "25";
print("\$my_answer: " . $my_answer . "\n");
print("\$CORRECT_ANSWER: " . $CORRECT_ANSWER . "\n");
print("(\$my_answer != \$CORRECT_ANSWER): " . "\n");
if ($my_answer != $CORRECT_ANSWER) {
    print("Your answer is correct" . "\n");
} else {
    print("Your answer is wrong" . "\n");
}

$my_answer = "25";
print("\$my_answer: " . $my_answer . "\n");
print("\$CORRECT_ANSWER: " . $CORRECT_ANSWER . "\n");
print("(\$my_answer ne \$CORRECT_ANSWER): " . "\n");
if ($my_answer ne $CORRECT_ANSWER) {
    print("Your answer is correct" . "\n");
} else {
    print("Your answer is wrong" . "\n");
}

$my_answer = 25;
print("\$my_answer: " . $my_answer . "\n");
print("\$CORRECT_ANSWER: " . $CORRECT_ANSWER . "\n");
print("(\$my_answer != \$CORRECT_ANSWER): " . "\n");
if ($my_answer != $CORRECT_ANSWER) {
    print("Your answer is correct" . "\n");
} else {
    print("Your answer is wrong" . "\n");
}

$my_answer = 25;
print("\$my_answer: " . $my_answer . "\n");
print("\$CORRECT_ANSWER: " . $CORRECT_ANSWER . "\n");
print("(\$my_answer ne \$CORRECT_ANSWER): " . "\n");
if ($my_answer ne $CORRECT_ANSWER) {
    print("Your answer is correct" . "\n");
} else {
    print("Your answer is wrong" . "\n");
}

print("\n# greater than [>, gt]\n");

$my_age = "70";
print("\$my_age: " . $my_age . "\n");
print("(\$my_age > 50): " . "\n");
print("You are old" . "\n") if ($my_age > 50);

$my_age = "70";
print("\$my_age: " . $my_age . "\n");
print("(\$my_age gt 50): " . "\n");
print("You are old" . "\n") if ($my_age gt 50);

$my_age = 70;
print("\$my_age: " . $my_age . "\n");
print("(\$my_age > 50): " . "\n");
print("You are old" . "\n") if ($my_age > 50);

$my_age = 70;
print("\$my_age: " . $my_age . "\n");
print("(\$my_age gt 50): " . "\n");
print("You are old" . "\n") if ($my_age gt 50);

print("\n# less than [<, lt]\n");

$my_age = "16";
print("\$my_age: " . $my_age . "\n");
print("(\$my_age < 20): " . "\n");
print("You are young" . "\n") if ($my_age < 20);

$my_age = "16";
print("\$my_age: " . $my_age . "\n");
print("(\$my_age lt 20): " . "\n");
print("You are young" . "\n") if ($my_age lt 20);

$my_age = 16;
print("\$my_age: " . $my_age . "\n");
print("(\$my_age < 20): " . "\n");
print("You are young" . "\n") if ($my_age < 20);

$my_age = 16;
print("\$my_age: " . $my_age . "\n");
print("(\$my_age lt 20): " . "\n");
print("You are young" . "\n") if ($my_age lt 20);

print("\n# greater then or equal to [>=, ge]\n");

$my_age = "73";
print("\$my_age: " . $my_age . "\n");
print("(\$my_age >= 65): " . "\n");
print("You are allowed to retire" . "\n") if ($my_age >= 65);

$my_age = "73";
print("\$my_age: " . $my_age . "\n");
print("(\$my_age ge 65): " . "\n");
print("You are allowed to retire" . "\n") if ($my_age ge 65);

$my_age = 73;
print("\$my_age: " . $my_age . "\n");
print("(\$my_age >= 65): " . "\n");
print("You are allowed to retire" . "\n") if ($my_age >= 65);

$my_age = 73;
print("\$my_age: " . $my_age . "\n");
print("(\$my_age ge 65): " . "\n");
print("You are allowed to retire" . "\n") if ($my_age ge 65);

print("\n# less then or equal to [<=, le]\n");

$my_age = "14"; 
print("\$my_age: " . $my_age . "\n");
print("(\$my_age <= 16): " . "\n");
print("You are not allowed to drive" . "\n") if ($my_age <= 16);

$my_age = "14"; 
print("\$my_age: " . $my_age . "\n");
print("(\$my_age le 16): " . "\n");
print("You are not allowed to drive" . "\n") if ($my_age le 16);

$my_age = 14; 
print("\$my_age: " . $my_age . "\n");
print("(\$my_age <= 16): " . "\n");
print("You are not allowed to drive" . "\n") if ($my_age <= 16);

$my_age = 14; 
print("\$my_age: " . $my_age . "\n");
print("(\$my_age le 16): " . "\n");
print("You are not allowed to drive" . "\n") if ($my_age le 16);

print("\n# Logical AND [&&, and]\n");

$my_age = 17;
print("\$my_age: " . $my_age . "\n");
$has_driving_license = 0;
print("\$has_driving_license: " . print_bool($has_driving_license) . "\n");
print("((\$my_age >= 17) && \$has_driving_license): " . "\n");
print(((($my_age >= 17) && $has_driving_license) ? "You are allowed to drive" . "\n" : "You are not allowed to drive" . "\n"));

$my_age = 17;
print("\$my_age: " . $my_age . "\n");
$has_driving_license = 1;
print("\$has_driving_license: " . print_bool($has_driving_license) . "\n");
print("((\$my_age >= 17) && \$has_driving_license): " . "\n");
print(((($my_age >= 17) && $has_driving_license) ? "You are allowed to drive" . "\n" : "You are not allowed to drive" . "\n"));

$my_age = 17;
print("\$my_age: " . $my_age . "\n");
$has_driving_license = 0;
print("\$has_driving_license: " . print_bool($has_driving_license) . "\n");
print("((\$my_age >= 17) and \$has_driving_license): " . "\n");
print(((($my_age >= 17) and $has_driving_license) ? "You are allowed to drive" . "\n" : "You are not allowed to drive" . "\n"));

$my_age = 17;
print("\$my_age: " . $my_age . "\n");
$has_driving_license = 1;
print("\$has_driving_license: " . print_bool($has_driving_license) . "\n");
print("((\$my_age >= 17) and \$has_driving_license): " . "\n");
print(((($my_age >= 17) and $has_driving_license) ? "You are allowed to drive" . "\n" : "You are not allowed to drive" . "\n"));

print("\n# Logical OR [||, or]\n");

$my_age = 2;
print("\$my_age: " . $my_age . "\n");
print("((\$my_age <= 3) || (\$my_age >= 65)): " . "\n");
print("You should stay home" . "\n") if (($my_age <= 3) || ($my_age >= 65));

$my_age = 89;
print("\$my_age: " . $my_age . "\n");
print("((\$my_age <= 3) || (\$my_age >= 65)): " . "\n");
print("You should stay home" . "\n") if (($my_age <= 3) || ($my_age >= 65));

$my_age = 2;
print("\$my_age: " . $my_age . "\n");
print("((\$my_age <= 3) or (\$my_age >= 65)): " . "\n");
print("You should stay home" . "\n") if (($my_age <= 3) or ($my_age >= 65));

$my_age = 89;
print("\$my_age: " . $my_age . "\n");
print("((\$my_age <= 3) or (\$my_age >= 65)): " . "\n");
print("You should stay home" . "\n") if (($my_age <= 3) or ($my_age >= 65));

print("\n# Logical NOT [!, not]\n");

$can_drive = 0;
print("\$can_drive:" . print_bool($can_drive) . "\n");
print("!\$can_drive:" . print_bool(!$can_drive) . "\n");

$can_drive = 1;
print("\$can_drive:" . print_bool($can_drive) . "\n");
print("!\$can_drive:" . print_bool(!$can_drive) . "\n");

$can_drive = 0;
print("\$can_drive:" . print_bool($can_drive) . "\n");
print("not \$can_drive:" . print_bool(not $can_drive) . "\n");

$can_drive = 1;
print("\$can_drive:" . print_bool($can_drive) . "\n");
print("not \$can_drive:" . print_bool(not $can_drive) . "\n");
