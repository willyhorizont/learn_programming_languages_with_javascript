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

# There's no JavaScript-like Array.findIndex() in Python.
# But, we can create our own function to mimic it in Python.


def array_find_index_v1(callback_function, an_array):
    '''JavaScript-like Array.findIndex() function array_find_index_v1'''
    data_found_index = -1
    for array_item_index, array_item in enumerate(an_array):
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == True):
            data_found_index = array_item_index
            break
    return data_found_index


def array_find_index_v2(callback_function, an_array):
    '''JavaScript-like Array.findIndex() function array_find_index_v2'''
    data_found_index = -1
    for array_item_index, array_item in enumerate(an_array):
        if (callback_function(array_item, array_item_index, an_array) == True):
            data_found_index = array_item_index
            break
    return data_found_index


def array_find_index_v3(callback_function, an_array):
    '''JavaScript-like Array.findIndex() function array_find_index_v3'''
    for array_item_index, array_item in enumerate(an_array):
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == True):
            return array_item_index
    return -1


def array_find_index_v4(callback_function, an_array):
    '''JavaScript-like Array.findIndex() function array_find_index_v4'''
    for array_item_index, array_item in enumerate(an_array):
        if (callback_function(array_item, array_item_index, an_array) == True):
            return array_item_index
    return -1


print("\n# JavaScript-like Array.findIndex() in Python list")

numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
print(f'numbers: {json_stringify(numbers)}')

number_to_find = 27
print(f"number to find: {number_to_find}")

print('# using JavaScript-like Array.findIndex() function "array_find_index_v1"')

number_found_index = array_find_index_v1(lambda number, *_: (number == number_to_find), numbers)
print(f"number found index: {number_found_index}")
# number found index: 2

print('# using JavaScript-like Array.findIndex() function "array_find_index_v2"')

number_found_index = array_find_index_v2(lambda number, *_: (number == number_to_find), numbers)
print(f"number found index: {number_found_index}")
# number found index: 2

print('# using JavaScript-like Array.findIndex() function "array_find_index_v3"')

number_found_index = array_find_index_v3(lambda number, *_: (number == number_to_find), numbers)
print(f"number found index: {number_found_index}")
# number found index: 2

print('# using JavaScript-like Array.findIndex() function "array_find_index_v4"')

number_found_index = array_find_index_v4(lambda number, *_: (number == number_to_find), numbers)
print(f"number found index: {number_found_index}")
# number found index: 2

print("\n# JavaScript-like Array.findIndex() in Python list of dictionaries")

products = [
    {
        "code": "pasta",
        "price": 321
    },
    {
        "code": "bubble_gum",
        "price": 233
    },
    {
        "code": "potato_chips",
        "price": 5
    },
    {
        "code": "towel",
        "price": 499
    }
]
print(f"products: {json_stringify(products, pretty=True)}")

product_to_find = 'pasta'
print(f"product to find: {product_to_find}")

print('# using JavaScript-like Array.findIndex() function "array_find_index_v1"')

product_found_index = array_find_index_v1(lambda product, *_: (product['code'] == product_to_find), products)
print(f"product found index: {product_found_index}")
# product found index: 0

print('# using JavaScript-like Array.findIndex() function "array_find_index_v2"')

product_found_index = array_find_index_v2(lambda product, *_: (product['code'] == product_to_find), products)
print(f"product found index: {product_found_index}")
# product found index: 0

print('# using JavaScript-like Array.findIndex() function "array_find_index_v3"')

product_found_index = array_find_index_v3(lambda product, *_: (product['code'] == product_to_find), products)
print(f"product found index: {product_found_index}")
# product found index: 0

print('# using JavaScript-like Array.findIndex() function "array_find_index_v4"')

product_found_index = array_find_index_v4(lambda product, *_: (product['code'] == product_to_find), products)
print(f"product found index: {product_found_index}")
# product found index: 0
