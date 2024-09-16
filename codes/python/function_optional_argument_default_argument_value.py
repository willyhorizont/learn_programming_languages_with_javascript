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

print("# Function Optional Argument and Function Default Argument Value in Python")


def function_v1_optional_argument_default_argument_value(anything, **optional_argument):
    pretty = nullish_coalescing(optional_chaining(optional_argument, "pretty"), False)
    print(f'optional argument default value function v1 optional argument pretty: {json_stringify(pretty)}')


function_v1_optional_argument_default_argument_value(["apple", "banana", "cherry"], pretty=True)
function_v1_optional_argument_default_argument_value(["apple", "banana", "cherry"])

function_v2_optional_argument_default_argument_value = lambda anything, **optional_argument: print(f'optional argument default value function v2 optional argument pretty: {json_stringify(nullish_coalescing(optional_chaining(optional_argument, "pretty"), False))}')
function_v2_optional_argument_default_argument_value(["apple", "banana", "cherry"], pretty=True)
function_v2_optional_argument_default_argument_value(["apple", "banana", "cherry"])
