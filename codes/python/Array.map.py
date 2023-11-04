import json


def array_map_v1(callback_function, an_array):
    '''JavaScript-like Array.map() function'''
    new_array = []
    for array_item_index, array_item in enumerate(an_array):
        new_array_item = callback_function(array_item, array_item_index, an_array)
        new_array.append(new_array_item)
    return new_array


def array_map_v2(callback_function, an_array):
    '''JavaScript-like Array.map() function'''
    new_array = []
    for array_item_index, array_item in enumerate(an_array):
        new_array_item = callback_function(array_item, array_item_index, an_array)
        new_array = [*new_array, new_array_item]
    return new_array


def array_map_v3(callback_function, an_array):
    '''JavaScript-like Array.map() function'''
    new_array = []
    for array_item_index, array_item in enumerate(an_array):
        new_array.append(callback_function(array_item, array_item_index, an_array))
    return new_array


def array_map_v4(callback_function, an_array):
    '''JavaScript-like Array.map() function'''
    new_array = []
    for array_item_index, array_item in enumerate(an_array):
        new_array = [*new_array, callback_function(array_item, array_item_index, an_array)]
    return new_array


def array_map_v5(callback_function, an_array):
    '''JavaScript-like Array.map() function'''
    return [callback_function(array_item, array_item_index, an_array) for array_item_index, array_item in enumerate(an_array)]


# JavaScript-like Array.map() function
array_map_v6 = lambda callback_function, an_array: [callback_function(array_item, array_item_index, an_array) for array_item_index, array_item in enumerate(an_array)]

print('\n# JavaScript-like Array.map() in Python List')

numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
print(f'numbers: {json.dumps(numbers)}')

print('# using JavaScript-like Array.map() function "array_map_v1"')

numbers_labeled = array_map_v1(lambda number, *_: {number: 'even' if ((number % 2) == 0) else 'odd'}, numbers)
print(f'labeled numbers: {json.dumps(numbers_labeled, indent=4)}')
# labeled numbers: [
#     {
#         "12": "even"
#     },
#     {
#         "34": "even"
#     },
#     {
#         "27": "odd"
#     },
#     {
#         "23": "odd"
#     },
#     {
#         "65": "odd"
#     },
#     {
#         "93": "odd"
#     },
#     {
#         "36": "even"
#     },
#     {
#         "87": "odd"
#     },
#     {
#         "4": "even"
#     },
#     {
#         "254": "even"
#     }
# ]

print('# using JavaScript-like Array.map() function "array_map_v2"')

numbers_labeled = array_map_v2(lambda number, *_: {number: 'even' if ((number % 2) == 0) else 'odd'}, numbers)
print(f'labeled numbers: {json.dumps(numbers_labeled, indent=4)}')
# labeled numbers: [
#     {
#         "12": "even"
#     },
#     {
#         "34": "even"
#     },
#     {
#         "27": "odd"
#     },
#     {
#         "23": "odd"
#     },
#     {
#         "65": "odd"
#     },
#     {
#         "93": "odd"
#     },
#     {
#         "36": "even"
#     },
#     {
#         "87": "odd"
#     },
#     {
#         "4": "even"
#     },
#     {
#         "254": "even"
#     }
# ]

print('# using JavaScript-like Array.map() function "array_map_v3"')

numbers_labeled = array_map_v3(lambda number, *_: {number: 'even' if ((number % 2) == 0) else 'odd'}, numbers)
print(f'labeled numbers: {json.dumps(numbers_labeled, indent=4)}')
# labeled numbers: [
#     {
#         "12": "even"
#     },
#     {
#         "34": "even"
#     },
#     {
#         "27": "odd"
#     },
#     {
#         "23": "odd"
#     },
#     {
#         "65": "odd"
#     },
#     {
#         "93": "odd"
#     },
#     {
#         "36": "even"
#     },
#     {
#         "87": "odd"
#     },
#     {
#         "4": "even"
#     },
#     {
#         "254": "even"
#     }
# ]

print('# using JavaScript-like Array.map() function "array_map_v4"')

numbers_labeled = array_map_v4(lambda number, *_: {number: 'even' if ((number % 2) == 0) else 'odd'}, numbers)
print(f'labeled numbers: {json.dumps(numbers_labeled, indent=4)}')
# labeled numbers: [
#     {
#         "12": "even"
#     },
#     {
#         "34": "even"
#     },
#     {
#         "27": "odd"
#     },
#     {
#         "23": "odd"
#     },
#     {
#         "65": "odd"
#     },
#     {
#         "93": "odd"
#     },
#     {
#         "36": "even"
#     },
#     {
#         "87": "odd"
#     },
#     {
#         "4": "even"
#     },
#     {
#         "254": "even"
#     }
# ]

print('# using JavaScript-like Array.map() function "array_map_v5"')

numbers_labeled = array_map_v5(lambda number, *_: {number: 'even' if ((number % 2) == 0) else 'odd'}, numbers)
print(f'labeled numbers: {json.dumps(numbers_labeled, indent=4)}')
# labeled numbers: [
#     {
#         "12": "even"
#     },
#     {
#         "34": "even"
#     },
#     {
#         "27": "odd"
#     },
#     {
#         "23": "odd"
#     },
#     {
#         "65": "odd"
#     },
#     {
#         "93": "odd"
#     },
#     {
#         "36": "even"
#     },
#     {
#         "87": "odd"
#     },
#     {
#         "4": "even"
#     },
#     {
#         "254": "even"
#     }
# ]

print('# using JavaScript-like Array.map() function "array_map_v6"')

numbers_labeled = array_map_v6(lambda number, *_: {number: 'even' if ((number % 2) == 0) else 'odd'}, numbers)
print(f'labeled numbers: {json.dumps(numbers_labeled, indent=4)}')
# labeled numbers: [
#     {
#         "12": "even"
#     },
#     {
#         "34": "even"
#     },
#     {
#         "27": "odd"
#     },
#     {
#         "23": "odd"
#     },
#     {
#         "65": "odd"
#     },
#     {
#         "93": "odd"
#     },
#     {
#         "36": "even"
#     },
#     {
#         "87": "odd"
#     },
#     {
#         "4": "even"
#     },
#     {
#         "254": "even"
#     }
# ]

print('# using Python Array.map() built-in function "map", the "pythonic" way')

numbers_labeled = list(map(lambda number: {number: 'even' if ((number % 2) == 0) else 'odd'}, numbers))
print(f'labeled numbers: {json.dumps(numbers_labeled, indent=4)}')
# labeled numbers: [
#     {
#         "12": "even"
#     },
#     {
#         "34": "even"
#     },
#     {
#         "27": "odd"
#     },
#     {
#         "23": "odd"
#     },
#     {
#         "65": "odd"
#     },
#     {
#         "93": "odd"
#     },
#     {
#         "36": "even"
#     },
#     {
#         "87": "odd"
#     },
#     {
#         "4": "even"
#     },
#     {
#         "254": "even"
#     }
# ]

print('\n# JavaScript-like Array.map() in Python List of Dictionaries')

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

print('# using JavaScript-like Array.map() function "array_map_v1"')

products_labeled = array_map_v1(lambda product, *_: {**product, 'label': 'expensive' if (product['price'] > 100) else 'cheap'}, products)
print(f'labeled products: {json.dumps(products_labeled, indent=4)}')
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato_chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]

print('# using JavaScript-like Array.map() function "array_map_v2"')

products_labeled = array_map_v2(lambda product, *_: {**product, 'label': 'expensive' if (product['price'] > 100) else 'cheap'}, products)
print(f'labeled products: {json.dumps(products_labeled, indent=4)}')
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato_chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]

print('# using JavaScript-like Array.map() function "array_map_v3"')

products_labeled = array_map_v3(lambda product, *_: {**product, 'label': 'expensive' if (product['price'] > 100) else 'cheap'}, products)
print(f'labeled products: {json.dumps(products_labeled, indent=4)}')
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato_chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]

print('# using JavaScript-like Array.map() function "array_map_v4"')

products_labeled = array_map_v4(lambda product, *_: {**product, 'label': 'expensive' if (product['price'] > 100) else 'cheap'}, products)
print(f'labeled products: {json.dumps(products_labeled, indent=4)}')
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato_chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]

print('# using JavaScript-like Array.map() function "array_map_v5"')

products_labeled = array_map_v5(lambda product, *_: {**product, 'label': 'expensive' if (product['price'] > 100) else 'cheap'}, products)
print(f'labeled products: {json.dumps(products_labeled, indent=4)}')
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato_chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]

print('# using JavaScript-like Array.map() function "array_map_v6"')

products_labeled = array_map_v6(lambda product, *_: {**product, 'label': 'expensive' if (product['price'] > 100) else 'cheap'}, products)
print(f'labeled products: {json.dumps(products_labeled, indent=4)}')
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato_chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]

print('# using Python Array.map() built-in function "map", the "pythonic" way')

products_labeled = list(map(lambda product: {**product, 'label': 'expensive' if (product['price'] > 100) else 'cheap'}, products))
print(f'labeled products: {json.dumps(products_labeled, indent=4)}')
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato_chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]
