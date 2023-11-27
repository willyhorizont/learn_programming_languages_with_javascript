import json
from functools import reduce


def array_reduce(callback_function, an_array, initial_value):
    '''JavaScript-like Array.reduce() function'''
    result = initial_value
    for array_item_index, array_item in enumerate(an_array):
        result = callback_function(result, array_item, array_item_index, an_array)
    return result


print('\n# JavaScript-like Array.reduce() in Python List')

numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
print(f'numbers: {json.dumps(numbers)}')

print('# using JavaScript-like Array.map() function "array_reduce"')

numbers_total = array_reduce(lambda current_result, current_number, *_: current_result + current_number, numbers, 0)
print(f'total number: {numbers_total}')
# total number: 635

print('# using Python Array.map() built-in function "functools.reduce"')

numbers_total = reduce(lambda current_result, current_number: current_result + current_number, numbers, 0)
print(f'total number: {numbers_total}')
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

products_grouped = array_reduce(lambda current_result, current_product, *_: {**current_result, 'expensive': [*current_result['expensive'], current_product]} if current_product['price'] > 100 else {**current_result, 'cheap': [*current_result['cheap'], current_product]}, products, {"expensive": [], "cheap": []})
print('grouped products:', json.dumps(products_grouped, indent=4))
# grouped products: {
#     "expensive": [
#         {
#             "code": "pasta",
#             "price": 321
#         },
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
#             "code": "potato_chips",
#             "price": 5
#         }
#     ]
# }

print('# using Python Array.map() built-in function "functools.reduce"')

products_grouped = reduce(lambda current_result, current_product: {**current_result, 'expensive': [*current_result['expensive'], current_product]} if current_product['price'] > 100 else {**current_result, 'cheap': [*current_result['cheap'], current_product]}, products, {"expensive": [], "cheap": []})
print('grouped products:', json.dumps(products_grouped, indent=4))
# grouped products: {
#     "expensive": [
#         {
#             "code": "pasta",
#             "price": 321
#         },
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
#             "code": "potato_chips",
#             "price": 5
#         }
#     ]
# }
