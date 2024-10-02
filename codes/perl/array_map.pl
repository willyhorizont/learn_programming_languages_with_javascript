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

sub array_map_v1 {
    # JavaScript-like Array.map() function array_map_v1
    my ($callback_function_ref, $an_array_ref) = @_;
    my $new_array_ref = [];
    for (my $array_item_index = 0; ($array_item_index < scalar(@{$an_array_ref})); $array_item_index += 1) {
        my $array_item = $an_array_ref->[$array_item_index];
        my $new_array_item_ref = $callback_function_ref->($array_item, $array_item_index, $an_array_ref);
        push(@{$new_array_ref}, $new_array_item_ref);
    }
    return $new_array_ref;
}

sub array_map_v2 {
    # JavaScript-like Array.map() function array_map_v2
    my ($callback_function_ref, $an_array_ref) = @_;
    my $new_array_ref = [];
    for (my $array_item_index = 0; ($array_item_index < scalar(@{$an_array_ref})); $array_item_index += 1) {
        my $array_item = $an_array_ref->[$array_item_index];
        push(@{$new_array_ref}, ($callback_function_ref->($array_item, $array_item_index, $an_array_ref)));
    }
    return $new_array_ref;
}

console_log("\n# JavaScript-like Array.map() in Perl List");

my $numbers_ref = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
console_log(string_interpolation("numbers_ref: ", [$numbers_ref]));

console_log('# using JavaScript-like Array.map() function "array_map_v1"');

{
    my $numbers_labeled_ref = array_map_v1(sub { object({string([@_]->[0]) => ((([@_]->[0] % 2) == 0) ? "even" : "odd")}) }, $numbers_ref);
    console_log(string_interpolation("labeled numbers: ", json_stringify($numbers_labeled_ref, "pretty" => "true")));
    # labeled numbers: [
    #     {
    #         "12": "even"
    #     },
    #     {
    #         "34": "even"
    #     },
    #     {
    #         "27": "odd"
    #     },
    #     {
    #         "23": "odd"
    #     },
    #     {
    #         "65": "odd"
    #     },
    #     {
    #         "93": "odd"
    #     },
    #     {
    #         "36": "even"
    #     },
    #     {
    #         "87": "odd"
    #     },
    #     {
    #         "4": "even"
    #     },
    #     {
    #         "254": "even"
    #     }
    # ]
}

console_log('# using JavaScript-like Array.map() function "array_map_v2"');

{
    my $numbers_labeled_ref = array_map_v2(sub { object({string([@_]->[0]) => ((([@_]->[0] % 2) == 0) ? "even" : "odd")}) }, $numbers_ref);
    console_log(string_interpolation("labeled numbers: ", json_stringify($numbers_labeled_ref, "pretty" => "true")));
    # labeled numbers: [
    #     {
    #         "12": "even"
    #     },
    #     {
    #         "34": "even"
    #     },
    #     {
    #         "27": "odd"
    #     },
    #     {
    #         "23": "odd"
    #     },
    #     {
    #         "65": "odd"
    #     },
    #     {
    #         "93": "odd"
    #     },
    #     {
    #         "36": "even"
    #     },
    #     {
    #         "87": "odd"
    #     },
    #     {
    #         "4": "even"
    #     },
    #     {
    #         "254": "even"
    #     }
    # ]
}

console_log('# using Perl Array.map() built-in function "map"');

{
    my $numbers_labeled_ref = [map { object({string($_) => ((($_ % 2) == 0) ? "even" : "odd")}) } @{$numbers_ref}];
    console_log(string_interpolation("labeled numbers: ", json_stringify($numbers_labeled_ref, "pretty" => "true")));
    # labeled numbers: [
    #     {
    #         "12": "even"
    #     },
    #     {
    #         "34": "even"
    #     },
    #     {
    #         "27": "odd"
    #     },
    #     {
    #         "23": "odd"
    #     },
    #     {
    #         "65": "odd"
    #     },
    #     {
    #         "93": "odd"
    #     },
    #     {
    #         "36": "even"
    #     },
    #     {
    #         "87": "odd"
    #     },
    #     {
    #         "4": "even"
    #     },
    #     {
    #         "254": "even"
    #     }
    # ]
}

console_log("\n# JavaScript-like Array.map() in Perl List of Hashes");

my $products_ref = [
    {
        "code" => "pasta",
        "price" => 321
    },
    {
        "code" => "bubble_gum",
        "price" => 233
    },
    {
        "code" => "potato_chips",
        "price" => 5
    },
    {
        "code" => "towel",
        "price" => 499
    }
];
console_log(string_interpolation("products: ", json_stringify($products_ref, "pretty" => "true")));

console_log('# using JavaScript-like Array.map() function "array_map_v1"');

{
    my $products_labeled_ref = array_map_v1(sub { object({(%{[@_]->[0]}, "label" => (((optional_chaining([@_]->[0], "price")) > 100) ? "expensive" : "cheap"))}) }, $products_ref);
    console_log(string_interpolation("labeled products: ", json_stringify($products_labeled_ref, "pretty" => "true")));
    # labeled products: [
    #     {
    #         "code": "pasta",
    #         "price": 321,
    #         "label": "expensive"
    #     },
    #     {
    #         "code": "bubble_gum",
    #         "price": 233,
    #         "label": "expensive"
    #     },
    #     {
    #         "code": "potato_chips",
    #         "price": 5,
    #         "label": "cheap"
    #     },
    #     {
    #         "code": "towel",
    #         "price": 499,
    #         "label": "expensive"
    #     }
    # ]
}

console_log('# using JavaScript-like Array.map() function "array_map_v2"');

{
    my $products_labeled_ref = array_map_v2(sub { object({(%{[@_]->[0]}, "label" => (((optional_chaining([@_]->[0], "price")) > 100) ? "expensive" : "cheap"))}) }, $products_ref);
    console_log(string_interpolation("labeled products: ", json_stringify($products_labeled_ref, "pretty" => "true")));
    # labeled products: [
    #     {
    #         "code": "pasta",
    #         "price": 321,
    #         "label": "expensive"
    #     },
    #     {
    #         "code": "bubble_gum",
    #         "price": 233,
    #         "label": "expensive"
    #     },
    #     {
    #         "code": "potato_chips",
    #         "price": 5,
    #         "label": "cheap"
    #     },
    #     {
    #         "code": "towel",
    #         "price": 499,
    #         "label": "expensive"
    #     }
    # ]
}

console_log('# using Perl Array.map() built-in function "map"');

{
    my $products_labeled_ref = [map { object({(%{$_}, "label" => (((optional_chaining($_, "price")) > 100) ? "expensive" : "cheap"))}) } @{$products_ref}];
    console_log(string_interpolation("labeled products: ", json_stringify($products_labeled_ref, "pretty" => "true")));
    # labeled products: [
    #     {
    #         "code": "pasta",
    #         "price": 321,
    #         "label": "expensive"
    #     },
    #     {
    #         "code": "bubble_gum",
    #         "price": 233,
    #         "label": "expensive"
    #     },
    #     {
    #         "code": "potato_chips",
    #         "price": 5,
    #         "label": "cheap"
    #     },
    #     {
    #         "code": "towel",
    #         "price": 499,
    #         "label": "expensive"
    #     }
    # ]
}
