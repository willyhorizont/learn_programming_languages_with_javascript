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


print("# JavaScript-like Template literals / Template strings (String Interpolation) in Python (f-string)")

my_name = "Alisa"
my_age = 25
print(f"my name is {my_name} and I am {my_age}.")

print(f"1 + 2 + 3 + 4 = {1 + 2 + 3 + 4}")


def get_rectangle_area(rectangle_width, rectangle_length):
    return (rectangle_width * rectangle_length)


print(f"get_rectangle_area(7, 5): {get_rectangle_area(7, 5)}")

any_string = "foo"
print(f'any string: {json_stringify(any_string)}')

any_numeric = 123
print(f"any numeric: {json_stringify(any_numeric)}")

any_boolean = True
print(f"any boolean: {json_stringify(any_boolean)}")

any_null = None
print(f"any null: {json_stringify(any_null)}")

any_array = [1, 2, 3]
print(f'any array: {json_stringify(any_array)}')
print(f'any array first element: {json_stringify(optional_chaining(any_array, 0))}')

any_object = {"foo": "bar"}
print(f'any object: {json_stringify(any_object)}')
print(f'any object foo value: {json_stringify(optional_chaining(any_object, "foo"))}')
