import json


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

print('\n# JavaScript-like Array.filter() in Python List')

numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
print(f'numbers: {json.dumps(numbers)}')

print('# using JavaScript-like Array.filter() function "array_filter_v1"')

numbers_even = array_filter_v1(lambda number, *_: ((number % 2) == 0), numbers)
print(f'even numbers only: {json.dumps(numbers_even)}')
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd = array_filter_v1(lambda number, *_: ((number % 2) != 0), numbers)
print(f'odd numbers only: {json.dumps(numbers_odd)}')
# odd numbers only: [27, 23, 65, 93, 87]

print('# using JavaScript-like Array.filter() function "array_filter_v2"')

numbers_even = array_filter_v2(lambda number, *_: ((number % 2) == 0), numbers)
print(f'even numbers only: {json.dumps(numbers_even)}')
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd = array_filter_v2(lambda number, *_: ((number % 2) != 0), numbers)
print(f'odd numbers only: {json.dumps(numbers_odd)}')
# odd numbers only: [27, 23, 65, 93, 87]

print('# using JavaScript-like Array.filter() function "array_filter_v3"')

numbers_even = array_filter_v3(lambda number, *_: ((number % 2) == 0), numbers)
print(f'even numbers only: {json.dumps(numbers_even)}')
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd = array_filter_v3(lambda number, *_: ((number % 2) != 0), numbers)
print(f'odd numbers only: {json.dumps(numbers_odd)}')
# odd numbers only: [27, 23, 65, 93, 87]

print('# using JavaScript-like Array.filter() function "array_filter_v4"')

numbers_even = array_filter_v4(lambda number, *_: ((number % 2) == 0), numbers)
print(f'even numbers only: {json.dumps(numbers_even)}')
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd = array_filter_v4(lambda number, *_: ((number % 2) != 0), numbers)
print(f'odd numbers only: {json.dumps(numbers_odd)}')
# odd numbers only: [27, 23, 65, 93, 87]

print('# using JavaScript-like Array.filter() function "array_filter_v5"')

numbers_even = array_filter_v5(lambda number, *_: ((number % 2) == 0), numbers)
print(f'even numbers only: {json.dumps(numbers_even)}')
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd = array_filter_v5(lambda number, *_: ((number % 2) != 0), numbers)
print(f'odd numbers only: {json.dumps(numbers_odd)}')
# odd numbers only: [27, 23, 65, 93, 87]

print('# using JavaScript-like Array.filter() function "array_filter_v6"')

numbers_even = array_filter_v6(lambda number, *_: ((number % 2) == 0), numbers)
print(f'even numbers only: {json.dumps(numbers_even)}')
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd = array_filter_v6(lambda number, *_: ((number % 2) != 0), numbers)
print(f'odd numbers only: {json.dumps(numbers_odd)}')
# odd numbers only: [27, 23, 65, 93, 87]

print('# using Python Array.filter() built-in function "filter", the "pythonic" way')

numbers_even = list(filter(lambda number: ((number % 2) == 0), numbers))
print(f'even numbers only: {json.dumps(numbers_even)}')
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd = list(filter(lambda number: ((number % 2) != 0), numbers))
print(f'odd numbers only: {json.dumps(numbers_odd)}')
# odd numbers only: [27, 23, 65, 93, 87]

print('\n# JavaScript-like Array.filter() in Python List of Dictionaries')

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

print('# using JavaScript-like Array.filter() function "array_filter_v1"')

products_below_100 = array_filter_v1(lambda product, *_: product['price'] <= 100, products)
print(f'products with price <= 100 only: {json.dumps(products_below_100, indent=4)}')
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v1(lambda product, *_: product['price'] >= 100, products)
print(f'products with price >= 100 only: {json.dumps(products_above_100, indent=4)}')
# products with price >= 100 only: [
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

products_below_100 = array_filter_v2(lambda product, *_: product['price'] <= 100, products)
print(f'products with price <= 100 only: {json.dumps(products_below_100, indent=4)}')
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v2(lambda product, *_: product['price'] >= 100, products)
print(f'products with price >= 100 only: {json.dumps(products_above_100, indent=4)}')
# products with price >= 100 only: [
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

products_below_100 = array_filter_v3(lambda product, *_: product['price'] <= 100, products)
print(f'products with price <= 100 only: {json.dumps(products_below_100, indent=4)}')
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v3(lambda product, *_: product['price'] >= 100, products)
print(f'products with price >= 100 only: {json.dumps(products_above_100, indent=4)}')
# products with price >= 100 only: [
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

products_below_100 = array_filter_v4(lambda product, *_: product['price'] <= 100, products)
print(f'products with price <= 100 only: {json.dumps(products_below_100, indent=4)}')
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v4(lambda product, *_: product['price'] >= 100, products)
print(f'products with price >= 100 only: {json.dumps(products_above_100, indent=4)}')
# products with price >= 100 only: [
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

products_below_100 = array_filter_v5(lambda product, *_: product['price'] <= 100, products)
print(f'products with price <= 100 only: {json.dumps(products_below_100, indent=4)}')
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v5(lambda product, *_: product['price'] >= 100, products)
print(f'products with price >= 100 only: {json.dumps(products_above_100, indent=4)}')
# products with price >= 100 only: [
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

products_below_100 = array_filter_v6(lambda product, *_: product['price'] <= 100, products)
print(f'products with price <= 100 only: {json.dumps(products_below_100, indent=4)}')
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v6(lambda product, *_: product['price'] >= 100, products)
print(f'products with price >= 100 only: {json.dumps(products_above_100, indent=4)}')
# products with price >= 100 only: [
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

products_below_100 = list(filter(lambda product: product['price'] <= 100, products))
print(f'products with price <= 100 only: {json.dumps(products_below_100, indent=4)}')
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = list(filter(lambda product: product['price'] >= 100, products))
print(f'products with price >= 100 only: {json.dumps(products_above_100, indent=4)}')
# products with price >= 100 only: [
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
