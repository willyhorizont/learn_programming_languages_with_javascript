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

# ? function statement or function declaration

sub get_rectangle_area_v1 {
    my ($rectangle_width, $rectangle_length) = @_;
    return ($rectangle_width * $rectangle_length);
}
console_log(string_interpolation('get_rectangle_area_v1(7, 5): ', [get_rectangle_area_v1(7, 5)]));

sub get_rectangle_area_v2 { ($_[0] * $_[1]) }
console_log(string_interpolation('get_rectangle_area_v2(7, 5): ', [get_rectangle_area_v2(7, 5)]));

sub get_rectangle_area_v3 { ([@_]->[0] * [@_]->[1]) }
console_log(string_interpolation('get_rectangle_area_v3(7, 5): ', [get_rectangle_area_v3(7, 5)]));

# ? function expression

my $get_rectangle_area_v4_ref = sub {
    my ($rectangle_width, $rectangle_length) = @_;
    return ($rectangle_width * $rectangle_length);
};
console_log(string_interpolation('$get_rectangle_area_v4_ref->(7, 5): ', [$get_rectangle_area_v4_ref->(7, 5)]));

my $get_rectangle_area_v5_ref = sub { ($_[0] * $_[1]) };
console_log(string_interpolation('$get_rectangle_area_v5_ref->(7, 5): ', [$get_rectangle_area_v5_ref->(7, 5)]));

my $get_rectangle_area_v6_ref = sub { ([@_]->[0] * [@_]->[1]) };
console_log(string_interpolation('$get_rectangle_area_v6_ref->(7, 5): ', [$get_rectangle_area_v6_ref->(7, 5)]));

# ? anonymous function

# sub {
#     my ($rectangle_width, $rectangle_length) = @_;
#     return ($rectangle_width * $rectangle_length);
# }

# sub { ($_[0] * $_[1]) };

# sub { ([@_]->[0] * [@_]->[1]) }

# ? Passing functions as arguments to other functions

sub say_hello {
    my ($callback_function_ref) = @_;
    console_log("hello");
    $callback_function_ref->();
    # # or
    # &$callback_function_ref();
}

sub say_how_are_you {
    console_log("how are you?");
}

my $say_how_are_you_ref = sub {
    console_log("how are you?");
};

say_hello(\&say_how_are_you);

say_hello($say_how_are_you_ref);

say_hello(sub {
    console_log("how are you?");
});

# ? Assigning functions to variables or storing them in data structures

my $get_rectangle_area_v3_ref_copy = sub {
    my ($rectangle_width, $rectangle_length) = @_;
    return ($rectangle_width * $rectangle_length);
};
console_log(string_interpolation('$get_rectangle_area_v3_ref_copy->(7, 5): ', [$get_rectangle_area_v3_ref_copy->(7, 5)]));

my $get_rectangle_area_v4_ref_copy = sub { ($_[0] * $_[1]) };
console_log(string_interpolation('$get_rectangle_area_v4_ref_copy->(7, 5): ', [$get_rectangle_area_v4_ref_copy->(7, 5)]));

my $get_rectangle_area_v5_ref_copy = sub { ([@_]->[0] * [@_]->[1]) };
console_log(string_interpolation('$get_rectangle_area_v5_ref_copy->(7, 5): ', [$get_rectangle_area_v5_ref_copy->(7, 5)]));

my @my_array_of_get_rectangle_area_functions = (
    \&get_rectangle_area_v1,
    sub {
        my ($rectangle_width, $rectangle_length) = @_;
        return ($rectangle_width * $rectangle_length);
    },
    sub { ($_[0] * $_[1]) },
    sub { ([@_]->[0] * [@_]->[1]) }
);
console_log(string_interpolation('[@my_array_of_get_rectangle_area_functions]->[0](7, 5): ', [[@my_array_of_get_rectangle_area_functions]->[0]->(7, 5)]));
console_log(string_interpolation('[@my_array_of_get_rectangle_area_functions]->[1](7, 5): ', [[@my_array_of_get_rectangle_area_functions]->[1]->(7, 5)]));
console_log(string_interpolation('[@my_array_of_get_rectangle_area_functions]->[2](7, 5): ', [[@my_array_of_get_rectangle_area_functions]->[2]->(7, 5)]));
console_log(string_interpolation('[@my_array_of_get_rectangle_area_functions]->[3](7, 5): ', [[@my_array_of_get_rectangle_area_functions]->[3]->(7, 5)]));
console_log(string_interpolation('optional_chaining(optional_chaining([@my_array_of_get_rectangle_area_functions], 0), 7, 5): ', [optional_chaining(optional_chaining([@my_array_of_get_rectangle_area_functions], 0), 7, 5)]));
console_log(string_interpolation('optional_chaining(optional_chaining([@my_array_of_get_rectangle_area_functions], 1), 7, 5): ', [optional_chaining(optional_chaining([@my_array_of_get_rectangle_area_functions], 1), 7, 5)]));
console_log(string_interpolation('optional_chaining(optional_chaining([@my_array_of_get_rectangle_area_functions], 2), 7, 5): ', [optional_chaining(optional_chaining([@my_array_of_get_rectangle_area_functions], 2), 7, 5)]));
console_log(string_interpolation('optional_chaining(optional_chaining([@my_array_of_get_rectangle_area_functions], 3), 7, 5): ', [optional_chaining(optional_chaining([@my_array_of_get_rectangle_area_functions], 3), 7, 5)]));
console_log(string_interpolation('pipe_v2(optional_chaining([@my_array_of_get_rectangle_area_functions], 0), sub { optional_chaining([@_]->[0], 7, 5) }): ', [pipe_v2(optional_chaining([@my_array_of_get_rectangle_area_functions], 0), sub { optional_chaining([@_]->[0], 7, 5) })]));
console_log(string_interpolation('pipe_v2(optional_chaining([@my_array_of_get_rectangle_area_functions], 1), sub { optional_chaining([@_]->[0], 7, 5) }): ', [pipe_v2(optional_chaining([@my_array_of_get_rectangle_area_functions], 1), sub { optional_chaining([@_]->[0], 7, 5) })]));
console_log(string_interpolation('pipe_v2(optional_chaining([@my_array_of_get_rectangle_area_functions], 2), sub { optional_chaining([@_]->[0], 7, 5) }): ', [pipe_v2(optional_chaining([@my_array_of_get_rectangle_area_functions], 2), sub { optional_chaining([@_]->[0], 7, 5) })]));
console_log(string_interpolation('pipe_v2(optional_chaining([@my_array_of_get_rectangle_area_functions], 3), sub { optional_chaining([@_]->[0], 7, 5) }): ', [pipe_v2(optional_chaining([@my_array_of_get_rectangle_area_functions], 3), sub { optional_chaining([@_]->[0], 7, 5) })]));

my $my_array_of_get_rectangle_area_functions_ref = [
    \&get_rectangle_area_v1,
    sub {
        my ($rectangle_width, $rectangle_length) = @_;
        return ($rectangle_width * $rectangle_length);
    },
    sub { ($_[0] * $_[1]) },
    sub { ([@_]->[0] * [@_]->[1]) }
];
console_log(string_interpolation('$my_array_of_get_rectangle_area_functions_ref->[0](7, 5): ', [$my_array_of_get_rectangle_area_functions_ref->[0]->(7, 5)]));
console_log(string_interpolation('$my_array_of_get_rectangle_area_functions_ref->[1](7, 5): ', [$my_array_of_get_rectangle_area_functions_ref->[1]->(7, 5)]));
console_log(string_interpolation('$my_array_of_get_rectangle_area_functions_ref->[2](7, 5): ', [$my_array_of_get_rectangle_area_functions_ref->[2]->(7, 5)]));
console_log(string_interpolation('$my_array_of_get_rectangle_area_functions_ref->[3](7, 5): ', [$my_array_of_get_rectangle_area_functions_ref->[3]->(7, 5)]));
console_log(string_interpolation('optional_chaining(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 0), 7, 5): ', [optional_chaining(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 0), 7, 5)]));
console_log(string_interpolation('optional_chaining(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 1), 7, 5): ', [optional_chaining(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 1), 7, 5)]));
console_log(string_interpolation('optional_chaining(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 2), 7, 5): ', [optional_chaining(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 2), 7, 5)]));
console_log(string_interpolation('optional_chaining(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 3), 7, 5): ', [optional_chaining(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 3), 7, 5)]));
console_log(string_interpolation('pipe_v2(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 0), sub { optional_chaining([@_]->[0], 7, 5) }): ', [pipe_v2(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 0), sub { optional_chaining([@_]->[0], 7, 5) })]));
console_log(string_interpolation('pipe_v2(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 1), sub { optional_chaining([@_]->[0], 7, 5) }): ', [pipe_v2(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 1), sub { optional_chaining([@_]->[0], 7, 5) })]));
console_log(string_interpolation('pipe_v2(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 2), sub { optional_chaining([@_]->[0], 7, 5) }): ', [pipe_v2(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 2), sub { optional_chaining([@_]->[0], 7, 5) })]));
console_log(string_interpolation('pipe_v2(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 3), sub { optional_chaining([@_]->[0], 7, 5) }): ', [pipe_v2(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 3), sub { optional_chaining([@_]->[0], 7, 5) })]));

sub exponentiation {
    my ($a, $b) = @_;
    return ($a ** $b);
}

my %simple_calculator = (
    "exponentiation" => \&exponentiation,
    "addition" => sub {
        my ($a, $b) = @_;
        return ($a + $b);
    },
    "subtraction" => sub { ($_[0] - $_[1]) },
    "multiplication" => sub { ([@_]->[0] * [@_]->[1]) }
);
console_log(string_interpolation('{%simple_calculator}->{"exponentiation"}->(2, 4): ', [{%simple_calculator}->{"exponentiation"}->(2, 4)]));
console_log(string_interpolation('{%simple_calculator}->{"addition"}->(9, 3): ', [{%simple_calculator}->{"addition"}->(9, 3)]));
console_log(string_interpolation('{%simple_calculator}->{"subtraction"}->(35, 8): ', [{%simple_calculator}->{"subtraction"}->(35, 8)]));
console_log(string_interpolation('{%simple_calculator}->{"multiplication"}->(7, 5): ', [{%simple_calculator}->{"multiplication"}->(7, 5)]));
console_log(string_interpolation('optional_chaining(optional_chaining({%simple_calculator}, "exponentiation"), 2, 4): ', [optional_chaining(optional_chaining({%simple_calculator}, "exponentiation"), 2, 4)]));
console_log(string_interpolation('optional_chaining(optional_chaining({%simple_calculator}, "addition"), 9, 3): ', [optional_chaining(optional_chaining({%simple_calculator}, "addition"), 9, 3)]));
console_log(string_interpolation('optional_chaining(optional_chaining({%simple_calculator}, "subtraction"), 35, 8)): ', [optional_chaining(optional_chaining({%simple_calculator}, "subtraction"), 35, 8)]));
console_log(string_interpolation('optional_chaining(optional_chaining({%simple_calculator}, "multiplication"), 7, 5)): ', [optional_chaining(optional_chaining({%simple_calculator}, "multiplication"), 7, 5)]));
console_log(string_interpolation('pipe_v2(optional_chaining({%simple_calculator}, "exponentiation"), sub { optional_chaining([@_]->[0], 2, 4) }): ', [pipe_v2(optional_chaining({%simple_calculator}, "exponentiation"), sub { optional_chaining([@_]->[0], 2, 4) })]));
console_log(string_interpolation('pipe_v2(optional_chaining({%simple_calculator}, "addition"), sub { optional_chaining([@_]->[0], 9, 3) }): ', [pipe_v2(optional_chaining({%simple_calculator}, "addition"), sub { optional_chaining([@_]->[0], 9, 3) })]));
console_log(string_interpolation('pipe_v2(optional_chaining({%simple_calculator}, "subtraction"), sub { optional_chaining([@_]->[0], 35, 8) })): ', [pipe_v2(optional_chaining({%simple_calculator}, "subtraction"), sub { optional_chaining([@_]->[0], 35, 8) })]));
console_log(string_interpolation('pipe_v2(optional_chaining({%simple_calculator}, "multiplication"), sub { optional_chaining([@_]->[0], 7, 5) })): ', [pipe_v2(optional_chaining({%simple_calculator}, "multiplication"), sub { optional_chaining([@_]->[0], 7, 5) })]));

my $simple_calculator_ref = {
    "exponentiation" => \&exponentiation,
    "addition" => sub {
        my ($a, $b) = @_;
        return ($a + $b);
    },
    "subtraction" => sub { ($_[0] - $_[1]) },
    "multiplication" => sub { ([@_]->[0] * [@_]->[1]) }
};
console_log(string_interpolation('$simple_calculator_ref->{"exponentiation"}->(2, 4): ', [$simple_calculator_ref->{"exponentiation"}->(2, 4)]));
console_log(string_interpolation('$simple_calculator_ref->{"addition"}->(9, 3): ', [$simple_calculator_ref->{"addition"}->(9, 3)]));
console_log(string_interpolation('$simple_calculator_ref->{"subtraction"}->(35, 8): ', [$simple_calculator_ref->{"subtraction"}->(35, 8)]));
console_log(string_interpolation('$simple_calculator_ref->{"multiplication"}->(7, 5): ', [$simple_calculator_ref->{"multiplication"}->(7, 5)]));
console_log(string_interpolation('optional_chaining(optional_chaining($simple_calculator_ref, "exponentiation"), 2, 4): ', [optional_chaining(optional_chaining($simple_calculator_ref, "exponentiation"), 2, 4)]));
console_log(string_interpolation('optional_chaining(optional_chaining($simple_calculator_ref, "addition"), 9, 3): ', [optional_chaining(optional_chaining($simple_calculator_ref, "addition"), 9, 3)]));
console_log(string_interpolation('optional_chaining(optional_chaining($simple_calculator_ref, "subtraction"), 35, 8)): ', [optional_chaining(optional_chaining($simple_calculator_ref, "subtraction"), 35, 8)]));
console_log(string_interpolation('optional_chaining(optional_chaining($simple_calculator_ref, "multiplication"), 7, 5)): ', [optional_chaining(optional_chaining($simple_calculator_ref, "multiplication"), 7, 5)]));
console_log(string_interpolation('pipe_v2(optional_chaining($simple_calculator_ref, "exponentiation"), sub { optional_chaining([@_]->[0], 2, 4) }): ', [pipe_v2(optional_chaining($simple_calculator_ref, "exponentiation"), sub { optional_chaining([@_]->[0], 2, 4) })]));
console_log(string_interpolation('pipe_v2(optional_chaining($simple_calculator_ref, "addition"), sub { optional_chaining([@_]->[0], 9, 3) }): ', [pipe_v2(optional_chaining($simple_calculator_ref, "addition"), sub { optional_chaining([@_]->[0], 9, 3) })]));
console_log(string_interpolation('pipe_v2(optional_chaining($simple_calculator_ref, "subtraction"), sub { optional_chaining([@_]->[0], 35, 8) })): ', [pipe_v2(optional_chaining($simple_calculator_ref, "subtraction"), sub { optional_chaining([@_]->[0], 35, 8) })]));
console_log(string_interpolation('pipe_v2(optional_chaining($simple_calculator_ref, "multiplication"), sub { optional_chaining([@_]->[0], 7, 5) })): ', [pipe_v2(optional_chaining($simple_calculator_ref, "multiplication"), sub { optional_chaining([@_]->[0], 7, 5) })]));

# ? Returning functions as values from other functions

sub multiply_v1 {
    my ($a) = @_;
    my $multiply_by = sub {
        my ($b) = @_;
        return ($a * $b);
    };
    return $multiply_by;
}
my $multiply_by2 = multiply_v1(2);
my $multiply_by2_result = $multiply_by2->(10);
console_log(string_interpolation('$multiply_by2->(10): ', [$multiply_by2_result]));

sub multiply_v2 {
    my ($a) = @_;
    return sub {
        my ($b) = @_;
        return ($a * $b);
    };
}
my $multiply_by3 = multiply_v2(3);
my $multiply_by3_result = $multiply_by3->(10);
console_log(string_interpolation('$multiply_by3->(10): ', [$multiply_by3_result]));

my $multiply_v3 = sub {
    my ($a) = @_;
    my $multiply_by = sub {
        my ($b) = @_;
        return ($a * $b);
    };
    return $multiply_by;
};
my $multiply_by4 = $multiply_v3->(4);
my $multiply_by4_result = $multiply_by4->(10);
console_log(string_interpolation('$multiply_by4->(10): ', [$multiply_by4_result]));

my $multiply_v4 = sub {
    my ($a) = @_;
    return sub {
        my ($b) = @_;
        return ($a * $b);
    };
};
my $multiply_by5 = $multiply_v4->(5);
my $multiply_by5_result = $multiply_by5->(10);
console_log(string_interpolation('$multiply_by5->(10): ', [$multiply_by5_result]));
