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

# ? function statement or function declaration

sub get_rectangle_area_v1 {
    my ($rectangle_width, $rectangle_length) = @_;
    return ($rectangle_width * $rectangle_length);
}
console_log(string_interpolation('get_rectangle_area_v1(7, 5): ', [get_rectangle_area_v1(7, 5)]));

sub get_rectangle_area_v2 { my ($rectangle_width, $rectangle_length) = @_; return ($rectangle_width * $rectangle_length); }
console_log(string_interpolation('get_rectangle_area_v2(7, 5): ', [get_rectangle_area_v2(7, 5)]));

sub get_rectangle_area_v3 { my ($rectangle_width, $rectangle_length) = @_; ($rectangle_width * $rectangle_length) }
console_log(string_interpolation('get_rectangle_area_v3(7, 5): ', [get_rectangle_area_v3(7, 5)]));

sub get_rectangle_area_v4 { ([@_]->[0] * [@_]->[1]) }
console_log(string_interpolation('get_rectangle_area_v4(7, 5): ', [get_rectangle_area_v4(7, 5)]));

# ? function expression

my $get_rectangle_area_v5 = sub {
    my ($rectangle_width, $rectangle_length) = @_;
    return ($rectangle_width * $rectangle_length);
};
console_log(string_interpolation('$get_rectangle_area_v5->(7, 5): ', [$get_rectangle_area_v5->(7, 5)]));

my $get_rectangle_area_v6 = sub { my ($rectangle_width, $rectangle_length) = @_; return ($rectangle_width * $rectangle_length); };
console_log(string_interpolation('$get_rectangle_area_v6->(7, 5): ', [$get_rectangle_area_v6->(7, 5)]));

my $get_rectangle_area_v7 = sub { my ($rectangle_width, $rectangle_length) = @_; ($rectangle_width * $rectangle_length) };
console_log(string_interpolation('$get_rectangle_area_v7->(7, 5): ', [$get_rectangle_area_v7->(7, 5)]));

my $get_rectangle_area_v8 = sub { ([@_]->[0] * [@_]->[1]) };
console_log(string_interpolation('$get_rectangle_area_v8->(7, 5): ', [$get_rectangle_area_v8->(7, 5)]));

# ? anonymous function

# sub {
#     my ($rectangle_width, $rectangle_length) = @_;
#     return ($rectangle_width * $rectangle_length);
# }

# sub { my ($rectangle_width, $rectangle_length) = @_; return ($rectangle_width * $rectangle_length); }

# sub { my ($rectangle_width, $rectangle_length) = @_; ($rectangle_width * $rectangle_length) }

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

say_hello(\&say_how_are_you);

say_hello(sub {
    console_log("how are you?");
});

# ? Assigning functions to variables or storing them in data structures

my $get_rectangle_area_v5_copy = sub {
    my ($rectangle_width, $rectangle_length) = @_;
    return ($rectangle_width * $rectangle_length);
};
console_log(string_interpolation('$get_rectangle_area_v5->(7, 5): ', [$get_rectangle_area_v5->(7, 5)]));

my $get_rectangle_area_v6_copy = sub { my ($rectangle_width, $rectangle_length) = @_; return ($rectangle_width * $rectangle_length); };
console_log(string_interpolation('$get_rectangle_area_v6->(7, 5): ', [$get_rectangle_area_v6->(7, 5)]));

my $get_rectangle_area_v7_copy = sub { my ($rectangle_width, $rectangle_length) = @_; ($rectangle_width * $rectangle_length) };
console_log(string_interpolation('$get_rectangle_area_v7->(7, 5): ', [$get_rectangle_area_v7->(7, 5)]));

my $get_rectangle_area_v8_copy = sub { ([@_]->[0] * [@_]->[1]) };
console_log(string_interpolation('$get_rectangle_area_v8->(7, 5): ', [$get_rectangle_area_v8->(7, 5)]));

my @my_array_of_get_rectangle_area_functions = (
    \&get_rectangle_area_v1,
    sub {
        my ($rectangle_width, $rectangle_length) = @_;
        return ($rectangle_width * $rectangle_length);
    },
    sub { my ($rectangle_width, $rectangle_length) = @_; return ($rectangle_width * $rectangle_length); },
    sub { my ($rectangle_width, $rectangle_length) = @_; ($rectangle_width * $rectangle_length) },
    sub { ([@_]->[0] * [@_]->[1]) }
);
console_log(string_interpolation('[@my_array_of_get_rectangle_area_functions]->[0](7, 5): ', [[@my_array_of_get_rectangle_area_functions]->[0]->(7, 5)]));
console_log(string_interpolation('[@my_array_of_get_rectangle_area_functions]->[1](7, 5): ', [[@my_array_of_get_rectangle_area_functions]->[1]->(7, 5)]));
console_log(string_interpolation('[@my_array_of_get_rectangle_area_functions]->[2](7, 5): ', [[@my_array_of_get_rectangle_area_functions]->[2]->(7, 5)]));
console_log(string_interpolation('[@my_array_of_get_rectangle_area_functions]->[3](7, 5): ', [[@my_array_of_get_rectangle_area_functions]->[3]->(7, 5)]));
console_log(string_interpolation('[@my_array_of_get_rectangle_area_functions]->[4](7, 5): ', [[@my_array_of_get_rectangle_area_functions]->[4]->(7, 5)]));
console_log(string_interpolation('optional_chaining(optional_chaining([@my_array_of_get_rectangle_area_functions], 0), 7, 5): ', [optional_chaining(optional_chaining([@my_array_of_get_rectangle_area_functions], 0), 7, 5)]));
console_log(string_interpolation('optional_chaining(optional_chaining([@my_array_of_get_rectangle_area_functions], 1), 7, 5): ', [optional_chaining(optional_chaining([@my_array_of_get_rectangle_area_functions], 1), 7, 5)]));
console_log(string_interpolation('optional_chaining(optional_chaining([@my_array_of_get_rectangle_area_functions], 2), 7, 5): ', [optional_chaining(optional_chaining([@my_array_of_get_rectangle_area_functions], 2), 7, 5)]));
console_log(string_interpolation('optional_chaining(optional_chaining([@my_array_of_get_rectangle_area_functions], 3), 7, 5): ', [optional_chaining(optional_chaining([@my_array_of_get_rectangle_area_functions], 3), 7, 5)]));
console_log(string_interpolation('optional_chaining(optional_chaining([@my_array_of_get_rectangle_area_functions], 4), 7, 5): ', [optional_chaining(optional_chaining([@my_array_of_get_rectangle_area_functions], 4), 7, 5)]));
console_log(string_interpolation('pipe_v2(optional_chaining([@my_array_of_get_rectangle_area_functions], 0), sub { optional_chaining([@_]->[0], 7, 5) }): ', [pipe_v2(optional_chaining([@my_array_of_get_rectangle_area_functions], 0), sub { optional_chaining([@_]->[0], 7, 5) })]));
console_log(string_interpolation('pipe_v2(optional_chaining([@my_array_of_get_rectangle_area_functions], 1), sub { optional_chaining([@_]->[0], 7, 5) }): ', [pipe_v2(optional_chaining([@my_array_of_get_rectangle_area_functions], 1), sub { optional_chaining([@_]->[0], 7, 5) })]));
console_log(string_interpolation('pipe_v2(optional_chaining([@my_array_of_get_rectangle_area_functions], 2), sub { optional_chaining([@_]->[0], 7, 5) }): ', [pipe_v2(optional_chaining([@my_array_of_get_rectangle_area_functions], 2), sub { optional_chaining([@_]->[0], 7, 5) })]));
console_log(string_interpolation('pipe_v2(optional_chaining([@my_array_of_get_rectangle_area_functions], 3), sub { optional_chaining([@_]->[0], 7, 5) }): ', [pipe_v2(optional_chaining([@my_array_of_get_rectangle_area_functions], 3), sub { optional_chaining([@_]->[0], 7, 5) })]));
console_log(string_interpolation('pipe_v2(optional_chaining([@my_array_of_get_rectangle_area_functions], 4), sub { optional_chaining([@_]->[0], 7, 5) }): ', [pipe_v2(optional_chaining([@my_array_of_get_rectangle_area_functions], 4), sub { optional_chaining([@_]->[0], 7, 5) })]));

my $my_array_of_get_rectangle_area_functions_ref = [
    \&get_rectangle_area_v1,
    sub {
        my ($rectangle_width, $rectangle_length) = @_;
        return ($rectangle_width * $rectangle_length);
    },
    sub { my ($rectangle_width, $rectangle_length) = @_; return ($rectangle_width * $rectangle_length); },
    sub { my ($rectangle_width, $rectangle_length) = @_; ($rectangle_width * $rectangle_length) },
    sub { ([@_]->[0] * [@_]->[1]) }
];
console_log(string_interpolation('$my_array_of_get_rectangle_area_functions_ref->[0](7, 5): ', [$my_array_of_get_rectangle_area_functions_ref->[0]->(7, 5)]));
console_log(string_interpolation('$my_array_of_get_rectangle_area_functions_ref->[1](7, 5): ', [$my_array_of_get_rectangle_area_functions_ref->[1]->(7, 5)]));
console_log(string_interpolation('$my_array_of_get_rectangle_area_functions_ref->[2](7, 5): ', [$my_array_of_get_rectangle_area_functions_ref->[2]->(7, 5)]));
console_log(string_interpolation('$my_array_of_get_rectangle_area_functions_ref->[3](7, 5): ', [$my_array_of_get_rectangle_area_functions_ref->[3]->(7, 5)]));
console_log(string_interpolation('$my_array_of_get_rectangle_area_functions_ref->[4](7, 5): ', [$my_array_of_get_rectangle_area_functions_ref->[4]->(7, 5)]));
console_log(string_interpolation('optional_chaining(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 0), 7, 5): ', [optional_chaining(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 0), 7, 5)]));
console_log(string_interpolation('optional_chaining(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 1), 7, 5): ', [optional_chaining(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 1), 7, 5)]));
console_log(string_interpolation('optional_chaining(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 2), 7, 5): ', [optional_chaining(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 2), 7, 5)]));
console_log(string_interpolation('optional_chaining(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 3), 7, 5): ', [optional_chaining(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 3), 7, 5)]));
console_log(string_interpolation('optional_chaining(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 4), 7, 5): ', [optional_chaining(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 4), 7, 5)]));
console_log(string_interpolation('pipe_v2(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 0), sub { optional_chaining([@_]->[0], 7, 5) }): ', [pipe_v2(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 0), sub { optional_chaining([@_]->[0], 7, 5) })]));
console_log(string_interpolation('pipe_v2(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 1), sub { optional_chaining([@_]->[0], 7, 5) }): ', [pipe_v2(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 1), sub { optional_chaining([@_]->[0], 7, 5) })]));
console_log(string_interpolation('pipe_v2(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 2), sub { optional_chaining([@_]->[0], 7, 5) }): ', [pipe_v2(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 2), sub { optional_chaining([@_]->[0], 7, 5) })]));
console_log(string_interpolation('pipe_v2(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 3), sub { optional_chaining([@_]->[0], 7, 5) }): ', [pipe_v2(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 3), sub { optional_chaining([@_]->[0], 7, 5) })]));
console_log(string_interpolation('pipe_v2(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 4), sub { optional_chaining([@_]->[0], 7, 5) }): ', [pipe_v2(optional_chaining($my_array_of_get_rectangle_area_functions_ref, 4), sub { optional_chaining([@_]->[0], 7, 5) })]));

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
    "subtraction" => sub { my ($a, $b) = @_; return ($a - $b); },
    "multiplication" => sub { my ($a, $b) = @_; ($a - $b) },
    "division" => sub { ([@_]->[0] / [@_]->[1]) }
);
console_log(string_interpolation('{%simple_calculator}->{"exponentiation"}->(2, 4): ', [{%simple_calculator}->{"exponentiation"}->(2, 4)]));
console_log(string_interpolation('{%simple_calculator}->{"addition"}->(9, 3): ', [{%simple_calculator}->{"addition"}->(9, 3)]));
console_log(string_interpolation('{%simple_calculator}->{"subtraction"}->(35, 8): ', [{%simple_calculator}->{"subtraction"}->(35, 8)]));
console_log(string_interpolation('{%simple_calculator}->{"multiplication"}->(7, 5): ', [{%simple_calculator}->{"multiplication"}->(7, 5)]));
console_log(string_interpolation('{%simple_calculator}->{"division"}->(81, 9): ', [{%simple_calculator}->{"division"}->(81, 9)]));
console_log(string_interpolation('optional_chaining(optional_chaining({%simple_calculator}, "exponentiation"), 2, 4): ', [optional_chaining(optional_chaining({%simple_calculator}, "exponentiation"), 2, 4)]));
console_log(string_interpolation('optional_chaining(optional_chaining({%simple_calculator}, "addition"), 9, 3): ', [optional_chaining(optional_chaining({%simple_calculator}, "addition"), 9, 3)]));
console_log(string_interpolation('optional_chaining(optional_chaining({%simple_calculator}, "subtraction"), 35, 8)): ', [optional_chaining(optional_chaining({%simple_calculator}, "subtraction"), 35, 8)]));
console_log(string_interpolation('optional_chaining(optional_chaining({%simple_calculator}, "multiplication"), 7, 5): ', [optional_chaining(optional_chaining({%simple_calculator}, "multiplication"), 7, 5)]));
console_log(string_interpolation('optional_chaining(optional_chaining({%simple_calculator}, "division"), 81, 9)): ', [optional_chaining(optional_chaining({%simple_calculator}, "division"), 81, 9)]));
console_log(string_interpolation('pipe_v2(optional_chaining({%simple_calculator}, "exponentiation"), sub { optional_chaining([@_]->[0], 2, 4) }): ', [pipe_v2(optional_chaining({%simple_calculator}, "exponentiation"), sub { optional_chaining([@_]->[0], 2, 4) })]));
console_log(string_interpolation('pipe_v2(optional_chaining({%simple_calculator}, "addition"), sub { optional_chaining([@_]->[0], 9, 3) }): ', [pipe_v2(optional_chaining({%simple_calculator}, "addition"), sub { optional_chaining([@_]->[0], 9, 3) })]));
console_log(string_interpolation('pipe_v2(optional_chaining({%simple_calculator}, "subtraction"), sub { optional_chaining([@_]->[0], 35, 8) })): ', [pipe_v2(optional_chaining({%simple_calculator}, "subtraction"), sub { optional_chaining([@_]->[0], 35, 8) })]));
console_log(string_interpolation('pipe_v2(optional_chaining({%simple_calculator}, "multiplication"), sub { optional_chaining([@_]->[0], 7, 5) }): ', [pipe_v2(optional_chaining({%simple_calculator}, "multiplication"), sub { optional_chaining([@_]->[0], 7, 5) })]));
console_log(string_interpolation('pipe_v2(optional_chaining({%simple_calculator}, "division"), sub { optional_chaining([@_]->[0], 81, 9) })): ', [pipe_v2(optional_chaining({%simple_calculator}, "division"), sub { optional_chaining([@_]->[0], 81, 9) })]));

my $simple_calculator_ref = {
    "exponentiation" => \&exponentiation,
    "addition" => sub {
        my ($a, $b) = @_;
        return ($a + $b);
    },
    "subtraction" => sub { my ($a, $b) = @_; return ($a - $b); },
    "multiplication" => sub { my ($a, $b) = @_; ($a - $b) },
    "division" => sub { ([@_]->[0] / [@_]->[1]) }
};
console_log(string_interpolation('$simple_calculator_ref->{"exponentiation"}->(2, 4): ', [$simple_calculator_ref->{"exponentiation"}->(2, 4)]));
console_log(string_interpolation('$simple_calculator_ref->{"addition"}->(9, 3): ', [$simple_calculator_ref->{"addition"}->(9, 3)]));
console_log(string_interpolation('$simple_calculator_ref->{"subtraction"}->(35, 8): ', [$simple_calculator_ref->{"subtraction"}->(35, 8)]));
console_log(string_interpolation('$simple_calculator_ref->{"multiplication"}->(7, 5): ', [$simple_calculator_ref->{"multiplication"}->(7, 5)]));
console_log(string_interpolation('$simple_calculator_ref->{"division"}->(81, 9): ', [$simple_calculator_ref->{"division"}->(81, 9)]));
console_log(string_interpolation('optional_chaining(optional_chaining($simple_calculator_ref, "exponentiation"), 2, 4): ', [optional_chaining(optional_chaining($simple_calculator_ref, "exponentiation"), 2, 4)]));
console_log(string_interpolation('optional_chaining(optional_chaining($simple_calculator_ref, "addition"), 9, 3): ', [optional_chaining(optional_chaining($simple_calculator_ref, "addition"), 9, 3)]));
console_log(string_interpolation('optional_chaining(optional_chaining($simple_calculator_ref, "subtraction"), 35, 8)): ', [optional_chaining(optional_chaining($simple_calculator_ref, "subtraction"), 35, 8)]));
console_log(string_interpolation('optional_chaining(optional_chaining($simple_calculator_ref, "multiplication"), 7, 5): ', [optional_chaining(optional_chaining($simple_calculator_ref, "multiplication"), 7, 5)]));
console_log(string_interpolation('optional_chaining(optional_chaining($simple_calculator_ref, "division"), 81, 9)): ', [optional_chaining(optional_chaining($simple_calculator_ref, "division"), 81, 9)]));
console_log(string_interpolation('pipe_v2(optional_chaining($simple_calculator_ref, "exponentiation"), sub { optional_chaining([@_]->[0], 2, 4) }): ', [pipe_v2(optional_chaining($simple_calculator_ref, "exponentiation"), sub { optional_chaining([@_]->[0], 2, 4) })]));
console_log(string_interpolation('pipe_v2(optional_chaining($simple_calculator_ref, "addition"), sub { optional_chaining([@_]->[0], 9, 3) }): ', [pipe_v2(optional_chaining($simple_calculator_ref, "addition"), sub { optional_chaining([@_]->[0], 9, 3) })]));
console_log(string_interpolation('pipe_v2(optional_chaining($simple_calculator_ref, "subtraction"), sub { optional_chaining([@_]->[0], 35, 8) })): ', [pipe_v2(optional_chaining($simple_calculator_ref, "subtraction"), sub { optional_chaining([@_]->[0], 35, 8) })]));
console_log(string_interpolation('pipe_v2(optional_chaining($simple_calculator_ref, "multiplication"), sub { optional_chaining([@_]->[0], 7, 5) }): ', [pipe_v2(optional_chaining($simple_calculator_ref, "multiplication"), sub { optional_chaining([@_]->[0], 7, 5) })]));
console_log(string_interpolation('pipe_v2(optional_chaining($simple_calculator_ref, "division"), sub { optional_chaining([@_]->[0], 81, 9) })): ', [pipe_v2(optional_chaining($simple_calculator_ref, "division"), sub { optional_chaining([@_]->[0], 81, 9) })]));

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

my $multiply_v5 = sub { my ($a) = @_; sub { my ($b) = @_; ($a * $b) } };
my $multiply_by6 = $multiply_v5->(6);
my $multiply_by6_result = $multiply_by6->(10);
console_log(string_interpolation('$multiply_by6->(10): ', [$multiply_by6_result]));
