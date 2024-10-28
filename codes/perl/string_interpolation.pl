use strict;
# use warnings;

my $js_like_type_ref = {"Null" => "Null", "Boolean" => "Boolean", "String" => "String", "Numeric" => "Numeric", "Object" => "Object", "Array" => "Array", "Function" => "Function"};

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

sub throw_error_if_null {
    my ($anything_ref) = @_;
    die "object key not found in the object" if (is_like_js_null($anything_ref) eq "true");
    return $anything_ref;
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

sub negate {
    my ($anything_ref) = @_;
    return "false" if ((is_like_js_boolean($anything_ref) eq "true") && ($anything_ref eq "true"));
    return "true" if ((is_like_js_boolean($anything_ref) eq "true") && ($anything_ref eq "false"));
    die 'expected string ("true"/"false")';
}

sub json_stringify {
    my ($anything_ref, %optional_keyword_argument_object) = @_;
    my $optional_keyword_argument_object_ref = {%optional_keyword_argument_object};
    my $pretty = ((get_type($optional_keyword_argument_object_ref->{"pretty"}) eq throw_error_if_null($js_like_type_ref->{"Boolean"})) ? ($optional_keyword_argument_object_ref->{"pretty"}) : "false");
    my $indent_default = (" " x 4);
    my $indent_level = 0;
    my $json_stringify_inner_ref;
    $json_stringify_inner_ref = sub {
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
                $result .= '"' . $object_key . '": ' . $json_stringify_inner_ref->($object_value);
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
                $result .= $json_stringify_inner_ref->($array_item);
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
    return $json_stringify_inner_ref->($anything_ref);
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

console_log("# JavaScript-like Template literals / Template strings (String Interpolation) in Perl (none 🤮)");

# Perl can only interpolate variables for string interpolation 🤮

my $my_name = "Alisa";
my $my_age = 25;
console_log("my name is $my_name and I am $my_age.");
console_log("my name is ${my_name} and I am ${my_age}.");
console_log("my name is " . $my_name . " and I am " . $my_age . ".");
console_log(qq(my name is $my_name and I am $my_age.));
console_log(qq(my name is ${my_name} and I am ${my_age}.));
console_log(qq(my name is $my_name and I am $my_age.));
console_log(string_interpolation("my name is ", $my_name, " and I am ", $my_age, "."));
console_log(string_interpolation("my name is ", [$my_name], " and I am ", [$my_age], "."));

console_log("1 + 2 + 3 + 4 = {1 + 2 + 3 + 4}"); # this is not working
# console_log("1 + 2 + 3 + 4 = ${1 + 2 + 3 + 4}"); # this is not working and throw warning
console_log("1 + 2 + 3 + 4 = " . (1 + 2 + 3 + 4));
console_log(string_interpolation("1 + 2 + 3 + 4 = ", (1 + 2 + 3 + 4)));
console_log(string_interpolation("1 + 2 + 3 + 4 = ", [1 + 2 + 3 + 4]));

sub get_rectangle_area {
    my ($rectangle_width, $rectangle_length) = @_;
    return ($rectangle_width * $rectangle_length);
}
console_log("get_rectangle_area(7, 5): {get_rectangle_area(7, 5)}"); # this is not working
# console_log("get_rectangle_area(7, 5): ${get_rectangle_area(7, 5)}"); # this is not working and throw warning
console_log("get_rectangle_area(7, 5): " . get_rectangle_area(7, 5)); # this is not working
console_log(string_interpolation("get_rectangle_area(7, 5): ", get_rectangle_area(7, 5)));
console_log(string_interpolation("get_rectangle_area(7, 5): ", [get_rectangle_area(7, 5)]));

my $any_string = "foo";
console_log(string_interpolation("any string: ", [$any_string]));

my $any_numeric = 123;
console_log(string_interpolation("any numeric: ", [$any_numeric]));

my $any_boolean = "true";
console_log(string_interpolation("any boolean: ", [$any_boolean]));

my $any_null = undef;
console_log(string_interpolation("any null: ", [$any_null]));

my $any_array = [1, 2, 3];
console_log(string_interpolation("any array: ", [$any_array]));
console_log(string_interpolation("any array first element: ", [$any_array->[0]]));

my $any_object = {"foo" => "bar"};
console_log(string_interpolation("any object: ", [$any_object]));
console_log(string_interpolation("any object foo value: ", [$any_object->{"foo"}]));
