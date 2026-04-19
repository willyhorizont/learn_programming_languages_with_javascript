require "json"

=begin
x. variable can store dynamic data type and dynamic value, variable can inferred data type from value, value of variable can be reassign with different data type or has option to make variable can store dynamic data type and dynamic value
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
x. it is possible to access and modify variables defined outside of the current scope within nested functions, so it is possible to have closure too
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
x. object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure can store dynamic data type and dynamic value
=end
my_object = {
    "my_string" => "foo",
    "my_number" => 123,
    "my_boolean" => true,
    "my_null" => nil,
    "my_array" => [1, 2, 3],
    "my_object" => {
        "foo" => "bar"
    }
}
print("my_object: ", JSON.pretty_generate(my_object, { "indent": " " * 4 }), "\n")

=begin
x. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
=end
my_array = ["foo", 123, true, nil, [1, 2, 3], { "foo" => "bar" }]
print("my_array: ", JSON.pretty_generate(my_array, { "indent": " " * 4 }), "\n")

=begin
x. support passing functions as arguments to other functions
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
x. support returning functions as values from other functions
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
x. support assigning functions to variables
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
x. support storing functions in data structures like object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure or array/list/slice/ordered-list-data-structure
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
    "my_boolean" => true,
    "my_null" => nil,
    "my_array" => [1, 2, 3],
    "my_object" => {
        "foo" => "bar"
    }
}
print("myObject2[\"my_function\"](7, 5): ", my_object2["my_function"].call(7, 5), "\n")
