use strict;
# use warnings;

my $js_like_type_ref = {"Null" => "Null", "Boolean" => "Boolean", "String" => "String", "Numeric" => "Numeric", "Object" => "Object", "Array" => "Array", "Function" => "Function"};

sub boolean {
    my ($anything_ref) = @_;
    return ($anything_ref ? (1 == 1) : (1 == 0));
}

sub string {
    my ($anything_ref) = @_;
    return ($anything_ref . "");
}

sub object {
    my ($any_object_ref) = @_;
    return \%{$any_object_ref};
}

sub is_like_js_null {
    my ($anything_ref) = @_;
    return ((defined $anything_ref) ? (1 == 0) : (1 == 1));
}

sub is_like_js_string {
    my ($anything_ref) = @_;
    return (1 == 0) if is_like_js_null($anything_ref);
    return ($anything_ref ne (string($anything_ref) + 0));
}

sub is_triple_equal {
    my ($left_ref, $right_ref) = @_;
    return ($left_ref eq $right_ref) if (is_like_js_string($left_ref) && is_like_js_string($right_ref));
    return ($left_ref == $right_ref);
}

sub is_like_js_numeric {
    my ($anything_ref) = @_;
    return (1 == 0) if is_like_js_null($anything_ref);
    return is_triple_equal(($anything_ref + 0), $anything_ref);
}

sub is_like_js_object {
    my ($anything_ref) = @_;
    return (1 == 0) if is_like_js_null($anything_ref);
    return is_triple_equal((ref $anything_ref), "HASH");
}

sub is_like_js_array {
    my ($anything_ref) = @_;
    return (1 == 0) if is_like_js_null($anything_ref);
    return is_triple_equal((ref $anything_ref), "ARRAY");
}

sub is_like_js_function {
    my ($anything_ref) = @_;
    return (1 == 0) if is_like_js_null($anything_ref);
    return is_triple_equal((ref $anything_ref), "CODE");
}

sub throw_error_if_null {
    my ($anything_ref) = @_;
    die "object key not found in the object" if is_like_js_null($anything_ref);
    return $anything_ref;
}

sub get_type {
    my ($anything_ref) = @_;
    return throw_error_if_null($js_like_type_ref->{"Null"}) if is_like_js_null($anything_ref);
    return throw_error_if_null($js_like_type_ref->{"Function"}) if is_like_js_function($anything_ref);
    return throw_error_if_null($js_like_type_ref->{"Object"}) if is_like_js_object($anything_ref);
    return throw_error_if_null($js_like_type_ref->{"Array"}) if is_like_js_array($anything_ref);
    return throw_error_if_null($js_like_type_ref->{"String"}) if is_like_js_string($anything_ref);
    return throw_error_if_null($js_like_type_ref->{"Numeric"}) if is_like_js_numeric($anything_ref);
    my $anything_ref_unknown_type = (ref $anything_ref);
    return (is_triple_equal($anything_ref_unknown_type, "") ? '"UNKNOWN"' : $anything_ref_unknown_type);
}

sub json_stringify {
    my ($anything_ref, %optional_keyword_argument_object) = @_;
    my $optional_keyword_argument_object_ref = {%optional_keyword_argument_object};
    my $pretty = boolean($optional_keyword_argument_object_ref->{"pretty"});
    my $indent_default = (" " x 4);
    my $indent_level = 0;
    my $json_stringify_inner_ref;
    $json_stringify_inner_ref = sub {
        my ($anything_inner_ref) = @_;
        my $anything_inner_ref_type = get_type($anything_inner_ref);
        return "null" if (is_triple_equal($anything_inner_ref_type, throw_error_if_null($js_like_type_ref->{"Null"})));
        return "[object Function]" if (is_triple_equal($anything_inner_ref_type, throw_error_if_null($js_like_type_ref->{"Function"})));
        if (is_triple_equal($anything_inner_ref_type, throw_error_if_null($js_like_type_ref->{"Object"}))) {
            my $object_keys_ref = [keys(%{$anything_inner_ref})];
            return "{}" if (scalar(@{$object_keys_ref}) == 0);
            $indent_level += 1;
            my $result = ($pretty ? ("{\n" . ($indent_default x $indent_level)) : "{ ");
            my $object_entry_index = 0;
            while (my ($object_key, $object_value) = each(%{$anything_inner_ref})) {
                $result .= '"' . $object_key . '": ' . $json_stringify_inner_ref->($object_value);
                $result .= ($pretty ? (",\n" . ($indent_default x $indent_level)) : ", ") if (($object_entry_index + 1) != scalar(@{$object_keys_ref}));
                $object_entry_index += 1;
            }
            $indent_level -= 1;
            $result .= ($pretty ? ("\n" . ($indent_default x $indent_level) . "}") : " }");
            return $result;
        }
        if (is_triple_equal($anything_inner_ref_type, throw_error_if_null($js_like_type_ref->{"Array"}))) {
            my $array_length = scalar(@{$anything_inner_ref});
            return "[]" if ($array_length == 0);
            $indent_level += 1;
            my $result = ($pretty ? ("[\n" . ($indent_default x $indent_level)) : "[");
            for (my $array_item_index = 0; ($array_item_index < scalar(@{$anything_inner_ref})); $array_item_index += 1) {
                my $array_item = $anything_inner_ref->[$array_item_index];
                $result .= $json_stringify_inner_ref->($array_item);
                $result .= ($pretty ? (",\n" . ($indent_default x $indent_level)) : ", ") if (($array_item_index + 1) != $array_length);
            }
            $indent_level -= 1;
            $result .= ($pretty ? ("\n" . ($indent_default x $indent_level) . "]") : "]");
            return $result;
        }
        return '"' . $anything_inner_ref . '"' if (is_triple_equal($anything_inner_ref_type, throw_error_if_null($js_like_type_ref->{"String"})));
        return string($anything_inner_ref) if (is_triple_equal($anything_inner_ref_type, throw_error_if_null($js_like_type_ref->{"Numeric"})));
        return $anything_inner_ref_type;
    };
    return $json_stringify_inner_ref->($anything_ref);
}

sub array_reduce {
    # JavaScript-like Array.reduce() function
    my ($callback_function_ref, $any_array_ref, $initial_value_ref) = @_;
    my $result_ref = $initial_value_ref;
    for (my $array_item_index = 0; ($array_item_index < scalar(@{$any_array_ref})); $array_item_index += 1) {
        my $array_item_ref = $any_array_ref->[$array_item_index];
        $result_ref = $callback_function_ref->($result_ref, $array_item_ref, $array_item_index, $any_array_ref);
    }
    return $result_ref;
}

sub string_interpolation {
    return (array_reduce((sub {
        my ($current_result_ref, $current_argument_ref) = @_;
        my $current_argument_type = get_type($current_argument_ref);
        return ($current_result_ref . $current_argument_ref) if (is_triple_equal($current_argument_type, throw_error_if_null($js_like_type_ref->{"String"})));
        return ($current_result_ref . (json_stringify($current_argument_ref->[0]))) if (is_triple_equal($current_argument_type, throw_error_if_null($js_like_type_ref->{"Array"})) && (scalar(@{$current_argument_ref}) == 1));
        return ($current_result_ref . (json_stringify($current_argument_ref)));
    }), \@_, ""));
}

sub console_log {
    print(string_interpolation(@_) . "\n");
}

sub optional_chaining {
    my ($anything_ref, @array_index_or_object_key_or_function_argument_array) = @_;
    my $anything_ref_type = get_type($anything_ref);
    return $anything_ref->(@array_index_or_object_key_or_function_argument_array) if (is_triple_equal($anything_ref_type, throw_error_if_null($js_like_type_ref->{"Function"})));
    return $anything_ref if ((!is_triple_equal($anything_ref_type, throw_error_if_null($js_like_type_ref->{"Object"})) && !is_triple_equal($anything_ref_type, throw_error_if_null($js_like_type_ref->{"Array"}))) || (scalar(@array_index_or_object_key_or_function_argument_array) == 0));
    return array_reduce((sub {
        my ($current_result_ref, $current_item_ref) = @_;
        my $current_result_ref_type = get_type($current_result_ref);
        my $current_item_ref_type = get_type($current_item_ref);
        return $anything_ref->{(string($current_item_ref))} if (is_triple_equal($current_result_ref_type, throw_error_if_null($js_like_type_ref->{"Null"})) && is_triple_equal($anything_ref_type, throw_error_if_null($js_like_type_ref->{"Object"})) && is_triple_equal($current_item_ref_type, throw_error_if_null($js_like_type_ref->{"String"})));
        return $anything_ref->[(int($current_item_ref))] if (is_triple_equal($current_result_ref_type, throw_error_if_null($js_like_type_ref->{"Null"})) && is_triple_equal($anything_ref_type, throw_error_if_null($js_like_type_ref->{"Array"})) && is_triple_equal($current_item_ref_type, throw_error_if_null($js_like_type_ref->{"Numeric"})) && (((int($current_item_ref)) >= 0) || ((int($current_item_ref)) == -1)) && (scalar(@{$anything_ref}) > (int($current_item_ref))));
        return $current_result_ref->{(string($current_item_ref))} if (is_triple_equal($current_result_ref_type, throw_error_if_null($js_like_type_ref->{"Object"})) && is_triple_equal($current_item_ref_type, throw_error_if_null($js_like_type_ref->{"String"})));
        return $current_result_ref->[(int($current_item_ref))] if (is_triple_equal($current_result_ref_type, throw_error_if_null($js_like_type_ref->{"Array"})) && is_triple_equal($current_item_ref_type, throw_error_if_null($js_like_type_ref->{"Numeric"})) && (((int($current_item_ref)) >= 0) || ((int($current_item_ref)) == -1)) && (scalar(@{$current_result_ref}) > (int($current_item_ref))));
        return undef;
    }), \@array_index_or_object_key_or_function_argument_array, undef);
}

sub object_from_entries {
    # JavaScript-like Object.fromEntries() function
    my ($any_object_entries_ref) = @_;
    my $new_object_ref = {};
    while (my ($object_entry_index, $object_entry_ref) = each(@{$any_object_entries_ref})) {
        my $object_key = $object_entry_ref->[0];
        my $object_value = $object_entry_ref->[1];
        $new_object_ref->{string($object_key)} = $object_value;
    }
    return $new_object_ref;
}

sub array_entries {
    # JavaScript-like Array.entries() function
    my ($any_array_ref) = @_;
    my $new_object_entries_ref = [];
    for (my $array_item_index = 0; ($array_item_index < scalar(@{$any_array_ref})); $array_item_index += 1) {
        my $array_item = $any_array_ref->[$array_item_index];
        push(@{$new_object_entries_ref}, [$array_item_index, $array_item]);
    }
    return $new_object_entries_ref;
}

sub array_every {
    # JavaScript-like Array.every() function array_every_v4
    my ($callback_function_ref, $any_array_ref) = @_;
    for (my $array_item_index = 0; ($array_item_index < scalar(@{$any_array_ref})); $array_item_index += 1) {
        my $array_item = $any_array_ref->[$array_item_index];
        return (1 == 0) if (!boolean($callback_function_ref->($array_item, $array_item_index, $any_array_ref)));
    }
    return (1 == 1);
}

sub array_filter {
    # JavaScript-like Array.filter() function array_filter_v3
    my ($callback_function_ref, $any_array_ref) = @_;
    my $new_array_ref = [];
    for (my $array_item_index = 0; ($array_item_index < scalar(@{$any_array_ref})); $array_item_index += 1) {
        my $array_item = $any_array_ref->[$array_item_index];
        push(@{$new_array_ref}, $array_item) if (boolean($callback_function_ref->($array_item, $array_item_index, $any_array_ref)));
    }
    return $new_array_ref;
}

sub array_find_index {
    # JavaScript-like Array.findIndex() function array_find_index_v4
    my ($callback_function_ref, $any_array_ref) = @_;
    for (my $array_item_index = 0; ($array_item_index < scalar(@{$any_array_ref})); $array_item_index += 1) {
        my $array_item = $any_array_ref->[$array_item_index];
        return $array_item_index if (boolean($callback_function_ref->($array_item, $array_item_index, $any_array_ref)));
    }
    return -1;
}

sub array_find {
    # JavaScript-like Array.find() function array_find_v4
    my ($callback_function_ref, $any_array_ref) = @_;
    for (my $array_item_index = 0; ($array_item_index < scalar(@{$any_array_ref})); $array_item_index += 1) {
        my $array_item = $any_array_ref->[$array_item_index];
        return $array_item if (boolean($callback_function_ref->($array_item, $array_item_index, $any_array_ref)));
    }
    return undef;
}

sub array_includes {
    # JavaScript-like Array.includes() function array_includes_v4
    my ($search_element, $any_array_ref) = @_;
    for (my $array_item_index = 0; ($array_item_index < scalar(@{$any_array_ref})); $array_item_index += 1) {
        my $array_item = $any_array_ref->[$array_item_index];
        return (1 == 1) if (is_triple_equal($array_item, $search_element));
    }
    return (1 == 0);
}

sub array_map {
    # JavaScript-like Array.map() function array_map_v2
    my ($callback_function_ref, $any_array_ref) = @_;
    my $new_array_ref = [];
    for (my $array_item_index = 0; ($array_item_index < scalar(@{$any_array_ref})); $array_item_index += 1) {
        my $array_item = $any_array_ref->[$array_item_index];
        push(@{$new_array_ref}, ($callback_function_ref->($array_item, $array_item_index, $any_array_ref)));
    }
    return $new_array_ref;
}

sub array_some {
    # JavaScript-like Array.some() function array_some_v4
    my ($callback_function_ref, $any_array_ref) = @_;
    for (my $array_item_index = 0; ($array_item_index < scalar(@{$any_array_ref})); $array_item_index += 1) {
        my $array_item = $any_array_ref->[$array_item_index];
        return (1 == 1) if (boolean($callback_function_ref->($array_item, $array_item_index, $any_array_ref)));
    }
    return (1 == 0);
}

sub object_entries {
    # JavaScript-like Object.entries() function
    my ($any_object_ref) = @_;
    my $new_array_ref = [];
    my $object_entry_index = 0;
    while (my ($object_key, $object_value) = each(%{$any_object_ref})) {
        push(@{$new_array_ref}, [$object_key, $object_value]);
        $object_entry_index += 1;
    }
    return $new_array_ref;
}

sub pipe_v2 {
    my $pipe_last_result_ref = undef;
    my $pipe_result_ref = array_reduce((sub {
        my ($current_result_ref, $current_argument_ref) = @_;
        $pipe_last_result_ref = $current_result_ref;
        return $current_argument_ref if (is_triple_equal(get_type($current_result_ref), throw_error_if_null($js_like_type_ref->{"Null"})));
        return $current_argument_ref->($current_result_ref) if (is_triple_equal(get_type($current_argument_ref), throw_error_if_null($js_like_type_ref->{"Function"})));
        return undef;
    }), \@_, undef);
    return $pipe_result_ref->($pipe_last_result_ref) if (is_triple_equal(get_type($pipe_result_ref), throw_error_if_null($js_like_type_ref->{"Function"})));
    return $pipe_result_ref;
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

# Perl doesn't have explicit built-in boolean type (true/false) 🤮.

# https://perlmaven.com/boolean-values-in-perl

# The number 0, the strings '0' and '', the empty list "()", and "undef"
# are all false in a boolean context. All other values are true.
# Negation of a true value by "!" or "not" returns a special false
# value. When evaluated as a string it is treated as '', but as a number, it is treated as 0.

# From perlsyn under "Truth and Falsehood".

# So the following scalar values are considered false:

# undef - the undefined value
# 0 the number 0, even if you write it as 000 or 0.0
# '' the empty string.
# '0' the string that contains a single 0 digit.

# All other scalar values, including the following are true:

# 1 any non-0 number
# ' ' the string with a space in it
# '00' two or more 0 characters in a string
# "0\n" a 0 followed by a newline
# 'true'
# 'false' yes, even the string 'false' evaluates to true.
# I think this is because Larry Wall, creator of Perl, has a general positive world-view. He probably thinks there are very few bad and false things in the world. Most of the things are true.

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
$has_driving_license = (1 == 0);
console_log('$has_driving_license: ', [$has_driving_license]);
console_log('(($my_age >= 17) && $has_driving_license):');
console_log(((($my_age >= 17) && $has_driving_license) ? "You are allowed to drive" : "You are not allowed to drive"));

$my_age = 17;
console_log(string_interpolation('$my_age: ', [$my_age]));
$has_driving_license = (1 == 1);
console_log('$has_driving_license: ', [$has_driving_license]);
console_log('(($my_age >= 17) && $has_driving_license):');
console_log(((($my_age >= 17) && $has_driving_license) ? "You are allowed to drive" : "You are not allowed to drive"));

$my_age = 17;
console_log(string_interpolation('$my_age: ', [$my_age]));
$has_driving_license = (1 == 0);
console_log('$has_driving_license: ', [$has_driving_license]);
console_log('(($my_age >= 17) and $has_driving_license):');
console_log(((($my_age >= 17) and $has_driving_license) ? "You are allowed to drive" : "You are not allowed to drive"));

$my_age = 17;
console_log(string_interpolation('$my_age: ', [$my_age]));
$has_driving_license = (1 == 1);
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

console_log(qq(\n# Logical NOT [!, not]\n));

$can_drive = (1 == 0);
console_log(string_interpolation('$can_drive: ', [$can_drive]));
console_log(string_interpolation('!$can_drive: ', [!$can_drive]));

$can_drive = (1 == 1);
console_log(string_interpolation('$can_drive: ', [$can_drive]));
console_log(string_interpolation('not $can_drive: ', [not $can_drive]));
