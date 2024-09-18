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

print("# JavaScript-like Array in Python (list)")

fruits = ["apple", "mango", "orange"]
print(f'fruits: {json_stringify(fruits)}')

print(f"fruits, length: {len(fruits)}")
# fruits, length: 3

print(f"fruits, get mango: {fruits[1]}")
# fruits, get mango: "mango"

print(f"fruits, get mango: {optional_chaining(fruits, 1)}")
# fruits, get mango: "mango"

print(f"fruits, first element: {fruits[0]}")
# fruits, first element: "apple"

print(f"fruits, first element: {optional_chaining(fruits, 0)}")
# fruits, first element: "apple"

print(f"fruits, last element: {fruits[-1]}")
# fruits, last element: "orange"

print(f"fruits, last element: {optional_chaining(fruits, -1)}")
# fruits, last element: "orange"

# iterate over and print each item and index
for (array_item_index, array_item) in enumerate(fruits):
    print(f"fruits, for loop, index: {array_item_index}, item: {array_item}")
# fruits, for loop, index: 0, item: "apple"
# fruits, for loop, index: 1, item: "mango"
# fruits, for loop, index: 2, item: "orange"

fruits.append("banana")
print(f'fruits: {json_stringify(fruits)}')
# fruits: ["apple", "mango", "orange", "banana"]

fruits = [*fruits, "kiwi"]
print(f'fruits: {json_stringify(fruits)}')
# fruits: ["apple", "mango", "orange", "banana", "kiwi"]
