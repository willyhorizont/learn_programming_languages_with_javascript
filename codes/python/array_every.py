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


def array_every_v1(callback_function, an_array):
    '''JavaScript-like Array.every() function array_every_v1'''
    is_condition_match = False
    for array_item_index, array_item in enumerate(an_array):
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == False):
            break
    return is_condition_match


def array_every_v2(callback_function, an_array):
    '''JavaScript-like Array.every() function array_every_v2'''
    is_condition_match = False
    for array_item_index, array_item in enumerate(an_array):
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == False):
            return is_condition_match
    return is_condition_match


def array_every_v3(callback_function, an_array):
    '''JavaScript-like Array.every() function array_every_v3'''
    for array_item_index, array_item in enumerate(an_array):
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == False):
            return False
    return True


def array_every_v4(callback_function, an_array):
    '''JavaScript-like Array.every() function array_every_v4'''
    for array_item_index, array_item in enumerate(an_array):
        if (callback_function(array_item, array_item_index, an_array) == False):
            return False
    return True


print("\n# JavaScript-like Array.every() in Python list")

numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
print(f'numbers: {json_stringify(numbers)}')

print('# using JavaScript-like Array.every() function "array_every_v1"')

is_all_number_less_than_500 = array_every_v1(lambda number, *_: (number < 500), numbers)
print(f"is all number < 500: {is_all_number_less_than_500}")
# is all number < 500: True

is_all_number_more_than_500 = array_every_v1(lambda number, *_: (number > 500), numbers)
print(f"is all number > 500: {is_all_number_more_than_500}")
# is all number > 500: False

print('# using JavaScript-like Array.every() function "array_every_v2"')

is_all_number_less_than_500 = array_every_v2(lambda number, *_: (number < 500), numbers)
print(f"is all number < 500: {is_all_number_less_than_500}")
# is all number < 500: True

is_all_number_more_than_500 = array_every_v2(lambda number, *_: (number > 500), numbers)
print(f"is all number > 500: {is_all_number_more_than_500}")
# is all number > 500: False

print('# using JavaScript-like Array.every() function "array_every_v3"')

is_all_number_less_than_500 = array_every_v3(lambda number, *_: (number < 500), numbers)
print(f"is all number < 500: {is_all_number_less_than_500}")
# is all number < 500: True

is_all_number_more_than_500 = array_every_v3(lambda number, *_: (number > 500), numbers)
print(f"is all number > 500: {is_all_number_more_than_500}")
# is all number > 500: False

print('# using JavaScript-like Array.every() function "array_every_v4"')

is_all_number_less_than_500 = array_every_v4(lambda number, *_: (number < 500), numbers)
print(f"is all number < 500: {is_all_number_less_than_500}")
# is all number < 500: True

is_all_number_more_than_500 = array_every_v4(lambda number, *_: (number > 500), numbers)
print(f"is all number > 500: {is_all_number_more_than_500}")
# is all number > 500: False

print('# using Python Array.every() built-in function "all", the "pythonic" way')

is_all_number_less_than_500 = all([(number < 500) for number in numbers])
print(f"is all number < 500: {is_all_number_less_than_500}")
# is all number < 500: True

is_all_number_more_than_500 = all([(number > 500) for number in numbers])
print(f"is all number > 500: {is_all_number_more_than_500}")
# is all number > 500: False

print("\n# JavaScript-like Array.every() in Python list of dictionaries")

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

print('# using JavaScript-like Array.every() function "array_every_v1"')

is_all_product_price_less_than_500 = array_every_v1(lambda product, *_: (product['price'] < 500), products)
print(f"is all product price < 500: {is_all_product_price_less_than_500}")
# is all product price < 500: True

is_all_product_price_more_than_500 = array_every_v1(lambda product, *_: (product['price'] > 500), products)
print(f"is all product price > 500: {is_all_product_price_more_than_500}")
# is all product price > 500: False

print('# using JavaScript-like Array.every() function "array_every_v2"')

is_all_product_price_less_than_500 = array_every_v2(lambda product, *_: (product['price'] < 500), products)
print(f"is all product price < 500: {is_all_product_price_less_than_500}")
# is all product price < 500: True

is_all_product_price_more_than_500 = array_every_v2(lambda product, *_: (product['price'] > 500), products)
print(f"is all product price > 500: {is_all_product_price_more_than_500}")
# is all product price > 500: False

print('# using JavaScript-like Array.every() function "array_every_v3"')

is_all_product_price_less_than_500 = array_every_v3(lambda product, *_: (product['price'] < 500), products)
print(f"is all product price < 500: {is_all_product_price_less_than_500}")
# is all product price < 500: True

is_all_product_price_more_than_500 = array_every_v3(lambda product, *_: (product['price'] > 500), products)
print(f"is all product price > 500: {is_all_product_price_more_than_500}")
# is all product price > 500: False

print('# using JavaScript-like Array.every() function "array_every_v4"')

is_all_product_price_less_than_500 = array_every_v4(lambda product, *_: (product['price'] < 500), products)
print(f"is all product price < 500: {is_all_product_price_less_than_500}")
# is all product price < 500: True

is_all_product_price_more_than_500 = array_every_v4(lambda product, *_: (product['price'] > 500), products)
print(f"is all product price > 500: {is_all_product_price_more_than_500}")
# is all product price > 500: False

print('# using Python Array.every() built-in function "all", the "pythonic" way')

is_all_product_price_less_than_500 = all([(product['price'] < 500) for product in products])
print(f"is all product price < 500: {is_all_product_price_less_than_500}")
# is all product price < 500: True

is_all_product_price_more_than_500 = all([(product['price'] > 500) for product in products])
print(f"is all product price > 500: {is_all_product_price_more_than_500}")
# is all product price > 500: False
