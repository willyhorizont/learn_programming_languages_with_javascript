import json
from numbers import Number

def array_reduce(callback_function, an_array, initial_value):
    '''JavaScript-like Array.reduce() function'''
    result = initial_value
    for array_item_index, array_item in enumerate(an_array):
        result = callback_function(result, array_item, array_item_index, an_array)
    return result


# optional_chaining_v3
optional_chaining = lambda anything, *object_properties_array: anything if (((isinstance(anything, dict) == False) and (isinstance(anything, list) == False)) or (len(object_properties_array) == 0)) else array_reduce(lambda current_result, current_item, *_: anything.get(str(current_item)) if ((current_result is None) and (isinstance(anything, dict) == True) and (isinstance(current_item, str) == True)) else anything[int(current_item)] if ((current_result is None) and (isinstance(anything, list) == True) and (isinstance(current_item, Number) == True) and (int(current_item) >= 0) and (len(anything) > int(current_item))) else current_result.get(str(current_item)) if ((isinstance(current_result, dict) == True) and (isinstance(current_item, str) == True)) else current_result[int(current_item)] if ((isinstance(current_result, list) == True) and (isinstance(current_item, Number) == True) and (int(current_item) >= 0) and (len(current_result) > int(current_item))) else None, object_properties_array, None)

# nullish_coalescing_v2
nullish_coalescing = lambda anything, default_value: default_value if (anything is None) else anything

json_stringify = lambda anything, **optional_argument: (json.dumps(anything, indent=4)) if (nullish_coalescing(optional_chaining(optional_argument, "pretty"), False) == True) else (json.dumps(anything).replace("{", "{ ").replace("}", " }"))

print("# get type of something in Python")


def get_type(anything):
    if (anything is None):
        return "Null"
    if ((isinstance(anything, bool) == True) and ((anything == True) or (anything == False))):
        return "Boolean"
    if (isinstance(anything, str) == True):
        return "String"
    if (isinstance(anything, Number) == True):
        return "Numeric"
    if (isinstance(anything, list) == True):
        return "Object"
    if (isinstance(anything, dict) == True):
        return "Array"
    return str(type(anything)).replace("<class '", "").replace("'>", "").title()


any_string = "foo"
print(f"any_string: {json_stringify(any_string)}")
print(f"type of anyString is {get_type(any_string)}")

any_numeric = 123
print(f"any_numeric: {json_stringify(any_numeric)}")
print(f"type of anyNumeric is {get_type(any_numeric)}")

any_boolean = True
print(f"any_boolean: {json_stringify(any_boolean)}")
print(f"type of anyBoolean is {get_type(any_boolean)}")

any_null = None
print(f"any_null: {json_stringify(any_null)}")
print(f"type of anyNull is {get_type(any_null)}")

any_array = [1, 2, 3]
print(f"any_array: {json_stringify(any_array)}")
print(f"type of anyArray is {get_type(any_array)}")

any_object = {"foo": "bar"}
print(f"any_object: {json_stringify(any_object)}")
print(f"type of anyObject is {get_type(any_object)}")
