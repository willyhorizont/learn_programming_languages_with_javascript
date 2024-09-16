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


def array_filter_v1(callback_function, an_array):
    '''JavaScript-like Array.filter() function'''
    data_filtered = []
    for array_item_index, array_item in enumerate(an_array):
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == True):
            data_filtered.append(array_item)
    return data_filtered


def array_filter_v2(callback_function, an_array):
    '''JavaScript-like Array.filter() function'''
    data_filtered = []
    for array_item_index, array_item in enumerate(an_array):
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == True):
            data_filtered = [*data_filtered, array_item]
    return data_filtered


def array_filter_v3(callback_function, an_array):
    '''JavaScript-like Array.filter() function'''
    data_filtered = []
    for array_item_index, array_item in enumerate(an_array):
        if (callback_function(array_item, array_item_index, an_array) == True):
            data_filtered.append(array_item)
    return data_filtered


def array_filter_v4(callback_function, an_array):
    '''JavaScript-like Array.filter() function'''
    data_filtered = []
    for array_item_index, array_item in enumerate(an_array):
        if (callback_function(array_item, array_item_index, an_array) == True):
            data_filtered = [*data_filtered, array_item]
    return data_filtered


def array_filter_v5(callback_function, an_array):
    '''JavaScript-like Array.filter() function'''
    return [array_item for array_item_index, array_item in enumerate(an_array) if (callback_function(array_item, array_item_index, an_array) == True)]


# JavaScript-like Array.filter() function
array_filter_v6 = lambda callback_function, an_array: [array_item for array_item_index, array_item in enumerate(an_array) if (callback_function(array_item, array_item_index, an_array) == True)]

print("\n# JavaScript-like Array.filter() in Python list")

numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
print(f'numbers: {json_stringify(numbers)}')

print('# using JavaScript-like Array.filter() function "array_filter_v1"')

numbers_even = array_filter_v1(lambda number, *_: ((number % 2) == 0), numbers)
print(f'even numbers only: {json_stringify(numbers_even)}')
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd = array_filter_v1(lambda number, *_: ((number % 2) != 0), numbers)
print(f'odd numbers only: {json_stringify(numbers_odd)}')
# odd numbers only: [27, 23, 65, 93, 87]

print('# using JavaScript-like Array.filter() function "array_filter_v2"')

numbers_even = array_filter_v2(lambda number, *_: ((number % 2) == 0), numbers)
print(f'even numbers only: {json_stringify(numbers_even)}')
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd = array_filter_v2(lambda number, *_: ((number % 2) != 0), numbers)
print(f'odd numbers only: {json_stringify(numbers_odd)}')
# odd numbers only: [27, 23, 65, 93, 87]

print('# using JavaScript-like Array.filter() function "array_filter_v3"')

numbers_even = array_filter_v3(lambda number, *_: ((number % 2) == 0), numbers)
print(f'even numbers only: {json_stringify(numbers_even)}')
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd = array_filter_v3(lambda number, *_: ((number % 2) != 0), numbers)
print(f'odd numbers only: {json_stringify(numbers_odd)}')
# odd numbers only: [27, 23, 65, 93, 87]

print('# using JavaScript-like Array.filter() function "array_filter_v4"')

numbers_even = array_filter_v4(lambda number, *_: ((number % 2) == 0), numbers)
print(f'even numbers only: {json_stringify(numbers_even)}')
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd = array_filter_v4(lambda number, *_: ((number % 2) != 0), numbers)
print(f'odd numbers only: {json_stringify(numbers_odd)}')
# odd numbers only: [27, 23, 65, 93, 87]

print('# using JavaScript-like Array.filter() function "array_filter_v5"')

numbers_even = array_filter_v5(lambda number, *_: ((number % 2) == 0), numbers)
print(f'even numbers only: {json_stringify(numbers_even)}')
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd = array_filter_v5(lambda number, *_: ((number % 2) != 0), numbers)
print(f'odd numbers only: {json_stringify(numbers_odd)}')
# odd numbers only: [27, 23, 65, 93, 87]

print('# using JavaScript-like Array.filter() function "array_filter_v6"')

numbers_even = array_filter_v6(lambda number, *_: ((number % 2) == 0), numbers)
print(f'even numbers only: {json_stringify(numbers_even)}')
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd = array_filter_v6(lambda number, *_: ((number % 2) != 0), numbers)
print(f'odd numbers only: {json_stringify(numbers_odd)}')
# odd numbers only: [27, 23, 65, 93, 87]

print('# using Python Array.filter() built-in function "filter", the "pythonic" way')

numbers_even = list(filter(lambda number: ((number % 2) == 0), numbers))
print(f'even numbers only: {json_stringify(numbers_even)}')
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd = list(filter(lambda number: ((number % 2) != 0), numbers))
print(f'odd numbers only: {json_stringify(numbers_odd)}')
# odd numbers only: [27, 23, 65, 93, 87]

print("\n# JavaScript-like Array.filter() in Python list of dictionaries")

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

print('# using JavaScript-like Array.filter() function "array_filter_v1"')

products_below_100 = array_filter_v1(lambda product, *_: (product['price'] <= 100), products)
print(f"products with price <= 100 only: {json_stringify(products_below_100, pretty=True)}")
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v1(lambda product, *_: (product['price'] > 100), products)
print(f"products with price > 100 only: {json_stringify(products_above_100, pretty=True)}")
# products with price > 100 only: [
#     {
#         "code": "pasta",
#         "price": 321
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233
#     },
#     {
#         "code": "towel",
#         "price": 499
#     }
# ]

print('# using JavaScript-like Array.filter() function "array_filter_v2"')

products_below_100 = array_filter_v2(lambda product, *_: (product['price'] <= 100), products)
print(f"products with price <= 100 only: {json_stringify(products_below_100, pretty=True)}")
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v2(lambda product, *_: (product['price'] > 100), products)
print(f"products with price > 100 only: {json_stringify(products_above_100, pretty=True)}")
# products with price > 100 only: [
#     {
#         "code": "pasta",
#         "price": 321
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233
#     },
#     {
#         "code": "towel",
#         "price": 499
#     }
# ]

print('# using JavaScript-like Array.filter() function "array_filter_v3"')

products_below_100 = array_filter_v3(lambda product, *_: (product['price'] <= 100), products)
print(f"products with price <= 100 only: {json_stringify(products_below_100, pretty=True)}")
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v3(lambda product, *_: (product['price'] > 100), products)
print(f"products with price > 100 only: {json_stringify(products_above_100, pretty=True)}")
# products with price > 100 only: [
#     {
#         "code": "pasta",
#         "price": 321
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233
#     },
#     {
#         "code": "towel",
#         "price": 499
#     }
# ]

print('# using JavaScript-like Array.filter() function "array_filter_v4"')

products_below_100 = array_filter_v4(lambda product, *_: (product['price'] <= 100), products)
print(f"products with price <= 100 only: {json_stringify(products_below_100, pretty=True)}")
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v4(lambda product, *_: (product['price'] > 100), products)
print(f"products with price > 100 only: {json_stringify(products_above_100, pretty=True)}")
# products with price > 100 only: [
#     {
#         "code": "pasta",
#         "price": 321
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233
#     },
#     {
#         "code": "towel",
#         "price": 499
#     }
# ]

print('# using JavaScript-like Array.filter() function "array_filter_v5"')

products_below_100 = array_filter_v5(lambda product, *_: (product['price'] <= 100), products)
print(f"products with price <= 100 only: {json_stringify(products_below_100, pretty=True)}")
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v5(lambda product, *_: (product['price'] > 100), products)
print(f"products with price > 100 only: {json_stringify(products_above_100, pretty=True)}")
# products with price > 100 only: [
#     {
#         "code": "pasta",
#         "price": 321
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233
#     },
#     {
#         "code": "towel",
#         "price": 499
#     }
# ]

print('# using JavaScript-like Array.filter() function "array_filter_v6"')

products_below_100 = array_filter_v6(lambda product, *_: (product['price'] <= 100), products)
print(f"products with price <= 100 only: {json_stringify(products_below_100, pretty=True)}")
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v6(lambda product, *_: (product['price'] > 100), products)
print(f"products with price > 100 only: {json_stringify(products_above_100, pretty=True)}")
# products with price > 100 only: [
#     {
#         "code": "pasta",
#         "price": 321
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233
#     },
#     {
#         "code": "towel",
#         "price": 499
#     }
# ]

print('# using Python Array.filter() built-in function "filter", the "pythonic" way')

products_below_100 = list(filter(lambda product: (product['price'] <= 100), products))
print(f"products with price <= 100 only: {json_stringify(products_below_100, pretty=True)}")
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = list(filter(lambda product: (product['price'] > 100), products))
print(f"products with price > 100 only: {json_stringify(products_above_100, pretty=True)}")
# products with price > 100 only: [
#     {
#         "code": "pasta",
#         "price": 321
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233
#     },
#     {
#         "code": "towel",
#         "price": 499
#     }
# ]
