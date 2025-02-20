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

sub array_map_v1 {
    # JavaScript-like Array.map() function array_map_v1
    my ($callback_function_ref, $any_array_ref) = @_;
    my $new_array_ref = [];
    for (my $array_item_index = 0; ($array_item_index < scalar(@{$any_array_ref})); $array_item_index += 1) {
        my $array_item = $any_array_ref->[$array_item_index];
        my $new_array_item_ref = $callback_function_ref->($array_item, $array_item_index, $any_array_ref);
        push(@{$new_array_ref}, $new_array_item_ref);
    }
    return $new_array_ref;
}

sub array_map_v2 {
    # JavaScript-like Array.map() function array_map_v2
    my ($callback_function_ref, $any_array_ref) = @_;
    my $new_array_ref = [];
    for (my $array_item_index = 0; ($array_item_index < scalar(@{$any_array_ref})); $array_item_index += 1) {
        my $array_item = $any_array_ref->[$array_item_index];
        push(@{$new_array_ref}, ($callback_function_ref->($array_item, $array_item_index, $any_array_ref)));
    }
    return $new_array_ref;
}

console_log("\n# JavaScript-like Array.map() in Perl List");

my $numbers_ref = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
console_log(string_interpolation("numbers_ref: ", [$numbers_ref]));

console_log('# using JavaScript-like Array.map() function "array_map_v1"');

{
    my $numbers_labeled_ref = array_map_v1(sub { object({string([@_]->[0]) => ((([@_]->[0] % 2) == 0) ? "even" : "odd")}) }, $numbers_ref);
    console_log(string_interpolation("labeled numbers: ", json_stringify($numbers_labeled_ref, "pretty" => (1 == 1))));
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
    console_log(string_interpolation("labeled numbers: ", json_stringify($numbers_labeled_ref, "pretty" => (1 == 1))));
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
    console_log(string_interpolation("labeled numbers: ", json_stringify($numbers_labeled_ref, "pretty" => (1 == 1))));
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
console_log(string_interpolation("products: ", json_stringify($products_ref, "pretty" => (1 == 1))));

console_log('# using JavaScript-like Array.map() function "array_map_v1"');

{
    my $products_labeled_ref = array_map_v1(sub { object({(%{[@_]->[0]}, "label" => (((optional_chaining([@_]->[0], "price")) > 100) ? "expensive" : "cheap"))}) }, $products_ref);
    console_log(string_interpolation("labeled products: ", json_stringify($products_labeled_ref, "pretty" => (1 == 1))));
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
    console_log(string_interpolation("labeled products: ", json_stringify($products_labeled_ref, "pretty" => (1 == 1))));
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
    console_log(string_interpolation("labeled products: ", json_stringify($products_labeled_ref, "pretty" => (1 == 1))));
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
