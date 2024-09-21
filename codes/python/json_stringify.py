import json
from numbers import Number

js_like_type = {
    "Null": "Null",
    "Boolean": "Boolean",
    "String": "String",
    "Numeric": "Numeric",
    "Object": "Object",
    "Array": "Array",
    "Function": "Function"
}


def array_reduce(callback_function, an_array, initial_value):
    '''JavaScript-like Array.reduce() function'''
    result = initial_value
    for array_item_index, array_item in enumerate(an_array):
        result = callback_function(result, array_item, array_item_index, an_array)
    return result


is_like_js_null = lambda anything: (anything is None)

is_like_js_boolean = lambda anything: ((isinstance(anything, bool) == True) and ((anything == True) or (anything == False)))

is_like_js_string = lambda anything: (isinstance(anything, str) == True)

is_like_js_numeric = lambda anything: (isinstance(anything, Number) == True)

is_like_js_object = lambda anything: (isinstance(anything, dict) == True)

is_like_js_array = lambda anything: (isinstance(anything, list) == True)

is_like_js_function = lambda anything: (callable(anything) == True)

get_type = lambda anything: (js_like_type["Null"] if (is_like_js_null(anything) == True) else js_like_type["Boolean"] if (is_like_js_boolean(anything) == True) else js_like_type["String"] if (is_like_js_string(anything) == True) else js_like_type["Numeric"] if (is_like_js_numeric(anything) == True) else js_like_type["Object"] if (is_like_js_object(anything) == True) else js_like_type["Array"] if (is_like_js_array(anything) == True) else js_like_type["Function"] if (is_like_js_function(anything) == True) else f'"{(str(type(anything)))}"')  # '''get_type_v2'''

optional_chaining = lambda anything, *array_index_or_object_key_or_function_argument_array: ((anything(*array_index_or_object_key_or_function_argument_array)) if (get_type(anything) == js_like_type["Function"]) else (anything if (((get_type(anything) != js_like_type["Object"]) and (get_type(anything) != js_like_type["Array"])) or (len(array_index_or_object_key_or_function_argument_array) == 0)) else (array_reduce(lambda current_result, current_item, *_: anything.get(str(current_item)) if ((get_type(current_result) == js_like_type["Null"]) and (get_type(anything) == js_like_type["Object"]) and (get_type(current_item) == js_like_type["String"])) else anything[int(current_item)] if ((get_type(current_result) == js_like_type["Null"]) and (get_type(anything) == js_like_type["Array"]) and (get_type(current_item) == js_like_type["Numeric"]) and (int(current_item) >= 0) and (len(anything) > int(current_item))) else current_result.get(str(current_item)) if ((get_type(current_result) == js_like_type["Object"]) and (get_type(current_item) == js_like_type["String"])) else current_result[int(current_item)] if ((get_type(current_result) == js_like_type["Array"]) and (get_type(current_item) == js_like_type["Numeric"]) and (int(current_item) >= 0) and (len(current_result) > int(current_item))) else None, array_index_or_object_key_or_function_argument_array, None))))  # '''JavaScript-like Optional Chaining Operator (?.) function optional_chaining_v4'''

nullish_coalescing = lambda anything, default_value: (default_value if (is_like_js_null(anything) == True) else anything)  # '''JavaScript-like Nullish Coalescing Operator (??) function nullish_coalescing_v2'''


def pipe(*rest_arguments):
    pipe_last_result = None


    def pipe_array_reduce_callback(current_result, current_argument, *_):
        nonlocal pipe_last_result
        pipe_last_result = current_result
        if (get_type(current_result) == js_like_type["Null"]):
            return current_argument
        if (get_type(current_argument) == js_like_type["Function"]):
            return current_argument(current_result)
        return None


    pipe_result = array_reduce(pipe_array_reduce_callback, rest_arguments, None)
    if (get_type(pipe_result) == js_like_type["Function"]):
        return pipe_result(pipe_last_result)
    return pipe_result


def json_stringify(anything, **optional_argument):
    '''custom JSON.stringify() function json_stringify_v2'''
    indent = " " * 4
    indent_level = 0
    pretty = pipe(optional_chaining(optional_argument, "pretty"), lambda _: nullish_coalescing(_, False))


    def json_stringify_inner(anything_inner):
        nonlocal indent_level
        if (get_type(anything_inner) == js_like_type["Null"]):
            return "null"
        if (get_type(anything_inner) == js_like_type["String"]):
            return f'"{anything_inner}"'
        if (get_type(anything_inner) == js_like_type["Numeric"]):
            return f"{anything_inner}"
        if ((get_type(anything_inner) == js_like_type["Boolean"]) and (anything_inner == True)):
            return "true"
        if ((get_type(anything_inner) == js_like_type["Boolean"]) and (anything_inner == False)):
            return "false"
        if (get_type(anything_inner) == js_like_type["Object"]):
            if (len(anything_inner) == 0):
                return "{" + "}"
            indent_level += 1
            result = (("{\n" + (indent * indent_level)) if (pretty == True) else "{ ")
            for object_entry_index, (object_key, object_value) in enumerate(anything_inner.items()):
                result += f'"{object_key}": {json_stringify_inner(object_value)}'
                if ((object_entry_index + 1) != len(anything_inner)):
                    result += ((f",\n{(indent * indent_level)}") if (pretty == True) else ", ")
            indent_level -= 1
            result += ((f"\n{(indent * indent_level)}" + "}") if (pretty == True) else " }")
            return result
        if (get_type(anything_inner) == js_like_type["Array"]):
            if (len(anything_inner) == 0):
                return "[]"
            indent_level += 1
            result = ((f"[\n{(indent * indent_level)}") if (pretty == True) else "[")
            for (array_item_index, array_item) in enumerate(anything_inner):
                result += json_stringify_inner(array_item)
                if ((array_item_index + 1) != len(anything_inner)):
                    result += (f",\n{(indent * indent_level)}" if (pretty == True) else ", ")
            indent_level -= 1
            result += (f"\n{(indent * indent_level)}]" if (pretty == True) else "]")
            return result
        if (get_type(anything_inner) == js_like_type["Function"]):
            return '"[object Function]"'
        return f'"{(str(type(anything_inner)))}"'


    return json_stringify_inner(anything)


json_stringify_v1 = lambda anything, **optional_argument: ((json.dumps(anything, indent=4)) if (pipe(optional_chaining(optional_argument, "pretty"), lambda _: nullish_coalescing(_, False)) == True) else (json.dumps(anything).replace("{", "{ ").replace("}", " }")))


def json_stringify_v2(anything, **optional_argument):
    '''custom JSON.stringify() function json_stringify_v2'''
    indent = " " * 4
    indent_level = 0
    pretty = pipe(optional_chaining(optional_argument, "pretty"), lambda _: nullish_coalescing(_, False))


    def json_stringify_inner(anything_inner):
        nonlocal indent_level
        if (get_type(anything_inner) == js_like_type["Null"]):
            return "null"
        if (get_type(anything_inner) == js_like_type["String"]):
            return f'"{anything_inner}"'
        if (get_type(anything_inner) == js_like_type["Numeric"]):
            return f"{anything_inner}"
        if ((get_type(anything_inner) == js_like_type["Boolean"]) and (anything_inner == True)):
            return "true"
        if ((get_type(anything_inner) == js_like_type["Boolean"]) and (anything_inner == False)):
            return "false"
        if (get_type(anything_inner) == js_like_type["Object"]):
            if (len(anything_inner) == 0):
                return "{" + "}"
            indent_level += 1
            result = (("{\n" + (indent * indent_level)) if (pretty == True) else "{ ")
            for object_entry_index, (object_key, object_value) in enumerate(anything_inner.items()):
                result += f'"{object_key}": {json_stringify_inner(object_value)}'
                if ((object_entry_index + 1) != len(anything_inner)):
                    result += ((f",\n{(indent * indent_level)}") if (pretty == True) else ", ")
            indent_level -= 1
            result += ((f"\n{(indent * indent_level)}" + "}") if (pretty == True) else " }")
            return result
        if (get_type(anything_inner) == js_like_type["Array"]):
            if (len(anything_inner) == 0):
                return "[]"
            indent_level += 1
            result = ((f"[\n{(indent * indent_level)}") if (pretty == True) else "[")
            for (array_item_index, array_item) in enumerate(anything_inner):
                result += json_stringify_inner(array_item)
                if ((array_item_index + 1) != len(anything_inner)):
                    result += (f",\n{(indent * indent_level)}" if (pretty == True) else ", ")
            indent_level -= 1
            result += (f"\n{(indent * indent_level)}]" if (pretty == True) else "]")
            return result
        if (get_type(anything_inner) == js_like_type["Function"]):
            return '"[object Function]"'
        return f'"{(str(type(anything_inner)))}"'


    return json_stringify_inner(anything)


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
# print(f'my_array: {json.dumps(my_array).replace("{", "{ ").replace("}", " }")}')  # throw error if array contains any functions
# print(f'my_array: {json_stringify_v1(my_array)}')  # throw error if array contains any functions
print(f'my_array: {json_stringify_v2(my_array)}')
print(f'my_array: {json_stringify(my_array)}')
# print(f"my_array: {json.dumps(my_array, indent=4)}")  # throw error if array contains any functions
# print(f"my_array: {json_stringify_v1(my_array, pretty=True)}")  # throw error if array contains any functions
print(f'my_array: {json_stringify_v2(my_array, pretty=True)}')
print(f'my_array: {json_stringify(my_array, pretty=True)}')

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
# print(f'my_object: {json.dumps(my_object).replace("{", "{ ").replace("}", " }")}')  # throw error if object contains any functions
# print(f"my_object: {json_stringify_v1(my_object)}")  # throw error if object contains any functions
print(f"my_object: {json_stringify_v2(my_object)}")
print(f"my_object: {json_stringify(my_object)}")
# print(f"my_object: {json.dumps(my_object, indent=4)}")  # throw error if object contains any functions
# print(f"my_object: {json_stringify_v1(my_object, pretty=True)}")  # throw error if object contains any functions
print(f"my_object: {json_stringify_v2(my_object, pretty=True)}")
print(f"my_object: {json_stringify(my_object, pretty=True)}")
