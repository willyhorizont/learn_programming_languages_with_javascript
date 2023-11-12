import json


# There's no JavaScript-like Array.findIndex() in Python.
# But, we can create our own function to mimic it in Python.

def array_find_index_v1(callback_function, an_array):
    '''JavaScript-like Array.findIndex() function'''
    item_index = -1
    for array_item_index, array_item in enumerate(an_array):
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == True):
            item_index = array_item_index
            break
    return item_index


def array_find_index_v2(callback_function, an_array):
    '''JavaScript-like Array.findIndex() function'''
    item_index = -1
    for array_item_index, array_item in enumerate(an_array):
        if (callback_function(array_item, array_item_index, an_array) == True):
            item_index = array_item_index
            break
    return item_index


def array_find_index_v3(callback_function, an_array):
    '''JavaScript-like Array.findIndex() function'''
    item_index = -1
    for array_item_index, array_item in enumerate(an_array):
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == True):
            return array_item_index
    return item_index


def array_find_index_v4(callback_function, an_array):
    '''JavaScript-like Array.findIndex() function'''
    item_index = -1
    for array_item_index, array_item in enumerate(an_array):
        if (callback_function(array_item, array_item_index, an_array) == True):
            return array_item_index
    return item_index


def array_find_index_v5(callback_function, an_array):
    '''JavaScript-like Array.findIndex() function'''
    for array_item_index, array_item in enumerate(an_array):
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == True):
            return array_item_index
    return -1


def array_find_index_v6(callback_function, an_array):
    '''JavaScript-like Array.findIndex() function'''
    for array_item_index, array_item in enumerate(an_array):
        if (callback_function(array_item, array_item_index, an_array) == True):
            return array_item_index
    return -1


print('\n# JavaScript-like Array.findIndex() in Python List')

numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
print(f'numbers: {json.dumps(numbers)}')

number_to_find = 27
print(f'number to find: {number_to_find}')

print('# using JavaScript-like Array.findIndex() function "array_find_index_v1"')

number_found_index = array_find_index_v1(lambda number, *_: number == number_to_find, numbers)
print(f'number found index: {number_found_index}')
# number found index: 2

print('# using JavaScript-like Array.findIndex() function "array_find_index_v2"')

number_found_index = array_find_index_v2(lambda number, *_: number == number_to_find, numbers)
print(f'number found index: {number_found_index}')
# number found index: 2

print('# using JavaScript-like Array.findIndex() function "array_find_index_v3"')

number_found_index = array_find_index_v3(lambda number, *_: number == number_to_find, numbers)
print(f'number found index: {number_found_index}')
# number found index: 2

print('# using JavaScript-like Array.findIndex() function "array_find_index_v4"')

number_found_index = array_find_index_v4(lambda number, *_: number == number_to_find, numbers)
print(f'number found index: {number_found_index}')
# number found index: 2

print('# using JavaScript-like Array.findIndex() function "array_find_index_v5"')

number_found_index = array_find_index_v5(lambda number, *_: number == number_to_find, numbers)
print(f'number found index: {number_found_index}')
# number found index: 2

print('# using JavaScript-like Array.findIndex() function "array_find_index_v6"')

number_found_index = array_find_index_v6(lambda number, *_: number == number_to_find, numbers)
print(f'number found index: {number_found_index}')
# number found index: 2

print('\n# JavaScript-like Array.findIndex() in Python List of Dictionaries')

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
print(f'products: {json.dumps(products, indent=4)}')

product_to_find = 'pasta'
print(f'product to find: {product_to_find}')

print('# using JavaScript-like Array.findIndex() function "array_find_index_v1"')

product_found_index = array_find_index_v1(lambda product, *_: product['code'] == product_to_find, products)
print(f'product found index: {product_found_index}')
# product found index: 0

print('# using JavaScript-like Array.findIndex() function "array_find_index_v2"')

product_found_index = array_find_index_v2(lambda product, *_: product['code'] == product_to_find, products)
print(f'product found index: {product_found_index}')
# product found index: 0

print('# using JavaScript-like Array.findIndex() function "array_find_index_v3"')

product_found_index = array_find_index_v3(lambda product, *_: product['code'] == product_to_find, products)
print(f'product found index: {product_found_index}')
# product found index: 0

print('# using JavaScript-like Array.findIndex() function "array_find_index_v4"')

product_found_index = array_find_index_v4(lambda product, *_: product['code'] == product_to_find, products)
print(f'product found index: {product_found_index}')
# product found index: 0

print('# using JavaScript-like Array.findIndex() function "array_find_index_v5"')

product_found_index = array_find_index_v5(lambda product, *_: product['code'] == product_to_find, products)
print(f'product found index: {product_found_index}')
# product found index: 0

print('# using JavaScript-like Array.findIndex() function "array_find_index_v6"')

product_found_index = array_find_index_v6(lambda product, *_: product['code'] == product_to_find, products)
print(f'product found index: {product_found_index}')
# product found index: 0
