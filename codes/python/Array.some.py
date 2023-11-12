import json


def array_some_v1(callback_function, an_array):
    '''JavaScript-like Array.some() function'''
    is_condition_match = False
    for array_item_index, array_item in enumerate(an_array):
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == True):
            break
    return is_condition_match

def array_some_v2(callback_function, an_array):
    '''JavaScript-like Array.some() function'''
    is_condition_match = False
    for array_item_index, array_item in enumerate(an_array):
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == True):
            return is_condition_match
    return is_condition_match


def array_some_v3(callback_function, an_array):
    '''JavaScript-like Array.some() function'''
    for array_item_index, array_item in enumerate(an_array):
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == True):
            return True
    return False

def array_some_v4(callback_function, an_array):
    '''JavaScript-like Array.some() function'''
    for array_item_index, array_item in enumerate(an_array):
        if (callback_function(array_item, array_item_index, an_array) == True):
            return True
    return False


print('\n# JavaScript-like Array.some() in Python List')

numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
print(f'numbers: {json.dumps(numbers)}')

print('# using JavaScript-like Array.some() function "array_some_v1"')

is_any_numbers_less_than500 = array_some_v1(lambda number, *_: number < 500, numbers)
print(f'is any number < 500: {"true" if is_any_numbers_less_than500 == True else "false"}')
# is any number < 500: true

is_any_numbers_more_than500 = array_some_v1(lambda number, *_: number > 500, numbers)
print(f'is any number > 500: {"true" if is_any_numbers_more_than500 == True else "false"}')
# is any number > 500: false

print('# using JavaScript-like Array.some() function "array_some_v2"')

is_any_numbers_less_than500 = array_some_v2(lambda number, *_: number < 500, numbers)
print(f'is any number < 500: {"true" if is_any_numbers_less_than500 == True else "false"}')
# is any number < 500: true

is_any_numbers_more_than500 = array_some_v2(lambda number, *_: number > 500, numbers)
print(f'is any number > 500: {"true" if is_any_numbers_more_than500 == True else "false"}')
# is any number > 500: false

print('# using JavaScript-like Array.some() function "array_some_v3"')

is_any_numbers_less_than500 = array_some_v3(lambda number, *_: number < 500, numbers)
print(f'is any number < 500: {"true" if is_any_numbers_less_than500 == True else "false"}')
# is any number < 500: true

is_any_numbers_more_than500 = array_some_v3(lambda number, *_: number > 500, numbers)
print(f'is any number > 500: {"true" if is_any_numbers_more_than500 == True else "false"}')
# is any number > 500: false

print('# using Python Array.some() built-in function "any", the "pythonic" way')

is_any_numbers_less_than500 = any([number < 500 for number in numbers])
print(f'is any number < 500: {"true" if is_any_numbers_less_than500 == True else "false"}')
# is any number < 500: true

is_any_numbers_more_than500 = any([number > 500 for number in numbers])
print(f'is any number > 500: {"true" if is_any_numbers_more_than500 == True else "false"}')
# is any number > 500: false

print('\n# JavaScript-like Array.some() in Python List of Dictionaries')

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

print('# using JavaScript-like Array.every() function "array_some_v1"')

is_any_product_price_less_than_500 = array_some_v1(lambda product, *_: product['price'] < 500, products)
print(f'is any product price < 500: {"true" if is_any_product_price_less_than_500 == True else "false"}')
# is any product price < 500: true

is_any_product_price_more_than_500 = array_some_v1(lambda product, *_: product['price'] > 500, products)
print(f'is any product price > 500: {"true" if is_any_product_price_more_than_500 == True else "false"}')
# is any product price > 500: false

print('# using JavaScript-like Array.every() function "array_some_v2"')

is_any_product_price_less_than_500 = array_some_v2(lambda product, *_: product['price'] < 500, products)
print(f'is any product price < 500: {"true" if is_any_product_price_less_than_500 == True else "false"}')
# is any product price < 500: true

is_any_product_price_more_than_500 = array_some_v2(lambda product, *_: product['price'] > 500, products)
print(f'is any product price > 500: {"true" if is_any_product_price_more_than_500 == True else "false"}')
# is any product price > 500: false

print('# using JavaScript-like Array.every() function "array_some_v3"')

is_any_product_price_less_than_500 = array_some_v3(lambda product, *_: product['price'] < 500, products)
print(f'is any product price < 500: {"true" if is_any_product_price_less_than_500 == True else "false"}')
# is any product price < 500: true

is_any_product_price_more_than_500 = array_some_v3(lambda product, *_: product['price'] > 500, products)
print(f'is any product price > 500: {"true" if is_any_product_price_more_than_500 == True else "false"}')
# is any product price > 500: false

print('# using JavaScript-like Array.every() function "array_some_v4"')

is_any_product_price_less_than_500 = array_some_v4(lambda product, *_: product['price'] < 500, products)
print(f'is any product price < 500: {"true" if is_any_product_price_less_than_500 == True else "false"}')
# is any product price < 500: true

is_any_product_price_more_than_500 = array_some_v4(lambda product, *_: product['price'] > 500, products)
print(f'is any product price > 500: {"true" if is_any_product_price_more_than_500 == True else "false"}')
# is any product price > 500: false

print('# using Python Array.some() built-in function "any", the "pythonic" way')

is_any_product_price_less_than_500 = any([product['price'] < 500 for product in products])
print(f'is any product price < 500: {"true" if is_any_product_price_less_than_500 == True else "false"}')
# is any product price < 500: true

is_any_product_price_more_than_500 = any([product['price'] > 500 for product in products])
print(f'is any product price > 500: {"true" if is_any_product_price_more_than_500 == True else "false"}')
# is any product price > 500: false
