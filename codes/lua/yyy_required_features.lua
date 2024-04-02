JSON = (loadfile "utils/JSON.lua")() -- Thanks to Jeffrey Friedl's awesome work, checkout his awesome personal blog at http://regex.info/blog/lua/json

function sprint(...)
    local parameters = {...}
    local result = ""
    for _, parameter in ipairs(parameters) do
        result = result .. tostring(parameter)
    end
    print(result)
end

function pretty_json_stringify(anything) return JSON:encode_pretty(anything, 'etc', { pretty=true, indent="    ", array_newline=true }) end

--[[
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
]]
something = "foo"
sprint("something: ", pretty_json_stringify(something))
something = 123
sprint("something: ", pretty_json_stringify(something))
something = true
sprint("something: ", pretty_json_stringify(something))
something = nil
sprint("something: ", pretty_json_stringify(something))
something = {1, 2, 3}
sprint("something: ", pretty_json_stringify(something))
something = { foo = "bar" }
sprint("something: ", pretty_json_stringify(something))

--[[
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
]]
function get_modified_indent_level()
    local indent_level = 0
    function change_indent_level()
        indent_level = indent_level + 1
        if (indent_level < 5) then change_indent_level() end
        return indent_level
    end
    return change_indent_level()
end
sprint("get_modified_indent_level(): ", get_modified_indent_level())
function create_new_game(initial_credit)
    local current_credit = initial_credit
    sprint("initial credit: ", initial_credit)
    return function ()
        current_credit = current_credit - 1
        if (current_credit == 0) then
            sprint("not enough credits")
            return
        end
        sprint("playing game, ", current_credit, " credit(s) remaining")
    end
end
play_game = create_new_game(3)
play_game()
play_game()
play_game()

--[[
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
]]
my_object = {
    my_string = "foo",
    my_number = 123,
    my_bool = true,
    my_null = nil,
    my_array = {1, 2, 3},
    my_object = {
        foo = "bar"
    }
}
sprint("my_object: ", pretty_json_stringify(my_object))

--[[
    4. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
    ```javascript
    const myArray = ["foo", 123, true, null, [1, 2, 3], { "foo": "bar" }];
    console.log("myArray:", myArray);
    ```
]]
my_array = {"foo", 123, true, nil, {1, 2, 3}, { foo = "bar" }}
sprint("my_array: ", pretty_json_stringify(my_array))

--[[
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
]]
function say_hello(callback_function)
    print("hello")
    callback_function()
end
function say_how_are_you()
    print("how are you?")
end
say_hello(say_how_are_you)
say_hello(function ()
    print("how are you?")
end)

--[[
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
]]
function multiply(a)
    return function (b)
        return (a * b)
    end
end
multiply_by2 = multiply(2)
multiply_by2_result = multiply_by2(10)
sprint("multiply_by2_result: ", multiply_by2_result)

--[[
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
]]
get_rectangle_area = function(rectangle_width, rectangle_length)
    return (rectangle_width * rectangle_length)
end
sprint("get_rectangle_area(7, 5): ", get_rectangle_area(7, 5))

--[[
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
]]
my_array2 = {
    function(a, b)
        return (a * b)
    end,
    "foo",
    123,
    true,
    nil,
    {1, 2, 3},
    { foo = "bar" }
}
sprint("myArray2[0](7, 5): ", my_array2[1](7, 5))

my_object2 = {
    my_function = function(a, b)
        return (a * b)
    end,
    my_string = "foo",
    my_number = 123,
    my_bool = true,
    my_null = nil,
    my_array = {1, 2, 3},
    my_object = {
        foo = "bar"
    }
}
sprint("myObject2[\"my_function\"](7, 5): ", my_object2["my_function"](7, 5))
