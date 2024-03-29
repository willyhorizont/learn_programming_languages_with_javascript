import json


# There's no JavaScript-like Array.find() in Python.
# But, we can create our own function to mimic it in Python.


def array_find_v1(callback_function, an_array):
    '''JavaScript-like Array.find() function'''
    data_found = None
    for array_item_index, array_item in enumerate(an_array):
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == True):
            data_found = array_item
            break
    return data_found


def array_find_v2(callback_function, an_array):
    '''JavaScript-like Array.find() function'''
    data_found = None
    for array_item_index, array_item in enumerate(an_array):
        if (callback_function(array_item, array_item_index, an_array) == True):
            data_found = array_item
            break
    return data_found


def array_find_v3(callback_function, an_array):
    '''JavaScript-like Array.find() function'''
    for array_item_index, array_item in enumerate(an_array):
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == True):
            return array_item
    return None


def array_find_v4(callback_function, an_array):
    '''JavaScript-like Array.find() function'''
    for array_item_index, array_item in enumerate(an_array):
        if (callback_function(array_item, array_item_index, an_array) == True):
            return array_item
    return None


print('\n# JavaScript-like Array.find() in Python list')

numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
print(f'numbers: {json.dumps(numbers)}')

print('# using JavaScript-like Array.find() function "array_find_v1"')

even_number_found = array_find_v1(lambda number, *_: ((number % 2) == 0), numbers)
print(f'even number found: {even_number_found}')
# even number found: 12

odd_number_found = array_find_v1(lambda number, *_: ((number % 2) != 0), numbers)
print(f'odd number found: {odd_number_found}')
# odd number found: 27

print('# using JavaScript-like Array.find() function "array_find_v2"')

even_number_found = array_find_v2(lambda number, *_: ((number % 2) == 0), numbers)
print(f'even number found: {even_number_found}')
# even number found: 12

odd_number_found = array_find_v2(lambda number, *_: ((number % 2) != 0), numbers)
print(f'odd number found: {odd_number_found}')
# odd number found: 27

print('# using JavaScript-like Array.find() function "array_find_v3"')

even_number_found = array_find_v3(lambda number, *_: ((number % 2) == 0), numbers)
print(f'even number found: {even_number_found}')
# even number found: 12

odd_number_found = array_find_v3(lambda number, *_: ((number % 2) != 0), numbers)
print(f'odd number found: {odd_number_found}')
# odd number found: 27

print('# using JavaScript-like Array.find() function "array_find_v4"')

even_number_found = array_find_v4(lambda number, *_: ((number % 2) == 0), numbers)
print(f'even number found: {even_number_found}')
# even number found: 12

odd_number_found = array_find_v4(lambda number, *_: ((number % 2) != 0), numbers)
print(f'odd number found: {odd_number_found}')
# odd number found: 27

print('\n# JavaScript-like Array.find() in Python list of dictionaries')

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

product_to_find = "bubble_gum"
print(f'product to find: {product_to_find}')

print('# using JavaScript-like Array.find() function "array_find_v1"')

product_found = array_find_v1(lambda product, *_: (product['code'] == product_to_find), products)
print(f'product found: {json.dumps(product_found, indent=4)}')
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

print('# using JavaScript-like Array.find() function "array_find_v2"')

product_found = array_find_v2(lambda product, *_: (product['code'] == product_to_find), products)
print(f'product found: {json.dumps(product_found, indent=4)}')
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

print('# using JavaScript-like Array.find() function "array_find_v3"')

product_found = array_find_v3(lambda product, *_: (product['code'] == product_to_find), products)
print(f'product found: {json.dumps(product_found, indent=4)}')
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

print('# using JavaScript-like Array.find() function "array_find_v4"')

product_found = array_find_v4(lambda product, *_: (product['code'] == product_to_find), products)
print(f'product found: {json.dumps(product_found, indent=4)}')
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }
