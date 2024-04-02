require "json"

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
=end
something = "foo"
print("something: ", JSON.pretty_generate(something, { "indent": " " * 4 }), "\n")
something = 123
print("something: ", JSON.pretty_generate(something, { "indent": " " * 4 }), "\n")
something = true
print("something: ", JSON.pretty_generate(something, { "indent": " " * 4 }), "\n")
something = nil
print("something: ", JSON.pretty_generate(something, { "indent": " " * 4 }), "\n")
something = [1, 2, 3]
print("something: ", JSON.pretty_generate(something, { "indent": " " * 4 }), "\n")
something = { "foo" => "bar" }
print("something: ", JSON.pretty_generate(something, { "indent": " " * 4 }), "\n")

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
=end
def get_modified_indent_level()
    indent_level = 0
    change_indent_level = ->() do
        indent_level += 1
        change_indent_level.call() if (indent_level < 5)
        return indent_level
    end
    change_indent_level.call()
end
print("get_modified_indent_level(): ", get_modified_indent_level(), "\n")
def create_new_game(initial_credit)
    current_credit = initial_credit
    print("initial credit: ", initial_credit, "\n")
    return ->() do
        current_credit -= 1
        if (current_credit == 0)
            print("not enough credits", "\n")
            return
        end
        print("playing game, #{current_credit} credit(s) remaining", "\n")
    end
end
play_game = create_new_game(3)
play_game.call()
play_game.call()
play_game.call()

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
    console.log("myObject:", myObject);
    ```
=end
my_object = {
    "my_string" => "foo",
    "my_number" => 123,
    "my_bool" => true,
    "my_null" => nil,
    "my_array" => [1, 2, 3],
    "my_object" => {
        "foo" => "bar"
    }
}
print("my_object: ", JSON.pretty_generate(my_object, { "indent": " " * 4 }), "\n")

=begin
    4. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
    ```javascript
    const myArray = ["foo", 123, true, null, [1, 2, 3], { "foo": "bar" }];
    console.log("myArray:", myArray);
    ```
=end
my_array = ["foo", 123, true, nil, [1, 2, 3], { "foo" => "bar" }]
print("my_array: ", JSON.pretty_generate(my_array, { "indent": " " * 4 }), "\n")

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
=end
def say_hello(callback_function)
    print("hello\n")
    callback_function.call()
end
def say_how_are_you()
    print("how are you?\n")
end
say_hello(method(:say_how_are_you))
say_hello(->() do
    print("how are you?", "\n")
end)

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
=end
multiply = ->(a) do
    return ->(b) do
        return (a * b)
    end
end
multiply_by2 = multiply.call(2)
multiply_by2_result = multiply_by2.call(10)
print("multiply_by2_result: ", multiply_by2_result, "\n")

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
=end
get_rectangle_area_v1 = Proc.new { |rectangle_width, rectangle_length| (rectangle_width * rectangle_length) }
print("get_rectangle_area_v1.call(7, 5): ", get_rectangle_area_v1.call(7, 5), "\n")
get_rectangle_area_v2 = proc { |rectangle_width, rectangle_length| (rectangle_width * rectangle_length) }
print("get_rectangle_area_v2.call(7, 5): ", get_rectangle_area_v2.call(7, 5), "\n")
get_rectangle_area_v3 = Proc.new do |rectangle_width, rectangle_length|
    (rectangle_width * rectangle_length)
end
print("get_rectangle_area_v3.call(7, 5): ", get_rectangle_area_v3.call(7, 5), "\n")
get_rectangle_area_v4 = proc do |rectangle_width, rectangle_length|
    (rectangle_width * rectangle_length)
end
print("get_rectangle_area_v4.call(7, 5): ", get_rectangle_area_v4.call(7, 5), "\n")
get_rectangle_area_v5 = lambda { |rectangle_width, rectangle_length| (rectangle_width * rectangle_length) }
print("get_rectangle_area_v5.call(7, 5): ", get_rectangle_area_v5.call(7, 5), "\n")
get_rectangle_area_v6 = ->(rectangle_width, rectangle_length) { (rectangle_width * rectangle_length) }
print("get_rectangle_area_v6.call(7, 5): ", get_rectangle_area_v6.call(7, 5), "\n")
get_rectangle_area_v7 = lambda do |rectangle_width, rectangle_length|
    return (rectangle_width * rectangle_length)
end
print("get_rectangle_area_v7.call(7, 5): ", get_rectangle_area_v7.call(7, 5), "\n")
get_rectangle_area_v8 = ->(rectangle_width, rectangle_length) do
    return (rectangle_width * rectangle_length)
end
print("get_rectangle_area_v8.call(7, 5): ", get_rectangle_area_v8.call(7, 5), "\n")

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
    console.log("myArray2[0](7, 5):", myArray2[0](7, 5));

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
    console.log("myObject2["my_function"](7, 5):", myObject2["my_function"](7, 5));
    ```
=end
my_array2 = [
    ->(a, b) do
        return (a * b)
    end,
    "foo",
    123,
    true,
    nil,
    [1, 2, 3],
    { "foo" => "bar" }
]
print("myArray2[0](7, 5): ", my_array2[0].call(7, 5), "\n")

my_object2 = {
    "my_function" => ->(a, b) do
        return (a * b)
    end,
    "my_string" => "foo",
    "my_number" => 123,
    "my_bool" => true,
    "my_null" => nil,
    "my_array" => [1, 2, 3],
    "my_object" => {
        "foo" => "bar"
    }
}
print("myObject2[\"my_function\"](7, 5): ", my_object2["my_function"].call(7, 5), "\n")
