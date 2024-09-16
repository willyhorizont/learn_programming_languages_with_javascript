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

print("# JavaScript-like Template literals / Template strings (String Interpolation) in Python (f-string)")

print(f"1 + 2 + 3 + 4 = {1 + 2 + 3 + 4}")

my_name = "Alisa"
my_age = 25
print(f"my name is {my_name} and I am {my_age}.")

any_string = "foo"
print(f'any string: {json_stringify(any_string)}')

any_numeric = 123
print(f"any numeric: {any_numeric}")

any_boolean = True
print(f"any boolean: {any_boolean}")

any_null = None
print(f"any null: {any_null}")

any_array = [1, 2, 3]
print(f'any array: {json_stringify(any_array)}')
print(f'any array first element: {json_stringify(optional_chaining(any_array, 0))}')

any_object = {"foo": "bar"}
print(f'any object: {json_stringify(any_object)}')
print(f'any object foo value: {json_stringify(optional_chaining(any_object, "foo"))}')
