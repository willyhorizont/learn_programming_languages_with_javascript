use strict;
# use warnings;

my $js_like_type = {
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
    return throw_error_if_null($js_like_type->{"Null"}) if (is_like_js_null($anything_ref) eq "true");
    return throw_error_if_null($js_like_type->{"Function"}) if (is_like_js_function($anything_ref) eq "true");
    return throw_error_if_null($js_like_type->{"Object"}) if (is_like_js_object($anything_ref) eq "true");
    return throw_error_if_null($js_like_type->{"Array"}) if (is_like_js_array($anything_ref) eq "true");
    return throw_error_if_null($js_like_type->{"Boolean"}) if (is_like_js_boolean($anything_ref) eq "true");
    return throw_error_if_null($js_like_type->{"String"}) if (is_like_js_string($anything_ref) eq "true");
    return throw_error_if_null($js_like_type->{"Numeric"}) if (is_like_js_numeric($anything_ref) eq "true");
    my $anything_ref_unknown_type = (ref $anything_ref);
    return (($anything_ref_unknown_type eq "") ? '"UNKNOWN"' : '"' . $anything_ref_unknown_type . '"');
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
    my $pretty = ((get_type($optional_argument->{"pretty"}) eq throw_error_if_null($js_like_type->{"Boolean"})) ? ($optional_argument->{"pretty"}) : "false");
    my $indent_default = (" " x 4);
    my $indent_level = 0;
    my $json_stringify_inner;
    $json_stringify_inner = sub {
        my ($anything_inner_ref) = @_;
        return "null" if (get_type($anything_inner_ref) eq throw_error_if_null($js_like_type->{"Null"}));
        return '"[object Function]"' if (get_type($anything_inner_ref) eq throw_error_if_null($js_like_type->{"Function"}));
        if (get_type($anything_inner_ref) eq throw_error_if_null($js_like_type->{"Object"})) {
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
        if (get_type($anything_inner_ref) eq throw_error_if_null($js_like_type->{"Array"})) {
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
        return "true" if ((get_type($anything_inner_ref) eq throw_error_if_null($js_like_type->{"Boolean"})) && ($anything_inner_ref eq "true"));
        return "false" if ((get_type($anything_inner_ref) eq throw_error_if_null($js_like_type->{"Boolean"})) && ($anything_inner_ref eq "false"));
        return '"' . $anything_inner_ref . '"' if (get_type($anything_inner_ref) eq throw_error_if_null($js_like_type->{"String"}));
        return string($anything_inner_ref) if (get_type($anything_inner_ref) eq throw_error_if_null($js_like_type->{"Numeric"}));
        return "null";
    };
    return $json_stringify_inner->($anything_ref);
}

sub array_reduce {
    # JavaScript-like Array.reduce() function
    my ($callback_function_ref, $an_array_ref, $initial_value) = @_;
    my $result = $initial_value;
    for (my $array_item_index = 0; ($array_item_index < scalar(@{$an_array_ref})); $array_item_index += 1) {
        my $array_item = $an_array_ref->[$array_item_index];
        $result = $callback_function_ref->($result, $array_item, $array_item_index, $an_array_ref);
    }
    return $result;
}

sub string_interpolation {
    return (array_reduce((sub {
        my ($current_result, $current_argument) = @_;
        return ($current_result . $current_argument) if (get_type($current_argument) eq throw_error_if_null($js_like_type->{"String"}));
        return ($current_result . (json_stringify($current_argument->[0]))) if ((get_type($current_argument) eq throw_error_if_null($js_like_type->{"Array"})) && (scalar(@{$current_argument}) == 1));
        return ($current_result . (json_stringify($current_argument)));
    }), \@_, ""));
}

sub console_log {
    print(string_interpolation(@_) . "\n");
}

sub optional_chaining {
    my ($anything, @array_index_or_object_key_or_function_argument_array) = @_;
    # JavaScript-like Optional Chaining Operator (?.) function optional_chaining_v1
    return $anything->(@array_index_or_object_key_or_function_argument_array) if (get_type($anything) eq throw_error_if_null($js_like_type->{"Function"}));
    return $anything if (((get_type($anything) ne throw_error_if_null($js_like_type->{"Object"})) && (get_type($anything) ne throw_error_if_null($js_like_type->{"Array"}))) || (scalar(@array_index_or_object_key_or_function_argument_array) == 0));
    return array_reduce((sub {
        my ($current_result, $current_item) = @_;
        return $anything->{(string($current_item))} if ((get_type($current_result) eq throw_error_if_null($js_like_type->{"Null"})) && (get_type($anything) eq throw_error_if_null($js_like_type->{"Object"})) && (get_type($current_item) eq throw_error_if_null($js_like_type->{"String"})));
        return $anything->[(int($current_item))] if ((get_type($current_result) eq throw_error_if_null($js_like_type->{"Null"})) && (get_type($anything) eq throw_error_if_null($js_like_type->{"Array"})) && (get_type($current_item) eq throw_error_if_null($js_like_type->{"Numeric"})) && (((int($current_item)) >= 0) || ((int($current_item)) == -1)) && (scalar(@{$anything}) > (int($current_item))));
        return $current_result->{(string($current_item))} if ((get_type($current_result) eq throw_error_if_null($js_like_type->{"Object"})) && (get_type($current_item) eq throw_error_if_null($js_like_type->{"String"})));
        return $current_result->[(int($current_item))] if ((get_type($current_result) eq throw_error_if_null($js_like_type->{"Array"})) && (get_type($current_item) eq throw_error_if_null($js_like_type->{"Numeric"})) && (((int($current_item)) >= 0) || ((int($current_item)) == -1)) && (scalar(@{$current_result}) > (int($current_item))));
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

sub pipe_v2 {
    my $pipe_last_result = undef;
    my $pipe_result = array_reduce((sub {
        my ($current_result, $current_argument) = @_;
        $pipe_last_result = $current_result;
        return $current_argument if (get_type($current_result) eq throw_error_if_null($js_like_type->{"Null"}));
        return $current_argument->($current_result) if (get_type($current_argument) eq throw_error_if_null($js_like_type->{"Function"}));
        return undef;
    }), \@_, undef);
    return $pipe_result->($pipe_last_result) if (get_type($pipe_result) eq throw_error_if_null($js_like_type->{"Function"}));
    return $pipe_result;
}

sub generate_number_sequence {
    my ($start_number, $stop_number) = @_;
    die "expected (start_number, stop_number)" if (get_type($stop_number) eq throw_error_if_null($js_like_type->{"Null"}));
    die "expected (numeric_value, numeric_value)" if ((get_type($start_number) ne throw_error_if_null($js_like_type->{"Numeric"})) && (get_type($stop_number) ne throw_error_if_null($js_like_type->{"Numeric"})));
    die "expected (stop_number > start_number) or (start_number > stop_number)" if ($start_number == $stop_number);
    if ($stop_number > $start_number) {
        my $number_sequence_array_ascending = [];
        for (my $any_number = $start_number; ($any_number <= $stop_number); $any_number += 1) {
            push(@{$number_sequence_array_ascending}, $any_number);
        }
        return $number_sequence_array_ascending;
    }
    if ($start_number > $stop_number) {
        my $number_sequence_array_descending = [];
        for (my $any_number = $start_number; ($any_number >= $stop_number); $any_number -= 1) {
            push(@{$number_sequence_array_descending}, $any_number);
        }
        return $number_sequence_array_descending;
    }
    die "something weird happened in generate_number_sequence";
}

console_log("# JavaScript-like Array in Perl (List)");

# initialization v1
my @fruits = ("apple", "mango", "orange");
console_log(string_interpolation("fruits: ", [\@fruits]));
console_log(string_interpolation("fruits: ", [[@fruits]]));

console_log(string_interpolation("fruits, length: ", [($#fruits + 1)]));
# fruits, length: 3

console_log(string_interpolation("fruits, length: ", [($#{[@fruits]} + 1)]));
# fruits, length: 3

console_log(string_interpolation("fruits, length: ", [($#{\@fruits} + 1)]));
# fruits, length: 3

console_log(string_interpolation("fruits, length: ", [scalar(@fruits)]));
# fruits, length: 3

console_log(string_interpolation("fruits, get mango: ", [$fruits[1]]));
# fruits, get mango: "mango"

console_log(string_interpolation("fruits, get mango: ", [[@fruits]->[1]]));
# fruits, get mango: "mango"

console_log(string_interpolation("fruits, get mango: ", [optional_chaining([@fruits], 1)]));
# fruits, get mango: "mango"

console_log(string_interpolation("fruits, first element: ", [$fruits[0]]));
# fruits, first element: "apple"

console_log(string_interpolation("fruits, first element: ", [[@fruits]->[0]]));
# fruits, first element: "apple"

console_log(string_interpolation("fruits, first element: ", [optional_chaining([@fruits], 0)]));
# fruits, first element: "apple"

console_log(string_interpolation("fruits, last element: ", [$fruits[-1]]));
# fruits, last element: "orange"

console_log(string_interpolation("fruits, last element: ", [[@fruits]->[-1]]));
# fruits, last element: "orange"

console_log(string_interpolation("fruits, last element: ", [optional_chaining([@fruits], -1)]));
# fruits, last element: "orange"

# iterate over and print each item and index
foreach my $array_item_index (0 .. $#fruits) {
    my $array_item = $fruits[$array_item_index];
    console_log(string_interpolation("fruits, index: ", [$array_item_index], ", value: ", [$array_item], ", for each range v1 loop"));
}
# fruits, index: 0, value: "apple", for each range v1 loop
# fruits, index: 1, value: "mango", for each range v1 loop
# fruits, index: 2, value: "orange", for each range v1 loop

# iterate over and print each item and index
for my $array_item_index (0 .. $#fruits) {
    my $array_item = $fruits[$array_item_index];
    console_log(string_interpolation("fruits, index: ", [$array_item_index], ", value: ", [$array_item], ", for range v1 loop"));
}
# fruits, index: 0, value: "apple", for range v1 loop
# fruits, index: 1, value: "mango", for range v1 loop
# fruits, index: 2, value: "orange", for range v1 loop

# iterate over and print each item and index
foreach my $array_item_index (0 .. (scalar(@fruits) - 1)) {
    my $array_item = $fruits[$array_item_index];
    console_log(string_interpolation("fruits, index: ", [$array_item_index], ", value: ", [$array_item], ", for each range v2 loop"));
}
# fruits, index: 0, value: "apple", for each range v2 loop
# fruits, index: 1, value: "mango", for each range v2 loop
# fruits, index: 2, value: "orange", for each range v2 loop

# iterate over and print each item and index
for my $array_item_index (0 .. (scalar(@fruits) - 1)) {
    my $array_item = $fruits[$array_item_index];
    console_log(string_interpolation("fruits, index: ", [$array_item_index], ", value: ", [$array_item], ", for range v2 loop"));
}
# fruits, index: 0, value: "apple", for range v2 loop
# fruits, index: 1, value: "mango", for range v2 loop
# fruits, index: 2, value: "orange", for range v2 loop

# iterate over and print each item and index
foreach my $array_item_index (@{generate_number_sequence(0, (scalar(@fruits) - 1))}) {
    my $array_item = $fruits[$array_item_index];
    console_log(string_interpolation("fruits, index: ", [$array_item_index], ", value: ", [$array_item], ", for each range v3 loop"));
}
# fruits, index: 0, value: "apple", for each range v3 loop
# fruits, index: 1, value: "mango", for each range v3 loop
# fruits, index: 2, value: "orange", for each range v3 loop

# iterate over and print each item and index
for my $array_item_index (@{generate_number_sequence(0, (scalar(@fruits) - 1))}) {
    my $array_item = $fruits[$array_item_index];
    console_log(string_interpolation("fruits, index: ", [$array_item_index], ", value: ", [$array_item], ", for range v3 loop"));
}
# fruits, index: 0, value: "apple", for range v3 loop
# fruits, index: 1, value: "mango", for range v3 loop
# fruits, index: 2, value: "orange", for range v3 loop

# iterate over and print each item and index
{
    my $array_item_index = 0;
    foreach my $array_item (@fruits) {
        console_log(string_interpolation("fruits, index: ", [$array_item_index], ", value: ", [$array_item], ", for each loop v1"));
        $array_item_index += 1;
    }
}
# fruits, index: 0, value: "apple", for each loop v1
# fruits, index: 1, value: "mango", for each loop v1
# fruits, index: 2, value: "orange", for each loop v1

# iterate over and print each item and index
{
    my $array_item_index = 0;
    for my $array_item (@fruits) {
        console_log(string_interpolation("fruits, index: ", [$array_item_index], ", value: ", [$array_item], ", for each loop v2"));
        $array_item_index += 1;
    }
}
# fruits, index: 0, value: "apple", for each loop v2
# fruits, index: 1, value: "mango", for each loop v2
# fruits, index: 2, value: "orange", for each loop v2

# # iterate over and print each item and index
# # don't use this ❗❗❗ $array_item_index is weird when using this ❗❗❗
# while (my ($array_item_index, $array_item) = each(@fruits)) {
#     console_log(string_interpolation("fruits, index: ", [$array_item_index], ", value: ", [$array_item], ", while each loop"));
# }
# # fruits, index: 0, value: "apple", while each loop
# # fruits, index: 1, value: "mango", while each loop
# # fruits, index: 2, value: "orange", while each loop

# iterate over and print each item and index
{
    my $array_item_index = 0;
    while ($array_item_index < scalar(@fruits)) {
        my $array_item = $fruits[$array_item_index];
        console_log(string_interpolation("fruits, index: ", [$array_item_index], ", value: ", [$array_item], ", while loop"));
        $array_item_index += 1;
    }
}
# fruits, index: 0, value: "apple", while loop
# fruits, index: 1, value: "mango", while loop
# fruits, index: 2, value: "orange", while loop

# iterate over and print each item and index
# ⭐⭐⭐⭐⭐
for (my $array_item_index = 0; ($array_item_index < scalar(@fruits)); $array_item_index += 1) {
    my $array_item = $fruits[$array_item_index];
    console_log(string_interpolation("fruits, index: ", [$array_item_index], ", value: ", [$array_item], ", for loop"));
}
# fruits, index: 0, value: "apple", for loop
# fruits, index: 1, value: "mango", for loop
# fruits, index: 2, value: "orange", for loop

push(@fruits, "banana");
console_log(string_interpolation("fruits: ", [[@fruits]]));
console_log(string_interpolation("fruits: ", [\@fruits]));
# fruits: ["apple", "mango", "orange", "banana"]

# initialization v2
my $fruits_ref = ["apple", "mango", "orange"];
console_log(string_interpolation("fruits_ref: ", [\@{$fruits_ref}]));
console_log(string_interpolation("fruits_ref: ", [$fruits_ref]));

console_log(string_interpolation("fruits_ref, length: ", [($#{$fruits_ref} + 1)]));
# fruits_ref, length: 3

console_log(string_interpolation("fruits_ref, length: ", [scalar(@{$fruits_ref})]));
# fruits_ref, length: 3

console_log(string_interpolation("fruits_ref, get mango: ", [$$fruits_ref[1]]));
# fruits_ref, get mango: "mango"

console_log(string_interpolation("fruits_ref, get mango: ", [${$fruits_ref}[1]]));
# fruits_ref, get mango: "mango"

console_log(string_interpolation("fruits_ref, get mango: ", [$fruits_ref->[1]]));
# fruits_ref, get mango: "mango"

console_log(string_interpolation("fruits_ref, get mango: ", [optional_chaining($fruits_ref, 1)]));
# fruits_ref, get mango: "mango"

console_log(string_interpolation("fruits_ref, first element: ", [$$fruits_ref[0]]));
# fruits_ref, first element: "apple"

console_log(string_interpolation("fruits_ref, first element: ", [${$fruits_ref}[0]]));
# fruits_ref, first element: "apple"

console_log(string_interpolation("fruits_ref, first element: ", [$fruits_ref->[0]]));
# fruits_ref, first element: "apple"

console_log(string_interpolation("fruits_ref, first element: ", [optional_chaining($fruits_ref, 0)]));
# fruits_ref, first element: "apple"

console_log(string_interpolation("fruits_ref, last element: ", [$$fruits_ref[-1]]));
# fruits_ref, last element: "orange"

console_log(string_interpolation("fruits_ref, last element: ", [${$fruits_ref}[-1]]));
# fruits_ref, last element: "orange"

console_log(string_interpolation("fruits_ref, last element: ", [$fruits_ref->[-1]]));
# fruits_ref, last element: "orange"

console_log(string_interpolation("fruits_ref, last element: ", [optional_chaining($fruits_ref, -1)]));
# fruits_ref, last element: "orange"

# iterate over and print each item and index
foreach my $array_item_index (0 .. $#{$fruits_ref}) {
    my $array_item = $fruits_ref->[$array_item_index];
    console_log(string_interpolation("fruits_ref, index: ", [$array_item_index], ", value: ", [$array_item], ", for each range v1 loop"));
}
# fruits_ref, index: 0, value: "apple", for each range v1 loop
# fruits_ref, index: 1, value: "mango", for each range v1 loop
# fruits_ref, index: 2, value: "orange", for each range v1 loop

# iterate over and print each item and index
for my $array_item_index (0 .. $#{$fruits_ref}) {
    my $array_item = $fruits_ref->[$array_item_index];
    console_log(string_interpolation("fruits_ref, index: ", [$array_item_index], ", value: ", [$array_item], ", for range v1 loop"));
}
# fruits_ref, index: 0, value: "apple", for range v1 loop
# fruits_ref, index: 1, value: "mango", for range v1 loop
# fruits_ref, index: 2, value: "orange", for range v1 loop

# iterate over and print each item and index
foreach my $array_item_index (0 .. (scalar(@{$fruits_ref}) - 1)) {
    my $array_item = $fruits_ref->[$array_item_index];
    console_log(string_interpolation("fruits_ref, index: ", [$array_item_index], ", value: ", [$array_item], ", for each range v2 loop"));
}
# fruits_ref, index: 0, value: "apple", for each range v2 loop
# fruits_ref, index: 1, value: "mango", for each range v2 loop
# fruits_ref, index: 2, value: "orange", for each range v2 loop

# iterate over and print each item and index
for my $array_item_index (0 .. (scalar(@{$fruits_ref}) - 1)) {
    my $array_item = $fruits_ref->[$array_item_index];
    console_log(string_interpolation("fruits_ref, index: ", [$array_item_index], ", value: ", [$array_item], ", for range v2 loop"));
}
# fruits_ref, index: 0, value: "apple", for range v2 loop
# fruits_ref, index: 1, value: "mango", for range v2 loop
# fruits_ref, index: 2, value: "orange", for range v2 loop

# iterate over and print each item and index
foreach my $array_item_index (@{generate_number_sequence(0, (scalar(@{$fruits_ref}) - 1))}) {
    my $array_item = $fruits_ref->[$array_item_index];
    console_log(string_interpolation("fruits_ref, index: ", [$array_item_index], ", value: ", [$array_item], ", for each range v3 loop"));
}
# fruits_ref, index: 0, value: "apple", for each range v3 loop
# fruits_ref, index: 1, value: "mango", for each range v3 loop
# fruits_ref, index: 2, value: "orange", for each range v3 loop

# iterate over and print each item and index
for my $array_item_index (@{generate_number_sequence(0, (scalar(@{$fruits_ref}) - 1))}) {
    my $array_item = $fruits_ref->[$array_item_index];
    console_log(string_interpolation("fruits_ref, index: ", [$array_item_index], ", value: ", [$array_item], ", for range v3 loop"));
}
# fruits_ref, index: 0, value: "apple", for range v3 loop
# fruits_ref, index: 1, value: "mango", for range v3 loop
# fruits_ref, index: 2, value: "orange", for range v3 loop

# iterate over and print each item and index
{
    my $array_item_index = 0;
    for my $array_item (@{$fruits_ref}) {
        console_log(string_interpolation("fruits_ref, index: ", [$array_item_index], ", value: ", [$array_item], ", for each loop v1"));
    }
}
# fruits_ref, index: 0, value: "apple", for each loop v1
# fruits_ref, index: 1, value: "mango", for each loop v1
# fruits_ref, index: 2, value: "orange", for each loop v1

# iterate over and print each item and index
{
    my $array_item_index = 0;
    foreach my $array_item (@{$fruits_ref}) {
        console_log(string_interpolation("fruits_ref, index: ", [$array_item_index], ", value: ", [$array_item], ", for each loop v2"));
    }
}
# fruits_ref, index: 0, value: "apple", for each loop v2
# fruits_ref, index: 1, value: "mango", for each loop v2
# fruits_ref, index: 2, value: "orange", for each loop v2

# # iterate over and print each item and index
# # don't use this ❗❗❗ $array_item_index is weird when using this ❗❗❗
# while (my ($array_item_index, $array_item) = each(@{$fruits_ref})) {
#     console_log(string_interpolation("fruits_ref, index: ", [$array_item_index], ", value: ", [$array_item], ", while each loop"));
# }
# # fruits_ref, index: 0, value: "apple", while each loop
# # fruits_ref, index: 1, value: "mango", while each loop
# # fruits_ref, index: 2, value: "orange", while each loop

# iterate over and print each item and index
{
    my $array_item_index = 0;
    while ($array_item_index < scalar(@{$fruits_ref})) {
        my $array_item = $fruits_ref->[$array_item_index];
        console_log(string_interpolation("fruits_ref, index: ", [$array_item_index], ", value: ", [$array_item], ", while loop"));
        $array_item_index += 1;
    }
}
# fruits_ref, index: 0, value: "apple", while loop
# fruits_ref, index: 1, value: "mango", while loop
# fruits_ref, index: 2, value: "orange", while loop

# iterate over and print each item and index
# ⭐⭐⭐⭐⭐
for (my $array_item_index = 0; ($array_item_index < scalar(@{$fruits_ref})); $array_item_index += 1) {
    my $array_item = $fruits_ref->[$array_item_index];
    console_log(string_interpolation("fruits_ref, index: ", [$array_item_index], ", value: ", [$array_item], ", for loop"));
}
# fruits_ref, index: 0, value: "apple", for loop
# fruits_ref, index: 1, value: "mango", for loop
# fruits_ref, index: 2, value: "orange", for loop

push(@{$fruits_ref}, "banana");
console_log(string_interpolation("fruits_ref: ", [$fruits_ref]));
# fruits_ref: ["apple", "mango", "orange", "banana"]
