use strict;
use warnings;
use Scalar::Util qw(looks_like_number);

sub json_stringify {
    my ($anything_ref, %additional_parameter) = @_;
    my $pretty = $additional_parameter{"pretty"} // 0;
    my $indent = $additional_parameter{"indent"} // "    ";
    my $indent_level = 0;
    my $json_stringify_inner;
    $json_stringify_inner = sub {
        my ($anything_inner_ref, $indent_inner) = @_;
        return "null" if (!defined($anything_inner_ref));
        return "$anything_inner_ref" if looks_like_number($anything_inner_ref);
        return "\"" . $anything_inner_ref . "\"" if (ref($anything_inner_ref) eq "");
        if (ref($anything_inner_ref) eq "ARRAY") {
            return "[]" if (scalar(@{$anything_inner_ref}) == 0);
            $indent_level += 1;
            my $result = (!$pretty ? "[" : ("[\n" . ($indent_inner x $indent_level)));
            for my $array_item_index (0..(scalar(@{$anything_inner_ref}) - 1)) {
                my $array_item = $anything_inner_ref->[$array_item_index];
                $result .= $json_stringify_inner->($array_item, $indent_inner);
                $result .= (!$pretty ? ", " : (",\n" . ($indent_inner x $indent_level))) if (($array_item_index + 1) != scalar(@{$anything_inner_ref}));
            }
            $indent_level -= 1;
            $result .= (!$pretty ? "]" : ("\n" . ($indent_inner x $indent_level) . "]"));
            return $result;
        }
        if (ref($anything_inner_ref) eq "HASH") {
            return "{}" if (scalar(keys(%{$anything_inner_ref})) == 0);
            $indent_level += 1;
            my $result = (!$pretty ? "{" : ("{\n" . ($indent_inner x $indent_level)));
            my $object_entry_index = 0;
            foreach my $object_key (keys(%{$anything_inner_ref})) {
                my $object_value = $anything_inner_ref->{$object_key};
                $result .= "\"" . $object_key . "\": " . $json_stringify_inner->($object_value, $indent_inner);
                $result .= (!$pretty ? ", " : (",\n" . ($indent_inner x $indent_level))) if (($object_entry_index + 1) != scalar(keys(%{$anything_inner_ref})));
                $object_entry_index += 1;
            }
            $indent_level -= 1;
            $result .= (!$pretty ? "}" : ("\n" . ($indent_inner x $indent_level) . "}"));
            return $result;
        }
        return "null";
    };
    return $json_stringify_inner->($anything_ref, $indent);
}

sub is_false {
    my ($anything) = @_;
    return (($anything == 0) || ($anything eq "0") || !defined($anything) || ($anything eq "") || (ref($anything) eq "ARRAY" && scalar(@{$anything}) == 0));
}

sub bool_to_string {
    my ($anything) = @_;
    return (is_false($anything) ? "false" : "true");
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

# in Perl, There's no true or false 🤮

my $correct_answer;
my $my_age;
my $my_answer;
my $has_driving_license;
my $can_drive;

print("\n# basic conditional control flow\n", "\n");

$my_age = 10;
print("\$my_age: ", json_stringify($my_age), "\n");
if ($my_age > 24) {
    print("you are old", "\n");
} elsif ($my_age > 17) {
    print("you are young", "\n");
} else {
    print("you are under age", "\n");
}

$my_age = 10;
print("\$my_age: ", json_stringify($my_age), "\n");
unless ($my_age <= 24) {
    print("you are old", "\n");
} else {
    print("you are young", "\n");
}

print("\n# equal to [==, eq]\n", "\n");

$my_answer = "100";
print("\$my_answer: ", json_stringify($my_answer), "\n");
$correct_answer = 100;
print("\$correct_answer: ", json_stringify($correct_answer), "\n");
print("(\$my_answer == \$correct_answer):", "\n");
if ($my_answer == $correct_answer) {
    print("Your answer is correct", "\n");
} else {
    print("Your answer is wrong", "\n");
}

$my_answer = "100";
print("\$my_answer: ", json_stringify($my_answer), "\n");
$correct_answer = 100;
print("\$correct_answer: ", json_stringify($correct_answer), "\n");
print("(\$my_answer eq \$correct_answer):", "\n");
if ($my_answer eq $correct_answer) {
    print("Your answer is correct", "\n");
} else {
    print("Your answer is wrong", "\n");
}

$my_answer = 100;
print("\$my_answer: ", json_stringify($my_answer), "\n");
$correct_answer = 100;
print("\$correct_answer: ", json_stringify($correct_answer), "\n");
print("(\$my_answer == \$correct_answer):", "\n");
if ($my_answer == $correct_answer) {
    print("Your answer is correct", "\n");
} else {
    print("Your answer is wrong", "\n");
}

$my_answer = 100;
print("\$my_answer: ", json_stringify($my_answer), "\n");
$correct_answer = 100;
print("\$correct_answer: ", json_stringify($correct_answer), "\n");
print("(\$my_answer eq \$correct_answer):", "\n");
if ($my_answer eq $correct_answer) {
    print("Your answer is correct", "\n");
} else {
    print("Your answer is wrong", "\n");
}

print("\n# not equal to [!=, ne]\n", "\n");

$my_answer = "25";
print("\$my_answer: ", json_stringify($my_answer), "\n");
$correct_answer = 100;
print("\$correct_answer: ", json_stringify($correct_answer), "\n");
print("(\$my_answer != \$correct_answer):", "\n");
if ($my_answer != $correct_answer) {
    print("Your answer is correct", "\n");
} else {
    print("Your answer is wrong", "\n");
}

$my_answer = "25";
print("\$my_answer: ", json_stringify($my_answer), "\n");
$correct_answer = 100;
print("\$correct_answer: ", json_stringify($correct_answer), "\n");
print("(\$my_answer ne \$correct_answer):", "\n");
if ($my_answer ne $correct_answer) {
    print("Your answer is correct", "\n");
} else {
    print("Your answer is wrong", "\n");
}

$my_answer = 25;
print("\$my_answer: ", json_stringify($my_answer), "\n");
$correct_answer = 100;
print("\$correct_answer: ", json_stringify($correct_answer), "\n");
print("(\$my_answer != \$correct_answer):", "\n");
if ($my_answer != $correct_answer) {
    print("Your answer is correct", "\n");
} else {
    print("Your answer is wrong", "\n");
}

$my_answer = 25;
print("\$my_answer: ", json_stringify($my_answer), "\n");
$correct_answer = 100;
print("\$correct_answer: ", json_stringify($correct_answer), "\n");
print("(\$my_answer ne \$correct_answer):", "\n");
if ($my_answer ne $correct_answer) {
    print("Your answer is correct", "\n");
} else {
    print("Your answer is wrong", "\n");
}

print("\n# greater than [>, gt]\n", "\n");

$my_age = "70";
print("\$my_age: ", json_stringify($my_age), "\n");
print("(", json_stringify($my_age), " > 50):", "\n");
print("You are old", "\n") if ($my_age > 50);

$my_age = "70";
print("\$my_age: ", json_stringify($my_age), "\n");
print("(", json_stringify($my_age), " gt 50):", "\n");
print("You are old", "\n") if ($my_age gt 50);

$my_age = 70;
print("\$my_age: ", json_stringify($my_age), "\n");
print("(", json_stringify($my_age), " > 50):", "\n");
print("You are old", "\n") if ($my_age > 50);

$my_age = 70;
print("\$my_age: ", json_stringify($my_age), "\n");
print("(", json_stringify($my_age), " gt 50):", "\n");
print("You are old", "\n") if ($my_age gt 50);

print("\n# less than [<, lt]\n", "\n");

$my_age = "16";
print("\$my_age: ", json_stringify($my_age), "\n");
print("(", json_stringify($my_age), " < 20):", "\n");
print("You are young", "\n") if ($my_age < 20);

$my_age = "16";
print("\$my_age: ", json_stringify($my_age), "\n");
print("(", json_stringify($my_age), " lt 20):", "\n");
print("You are young", "\n") if ($my_age lt 20);

$my_age = 16;
print("\$my_age: ", json_stringify($my_age), "\n");
print("(", json_stringify($my_age), " < 20):", "\n");
print("You are young", "\n") if ($my_age < 20);

$my_age = 16;
print("\$my_age: ", json_stringify($my_age), "\n");
print("(", json_stringify($my_age), " lt 20):", "\n");
print("You are young", "\n") if ($my_age lt 20);

print("\n# greater than or equal to [>=, ge]\n", "\n");

$my_age = "73";
print("\$my_age: ", json_stringify($my_age), "\n");
print("(", json_stringify($my_age), " >= 65):", "\n");
print("You are allowed to retire", "\n") if ($my_age >= 65);

$my_age = "73";
print("\$my_age: ", json_stringify($my_age), "\n");
print("(", json_stringify($my_age), " ge 65):", "\n");
print("You are allowed to retire", "\n") if ($my_age ge 65);

$my_age = 73;
print("\$my_age: ", json_stringify($my_age), "\n");
print("(", json_stringify($my_age), " >= 65):", "\n");
print("You are allowed to retire", "\n") if ($my_age >= 65);

$my_age = 73;
print("\$my_age: ", json_stringify($my_age), "\n");
print("(", json_stringify($my_age), " ge 65):", "\n");
print("You are allowed to retire", "\n") if ($my_age ge 65);

print("\n# less than or equal to [<=, le]\n", "\n");

$my_age = "14"; 
print("\$my_age: ", json_stringify($my_age), "\n");
print("(", json_stringify($my_age), " <= 16):", "\n");
print("You are not allowed to drive", "\n") if ($my_age <= 16);

$my_age = "14"; 
print("\$my_age: ", json_stringify($my_age), "\n");
print("(", json_stringify($my_age), " le 16):", "\n");
print("You are not allowed to drive", "\n") if ($my_age le 16);

$my_age = 14; 
print("\$my_age: ", json_stringify($my_age), "\n");
print("(", json_stringify($my_age), " <= 16):", "\n");
print("You are not allowed to drive", "\n") if ($my_age <= 16);

$my_age = 14; 
print("\$my_age: ", json_stringify($my_age), "\n");
print("(", json_stringify($my_age), " le 16):", "\n");
print("You are not allowed to drive", "\n") if ($my_age le 16);

print("\n# Logical AND [&&, and]\n", "\n");

$my_age = 17;
print("\$my_age: ", json_stringify($my_age), "\n");
$has_driving_license = 0;
print("\$has_driving_license: ", bool_to_string($has_driving_license), "\n");
print("((\$my_age >= 17) && \$has_driving_license):", "\n");
print(((($my_age >= 17) && $has_driving_license) ? "You are allowed to drive" : "You are not allowed to drive"), "\n");

$my_age = 17;
print("\$my_age: ", json_stringify($my_age), "\n");
$has_driving_license = 1;
print("\$has_driving_license: ", bool_to_string($has_driving_license), "\n");
print("((\$my_age >= 17) && \$has_driving_license):", "\n");
print(((($my_age >= 17) && $has_driving_license) ? "You are allowed to drive" : "You are not allowed to drive"), "\n");

$my_age = 17;
print("\$my_age: ", json_stringify($my_age), "\n");
$has_driving_license = 0;
print("\$has_driving_license: ", bool_to_string($has_driving_license), "\n");
print("((\$my_age >= 17) and \$has_driving_license):", "\n");
print(((($my_age >= 17) and $has_driving_license) ? "You are allowed to drive" : "You are not allowed to drive"), "\n");

$my_age = 17;
print("\$my_age: ", json_stringify($my_age), "\n");
$has_driving_license = 1;
print("\$has_driving_license: ", bool_to_string($has_driving_license), "\n");
print("((\$my_age >= 17) and \$has_driving_license):", "\n");
print(((($my_age >= 17) and $has_driving_license) ? "You are allowed to drive" : "You are not allowed to drive"), "\n");

print("\n# Logical OR [||, or]\n", "\n");

$my_age = 2;
print("\$my_age: ", json_stringify($my_age), "\n");
print("((\$my_age <= 3) || (\$my_age >= 65)):", "\n");
print("You should stay home", "\n") if (($my_age <= 3) || ($my_age >= 65));

$my_age = 89;
print("\$my_age: ", json_stringify($my_age), "\n");
print("((\$my_age <= 3) || (\$my_age >= 65)):", "\n");
print("You should stay home", "\n") if (($my_age <= 3) || ($my_age >= 65));

$my_age = 2;
print("\$my_age: ", json_stringify($my_age), "\n");
print("((\$my_age <= 3) or (\$my_age >= 65)):", "\n");
print("You should stay home", "\n") if (($my_age <= 3) or ($my_age >= 65));

$my_age = 89;
print("\$my_age: ", json_stringify($my_age), "\n");
print("((\$my_age <= 3) or (\$my_age >= 65)):", "\n");
print("You should stay home", "\n") if (($my_age <= 3) or ($my_age >= 65));

print("\n# Logical NOT [!, not]\n", "\n");

$can_drive = 0;
print("\$can_drive: ", bool_to_string($can_drive), "\n");
print("!\$can_drive: ", bool_to_string(!$can_drive), "\n");

$can_drive = 1;
print("\$can_drive: ", bool_to_string($can_drive), "\n");
print("!\$can_drive: ", bool_to_string(!$can_drive), "\n");

$can_drive = 0;
print("\$can_drive: ", bool_to_string($can_drive), "\n");
print("not \$can_drive: ", bool_to_string(not $can_drive), "\n");

$can_drive = 1;
print("\$can_drive: ", bool_to_string($can_drive), "\n");
print("not \$can_drive: ", bool_to_string(not $can_drive), "\n");
