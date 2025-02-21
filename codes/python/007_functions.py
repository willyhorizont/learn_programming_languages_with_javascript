from numbers import Number

js_like_type = {"Null": "Null", "Boolean": "Boolean", "String": "String", "Numeric": "Numeric", "Object": "Object", "Array": "Array", "Function": "Function"}

array_reduce = lambda callback_function, any_array, initial_value_or_current_result, array_item_index=0: (initial_value_or_current_result if (array_item_index >= len(any_array)) else array_reduce(callback_function, any_array, (callback_function(initial_value_or_current_result, any_array[array_item_index], array_item_index, any_array)), (array_item_index + 1)))  # '''JavaScript-like Array.reduce() function array_reduce_v2'''

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

json_stringify = (json_stringify_v10_inner := lambda anything, pretty=False, indent=(" " * 4), indent_level=0: ("null" if ((anything_type := get_type(anything)) == js_like_type["Null"]) else ('"' + str(anything) + '"') if (anything_type == js_like_type["String"]) else str(anything) if (anything_type == js_like_type["Numeric"]) else "true" if ((anything_type == js_like_type["Boolean"]) and (anything == True)) else "false" if ((anything_type == js_like_type["Boolean"]) and (anything == False)) else (("{" + "}") if (len(anything) == 0) else ("".join([(("{\n" + (indent * (indent_level + 1))) if (pretty == True) else "{ "), *[((('"' + str(object_key) + '": ' + json_stringify_v10_inner(object_value, pretty=pretty, indent_level=(indent_level + 1))) + ((",\n" + (indent * (indent_level + 1))) if (pretty == True) else ", ")) if ((object_entry_index + 1) != len(anything)) else ('"' + str(object_key) + '": ' + json_stringify_v10_inner(object_value, pretty=pretty, indent_level=(indent_level + 1)))) for (object_entry_index, (object_key, object_value)) in enumerate(anything.items())], (("\n" + (indent * indent_level) + "}") if (pretty == True) else " }")]))) if (anything_type == js_like_type["Object"]) else ("[]" if (len(anything) == 0) else ("".join([(("[\n" + (indent * (indent_level + 1))) if (pretty == True) else "["), *[((json_stringify_v10_inner(array_item, pretty=pretty, indent_level=(indent_level + 1)) + ((",\n" + (indent * (indent_level + 1))) if (pretty == True) else ", ")) if ((array_item_index + 1) != len(anything)) else json_stringify_v10_inner(array_item, pretty=pretty, indent_level=(indent_level + 1))) for (array_item_index, array_item) in enumerate(anything)], (("\n" + (indent * indent_level) + "]") if (pretty == True) else "]")]))) if (anything_type == js_like_type["Array"]) else "[object Function]" if (anything_type == js_like_type["Function"]) else anything_type))  # '''custom JSON.stringify() function json_stringify_v10'''

# ? function statement or function declaration


def get_rectangle_area_v1(rectangle_width, rectangle_length):
    return (rectangle_width * rectangle_length)


print(f"get_rectangle_area_v1(7, 5): {get_rectangle_area_v1(7, 5)}")

# ? function expression with lambda function or named lambda function

get_rectangle_area_v2 = lambda rectangle_width, rectangle_length: (rectangle_width * rectangle_length)
print(f"get_rectangle_area_v2(7, 5): {get_rectangle_area_v2(7, 5)}")

# ? anonymous function or anonymous lambda function or lambda function
lambda rectangle_width, rectangle_length: (rectangle_width * rectangle_length)

# ? Passing functions as arguments to other functions


def say_hello(callback_function):
    print("hello")
    callback_function()


def say_how_are_you():
    print("how are you?")


say_hello(say_how_are_you)

say_hello(lambda: print("how are you ?"))

# ? Assigning functions to variables or storing them in data structures

get_rectangle_area_v2 = lambda rectangle_width, rectangle_length: (rectangle_width * rectangle_length)

my_array_of_get_rectangle_area_functions = [
    get_rectangle_area_v1,
    lambda rectangle_width, rectangle_length: (rectangle_width * rectangle_length)
]
print(f"my_array_of_get_rectangle_area_functions[0](7, 5): {my_array_of_get_rectangle_area_functions[0](7, 5)}")
print(f"my_array_of_get_rectangle_area_functions[1](7, 5): {my_array_of_get_rectangle_area_functions[1](7, 5)}")
print(f"optional_chaining(lambda: (my_array_of_get_rectangle_area_functions[0](7, 5))): {optional_chaining(lambda: (my_array_of_get_rectangle_area_functions[0](7, 5)))}")
print(f"optional_chaining(lambda: (my_array_of_get_rectangle_area_functions[1](7, 5))): {optional_chaining(lambda: (my_array_of_get_rectangle_area_functions[1](7, 5)))}")


def exponentiation(a, b):
    return (a ** b)


simple_calculator = {
    "exponentiation": exponentiation,
    "addition": lambda a, b: (a + b)
}
print(f'simple_calculator["exponentiation"](2, 4): {simple_calculator["exponentiation"](2, 4)}')
print(f'simple_calculator["addition"](9, 3): {simple_calculator["addition"](9, 3)}')
print(f'optional_chaining(lambda: (simple_calculator["exponentiation"](2, 4))): {optional_chaining(lambda: (simple_calculator["exponentiation"](2, 4)))}')
print(f'optional_chaining(lambda: (simple_calculator["addition"](9, 3))): {optional_chaining(lambda: (simple_calculator["addition"](9, 3)))}')

# ? Returning functions as values from other functions


def multiply_v1(a):
    def multiply_by(b):
        return (a * b)
    return multiply_by


multiply_by2 = multiply_v1(2)
multiply_by2_result = multiply_by2(10)
print(f"multiply_by2(10): {multiply_by2_result}")


def multiply_v2(a):
    multiply_by = lambda b: (a * b)
    return multiply_by


multiply_by3 = multiply_v2(3)
multiply_by3_result = multiply_by3(10)
print(f"multiply_by3(10): {multiply_by3_result}")


def multiply_v3(a):
    return lambda b: (a * b)


multiply_by4 = multiply_v3(4)
multiply_by4_result = multiply_by4(10)
print(f"multiply_by4(10): {multiply_by4_result}")


multiply_v4 = lambda a: lambda b: (a * b)
multiply_by5 = multiply_v4(5)
multiply_by5_result = multiply_by5(10)
print(f"multiply_by5(10): {multiply_by5_result}")
