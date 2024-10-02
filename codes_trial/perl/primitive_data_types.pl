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
            my $object_keys = keys(%{$anything_inner_ref});
            return "{}" if (scalar($object_keys) == 0);
            $indent_level += 1;
            my $result = (($pretty eq "true") ? ("{\n" . ($indent_default x $indent_level)) : "{ ");
            my $object_entry_index = 0;
            while (my ($object_key, $object_value) = each(%{$anything_inner_ref})) {
                $result .= '"' . $object_key . '": ' . $json_stringify_inner->($object_value);
                $result .= (($pretty eq "true") ? (",\n" . ($indent_default x $indent_level)) : ", ") if (($object_entry_index + 1) != scalar($object_keys));
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
        return "true" if ((get_type($anything_inner_ref) eq throw_error_if_null($js_like_type->{"Boolean"})) && $anything_inner_ref eq "true");
        return "false" if ((get_type($anything_inner_ref) eq throw_error_if_null($js_like_type->{"Boolean"})) && $anything_inner_ref eq "false");
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

sub is_false {
    my ($anything_ref) = @_;
    my $falsey_condition1 = (get_type($anything_ref) eq throw_error_if_null($js_like_type->{"Null"})); # undef - the undefined value
    my $falsey_condition2 = ((get_type($anything_ref) eq throw_error_if_null($js_like_type->{"Numeric"})) && ($anything_ref == 0)); # 0 the number 0
    my $falsey_condition3 = ((get_type($anything_ref) eq throw_error_if_null($js_like_type->{"Numeric"})) && (string($anything_ref) =~ /^0\.?0+$/)); # 0 the number 0, even if you write it as 000 or 0.0
    my $falsey_condition4 = ((get_type($anything_ref) eq throw_error_if_null($js_like_type->{"String"})) && ($anything_ref eq "")); # '' the empty string
    my $falsey_condition5 = ((get_type($anything_ref) eq throw_error_if_null($js_like_type->{"String"})) && ($anything_ref eq "0")); # '0' the string that contains a single 0 digit
    my $falsey_condition6 = ((get_type($anything_ref) eq throw_error_if_null($js_like_type->{"Array"})) && (scalar(@{$anything_ref}) == 0)); # empty List
    my $falsey_condition7 = ((get_type($anything_ref) eq throw_error_if_null($js_like_type->{"Object"})) && (scalar(keys(%{$anything_ref})) == 0)); # empty Hash
    return (boolean($falsey_condition1 || $falsey_condition2 || $falsey_condition3 || $falsey_condition4 || $falsey_condition5 || $falsey_condition6 || $falsey_condition7));
}

sub is_true {
    my ($anything_ref) = @_;
    my $truthy_condition1 = (is_false($anything_ref) ne "true"); # All other non-falsy values are true
    my $truthy_condition2 = ((get_type($anything_ref) eq throw_error_if_null($js_like_type->{"Numeric"})) && (($anything_ref > 0) || ($anything_ref < 0))); # 1 any non-0 number
    my $truthy_condition3 = ((get_type($anything_ref) eq throw_error_if_null($js_like_type->{"String"})) && ($anything_ref =~ /^ +$/)); # ' ' the string with a space in it
    my $truthy_condition4 = ((get_type($anything_ref) eq throw_error_if_null($js_like_type->{"String"})) && ($anything_ref =~ /^0+$/)); # '00' two or more 0 characters in a string
    my $truthy_condition5 = ((get_type($anything_ref) eq throw_error_if_null($js_like_type->{"String"})) && ($anything_ref =~ /0+\n/)); # "0\n" a 0 followed by a newline
    my $truthy_condition6 = ((get_type($anything_ref) eq throw_error_if_null($js_like_type->{"String"})) && ($anything_ref eq "true")); # 'true'
    my $truthy_condition7 = ((get_type($anything_ref) eq throw_error_if_null($js_like_type->{"String"})) && ($anything_ref eq "false")); # 'false' yes, even the string 'false' evaluates to true.
    return (boolean($truthy_condition1 || $truthy_condition2 || $truthy_condition3 || $truthy_condition4 || $truthy_condition5 || $truthy_condition6 || $truthy_condition7));
}

print('("true" eq "True") 1: ' . (("true" eq "True") ? "true" : "false") . "\n");

{
    my $something = undef;
    print("undef: " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = 0;
    print("0: " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = 00;
    print("00: " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = 000;
    print("000: " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = 0000;
    print("0000: " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = 00000;
    print("00000: " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = 0.0;
    print("0.0: " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = 0.00;
    print("0.00: " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = 0.000;
    print("0.000: " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = 0.0000;
    print("0.0000: " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = 0.00000;
    print("0.00000: " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = 00.0;
    print("00.0: " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = 000.0;
    print("000.0: " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = 0000.0;
    print("0000.0: " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = 00000.0;
    print("00000.0: " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = '';
    print("'': " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = '0';
    print("'0': " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = 2;
    print("2: " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = -1;
    print("-1: " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = -1.5;
    print("-1.5: " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = -2;
    print("-2: " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = ' ';
    print("' ': " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = '    ';
    print("'    ': " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = '00';
    print("'00': " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = '000';
    print("'000': " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = '0000';
    print("'0000': " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = '00000';
    print("'00000': " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = '0.0';
    print("'0.0': " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = '0.00';
    print("'0.00': " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = '0.000';
    print("'0.000': " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = '0.0000';
    print("'0.0000': " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = '0.00000';
    print("'0.00000': " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = '00.0';
    print("'00.0': " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = '000.0';
    print("'000.0': " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = '0000.0';
    print("'0000.0': " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = '00000.0';
    print("'00000.0': " . (($something) ? "true" : "false") . "\n")
}

{
    my $something = "0\n";
    print('"0\n": ' . (($something) ? "true" : "false") . "\n")
}

{
    my $something = "00\n";
    print('"00\n": ' . (($something) ? "true" : "false") . "\n")
}

{
    my $something = "000\n";
    print('"000\n": ' . (($something) ? "true" : "false") . "\n")
}

{
    my $something = "0000\n";
    print('"0000\n": ' . (($something) ? "true" : "false") . "\n")
}

{
    my $something = "00000\n";
    print('"00000\n": ' . (($something) ? "true" : "false") . "\n")
}

{
    my $something = "false";
    print('"false": ' . (($something) ? "true" : "false") . "\n")
}

{
    my $something = "true";
    print('"true": ' . (($something) ? "true" : "false") . "\n")
}

{
    my $something = !"true";
    print('!"true": ' . (($something) ? "true" : "false") . "\n")
}

{
    my @any_array = ();
    print('"()": ' . ((@any_array) ? "true" : "false") . "\n")
}

{
    my $any_array_ref = [];
    print('"[]": ' . ((@{$any_array_ref}) ? "true" : "false") . "\n")
}

{
    my %any_object = ();
    print('"()": ' . ((%any_object) ? "true" : "false") . "\n")
}

{
    my $any_object_ref = {};
    print('"{}": ' . ((%{$any_object_ref}) ? "true" : "false") . "\n")
}
