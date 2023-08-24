import json
from functools import reduce


def array_reduce(callback_function, an_array, initial_value):
    '''JavaScript-like Array.reduce() function'''
    result = None
    for array_item_index, array_item in enumerate(an_array):
        result = initial_value if result is None else result

        if isinstance(initial_value, list):
            result = [] if result is None else result
            result = callback_function(result, array_item, array_item_index, an_array)
            continue

        if isinstance(initial_value, dict):
            result = {} if result is None else result
            result = callback_function(result, array_item, array_item_index, an_array)
            continue

        if isinstance(initial_value, int) or isinstance(initial_value, float):
            result = 0 if result is None else result
            result = callback_function(result, array_item, array_item_index, an_array)
            continue

        if isinstance(initial_value, str):
            result = '' if result is None else result
            result = callback_function(result, array_item, array_item_index, an_array)
            continue

        if isinstance(initial_value, bool):
            result = False if result is None else result
            result = callback_function(result, array_item, array_item_index, an_array)
            continue

        if initial_value is None:
            result = None if result is None else result
            result = callback_function(result, array_item, array_item_index, an_array)
            continue

    return result


print('\n# JavaScript-like Array.reduce() in Python List')

numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
print(f'numbers: {json.dumps(numbers)}')

print('# using JavaScript-like Array.map() function "array_reduce"')

total_number = reduce(lambda current_total_number, current_number: current_total_number + current_number, numbers, 0)
print(f'total number: {total_number}')
# total number: 635

print('# using Python Array.map() built-in function "functools.reduce"')

total_number = array_reduce(lambda current_total_number, current_number, *_: current_total_number + current_number, numbers, 0)
print(f'total number: {total_number}')
# total number: 635

print('\n# JavaScript-like Array.reduce() in Python List of Dictionaries')

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

print('# using JavaScript-like Array.map() function "array_reduce"')

grouped_products = array_reduce(lambda current_grouped_products, current_product, *_: {**current_grouped_products, 'expensive': [*current_grouped_products['expensive'], current_product]} if current_product['price'] > 100 else {**current_grouped_products, 'cheap': [*current_grouped_products['cheap'], current_product]}, products, {"expensive": [], "cheap": []})
print('grouped products:', json.dumps(grouped_products, indent=4))

print('# using Python Array.map() built-in function "functools.reduce"')

grouped_products = reduce(lambda current_grouped_products, current_product: {**current_grouped_products, 'expensive': [*current_grouped_products['expensive'], current_product]} if current_product['price'] > 100 else {**current_grouped_products, 'cheap': [*current_grouped_products['cheap'], current_product]}, products, {"expensive": [], "cheap": []})
print('grouped products:', json.dumps(grouped_products, indent=4))
# grouped products: {
#     "expensive": [
#         {
#             "code": "bubble_gum",
#             "price": 233
#         },
#         {
#             "code": "towel",
#             "price": 499
#         }
#     ],
#     "cheap": [
#         {
#             "code": "pasta",
#             "price": 30
#         },
#         {
#             "code": "potato_chips",
#             "price": 5
#         }
#     ]
# }
