import json


def array_every_v1(callback_function, an_array):
    '''JavaScript-like Array.every() function'''
    is_condition_match = False
    for array_item_index, array_item in enumerate(an_array):
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == False):
            break
    return is_condition_match


def array_every_v2(callback_function, an_array):
    '''JavaScript-like Array.every() function'''
    is_condition_match = False
    for array_item_index, array_item in enumerate(an_array):
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == False):
            return is_condition_match
    return is_condition_match


def array_every_v3(callback_function, an_array):
    '''JavaScript-like Array.every() function'''
    for array_item_index, array_item in enumerate(an_array):
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == False):
            return False
    return True


def array_every_v4(callback_function, an_array):
    '''JavaScript-like Array.every() function'''
    for array_item_index, array_item in enumerate(an_array):
        if (callback_function(array_item, array_item_index, an_array) == False):
            return False
    return True


print('\n# JavaScript-like Array.every() in Python list')

numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
print(f'numbers: {json.dumps(numbers)}')

print('# using JavaScript-like Array.every() function "array_every_v1"')

is_all_number_less_than_500 = array_every_v1(lambda number, *_: (number < 500), numbers)
print(f'is all number < 500: {is_all_number_less_than_500}')
# is all number < 500: True

is_all_number_more_than_500 = array_every_v1(lambda number, *_: (number > 500), numbers)
print(f'is all number > 500: {is_all_number_more_than_500}')
# is all number > 500: False

print('# using JavaScript-like Array.every() function "array_every_v2"')

is_all_number_less_than_500 = array_every_v2(lambda number, *_: (number < 500), numbers)
print(f'is all number < 500: {is_all_number_less_than_500}')
# is all number < 500: True

is_all_number_more_than_500 = array_every_v2(lambda number, *_: (number > 500), numbers)
print(f'is all number > 500: {is_all_number_more_than_500}')
# is all number > 500: False

print('# using JavaScript-like Array.every() function "array_every_v3"')

is_all_number_less_than_500 = array_every_v3(lambda number, *_: (number < 500), numbers)
print(f'is all number < 500: {is_all_number_less_than_500}')
# is all number < 500: True

is_all_number_more_than_500 = array_every_v3(lambda number, *_: (number > 500), numbers)
print(f'is all number > 500: {is_all_number_more_than_500}')
# is all number > 500: False

print('# using JavaScript-like Array.every() function "array_every_v4"')

is_all_number_less_than_500 = array_every_v4(lambda number, *_: (number < 500), numbers)
print(f'is all number < 500: {is_all_number_less_than_500}')
# is all number < 500: True

is_all_number_more_than_500 = array_every_v4(lambda number, *_: (number > 500), numbers)
print(f'is all number > 500: {is_all_number_more_than_500}')
# is all number > 500: False

print('# using Python Array.every() built-in function "all", the "pythonic" way')

is_all_number_less_than_500 = all([(number < 500) for number in numbers])
print(f'is all number < 500: {is_all_number_less_than_500}')
# is all number < 500: True

is_all_number_more_than_500 = all([(number > 500) for number in numbers])
print(f'is all number > 500: {is_all_number_more_than_500}')
# is all number > 500: False

print('\n# JavaScript-like Array.every() in Python list of dictionaries')

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

print('# using JavaScript-like Array.every() function "array_every_v1"')

is_all_product_price_less_than_500 = array_every_v1(lambda product, *_: (product['price'] < 500), products)
print(f'is all product price < 500: {is_all_product_price_less_than_500}')
# is all product price < 500: True

is_all_product_price_more_than_500 = array_every_v1(lambda product, *_: (product['price'] > 500), products)
print(f'is all product price > 500: {is_all_product_price_more_than_500}')
# is all product price > 500: False

print('# using JavaScript-like Array.every() function "array_every_v2"')

is_all_product_price_less_than_500 = array_every_v2(lambda product, *_: (product['price'] < 500), products)
print(f'is all product price < 500: {is_all_product_price_less_than_500}')
# is all product price < 500: True

is_all_product_price_more_than_500 = array_every_v2(lambda product, *_: (product['price'] > 500), products)
print(f'is all product price > 500: {is_all_product_price_more_than_500}')
# is all product price > 500: False

print('# using JavaScript-like Array.every() function "array_every_v3"')

is_all_product_price_less_than_500 = array_every_v3(lambda product, *_: (product['price'] < 500), products)
print(f'is all product price < 500: {is_all_product_price_less_than_500}')
# is all product price < 500: True

is_all_product_price_more_than_500 = array_every_v3(lambda product, *_: (product['price'] > 500), products)
print(f'is all product price > 500: {is_all_product_price_more_than_500}')
# is all product price > 500: False

print('# using JavaScript-like Array.every() function "array_every_v4"')

is_all_product_price_less_than_500 = array_every_v4(lambda product, *_: (product['price'] < 500), products)
print(f'is all product price < 500: {is_all_product_price_less_than_500}')
# is all product price < 500: True

is_all_product_price_more_than_500 = array_every_v4(lambda product, *_: (product['price'] > 500), products)
print(f'is all product price > 500: {is_all_product_price_more_than_500}')
# is all product price > 500: False

print('# using Python Array.every() built-in function "all", the "pythonic" way')

is_all_product_price_less_than_500 = all([(product['price'] < 500) for product in products])
print(f'is all product price < 500: {is_all_product_price_less_than_500}')
# is all product price < 500: True

is_all_product_price_more_than_500 = all([(product['price'] > 500) for product in products])
print(f'is all product price > 500: {is_all_product_price_more_than_500}')
# is all product price > 500: False
