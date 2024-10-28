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

sub pipe_v2 {
    my $pipe_last_result_ref = undef;
    my $pipe_result_ref = array_reduce((sub {
        my ($current_result_ref, $current_argument_ref) = @_;
        $pipe_last_result_ref = $current_result_ref;
        return $current_argument_ref if (get_type($current_result_ref) eq throw_error_if_null($js_like_type_ref->{"Null"}));
        return $current_argument_ref->($current_result_ref) if (get_type($current_argument_ref) eq throw_error_if_null($js_like_type_ref->{"Function"}));
        return undef;
    }), \@_, undef);
    return $pipe_result_ref->($pipe_last_result_ref) if (get_type($pipe_result_ref) eq throw_error_if_null($js_like_type_ref->{"Function"}));
    return $pipe_result_ref;
}

=begin
1. variable can store dynamic data type and dynamic value, variable can inferred data type from value, value of variable can be reassign with different data type or has option to make variable can store dynamic data type and dynamic value
```javascript
let something = "foo";
console.log(`something: ${something}`);
something = 123;
console.log(`something: ${something}`);
something = true;
console.log(`something: ${something}`);
something = null;
console.log(`something: ${something}`);
something = [1, 2, 3];
console.log(`something: ${something}`);
something = { "foo": "bar" };
console.log(`something: ${something}`);
```
```go
type Any interface{}
```
=cut
my $something = "foo";
console_log(string_interpolation('something: ', json_stringify($something, "pretty" => "true")));
$something = 123;
console_log(string_interpolation('something: ', json_stringify($something, "pretty" => "true")));
$something = "true";
console_log(string_interpolation('something: ', json_stringify($something, "pretty" => "true")));
$something = undef;
console_log(string_interpolation('something: ', json_stringify($something, "pretty" => "true")));
$something = [1, 2, 3];
console_log(string_interpolation('something: ', json_stringify($something, "pretty" => "true")));
$something = {"foo" => "bar"};
console_log(string_interpolation('something: ', json_stringify($something, "pretty" => "true")));

=begin
2. it is possible to access and modify variables defined outside of the current scope within nested functions, so it is possible to have closure too
```javascript
function getModifiedIndentLevel() {
    let indentLevel = 0;
    function changeIndentLevel() {
        indentLevel += 1;
        if (indentLevel < 5) changeIndentLevel();
        return indentLevel;
    }
    return changeIndentLevel();
}
console.log(`getModifiedIndentLevel(): ${getModifiedIndentLevel()}`);
function createNewGame(initialCredit) {
    let currentCredit = initialCredit;
    console.log(`initial credit: ${initialCredit}`);
    return function () {
        currentCredit -= 1;
        if (currentCredit === 0) {
            console.log("not enough credits");
            return;
        }
        console.log(`playing game, ${currentCredit} credit(s) remaining`);
    };
}
const playGame = createNewGame(3);
playGame();
playGame();
playGame();
```
=cut
sub get_modified_indent_level {
    my $indent_level = 0;
    my $change_indent_level;
    $change_indent_level = sub {
        $indent_level += 1;
        $change_indent_level->() if ($indent_level < 5);
        return $indent_level;
    };
    return $change_indent_level->();
}
console_log(string_interpolation("get_modified_indent_level(): ", [get_modified_indent_level()]));
sub create_new_game {
    my ($initial_credit) = @_;
    my $current_credit = $initial_credit;
    console_log(string_interpolation("initial credit: ", [$initial_credit]));
    return sub {
        $current_credit -= 1;
        if ($current_credit == 0) {
            console_log("not enough credits");
            return;
        }
        console_log(string_interpolation("playing game, ", [$current_credit], " credit(s) remaining"));
    };
}

my $play_game = create_new_game(3);
$play_game->();
$play_game->();
$play_game->();

=begin
3. object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure can store dynamic data type and dynamic value
```javascript
const myObject = {
    "my_string": "foo",
    "my_number": 123,
    "my_bool": true,
    "my_null": null,
    "my_array": [1, 2, 3],
    "my_object": {
        "foo": "bar"
    }
};
console.log(`myObject: ${myObject}`);
```
=cut
my %my_object = (
    "my_string" => "foo",
    "my_number" => 123,
    "my_bool" => "true",
    "my_null" => undef,
    "my_array" => [1, 2, 3],
    "my_object" => {
        "foo" => "bar"
    }
);
console_log(string_interpolation("my_object: ", json_stringify(\%my_object, "pretty" => "true")));
console_log(string_interpolation("my_object: ", json_stringify({%my_object}, "pretty" => "true")));
my $my_object_ref = {
    "my_string" => "foo",
    "my_number" => 123,
    "my_bool" => "true",
    "my_null" => undef,
    "my_array" => [1, 2, 3],
    "my_object" => {
        "foo" => "bar"
    }
};
console_log(string_interpolation("my_object_ref: ", json_stringify(\%{$my_object_ref}, "pretty" => "true")));
console_log(string_interpolation("my_object_ref: ", json_stringify($my_object_ref, "pretty" => "true")));

=begin
4. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
```javascript
const myArray = ["foo", 123, true, null, [1, 2, 3], { "foo": "bar" }];
console.log(`myArray: ${myArray}`);
```
=cut
my @my_array = ("foo", 123, "true", undef, [1, 2, 3], {"foo" => "bar"});
console_log(string_interpolation("my_array: ", json_stringify(\@my_array, "pretty" => "true")));
console_log(string_interpolation("my_array: ", json_stringify([@my_array], "pretty" => "true")));
my $my_array_ref = ["foo", 123, "true", undef, [1, 2, 3], {"foo" => "bar"}];
console_log(string_interpolation("my_array_ref: ", json_stringify(\@{$my_array_ref}, "pretty" => "true")));
console_log(string_interpolation("my_array_ref: ", json_stringify($my_array_ref, "pretty" => "true")));

=begin
5. support passing functions as arguments to other functions
```javascript
function sayHello(callbackFunction) {
    console.log("hello");
    callbackFunction();
}
function sayHowAreYou() {
    console.log("how are you?");
}
sayHello(sayHowAreYou);
sayHello(function () {
    console.log("how are you?");
});
```
=cut
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

=begin
6. support returning functions as values from other functions
```javascript
function multiply(a) {
    return function (b) {
        return (a * b);
    };
}
const multiplyBy2 = multiply(2);
const multiplyBy2Result = multiplyBy2(10);
console.log(`multiplyBy2(10): ${multiplyBy2Result}`);
```
=cut
sub multiply {
    my ($a) = @_;
    return sub {
        my ($b) = @_;
        return ($a * $b);
    };
}
my $multiply_by2 = multiply(2);
my $multiply_by2_result = $multiply_by2->(10);
console_log(string_interpolation('multiplyBy2(10): ', $multiply_by2_result));

=begin
7. support assigning functions to variables
```javascript
const getRectangleAreaV1 = function (rectangleWidth, rectangleLength) {
    return (rectangleWidth * rectangleLength);
};
console.log(`getRectangleAreaV1(7, 5): ${getRectangleAreaV1(7, 5)}`);
const getRectangleAreaV2 = (rectangleWidth, rectangleLength) => {
    return (rectangleWidth * rectangleLength);
};
console.log(`getRectangleAreaV2(7, 5): ${getRectangleAreaV2(7, 5)}`);
const getRectangleAreaV3 = (rectangleWidth, rectangleLength) => (rectangleWidth * rectangleLength);
console.log(`getRectangleAreaV3(7, 5): ${getRectangleAreaV3(7, 5)}`);
```
=cut
my $get_rectangle_area = sub {
    my ($rectangle_width, $rectangle_length) = @_;
    return ($rectangle_width * $rectangle_length);
};
console_log(string_interpolation('$get_rectangle_area->(7, 5): ', $get_rectangle_area->(7, 5)));

=begin
8. support storing functions in data structures like array/list/slice/ordered-list-data-structure or object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure
```javascript
const myArray2 = [
    function (a, b) {
        return (a * b);
    },
    "foo",
    123,
    true,
    null,
    [1, 2, 3],
    { "foo": "bar" }
];
console.log(`myArray2[0](7, 5): ${myArray2[0](7, 5)}`);
const myObject2 = {
    "my_function": function (a, b) {
        return (a * b);
    },
    "my_string": "foo",
    "my_number": 123,
    "my_bool": true,
    "my_null": null,
    "my_array": [1, 2, 3],
    "my_object": {
        "foo": "bar"
    }
};
console.log(`myObject2["my_function"](7, 5): ${myObject2["my_function"](7, 5)}`);
```
=cut
my @my_array2 = (
    sub {
        my ($a, $b) = @_;
        return ($a * $b);
    },
    "foo",
    123,
    "true",
    undef,
    [1, 2, 3],
    {"foo" => "bar"}
);
console_log(string_interpolation("myArray2[0](7, 5): ", optional_chaining(optional_chaining([@my_array2], 0), 7, 5)));
console_log(string_interpolation("myArray2[0](7, 5): ", pipe_v2(optional_chaining([@my_array2], 0), (sub { optional_chaining([@_]->[0], 7, 5) }))));
my $my_array2_ref = [
    sub {
        my ($a, $b) = @_;
        return ($a * $b);
    },
    "foo",
    123,
    "true",
    undef,
    [1, 2, 3],
    {"foo" => "bar"}
];
console_log(string_interpolation("myArray2[0](7, 5): ", optional_chaining(optional_chaining($my_array2_ref, 0), 7, 5)));
console_log(string_interpolation("myArray2[0](7, 5): ", pipe_v2(optional_chaining($my_array2_ref, 0), (sub { optional_chaining([@_]->[0], 7, 5) }))));
my %my_object2 = (
    "my_function" => sub {
        my ($a, $b) = @_;
        return ($a * $b);
    },
    "my_string" => "foo",
    "my_number" => 123,
    "my_bool" => "true",
    "my_null" => undef,
    "my_array" => [1, 2, 3],
    "my_object" => {
        "foo" => "bar"
    }
);
console_log(string_interpolation('myObject2["my_function"](7, 5): ', optional_chaining(optional_chaining({%my_object2}, "my_function"), 7, 5)));
console_log(string_interpolation('myObject2["my_function"](7, 5): ', pipe_v2(optional_chaining({%my_object2}, "my_function"), (sub { optional_chaining([@_]->[0], 7, 5) }))));
my $my_object2_ref = {
    "my_function" => sub {
        my ($a, $b) = @_;
        return ($a * $b);
    },
    "my_string" => "foo",
    "my_number" => 123,
    "my_bool" => "true",
    "my_null" => undef,
    "my_array" => [1, 2, 3],
    "my_object" => {
        "foo" => "bar"
    }
};
console_log(string_interpolation('myObject2["my_function"](7, 5): ', optional_chaining(optional_chaining($my_object2_ref, "my_function"), 7, 5)));
console_log(string_interpolation('myObject2["my_function"](7, 5): ', pipe_v2(optional_chaining($my_object2_ref, "my_function"), (sub { optional_chaining([@_]->[0], 7, 5) }))));
