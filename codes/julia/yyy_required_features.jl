struct js_like_type_struct
    Null::Any
    Boolean::Any
    String::Any
    Numeric::Any
    Object::Any
    Array::Any
    Function::Any
end

js_like_type::Any = js_like_type_struct(
    "Null",
    "Boolean",
    "String",
    "Numeric",
    "Object",
    "Array",
    "Function"
)

is_like_js_null::Any = (anything::Any) -> ((anything === nothing) && (isnothing(anything) === true))::Any

is_like_js_boolean::Any = (anything::Any) -> ((isa(anything, Bool) === true) && ((anything === true) || (anything === false)))::Any

is_like_js_string::Any = (anything::Any) -> (isa(anything, AbstractString) === true)::Any

is_like_js_numeric::Any = (anything::Any) -> (isa(anything, Number) === true)::Any

is_like_js_object::Any = (anything::Any) -> (isa(anything, Dict{String, Any}) === true)::Any

is_like_js_array::Any = (anything::Any) -> ((isa(anything, Array{Any, 1}) === true) && (isa(anything, Vector{Any}) === true))::Any

is_like_js_function::Any = (anything::Any) -> (isa(anything, Function) === true)::Any

get_type::Any = (anything::Any) -> (begin
    if (is_like_js_null(anything) === true) return (js_like_type.Null)::Any end
    if (is_like_js_boolean(anything) === true) return (js_like_type.Boolean)::Any end
    if (is_like_js_string(anything) === true) return (js_like_type.String)::Any end
    if (is_like_js_numeric(anything) === true) return (js_like_type.Numeric)::Any end
    if (is_like_js_object(anything) === true) return (js_like_type.Object)::Any end
    if (is_like_js_array(anything) === true) return (js_like_type.Array)::Any end
    if (is_like_js_function(anything) === true) return (js_like_type.Function)::Any end
    return ("\"$(typeof(anything))\"")::Any
end)::Any

json_stringify::Any = (anything::Any; pretty::Any=false) -> (begin
    # custom JSON.stringify() function
    local indent::Any = repeat(" ", 4)
    local indent_level::Any = 0
    local json_stringify_inner::Any = (anything_inner::Any) -> (begin
        if (get_type(anything_inner) === js_like_type.Null) return ("null")::Any end
        if (get_type(anything_inner) === js_like_type.String) return ("\"$(anything_inner)\"")::Any end
        if ((get_type(anything_inner) === js_like_type.Numeric) || (get_type(anything_inner) === js_like_type.Boolean)) return ("$(anything_inner)")::Any end
        if (get_type(anything_inner) === js_like_type.Array)
            return ((() -> begin
                if (length(anything_inner) === 0) return ("[]")::Any end
                indent_level += 1
                local result::Any = ((pretty === true) ? "[\n$(repeat(indent, indent_level))" : "[")
                for (array_item_index, array_item) in enumerate(anything_inner)
                    result *= json_stringify_inner(array_item)
                    if (array_item_index !== length(anything_inner))
                        result *= ((pretty === true) ? ",\n$(repeat(indent, indent_level))" : ", ")
                    end
                end
                indent_level -= 1
                result *= ((pretty === true) ? "\n$(repeat(indent, indent_level))]" : "]")
                return (result)::Any
            end)())::Any
        end
        if (get_type(anything_inner) === js_like_type.Object)
            return ((() -> begin
                if (length(anything_inner) === 0) return ("{}")::Any end
                indent_level += 1
                local result::Any = ((pretty === true) ? "{\n$(repeat(indent, indent_level))" : "{ ")
                for (object_entry_index, (object_key, object_value)) in enumerate(pairs(anything_inner))
                    result *= "\"$(object_key)\": $(json_stringify_inner(object_value))"
                    if (object_entry_index !== length(anything_inner))
                        result *= ((pretty === true) ? ",\n$(repeat(indent, indent_level))" : ", ")
                    end
                end
                indent_level -= 1
                result *= ((pretty === true) ? "\n$(repeat(indent, indent_level))}" : " }")
                return (result)::Any
            end)())::Any
        end
        if (get_type(anything_inner) === js_like_type.Function) return ("\"[object Function]\"")::Any end
        return ("\"$(typeof(anything))\"")::Any
    end)::Any
    return (json_stringify_inner(anything))::Any
end)::Any

#=
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
=#
something::Any = "foo"
println("something: $(json_stringify(something, pretty=true))")
something = 123
println("something: $(json_stringify(something, pretty=true))")
something = true
println("something: $(json_stringify(something, pretty=true))")
something = nothing
println("something: $(json_stringify(something, pretty=true))")
something = Vector{Any}([1, 2, 3])
println("something: $(json_stringify(something, pretty=true))")
something = Dict{String, Any}("foo" => "bar")
println("something: $(json_stringify(something, pretty=true))")

#=
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
=#
function get_modified_indent_level()::Any
    local indent_level::Any = 0
    function change_indent_level()
        indent_level += 1
        if (indent_level < 5) change_indent_level() end
        return indent_level
    end
    return change_indent_level()
end
println("get_modified_indent_level(): $(get_modified_indent_level())")
function create_new_game(initial_credit::Any)::Any
    local current_credit::Any = initial_credit
    println("initial credit: $(initial_credit)")
    return (() -> (begin
        current_credit -= 1
        if (current_credit === 0)
            println("not enough credits")
            return
        end
        println("playing game, $(current_credit) credit(s) remaining")
    end)::Any)::Any
end
play_game::Any = create_new_game(3)
play_game()
play_game()
play_game()

#=
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
=#
my_object::Any = Dict{String, Any}(
    "my_string" => "foo",
    "my_number" => 123,
    "my_bool" => true,
    "my_null" => nothing,
    "my_array" => Vector{Any}([1, 2, 3]),
    "my_object" => Dict{String, Any}(
        "foo" => "bar"
    )
)
println("my_object: $(json_stringify(my_object, pretty=true))")

#=
4. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
```javascript
const myArray = ["foo", 123, true, null, [1, 2, 3], { "foo": "bar" }];
console.log(`myArray: ${myArray}`);
```
=#
my_array::Any = Vector{Any}(["foo", 123, true, nothing, Vector{Any}([1, 2, 3]), Dict{String, Any}("foo" => "bar")])
println("my_array: $(json_stringify(my_array, pretty=true))")

#=
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
=#
function say_hello(callback_function::Any)::Any
    println("hello")
    callback_function()
end
function say_how_are_you()::Any
    println("how are you ?")
end
say_hello(say_how_are_you)
say_hello(function ()
    println("how are you ?")
end)

#=
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
=#
function multiply(a::Any)::Any
    return ((b::Any) -> (begin
        return (a * b)::Any
    end)::Any)::Any
end
multiply_by2::Any = multiply(2)
multiply_by2_result::Any = multiply_by2(10)
println("multiply_by2(10): $(multiply_by2_result)")

#=
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
=#
get_rectangle_area_v3::Any = function (rectangle_width::Any, rectangle_length::Any)
    return (rectangle_width * rectangle_length)::Any
end
println("get_rectangle_area_v3(7, 5): $(get_rectangle_area_v3(7, 5))")

get_rectangle_area_v5::Any = (rectangle_width::Any, rectangle_length::Any) -> (begin
    return (rectangle_width * rectangle_length)::Any
end)::Any
println("get_rectangle_area_v5(7, 5): $(get_rectangle_area_v5(7, 5))")

get_rectangle_area_v6::Any = (rectangle_width::Any, rectangle_length::Any) -> (rectangle_width * rectangle_length)::Any
println("get_rectangle_area_v6(7, 5): $(get_rectangle_area_v6(7, 5))")

#=
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
=#
my_array2::Any = Vector{Any}([
    function (a::Any, b::Any)
        return (a * b)::Any
    end,
    "foo",
    123,
    true,
    nothing,
    Vector{Any}([1, 2, 3]),
    Dict{String, Any}("foo" => "bar")
])
println("myArray2[0](7, 5): $(my_array2[1](7, 5))")
my_object2::Any = Dict{String, Any}(
    "my_function" => function (a::Any, b::Any)
        return (a * b)::Any
    end,
    "my_string" => "foo",
    "my_number" => 123,
    "my_bool" => true,
    "my_null" => nothing,
    "my_array" => Vector{Any}([1, 2, 3]),
    "my_object" => Dict{String, Any}(
        "foo" => "bar"
    )
)
println("myObject2[\"my_function\"](7, 5): $(my_object2["my_function"](7, 5))")
