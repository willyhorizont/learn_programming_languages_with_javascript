from numbers import Number

js_like_type = {"Null": "Null", "Boolean": "Boolean", "String": "String", "Numeric": "Numeric", "Object": "Object", "Array": "Array", "Function": "Function"}

array_reduce = lambda callback_function, any_array, initial_value_or_current_result, array_item_index=0: (initial_value_or_current_result if (array_item_index >= len(any_array)) else array_reduce_v2(callback_function, any_array, (callback_function(initial_value_or_current_result, any_array[array_item_index], array_item_index, any_array)), (array_item_index + 1)))  # '''JavaScript-like Array.reduce() function array_reduce_v2'''

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


print("# get type of something in Python")


def get_type_v1(anything):
    '''get_type_v1'''
    if (is_like_js_null(anything) == True):
        return js_like_type["Null"]
    if (is_like_js_boolean(anything) == True):
        return js_like_type["Boolean"]
    if (is_like_js_string(anything) == True):
        return js_like_type["String"]
    if (is_like_js_numeric(anything) == True):
        return js_like_type["Numeric"]
    if (is_like_js_object(anything) == True):
        return js_like_type["Object"]
    if (is_like_js_array(anything) == True):
        return js_like_type["Array"]
    if (is_like_js_function(anything) == True):
        return js_like_type["Function"]
    return str(type(anything))


get_type_v2 = lambda anything: (js_like_type["Null"] if (is_like_js_null(anything) == True) else js_like_type["Boolean"] if (is_like_js_boolean(anything) == True) else js_like_type["String"] if (is_like_js_string(anything) == True) else js_like_type["Numeric"] if (is_like_js_numeric(anything) == True) else js_like_type["Object"] if (is_like_js_object(anything) == True) else js_like_type["Array"] if (is_like_js_array(anything) == True) else js_like_type["Function"] if (is_like_js_function(anything) == True) else str(type(anything)))  # '''get_type_v2'''

any_string = "foo"
print(f"any_string: {json_stringify(any_string)}")
print(f'type of any_string: "{get_type_v1(any_string)}"')
print(f'type of any_string: "{get_type_v2(any_string)}"')

any_numeric = 123
print(f"any_numeric: {json_stringify(any_numeric)}")
print(f'type of any_numeric: "{get_type_v1(any_numeric)}"')
print(f'type of any_numeric: "{get_type_v2(any_numeric)}"')

any_boolean = True
print(f"any_boolean: {json_stringify(any_boolean)}")
print(f'type of any_boolean: "{get_type_v1(any_boolean)}"')
print(f'type of any_boolean: "{get_type_v2(any_boolean)}"')

any_null = None
print(f"any_null: {json_stringify(any_null)}")
print(f'type of any_null: "{get_type_v1(any_null)}"')
print(f'type of any_null: "{get_type_v2(any_null)}"')

any_array = [1, 2, 3]
print(f"any_array: {json_stringify(any_array)}")
print(f'type of any_array: "{get_type_v1(any_array)}"')
print(f'type of any_array: "{get_type_v2(any_array)}"')

any_object = {"foo": "bar"}
print(f"any_object: {json_stringify(any_object)}")
print(f'type of any_object: "{get_type_v1(any_object)}"')
print(f'type of any_object: "{get_type_v2(any_object)}"')
