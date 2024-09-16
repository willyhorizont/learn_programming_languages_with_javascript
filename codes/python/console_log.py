import json
from numbers import Number


def array_reduce(callback_function, an_array, initial_value):
    '''JavaScript-like Array.reduce() function'''
    result = initial_value
    for array_item_index, array_item in enumerate(an_array):
        result = callback_function(result, array_item, array_item_index, an_array)
    return result


optional_chaining = lambda anything, *object_properties_array: anything if (((isinstance(anything, dict) == False) and (isinstance(anything, list) == False)) or (len(object_properties_array) == 0)) else array_reduce(lambda current_result, current_item, *_: anything.get(str(current_item)) if ((current_result is None) and (isinstance(anything, dict) == True) and (isinstance(current_item, str) == True)) else anything[int(current_item)] if ((current_result is None) and (isinstance(anything, list) == True) and (isinstance(current_item, Number) == True) and (int(current_item) >= 0) and (len(anything) > int(current_item))) else current_result.get(str(current_item)) if ((isinstance(current_result, dict) == True) and (isinstance(current_item, str) == True)) else current_result[int(current_item)] if ((isinstance(current_result, list) == True) and (isinstance(current_item, Number) == True) and (int(current_item) >= 0) and (len(current_result) > int(current_item))) else None, object_properties_array, None)  # '''JavaScript-like Optional Chaining Operator (?.) function optional_chaining_v3'''

nullish_coalescing = lambda anything, default_value: default_value if (anything is None) else anything  # '''JavaScript-like Nullish Coalescing Operator (??) function nullish_coalescing_v2'''

json_stringify = lambda anything, **optional_argument: (json.dumps(anything, indent=4)) if (nullish_coalescing(optional_chaining(optional_argument, "pretty"), False) == True) else (json.dumps(anything).replace("{", "{ ").replace("}", " }"))

print("# JavaScript-like console.log() in Python")

any_string = "foo"
any_numeric = 123
any_boolean = True
any_null = None
any_array = [1, 2, 3]
any_object = {"foo": "bar"}

# its add whitespace as separator by default
print("any string: ", any_string, ", any numeric: ", any_numeric, ", any boolean: ", any_boolean, ", any null: ", any_null, ", any array: ", any_array, ", any object: ", any_object)

# using `sep=""` option
print("any string: ", any_string, ", any numeric: ", any_numeric, ", any boolean: ", any_boolean, ", any null: ", any_null, ", any array: ", any_array, ", any object: ", any_object, sep="")

print("any string: ", json_stringify(any_string), ", any numeric: ", json_stringify(any_numeric), ", any boolean: ", json_stringify(any_boolean), ", any null: ", json_stringify(any_null), ", any array: ", json_stringify(any_array), ", any object: ", json_stringify(any_object), sep="")

# using JavaScript-like Template literals / Template strings (String Interpolation) in Python (f-string)
print(f'any string: {json_stringify(any_string)}, any numeric: {json_stringify(any_numeric)}, any boolean: {json_stringify(any_boolean)}, any null: {json_stringify(any_null)}, any array: {json_stringify(any_array)}, any object: {json_stringify(any_object)}')
