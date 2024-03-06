sub pretty_json_stringify {
    my ($anything) = @_;
    use JSON;
    my $pretty_json_string = JSON->new->allow_nonref->pretty->encode($anything);
    $pretty_json_string =~ s/   /    /g;
    return $pretty_json_string;
}

=begin
    1. variable can store dynamic data type and dynamic value, variable can inferred data type from value, value of variable can be reassign with different data type or has option to make variable can store dynamic data type and dynamic value
    ```javascript
    let something = "foo";
    console.log("something:", something);
    something = 123;
    console.log("something:", something);
    something = true;
    console.log("something:", something);
    something = null;
    console.log("something:", something);
    something = [1, 2, 3];
    console.log("something:", something);
    something = { "foo": "bar" };
    console.log("something:", something);
    ```
    ```go
    type Any interface{}
    ```
=cut
my $something = "foo";
print("something: " . pretty_json_stringify($something));
$something = 123;
print("something: " . pretty_json_stringify($something));
$something = 1;
print("something: " . pretty_json_stringify($something));
$something = undef;
print("something: " . pretty_json_stringify($something));
$something = [1, 2, 3];
print("something: " . pretty_json_stringify($something));
$something = { "foo" => "bar" };
print("something: " . pretty_json_stringify($something));

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
    console.log("getModifiedIndentLevel():", getModifiedIndentLevel());
    function createNewGame(initialCredit) {
        let currentCredit = initialCredit;
        console.log("initial credit:", initialCredit);
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
print("get_modified_indent_level(): " . get_modified_indent_level() . "\n");
sub create_new_game {
    my ($initial_credit) = @_;
    my $current_credit = $initial_credit;
    print("initial credit: " . $initial_credit . "\n");
    return sub {
        $current_credit -= 1;
        if ($current_credit == 0) {
            print("not enough credits" . "\n");
            return;
        }
        print("playing game, " . $current_credit . " credit(s) remaining", "\n");
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
        "my_object": {
            "foo": "bar"
        },
        "my_array": [1, 2, 3]
    };
    console.log("myObject:", myObject);
    ```
=cut
my $my_object = {
    "my_string" => "foo",
    "my_number" => 123,
    "my_bool" => 1,
    "my_null" => undef,
    "my_object" => {
        "foo" => "bar"
    },
    "my_array" => [1, 2, 3]
};
print("my_object: " . pretty_json_stringify($my_object));

=begin
    4. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
    ```javascript
    const myArray = ["foo", 123, true, null, [1, 2, 3], { "foo": "bar" }];
    console.log("myArray:", myArray);
    ```
=cut
my $my_array = ["foo", 123, 1, undef, [1, 2, 3], { "foo" => "bar" }];
print("my_array: " . pretty_json_stringify($my_array));

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
    my ($callback_function) = @_;
    print("hello" . "\n");
    $callback_function -> ();
}
sub say_how_are_you {
    print("how are you?" . "\n");
}
say_hello(\&say_how_are_you);
say_hello(sub {
    print("how are you?" . "\n");
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
    console.log("multiplyBy2Result:", multiplyBy2Result);
    ```
=cut
sub multiply {
    my ($a) = @_;
    return sub {
        my ($b) = @_;
        return $a * $b;
    };
}
my $multiply_by2 = multiply(2);
my $multiply_by2_result = $multiply_by2->(10);
print("multiply_by2_result: " . $multiply_by2_result . "\n");

=begin
    7. support assigning functions to variables
    ```javascript
    const getRectangleAreaV1 = function (rectangleWidth, rectangleLength) {
        return (rectangleWidth * rectangleLength);
    };
    console.log("getRectangleAreaV1(7, 5):", getRectangleAreaV1(7, 5));
    const getRectangleAreaV2 = function (rectangleWidth, rectangleLength) {
        return (rectangleWidth * rectangleLength);
    };
    console.log("getRectangleAreaV2(7, 5):", getRectangleAreaV2(7, 5));
    const getRectangleAreaV3 = (rectangleWidth, rectangleLength) => {
        return (rectangleWidth * rectangleLength);
    };
    console.log("getRectangleAreaV3(7, 5):", getRectangleAreaV3(7, 5));
    const getRectangleAreaV4 = (rectangleWidth, rectangleLength) => (rectangleWidth * rectangleLength);
    console.log("getRectangleAreaV4(7, 5):", getRectangleAreaV4(7, 5));
    ```
=cut
my $get_rectangle_area = sub {
    my ($rectangle_width, $rectangle_length) = @_;
    return $rectangle_width * $rectangle_length;
};
print("get_rectangle_area(7, 5): " . $get_rectangle_area->(7, 5) . "\n");

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
        { "foo": "bar" },
    ];
    console.log("myArray2[0](7, 5):", myArray2[0](7, 5));

    const myObject2 = {
        "my_function": function (a, b) {
            return (a * b);
        },
        "my_string": "foo",
        "my_number": 123,
        "my_bool": true,
        "my_null": null,
        "my_object": {
            "foo": "bar"
        },
        "my_array": [1, 2, 3]
    };
    console.log("myObject2["my_function"](7, 5):", myObject2["my_function"](7, 5));
    ```
=cut
my $my_array2 = [
    sub {
        my ($a, $b) = @_;
        return $a * $b;
    },
    "foo",
    123,
    1,
    undef,
    [1, 2, 3],
    { "foo" => "bar" }
];
print("myArray2[0](7, 5): " . $my_array2->[0]->(7, 5) . "\n");

my $my_object2 = {
    "my_function" => sub {
        my ($a, $b) = @_;
        return $a * $b;
    },
    "my_string" => "foo",
    "my_number" => 123,
    "my_bool" => 1,
    "my_null" => undef,
    "my_object" => {
        "foo" => "bar"
    },
    "my_array" => [1, 2, 3]
};
print("myObject2[\"my_function\"](7, 5): " . $my_object2->{"my_function"}->(7, 5) . "\n");
