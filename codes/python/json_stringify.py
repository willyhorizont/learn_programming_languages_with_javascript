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
    for (array_item_index, array_item) in enumerate(an_array):
        result = callback_function(result, array_item, array_item_index, an_array)
    return result


is_like_js_null = lambda anything: (anything is None)

is_like_js_boolean = lambda anything: ((isinstance(anything, bool) == True) and ((anything == True) or (anything == False)))

is_like_js_string = lambda anything: (isinstance(anything, str) == True)

is_like_js_numeric = lambda anything: (isinstance(anything, Number) == True)

is_like_js_object = lambda anything: (isinstance(anything, dict) == True)

is_like_js_array = lambda anything: (isinstance(anything, list) == True)

is_like_js_function = lambda anything: (callable(anything) == True)

get_type = lambda anything: (js_like_type["Null"] if (is_like_js_null(anything) == True) else js_like_type["Boolean"] if (is_like_js_boolean(anything) == True) else js_like_type["String"] if (is_like_js_string(anything) == True) else js_like_type["Numeric"] if (is_like_js_numeric(anything) == True) else js_like_type["Object"] if (is_like_js_object(anything) == True) else js_like_type["Array"] if (is_like_js_array(anything) == True) else js_like_type["Function"] if (is_like_js_function(anything) == True) else str(type(anything)))  # '''get_type_v2'''


def optional_chaining(anything, *rest_arguments):
    '''JavaScript-like Optional Chaining Operator (?.) function optional_chaining_v2'''
    anything_type = get_type(anything)
    if (anything_type == js_like_type["Function"]):
        return anything(*rest_arguments)
    if (((anything_type != js_like_type["Object"]) and (anything_type != js_like_type["Array"])) or (len(rest_arguments) == 0)):
        return anything


    def array_reduce_callback(current_result, current_item, *_):
        current_result_type = get_type(current_result)
        current_item_type = get_type(current_item)
        if ((current_result_type == js_like_type["Null"]) and (anything_type == js_like_type["Object"]) and (current_item_type == js_like_type["String"])):
            return anything.get(str(current_item))
        if ((current_result_type == js_like_type["Null"]) and (anything_type == js_like_type["Array"]) and (current_item_type == js_like_type["Numeric"]) and ((int(current_item) >= 0) or (int(current_item) == -1)) and (len(anything) > int(current_item))):
            return anything[int(current_item)]
        if ((current_result_type == js_like_type["Object"]) and (current_item_type == js_like_type["String"])):
            return current_result.get(str(current_item))
        if ((current_result_type == js_like_type["Array"]) and (current_item_type == js_like_type["Numeric"]) and ((int(current_item) >= 0) or (int(current_item) == -1)) and (len(current_result) > int(current_item))):
            return current_result[int(current_item)]
        return None
    

    return array_reduce(array_reduce_callback, rest_arguments, None)


nullish_coalescing = lambda anything, default_value: (default_value if (is_like_js_null(anything) == True) else anything)  # '''JavaScript-like Nullish Coalescing Operator (??) function nullish_coalescing_v2'''


def json_stringify(anything, pretty=False):
    '''custom JSON.stringify() function json_stringify_v3'''
    indent = (" " * 4)
    indent_level = 0


    def json_stringify_inner(anything_inner):
        nonlocal indent_level
        anything_inner_type = get_type(anything_inner)
        if (anything_inner_type == js_like_type["Null"]):
            return "null"
        if (anything_inner_type == js_like_type["String"]):
            return f'"{anything_inner}"'
        if (anything_inner_type == js_like_type["Numeric"]):
            return f"{anything_inner}"
        if ((anything_inner_type == js_like_type["Boolean"]) and (anything_inner == True)):
            return "true"
        if ((anything_inner_type == js_like_type["Boolean"]) and (anything_inner == False)):
            return "false"
        if (anything_inner_type == js_like_type["Object"]):
            if (len(anything_inner) == 0):
                return "{" + "}"
            indent_level += 1
            result = (("{\n" + (indent * indent_level)) if (pretty == True) else "{ ")
            for (object_entry_index, (object_key, object_value)) in enumerate(anything_inner.items()):
                result += f'"{object_key}": {json_stringify_inner(object_value)}'
                if ((object_entry_index + 1) != len(anything_inner)):
                    result += ((f",\n{(indent * indent_level)}") if (pretty == True) else ", ")
            indent_level -= 1
            result += ((f"\n{(indent * indent_level)}" + "}") if (pretty == True) else " }")
            return result
        if (anything_inner_type == js_like_type["Array"]):
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
        if (anything_inner_type == js_like_type["Function"]):
            return "[object Function]"
        return anything_inner_type


    return json_stringify_inner(anything)


json_stringify_v1 = lambda anything, pretty=False: ((json.dumps(anything, indent=4)) if (pretty == True) else (json.dumps(anything).replace("{", "{ ").replace("}", " }")))  # '''custom JSON.stringify() function json_stringify_v1'''


def json_dumps_abler_v1(anything):
    anything_type = get_type(anything)
    if ((anything_type == js_like_type["Null"]) or (anything_type == js_like_type["String"]) or (anything_type == js_like_type["Numeric"]) or (anything_type == js_like_type["Boolean"])):
        return anything
    if (anything_type == js_like_type["Object"]):
        return {object_key: json_dumps_abler_v1(object_value) for (object_entry_index, (object_key, object_value)) in enumerate(anything.items())}
    if (anything_type == js_like_type["Array"]):
        return [json_dumps_abler_v1(array_item) for (array_item_index, array_item) in enumerate(anything)]
    if (anything_type == js_like_type["Function"]):
        return "[object Function]"
    return anything_type


json_dumps_abler_v2 = lambda anything: anything if (((anything_type := get_type(anything)) == js_like_type["Null"]) or (anything_type == js_like_type["String"]) or (anything_type == js_like_type["Numeric"]) or (anything_type == js_like_type["Boolean"])) else {object_key: json_dumps_abler_v1(object_value) for (object_entry_index, (object_key, object_value)) in enumerate(anything.items())} if (anything_type == js_like_type["Object"]) else [json_dumps_abler_v1(array_item) for (array_item_index, array_item) in enumerate(anything)] if (anything_type == js_like_type["Array"]) else "[object Function]" if (anything_type == js_like_type["Function"]) else anything_type


def json_stringify_v2(anything, pretty=False):
    '''custom JSON.stringify() function json_stringify_v2'''

    json_stringify_inner_result = json_dumps_abler_v1(anything)
    return ((json.dumps(json_stringify_inner_result, indent=4)) if (pretty == True) else (json.dumps(json_stringify_inner_result).replace("{", "{ ").replace("}", " }"))).replace('"[object Function]"', "[object Function]").replace('"<class \'', '<class \'').replace('\'>"', '\'>')


def json_stringify_v3(anything, pretty=False):
    '''custom JSON.stringify() function json_stringify_v3'''
    indent = (" " * 4)
    indent_level = 0


    def json_stringify_inner(anything_inner):
        nonlocal indent_level
        anything_inner_type = get_type(anything_inner)
        if (anything_inner_type == js_like_type["Null"]):
            return "null"
        if (anything_inner_type == js_like_type["String"]):
            return f'"{anything_inner}"'
        if (anything_inner_type == js_like_type["Numeric"]):
            return f"{anything_inner}"
        if ((anything_inner_type == js_like_type["Boolean"]) and (anything_inner == True)):
            return "true"
        if ((anything_inner_type == js_like_type["Boolean"]) and (anything_inner == False)):
            return "false"
        if (anything_inner_type == js_like_type["Object"]):
            if (len(anything_inner) == 0):
                return "{" + "}"
            indent_level += 1
            result = (("{\n" + (indent * indent_level)) if (pretty == True) else "{ ")
            for (object_entry_index, (object_key, object_value)) in enumerate(anything_inner.items()):
                result += f'"{object_key}": {json_stringify_inner(object_value)}'
                if ((object_entry_index + 1) != len(anything_inner)):
                    result += ((f",\n{(indent * indent_level)}") if (pretty == True) else ", ")
            indent_level -= 1
            result += ((f"\n{(indent * indent_level)}" + "}") if (pretty == True) else " }")
            return result
        if (anything_inner_type == js_like_type["Array"]):
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
        if (anything_inner_type == js_like_type["Function"]):
            return "[object Function]"
        return anything_inner_type


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
# print(f'json.dumps(my_array): {json.dumps(my_array).replace("{", "{ ").replace("}", " }")}')  # throw error if array contains any functions
# print(f'json_stringify_v1(my_array): {json_stringify_v1(my_array)}')  # throw error if array contains any functions
print(f'json_stringify_v2(my_array): {json_stringify_v2(my_array)}')
print(f'json_stringify_v3(my_array): {json_stringify_v3(my_array)}')
print(f'json_stringify(my_array): {json_stringify(my_array)}')
# print(f"json.dumps(my_array, indent=4): {json.dumps(my_array, indent=4)}")  # throw error if array contains any functions
# print(f"json_stringify_v1(my_array, pretty=True): {json_stringify_v1(my_array, pretty=True)}")  # throw error if array contains any functions
print(f'json_stringify_v2(my_array, pretty=True): {json_stringify_v2(my_array, pretty=True)}')
print(f'json_stringify_v3(my_array, pretty=True): {json_stringify_v3(my_array, pretty=True)}')
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
# print(f'json.dumps(my_object): {json.dumps(my_object).replace("{", "{ ").replace("}", " }")}')  # throw error if object contains any functions
# print(f"json_stringify_v1(my_object): {json_stringify_v1(my_object)}")  # throw error if object contains any functions
print(f"json_stringify_v2(my_object): {json_stringify_v2(my_object)}")
print(f"json_stringify_v3(my_object): {json_stringify_v3(my_object)}")
print(f"json_stringify(my_object): {json_stringify(my_object)}")
# print(f"json.dumps(my_object, indent=4): {json.dumps(my_object, indent=4)}")  # throw error if object contains any functions
# print(f"json_stringify_v1(my_object, pretty=True): {json_stringify_v1(my_object, pretty=True)}")  # throw error if object contains any functions
print(f"json_stringify_v2(my_object, pretty=True): {json_stringify_v2(my_object, pretty=True)}")
print(f"json_stringify_v3(my_object, pretty=True): {json_stringify_v3(my_object, pretty=True)}")
print(f"json_stringify(my_object, pretty=True): {json_stringify(my_object, pretty=True)}")
