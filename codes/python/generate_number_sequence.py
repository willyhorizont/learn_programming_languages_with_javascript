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


def generate_number_sequence_v1(start_number, stop_number):
    # generate_number_sequence_v1
    if (stop_number > start_number):
        return list(range(start_number, (stop_number + 1), 1))
    if (start_number > stop_number):
        return list(range(start_number, (stop_number - 1), -1))
    return [0]


generate_number_sequence_v2 = lambda start_number, stop_number: list(range(start_number, (stop_number + 1), 1)) if (stop_number > start_number) else list(range(start_number, (stop_number - 1), -1)) if (start_number > stop_number) else [0]  # generate_number_sequence_v2

print(f"generate_number_sequence_v1(0, 9): {json_stringify(generate_number_sequence_v1(0, 9))}");
# [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
print(f"generate_number_sequence_v1(1, 10): {json_stringify(generate_number_sequence_v1(1, 10))}");
# [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
print(f"generate_number_sequence_v1(10, 1): {json_stringify(generate_number_sequence_v1(10, 1))}");
# [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
print(f"generate_number_sequence_v1(9, 0): {json_stringify(generate_number_sequence_v1(9, 0))}");
# [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]

print(f"generate_number_sequence_v2(0, 9): {json_stringify(generate_number_sequence_v2(0, 9))}");
# [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
print(f"generate_number_sequence_v2(1, 10): {json_stringify(generate_number_sequence_v2(1, 10))}");
# [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
print(f"generate_number_sequence_v2(10, 1): {json_stringify(generate_number_sequence_v2(10, 1))}");
# [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
print(f"generate_number_sequence_v2(9, 0): {json_stringify(generate_number_sequence_v2(9, 0))}");
# [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
