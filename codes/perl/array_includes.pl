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

# There's no JavaScript-like Array.includes() in Perl.
# But, we can create our own function to mimic it in Perl.

sub array_includes_v1 {
    # JavaScript-like Array.includes() function array_includes_v1
    my ($search_element, $an_array_ref) = @_;
    my $is_element_found = "false";
    for (my $array_item_index = 0; ($array_item_index < scalar(@{$an_array_ref})); $array_item_index += 1) {
        my $array_item = $an_array_ref->[$array_item_index];
        my $is_condition_match = boolean(($array_item == $search_element) && ($array_item eq $search_element));
        if ($is_condition_match eq "true") {
            $is_element_found = "true";
            last;
        }
    }
    return $is_element_found;
}

sub array_includes_v2 {
    # JavaScript-like Array.includes() function array_includes_v2
    my ($search_element, $an_array_ref) = @_;
    my $is_element_found = "false";
    for (my $array_item_index = 0; ($array_item_index < scalar(@{$an_array_ref})); $array_item_index += 1) {
        my $array_item = $an_array_ref->[$array_item_index];
        if (boolean(($array_item == $search_element) && ($array_item eq $search_element)) eq "true") {
            $is_element_found = "true";
            last;
        }
    }
    return $is_element_found;
}

sub array_includes_v3 {
    # JavaScript-like Array.includes() function array_includes_v3
    my ($search_element, $an_array_ref) = @_;
    for (my $array_item_index = 0; ($array_item_index < scalar(@{$an_array_ref})); $array_item_index += 1) {
        my $array_item = $an_array_ref->[$array_item_index];
        my $is_condition_match = boolean(($array_item == $search_element) && ($array_item eq $search_element));
        return "true" if ($is_condition_match eq "true");
    }
    return "false";
}

sub array_includes_v4 {
    # JavaScript-like Array.includes() function array_includes_v4
    my ($search_element, $an_array_ref) = @_;
    for (my $array_item_index = 0; ($array_item_index < scalar(@{$an_array_ref})); $array_item_index += 1) {
        my $array_item = $an_array_ref->[$array_item_index];
        return "true" if (boolean(($array_item == $search_element) && ($array_item eq $search_element)) eq "true");
    }
    return "false";
}

console_log("\n# JavaScript-like Array.includes() in Perl");

my $my_friends_ref = ["Alisa", "Trivia"];
console_log(string_interpolation("my friends: ", [$my_friends_ref]));

console_log('# using JavaScript-like Array.includes() function "array_includes_v1"');

{
    my $any_name = "Alisa";
    console_log(string_interpolation("name: ", [$any_name]));
    my $is_my_friend = array_includes_v1($any_name, $my_friends_ref);
    console_log(string_interpolation("is my friends includes ", [$any_name], ": ", [$is_my_friend]));
    # is my friends includes "Alisa": true
}

{
    my $any_name = "Trivia";
    console_log(string_interpolation("name: ", [$any_name]));
    my $is_my_friend = array_includes_v1($any_name, $my_friends_ref);
    console_log(string_interpolation("is my friends includes ", [$any_name], ": ", [$is_my_friend]));
    # is my friends includes "Trivia": true
}

{
    my $any_name = "Tony";
    console_log(string_interpolation("name: ", [$any_name]));
    my $is_my_friend = array_includes_v1($any_name, $my_friends_ref);
    console_log(string_interpolation("is my friends includes ", [$any_name], ": ", [$is_my_friend]));
    # is my friends includes "Tony": false
}

{
    my $any_name = "Ezekiel";
    console_log(string_interpolation("name: ", [$any_name]));
    my $is_my_friend = array_includes_v1($any_name, $my_friends_ref);
    console_log(string_interpolation("is my friends includes ", [$any_name], ": ", [$is_my_friend]));
    # is my friends includes "Ezekiel": false
}

console_log('# using JavaScript-like Array.includes() function "array_includes_v2"');

{
    my $any_name = "Alisa";
    console_log(string_interpolation("name: ", [$any_name]));
    my $is_my_friend = array_includes_v2($any_name, $my_friends_ref);
    console_log(string_interpolation("is my friends includes ", [$any_name], ": ", [$is_my_friend]));
    # is my friends includes "Alisa": true
}

{
    my $any_name = "Trivia";
    console_log(string_interpolation("name: ", [$any_name]));
    my $is_my_friend = array_includes_v2($any_name, $my_friends_ref);
    console_log(string_interpolation("is my friends includes ", [$any_name], ": ", [$is_my_friend]));
    # is my friends includes "Trivia": true
}

{
    my $any_name = "Tony";
    console_log(string_interpolation("name: ", [$any_name]));
    my $is_my_friend = array_includes_v2($any_name, $my_friends_ref);
    console_log(string_interpolation("is my friends includes ", [$any_name], ": ", [$is_my_friend]));
    # is my friends includes "Tony": false
}

{
    my $any_name = "Ezekiel";
    console_log(string_interpolation("name: ", [$any_name]));
    my $is_my_friend = array_includes_v2($any_name, $my_friends_ref);
    console_log(string_interpolation("is my friends includes ", [$any_name], ": ", [$is_my_friend]));
    # is my friends includes "Ezekiel": false
}

console_log('# using JavaScript-like Array.includes() function "array_includes_v3"');

{
    my $any_name = "Alisa";
    console_log(string_interpolation("name: ", [$any_name]));
    my $is_my_friend = array_includes_v3($any_name, $my_friends_ref);
    console_log(string_interpolation("is my friends includes ", [$any_name], ": ", [$is_my_friend]));
    # is my friends includes "Alisa": true
}

{
    my $any_name = "Trivia";
    console_log(string_interpolation("name: ", [$any_name]));
    my $is_my_friend = array_includes_v3($any_name, $my_friends_ref);
    console_log(string_interpolation("is my friends includes ", [$any_name], ": ", [$is_my_friend]));
    # is my friends includes "Trivia": true
}

{
    my $any_name = "Tony";
    console_log(string_interpolation("name: ", [$any_name]));
    my $is_my_friend = array_includes_v3($any_name, $my_friends_ref);
    console_log(string_interpolation("is my friends includes ", [$any_name], ": ", [$is_my_friend]));
    # is my friends includes "Tony": false
}

{
    my $any_name = "Ezekiel";
    console_log(string_interpolation("name: ", [$any_name]));
    my $is_my_friend = array_includes_v3($any_name, $my_friends_ref);
    console_log(string_interpolation("is my friends includes ", [$any_name], ": ", [$is_my_friend]));
    # is my friends includes "Ezekiel": false
}

console_log('# using JavaScript-like Array.includes() function "array_includes_v4"');

{
    my $any_name = "Alisa";
    console_log(string_interpolation("name: ", [$any_name]));
    my $is_my_friend = array_includes_v4($any_name, $my_friends_ref);
    console_log(string_interpolation("is my friends includes ", [$any_name], ": ", [$is_my_friend]));
    # is my friends includes "Alisa": true
}

{
    my $any_name = "Trivia";
    console_log(string_interpolation("name: ", [$any_name]));
    my $is_my_friend = array_includes_v4($any_name, $my_friends_ref);
    console_log(string_interpolation("is my friends includes ", [$any_name], ": ", [$is_my_friend]));
    # is my friends includes "Trivia": true
}

{
    my $any_name = "Tony";
    console_log(string_interpolation("name: ", [$any_name]));
    my $is_my_friend = array_includes_v4($any_name, $my_friends_ref);
    console_log(string_interpolation("is my friends includes ", [$any_name], ": ", [$is_my_friend]));
    # is my friends includes "Tony": false
}

{
    my $any_name = "Ezekiel";
    console_log(string_interpolation("name: ", [$any_name]));
    my $is_my_friend = array_includes_v4($any_name, $my_friends_ref);
    console_log(string_interpolation("is my friends includes ", [$any_name], ": ", [$is_my_friend]));
    # is my friends includes "Ezekiel": false
}
