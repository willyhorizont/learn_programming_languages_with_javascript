from numbers import Number
import time

js_like_type = {"Null": "Null", "Boolean": "Boolean", "String": "String", "Numeric": "Numeric", "Object": "Object", "Array": "Array", "Function": "Function"}


def array_reduce(callback_function, any_array, initial_value):
    '''JavaScript-like Array.reduce() function'''
    result = initial_value
    for (array_item_index, array_item) in enumerate(any_array):
        result = callback_function(result, array_item, array_item_index, any_array)
    return result


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

json_stringify = (json_stringify_v10_inner := lambda anything, pretty=False, indent=(" " * 4), indent_level=0: ("null" if ((anything_inner_type := get_type(anything)) == js_like_type["Null"]) else ('"' + str(anything) + '"') if (anything_inner_type == js_like_type["String"]) else str(anything) if (anything_inner_type == js_like_type["Numeric"]) else "true" if ((anything_inner_type == js_like_type["Boolean"]) and (anything == True)) else "false" if ((anything_inner_type == js_like_type["Boolean"]) and (anything == False)) else (("{" + "}") if (len(anything) == 0) else ("".join([(("{\n" + (indent * (indent_level + 1))) if (pretty == True) else "{ "), *[((('"' + object_key + '": ' + json_stringify_v10_inner(object_value, pretty=pretty, indent_level=(indent_level + 1))) + ((",\n" + (indent * (indent_level + 1))) if (pretty == True) else ", ")) if ((object_entry_index + 1) != len(anything)) else ('"' + object_key + '": ' + json_stringify_v10_inner(object_value, pretty=pretty, indent_level=(indent_level + 1)))) for (object_entry_index, (object_key, object_value)) in enumerate(anything.items())], (("\n" + (indent * indent_level) + "}") if (pretty == True) else " }")]))) if (anything_inner_type == js_like_type["Object"]) else ("[]" if (len(anything) == 0) else ("".join([(("[\n" + (indent * (indent_level + 1))) if (pretty == True) else "["), *[((json_stringify_v10_inner(array_item, pretty=pretty, indent_level=(indent_level + 1)) + ((",\n" + (indent * (indent_level + 1))) if (pretty == True) else ", ")) if ((array_item_index + 1) != len(anything)) else json_stringify_v10_inner(array_item, pretty=pretty, indent_level=(indent_level + 1))) for (array_item_index, array_item) in enumerate(anything)], (("\n" + (indent * indent_level) + "]") if (pretty == True) else "]")]))) if (anything_inner_type == js_like_type["Array"]) else "[object Function]" if (anything_inner_type == js_like_type["Function"]) else anything_inner_type))  # '''custom JSON.stringify() function json_stringify_v10'''

if __name__ == "__main__":
    python_start = time.perf_counter_ns()

    print("# JavaScript-like JSON.stringify() in Python")

    my_array = [
        lambda a, b: (a * b),
        "foo",
        123,
        True,
        None,
        [1, 2, 3],
        {"foo": "bar"}
    ]
    print(f'json_stringify(my_array): {json_stringify(my_array)}')
    print(f'json_stringify(my_array, pretty=True): {json_stringify(my_array, pretty=True)}')

    my_object = {
        "my_function": lambda a, b: (a * b),
        "my_string": "foo",
        "my_number": 123,
        "my_bool": True,
        "my_null": None,
        "my_array": [1, 2, 3],
        "my_object": {
            "foo": "bar"
        }
    }
    print(f"json_stringify(my_object): {json_stringify(my_object)}")
    print(f"json_stringify(my_object, pretty=True): {json_stringify(my_object, pretty=True)}")

    python_end = time.perf_counter_ns()
    python_time = ((python_end - python_start) / 1_000)
    print(python_time)
