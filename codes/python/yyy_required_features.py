from numbers import Number

js_like_type = {"Null": "Null", "Boolean": "Boolean", "String": "String", "Numeric": "Numeric", "Object": "Object", "Array": "Array", "Function": "Function"}

array_reduce = lambda callback_function, any_array, initial_value: (array_reduce_v2_inner := lambda array_item_index, result: (result if (array_item_index >= len(any_array)) else array_reduce_v2_inner((array_item_index + 1), callback_function(result, any_array[array_item_index], array_item_index, any_array))))(0, initial_value)  # '''JavaScript-like Array.reduce() function array_reduce_v2'''

is_like_js_null = lambda anything: (anything is None)

is_like_js_boolean = lambda anything: ((isinstance(anything, bool) == True) and ((anything == True) or (anything == False)))

is_like_js_string = lambda anything: (isinstance(anything, str) == True)

is_like_js_numeric = lambda anything: (isinstance(anything, Number) == True)

is_like_js_object = lambda anything: (isinstance(anything, dict) == True)

is_like_js_array = lambda anything: (isinstance(anything, list) == True)

is_like_js_function = lambda anything: (callable(anything) == True)

get_type = lambda anything: (js_like_type["Null"] if (is_like_js_null(anything) == True) else js_like_type["Boolean"] if (is_like_js_boolean(anything) == True) else js_like_type["String"] if (is_like_js_string(anything) == True) else js_like_type["Numeric"] if (is_like_js_numeric(anything) == True) else js_like_type["Object"] if (is_like_js_object(anything) == True) else js_like_type["Array"] if (is_like_js_array(anything) == True) else js_like_type["Function"] if (is_like_js_function(anything) == True) else str(type(anything)))  # '''get_type_v2'''


def optional_chaining(callback_function):
    try:
        return callback_function()
    except Exception as any_exception:
        return None


nullish_coalescing = lambda anything, default_value: (default_value if (is_like_js_null(anything) == True) else anything)  # '''JavaScript-like Nullish Coalescing Operator (??) function nullish_coalescing_v2'''

json_stringify = (json_stringify_v9_inner := lambda anything, pretty=False, indent=(" " * 4), indent_level=0: ("null" if ((anything_type := get_type(anything)) == js_like_type["Null"]) else ('"' + str(anything) + '"') if (anything_type == js_like_type["String"]) else str(anything) if (anything_type == js_like_type["Numeric"]) else "true" if ((anything_type == js_like_type["Boolean"]) and (anything == True)) else "false" if ((anything_type == js_like_type["Boolean"]) and (anything == False)) else (("{" + "}") if (len(anything) == 0) else ("".join([(("{\n" + (indent * (indent_level + 1))) if (pretty == True) else "{ "), *[((('"' + str(object_key) + '": ' + json_stringify_v9_inner(object_value, pretty=pretty, indent_level=(indent_level + 1))) + ((",\n" + (indent * (indent_level + 1))) if (pretty == True) else ", ")) if ((object_entry_index + 1) != len(anything)) else ('"' + str(object_key) + '": ' + json_stringify_v9_inner(object_value, pretty=pretty, indent_level=(indent_level + 1)))) for (object_entry_index, (object_key, object_value)) in enumerate(anything.items())], (("\n" + (indent * indent_level) + "}") if (pretty == True) else " }")]))) if (anything_type == js_like_type["Object"]) else ("[]" if (len(anything) == 0) else ("".join([(("[\n" + (indent * (indent_level + 1))) if (pretty == True) else "["), *[((json_stringify_v9_inner(array_item, pretty=pretty, indent_level=(indent_level + 1)) + ((",\n" + (indent * (indent_level + 1))) if (pretty == True) else ", ")) if ((array_item_index + 1) != len(anything)) else json_stringify_v9_inner(array_item, pretty=pretty, indent_level=(indent_level + 1))) for (array_item_index, array_item) in enumerate(anything)], (("\n" + (indent * indent_level) + "]") if (pretty == True) else "]")]))) if (anything_type == js_like_type["Array"]) else "[object Function]" if (anything_type == js_like_type["Function"]) else anything_type))  # '''custom JSON.stringify() function json_stringify_v9'''

"""
x. variable can store dynamic data type and dynamic value, variable can inferred data type from value, value of variable can be reassign with different data type or has option to make variable can store dynamic data type and dynamic value
"""
something = "foo"
print(f"something: {json_stringify(something)}")
something = 123
print(f"something: {json_stringify(something)}")
something = True
print(f"something: {json_stringify(something)}")
something = None
print(f"something: {json_stringify(something)}")
something = [1, 2, 3]
print(f"something: {json_stringify(something)}")
something = {"foo": "bar"}
print(f"something: {json_stringify(something)}")

"""
x. it is possible to access and modify variables defined outside of the current scope within nested functions, so it is possible to have closure too
"""


def get_modified_indent_level():
    indent_level = 0


    def change_indent_level():
        nonlocal indent_level
        indent_level += 1
        if (indent_level < 5):
            change_indent_level()
        return indent_level


    return change_indent_level()


print(f"get_modified_indent_level(): {get_modified_indent_level()}")


def create_new_game(initial_credit):
    current_credit = initial_credit
    print(f"initial credit: {initial_credit}")


    def play_game():
        nonlocal current_credit
        current_credit -= 1
        if (current_credit == 0):
            print("not enough credits")
            return
        print(f"playing game, {current_credit} credit(s) remaining")


    return play_game


play_game = create_new_game(3)
play_game()
play_game()
play_game()

"""
x. object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure can store dynamic data type and dynamic value
"""
my_object = {
    "my_string": "foo",
    "my_number": 123,
    "my_boolean": True,
    "my_null": None,
    "my_array": [1, 2, 3],
    "my_object": {
        "foo": "bar"
    }
}
print(f"my_object: {json_stringify(my_object, pretty=True)}")

"""
x. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
"""
my_array = ["foo", 123, True, None, [1, 2, 3], {"foo": "bar"}]
print(f"my_array: {json_stringify(my_array, pretty=True)}")

"""
x. support passing functions as arguments to other functions
"""
def say_hello(callback_function):
    print("hello")
    callback_function()


def say_how_are_you():
    print("how are you?")


say_hello(say_how_are_you)
say_hello(lambda: print("how are you ?"))

"""
x. support returning functions as values from other functions
"""
def multiply(a):
    return lambda b: (a * b)


multiply_by2 = multiply(2)
multiply_by2_result = multiply_by2(10)
print(f"multiplyBy2(10): {multiply_by2_result}")

"""
x. support assigning functions to variables
"""
get_rectangle_area = lambda rectangle_width, rectangle_length: (rectangle_width * rectangle_length)
print(f"get_rectangle_area(7, 5): {get_rectangle_area(7, 5)}")

"""
x. support storing functions in data structures like object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure or array/list/slice/ordered-list-data-structure
"""
my_array2 = [
    lambda a, b: (a * b),
    "foo",
    123,
    True,
    None,
    [1, 2, 3],
    {"foo": "bar"}
]
print(f"myArray2[0](7, 5): {my_array2[0](7, 5)}")
my_object2 = {
    "my_function": lambda a, b: (a * b),
    "my_string": "foo",
    "my_number": 123,
    "my_boolean": True,
    "my_null": None,
    "my_array": [1, 2, 3],
    "my_object": {
        "foo": "bar"
    }
}
print(f'myObject2["my_function"](7, 5): {my_object2["my_function"](7, 5)}')
