use strict;
# use warnings;

my $js_like_type_ref = {
    "Null" => "Null",
    "Boolean" => "Boolean",
    "String" => "String",
    "Numeric" => "Numeric",
    "Object" => "Object",
    "Array" => "Array",
    "Function" => "Function"
};

sub boolean {
    my ($anything_ref) = @_;
    return ($anything_ref ? "true" : "false");
}

sub string {
    my ($anything_ref) = @_;
    return ($anything_ref . "");
}

sub object {
    my ($an_object_ref) = @_;
    return \%{$an_object_ref};
}

sub is_like_js_null {
    my ($anything_ref) = @_;
    return ((defined $anything_ref) ? "false" : "true");
}

sub is_like_js_boolean {
    my ($anything_ref) = @_;
    return "false" if (is_like_js_null($anything_ref) eq "true");
    return ((($anything_ref eq "true") || ($anything_ref eq "false")) ? "true" : "false");
}

sub is_like_js_string {
    my ($anything_ref) = @_;
    return "false" if (is_like_js_null($anything_ref) eq "true");
    return ((($anything_ref ne (string($anything_ref) + 0)) && (is_like_js_boolean($anything_ref) eq "false")) ? "true" : "false");
}

sub is_like_js_numeric {
    my ($anything_ref) = @_;
    return "false" if (is_like_js_null($anything_ref) eq "true");
    return ((($anything_ref + 0) eq $anything_ref) ? "true" : "false");
}

sub is_like_js_object {
    my ($anything_ref) = @_;
    return "false" if (is_like_js_null($anything_ref) eq "true");
    return (((ref $anything_ref) eq "HASH") ? "true" : "false");
}

sub is_like_js_array {
    my ($anything_ref) = @_;
    return "false" if (is_like_js_null($anything_ref) eq "true");
    return (((ref $anything_ref) eq "ARRAY") ? "true" : "false");
}

sub is_like_js_function {
    my ($anything_ref) = @_;
    return "false" if (is_like_js_null($anything_ref) eq "true");
    return (((ref $anything_ref) eq "CODE") ? "true" : "false");
}

sub get_type {
    my ($anything_ref) = @_;
    return throw_error_if_null($js_like_type_ref->{"Null"}) if (is_like_js_null($anything_ref) eq "true");
    return throw_error_if_null($js_like_type_ref->{"Function"}) if (is_like_js_function($anything_ref) eq "true");
    return throw_error_if_null($js_like_type_ref->{"Object"}) if (is_like_js_object($anything_ref) eq "true");
    return throw_error_if_null($js_like_type_ref->{"Array"}) if (is_like_js_array($anything_ref) eq "true");
    return throw_error_if_null($js_like_type_ref->{"Boolean"}) if (is_like_js_boolean($anything_ref) eq "true");
    return throw_error_if_null($js_like_type_ref->{"String"}) if (is_like_js_string($anything_ref) eq "true");
    return throw_error_if_null($js_like_type_ref->{"Numeric"}) if (is_like_js_numeric($anything_ref) eq "true");
    my $anything_ref_unknown_type = (ref $anything_ref);
    return (($anything_ref_unknown_type eq "") ? '"UNKNOWN"' : $anything_ref_unknown_type);
}

sub throw_error_if_null {
    my ($anything_ref) = @_;
    die "object key not found in the object" if (is_like_js_null($anything_ref) eq "true");
    return $anything_ref;
}

sub negate {
    my ($anything_ref) = @_;
    return "false" if ((is_like_js_boolean($anything_ref) eq "true") && ($anything_ref eq "true"));
    return "true" if ((is_like_js_boolean($anything_ref) eq "true") && ($anything_ref eq "false"));
    die 'expected string ("true"/"false")';
}

sub json_stringify {
    my ($anything_ref, %keyword_argument) = @_;
    my $optional_argument = {%keyword_argument};
    my $pretty = ((get_type($optional_argument->{"pretty"}) eq throw_error_if_null($js_like_type_ref->{"Boolean"})) ? ($optional_argument->{"pretty"}) : "false");
    my $indent_default = (" " x 4);
    my $indent_level = 0;
    my $json_stringify_inner;
    $json_stringify_inner = sub {
        my ($anything_inner_ref) = @_;
        my $anything_inner_ref_type = get_type($anything_inner_ref);
        return "null" if ($anything_inner_ref_type eq throw_error_if_null($js_like_type_ref->{"Null"}));
        return "[object Function]" if ($anything_inner_ref_type eq throw_error_if_null($js_like_type_ref->{"Function"}));
        if ($anything_inner_ref_type eq throw_error_if_null($js_like_type_ref->{"Object"})) {
            my $object_keys_ref = [keys(%{$anything_inner_ref})];
            return "{}" if (scalar(@{$object_keys_ref}) == 0);
            $indent_level += 1;
            my $result = (($pretty eq "true") ? ("{\n" . ($indent_default x $indent_level)) : "{ ");
            my $object_entry_index = 0;
            while (my ($object_key, $object_value) = each(%{$anything_inner_ref})) {
                $result .= '"' . $object_key . '": ' . $json_stringify_inner->($object_value);
                $result .= (($pretty eq "true") ? (",\n" . ($indent_default x $indent_level)) : ", ") if (($object_entry_index + 1) != scalar(@{$object_keys_ref}));
                $object_entry_index += 1;
            }
            $indent_level -= 1;
            $result .= (($pretty eq "true") ? ("\n" . ($indent_default x $indent_level) . "}") : " }");
            return $result;
        }
        if ($anything_inner_ref_type eq throw_error_if_null($js_like_type_ref->{"Array"})) {
            my $array_length = scalar(@{$anything_inner_ref});
            return "[]" if ($array_length == 0);
            $indent_level += 1;
            my $result = (($pretty eq "true") ? ("[\n" . ($indent_default x $indent_level)) : "[");
            for (my $array_item_index = 0; ($array_item_index < scalar(@{$anything_inner_ref})); $array_item_index += 1) {
                my $array_item = $anything_inner_ref->[$array_item_index];
                $result .= $json_stringify_inner->($array_item);
                $result .= (($pretty eq "true") ? (",\n" . ($indent_default x $indent_level)) : ", ") if (($array_item_index + 1) != $array_length);
            }
            $indent_level -= 1;
            $result .= (($pretty eq "true") ? ("\n" . ($indent_default x $indent_level) . "]") : "]");
            return $result;
        }
        return "true" if (($anything_inner_ref_type eq throw_error_if_null($js_like_type_ref->{"Boolean"})) && ($anything_inner_ref eq "true"));
        return "false" if (($anything_inner_ref_type eq throw_error_if_null($js_like_type_ref->{"Boolean"})) && ($anything_inner_ref eq "false"));
        return '"' . $anything_inner_ref . '"' if ($anything_inner_ref_type eq throw_error_if_null($js_like_type_ref->{"String"}));
        return string($anything_inner_ref) if ($anything_inner_ref_type eq throw_error_if_null($js_like_type_ref->{"Numeric"}));
        return $anything_inner_ref_type;
    };
    return $json_stringify_inner->($anything_ref);
}

sub array_reduce {
    # JavaScript-like Array.reduce() function
    my ($callback_function_ref, $an_array_ref, $initial_value_ref) = @_;
    my $result_ref = $initial_value_ref;
    for (my $array_item_index = 0; ($array_item_index < scalar(@{$an_array_ref})); $array_item_index += 1) {
        my $array_item_ref = $an_array_ref->[$array_item_index];
        $result_ref = $callback_function_ref->($result_ref, $array_item_ref, $array_item_index, $an_array_ref);
    }
    return $result_ref;
}

sub string_interpolation {
    return (array_reduce((sub {
        my ($current_result_ref, $current_argument_ref) = @_;
        my $current_argument_type = get_type($current_argument_ref);
        return ($current_result_ref . $current_argument_ref) if ($current_argument_type eq throw_error_if_null($js_like_type_ref->{"String"}));
        return ($current_result_ref . (json_stringify($current_argument_ref->[0]))) if (($current_argument_type eq throw_error_if_null($js_like_type_ref->{"Array"})) && (scalar(@{$current_argument_ref}) == 1));
        return ($current_result_ref . (json_stringify($current_argument_ref)));
    }), \@_, ""));
}

sub console_log {
    print(string_interpolation(@_) . "\n");
}

sub optional_chaining {
    my ($anything_ref, @array_index_or_object_key_or_function_argument_array) = @_;
    # JavaScript-like Optional Chaining Operator (?.) function optional_chaining_v1
    my $anything_ref_type = get_type($anything_ref);
    return $anything_ref->(@array_index_or_object_key_or_function_argument_array) if ($anything_ref_type eq throw_error_if_null($js_like_type_ref->{"Function"}));
    return $anything_ref if ((($anything_ref_type ne throw_error_if_null($js_like_type_ref->{"Object"})) && ($anything_ref_type ne throw_error_if_null($js_like_type_ref->{"Array"}))) || (scalar(@array_index_or_object_key_or_function_argument_array) == 0));
    return array_reduce((sub {
        my ($current_result_ref, $current_item_ref) = @_;
        my $current_result_ref_type = get_type($current_result_ref);
        my $current_item_ref_type = get_type($current_item_ref);
        return $anything_ref->{(string($current_item_ref))} if (($current_result_ref_type eq throw_error_if_null($js_like_type_ref->{"Null"})) && ($anything_ref_type eq throw_error_if_null($js_like_type_ref->{"Object"})) && ($current_item_ref_type eq throw_error_if_null($js_like_type_ref->{"String"})));
        return $anything_ref->[(int($current_item_ref))] if (($current_result_ref_type eq throw_error_if_null($js_like_type_ref->{"Null"})) && ($anything_ref_type eq throw_error_if_null($js_like_type_ref->{"Array"})) && ($current_item_ref_type eq throw_error_if_null($js_like_type_ref->{"Numeric"})) && (((int($current_item_ref)) >= 0) || ((int($current_item_ref)) == -1)) && (scalar(@{$anything_ref}) > (int($current_item_ref))));
        return $current_result_ref->{(string($current_item_ref))} if (($current_result_ref_type eq throw_error_if_null($js_like_type_ref->{"Object"})) && ($current_item_ref_type eq throw_error_if_null($js_like_type_ref->{"String"})));
        return $current_result_ref->[(int($current_item_ref))] if (($current_result_ref_type eq throw_error_if_null($js_like_type_ref->{"Array"})) && ($current_item_ref_type eq throw_error_if_null($js_like_type_ref->{"Numeric"})) && (((int($current_item_ref)) >= 0) || ((int($current_item_ref)) == -1)) && (scalar(@{$current_result_ref}) > (int($current_item_ref))));
        return undef;
    }), \@array_index_or_object_key_or_function_argument_array, undef);
}

sub object_from_entries {
    # JavaScript-like Object.fromEntries() function
    my ($an_object_entries_ref) = @_;
    my $new_object_ref = {};
    while (my ($object_entry_index, $object_entry_ref) = each(@{$an_object_entries_ref})) {
        my $object_key = $object_entry_ref->[0];
        my $object_value = $object_entry_ref->[1];
        $new_object_ref->{string($object_key)} = $object_value;
    }
    return $new_object_ref;
}

sub array_entries {
    # JavaScript-like Array.entries() function
    my ($an_array_ref) = @_;
    my $new_object_entries_ref = [];
    for (my $array_item_index = 0; ($array_item_index < scalar(@{$an_array_ref})); $array_item_index += 1) {
        my $array_item = $an_array_ref->[$array_item_index];
        push(@{$new_object_entries_ref}, [$array_item_index, $array_item]);
    }
    return $new_object_entries_ref;
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
    Logical NOT [!, not] (use negate() instead if You use string ("true"/"false")) for boolean value
=cut

# Perl doesn't have explicit built-in boolean type (true/false) 🤮, the truthy and the falsy values are also confusing. so I use string ("true"/"false") instead.

my $CORRECT_ANSWER;
my $my_age;
my $my_answer;
my $has_driving_license;
my $can_drive;

console_log("\n# basic conditional control flow\n");

$my_age = 10;
console_log(string_interpolation('$my_age: ', [$my_age]));
if ($my_age > 24) {
    console_log("you are old");
} elsif ($my_age > 17) {
    console_log("you are young");
} else {
    console_log("you are under age");
}

$my_age = 10;
console_log(string_interpolation('$my_age: ', [$my_age]));
unless ($my_age <= 24) {
    console_log("you are old");
} else {
    console_log("you are young");
}

console_log("\n# equal to [==, eq]\n");

$my_answer = "100";
console_log(string_interpolation('$my_answer: ', [$my_answer]));
$CORRECT_ANSWER = 100;
console_log('$CORRECT_ANSWER: ', [$CORRECT_ANSWER]);
console_log('($my_answer == $CORRECT_ANSWER):');
if ($my_answer == $CORRECT_ANSWER) {
    console_log("Your answer is correct");
} else {
    console_log("Your answer is wrong");
}

$my_answer = "100";
console_log(string_interpolation('$my_answer: ', [$my_answer]));
$CORRECT_ANSWER = 100;
console_log('$CORRECT_ANSWER: ', [$CORRECT_ANSWER]);
console_log('($my_answer eq $CORRECT_ANSWER):');
if ($my_answer eq $CORRECT_ANSWER) {
    console_log("Your answer is correct");
} else {
    console_log("Your answer is wrong");
}

$my_answer = 100;
console_log(string_interpolation('$my_answer: ', [$my_answer]));
$CORRECT_ANSWER = 100;
console_log('$CORRECT_ANSWER: ', [$CORRECT_ANSWER]);
console_log('($my_answer == $CORRECT_ANSWER):');
if ($my_answer == $CORRECT_ANSWER) {
    console_log("Your answer is correct");
} else {
    console_log("Your answer is wrong");
}

$my_answer = 100;
console_log(string_interpolation('$my_answer: ', [$my_answer]));
$CORRECT_ANSWER = 100;
console_log('$CORRECT_ANSWER: ', [$CORRECT_ANSWER]);
console_log('($my_answer eq $CORRECT_ANSWER):');
if ($my_answer eq $CORRECT_ANSWER) {
    console_log("Your answer is correct");
} else {
    console_log("Your answer is wrong");
}

console_log("\n# not equal to [!=, ne]\n");

$my_answer = "25";
console_log(string_interpolation('$my_answer: ', [$my_answer]));
$CORRECT_ANSWER = 100;
console_log('$CORRECT_ANSWER: ', [$CORRECT_ANSWER]);
console_log('($my_answer != $CORRECT_ANSWER):');
if ($my_answer != $CORRECT_ANSWER) {
    console_log("Your answer is correct");
} else {
    console_log("Your answer is wrong");
}

$my_answer = "25";
console_log(string_interpolation('$my_answer: ', [$my_answer]));
$CORRECT_ANSWER = 100;
console_log('$CORRECT_ANSWER: ', [$CORRECT_ANSWER]);
console_log('($my_answer ne $CORRECT_ANSWER):');
if ($my_answer ne $CORRECT_ANSWER) {
    console_log("Your answer is correct");
} else {
    console_log("Your answer is wrong");
}

$my_answer = 25;
console_log(string_interpolation('$my_answer: ', [$my_answer]));
$CORRECT_ANSWER = 100;
console_log('$CORRECT_ANSWER: ', [$CORRECT_ANSWER]);
console_log('($my_answer != $CORRECT_ANSWER):');
if ($my_answer != $CORRECT_ANSWER) {
    console_log("Your answer is correct");
} else {
    console_log("Your answer is wrong");
}

$my_answer = 25;
console_log(string_interpolation('$my_answer: ', [$my_answer]));
$CORRECT_ANSWER = 100;
console_log('$CORRECT_ANSWER: ', [$CORRECT_ANSWER]);
console_log('($my_answer ne $CORRECT_ANSWER):');
if ($my_answer ne $CORRECT_ANSWER) {
    console_log("Your answer is correct");
} else {
    console_log("Your answer is wrong");
}

console_log("\n# greater than [>, gt]\n");

$my_age = "70";
console_log(string_interpolation('$my_age: ', [$my_age]));
console_log(string_interpolation("(", [$my_age], " > 50):"));
console_log("You are old") if ($my_age > 50);

$my_age = "70";
console_log(string_interpolation('$my_age: ', [$my_age]));
console_log(string_interpolation("(", [$my_age], " gt 50):"));
console_log("You are old") if ($my_age gt 50);

$my_age = 70;
console_log(string_interpolation('$my_age: ', [$my_age]));
console_log(string_interpolation("(", [$my_age], " > 50):"));
console_log("You are old") if ($my_age > 50);

$my_age = 70;
console_log(string_interpolation('$my_age: ', [$my_age]));
console_log(string_interpolation("(", [$my_age], " gt 50):"));
console_log("You are old") if ($my_age gt 50);

console_log("\n# less than [<, lt]\n");

$my_age = "16";
console_log(string_interpolation('$my_age: ', [$my_age]));
console_log(string_interpolation("(", [$my_age], " < 20):"));
console_log("You are young") if ($my_age < 20);

$my_age = "16";
console_log(string_interpolation('$my_age: ', [$my_age]));
console_log(string_interpolation("(", [$my_age], " lt 20):"));
console_log("You are young") if ($my_age lt 20);

$my_age = 16;
console_log(string_interpolation('$my_age: ', [$my_age]));
console_log(string_interpolation("(", [$my_age], " < 20):"));
console_log("You are young") if ($my_age < 20);

$my_age = 16;
console_log(string_interpolation('$my_age: ', [$my_age]));
console_log(string_interpolation("(", [$my_age], " lt 20):"));
console_log("You are young") if ($my_age lt 20);

console_log("\n# greater than or equal to [>=, ge]\n");

$my_age = "73";
console_log(string_interpolation('$my_age: ', [$my_age]));
console_log(string_interpolation("(", [$my_age], " >= 65):"));
console_log("You are allowed to retire") if ($my_age >= 65);

$my_age = "73";
console_log(string_interpolation('$my_age: ', [$my_age]));
console_log(string_interpolation("(", [$my_age], " ge 65):"));
console_log("You are allowed to retire") if ($my_age ge 65);

$my_age = 73;
console_log(string_interpolation('$my_age: ', [$my_age]));
console_log(string_interpolation("(", [$my_age], " >= 65):"));
console_log("You are allowed to retire") if ($my_age >= 65);

$my_age = 73;
console_log(string_interpolation('$my_age: ', [$my_age]));
console_log(string_interpolation("(", [$my_age], " ge 65):"));
console_log("You are allowed to retire") if ($my_age ge 65);

console_log("\n# less than or equal to [<=, le]\n");

$my_age = "14"; 
console_log(string_interpolation('$my_age: ', [$my_age]));
console_log(string_interpolation("(", [$my_age], " <= 16):"));
console_log("You are not allowed to drive") if ($my_age <= 16);

$my_age = "14"; 
console_log(string_interpolation('$my_age: ', [$my_age]));
console_log(string_interpolation("(", [$my_age], " le 16):"));
console_log("You are not allowed to drive") if ($my_age le 16);

$my_age = 14; 
console_log(string_interpolation('$my_age: ', [$my_age]));
console_log(string_interpolation("(", [$my_age], " <= 16):"));
console_log("You are not allowed to drive") if ($my_age <= 16);

$my_age = 14; 
console_log(string_interpolation('$my_age: ', [$my_age]));
console_log(string_interpolation("(", [$my_age], " le 16):"));
console_log("You are not allowed to drive") if ($my_age le 16);

console_log("\n# Logical AND [&&, and]\n");

$my_age = 17;
console_log(string_interpolation('$my_age: ', [$my_age]));
$has_driving_license = "false";
console_log('$has_driving_license: ', [$has_driving_license]);
console_log('(($my_age >= 17) && $has_driving_license):');
console_log(((($my_age >= 17) && $has_driving_license) ? "You are allowed to drive" : "You are not allowed to drive"));

$my_age = 17;
console_log(string_interpolation('$my_age: ', [$my_age]));
$has_driving_license = "true";
console_log('$has_driving_license: ', [$has_driving_license]);
console_log('(($my_age >= 17) && $has_driving_license):');
console_log(((($my_age >= 17) && $has_driving_license) ? "You are allowed to drive" : "You are not allowed to drive"));

$my_age = 17;
console_log(string_interpolation('$my_age: ', [$my_age]));
$has_driving_license = "false";
console_log('$has_driving_license: ', [$has_driving_license]);
console_log('(($my_age >= 17) and $has_driving_license):');
console_log(((($my_age >= 17) and $has_driving_license) ? "You are allowed to drive" : "You are not allowed to drive"));

$my_age = 17;
console_log(string_interpolation('$my_age: ', [$my_age]));
$has_driving_license = "true";
console_log('$has_driving_license: ', [$has_driving_license]);
console_log('(($my_age >= 17) and $has_driving_license):');
console_log(((($my_age >= 17) and $has_driving_license) ? "You are allowed to drive" : "You are not allowed to drive"));

console_log("\n# Logical OR [||, or]\n");

$my_age = 2;
console_log(string_interpolation('$my_age: ', [$my_age]));
console_log('(($my_age <= 3) || ($my_age > 65)):');
console_log("You should stay home") if (($my_age <= 3) || ($my_age >= 65));

$my_age = 89;
console_log(string_interpolation('$my_age: ', [$my_age]));
console_log('(($my_age <= 3) || ($my_age > 65)):');
console_log("You should stay home") if (($my_age <= 3) || ($my_age >= 65));

$my_age = 2;
console_log(string_interpolation('$my_age: ', [$my_age]));
console_log('(($my_age <= 3) or ($my_age > 65)):');
console_log("You should stay home") if (($my_age <= 3) or ($my_age >= 65));

$my_age = 89;
console_log(string_interpolation('$my_age: ', [$my_age]));
console_log('(($my_age <= 3) or ($my_age > 65)):');
console_log("You should stay home") if (($my_age <= 3) or ($my_age >= 65));

console_log(qq(\n# Logical NOT [!, not] (use negate() instead if You use string ("true"/"false")) for boolean value\n));

$can_drive = "false";
console_log(string_interpolation('$can_drive: ', [$can_drive]));
console_log(string_interpolation('negate($can_drive): ', [negate($can_drive)]));

$can_drive = "true";
console_log(string_interpolation('$can_drive: ', [$can_drive]));
console_log(string_interpolation('negate($can_drive): ', [negate($can_drive)]));
