def js_like_array_map_v1(callback_function, any_array):
    '''JavaScript-like Array.map() function js_like_array_map_v1'''
    new_array = []
    for (array_item_index, array_item) in enumerate(any_array):
        new_array_item = callback_function(array_item, array_item_index, any_array)
        new_array.append(new_array_item)
    return new_array


def js_like_array_map_v2(callback_function, any_array):
    '''JavaScript-like Array.map() function js_like_array_map_v2'''
    new_array = []
    for (array_item_index, array_item) in enumerate(any_array):
        new_array_item = callback_function(array_item, array_item_index, any_array)
        new_array = [*new_array, new_array_item]
    return new_array


def js_like_array_map_v3(callback_function, any_array):
    '''JavaScript-like Array.map() function js_like_array_map_v3'''
    new_array = []
    for (array_item_index, array_item) in enumerate(any_array):
        new_array.append(callback_function(array_item, array_item_index, any_array))
    return new_array


def js_like_array_map_v4(callback_function, any_array):
    '''JavaScript-like Array.map() function js_like_array_map_v4'''
    new_array = []
    for (array_item_index, array_item) in enumerate(any_array):
        new_array = [*new_array, callback_function(array_item, array_item_index, any_array)]
    return new_array


def js_like_array_map_v5(callback_function, any_array):
    '''JavaScript-like Array.map() function js_like_array_map_v5'''
    return [callback_function(array_item, array_item_index, any_array) for (array_item_index, array_item) in enumerate(any_array)]


js_like_array_map_v6 = lambda callback_function, any_array: [callback_function(array_item, array_item_index, any_array) for (array_item_index, array_item) in enumerate(any_array)]  # '''JavaScript-like Array.map() function js_like_array_map_v6'''


def main():
    from utils import json_stringify

    print("\n# JavaScript-like Array.map() in Python list")

    numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
    print(f'numbers: {json_stringify(numbers)}')

    print('# using JavaScript-like Array.map() function "js_like_array_map_v1"')

    numbers_labeled = js_like_array_map_v1(lambda any_number, *_: {any_number: "even" if ((any_number % 2) == 0) else "odd"}, numbers)
    print(f"labeled numbers: {json_stringify(numbers_labeled, pretty=True)}")
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

    print('# using JavaScript-like Array.map() function "js_like_array_map_v2"')

    numbers_labeled = js_like_array_map_v2(lambda any_number, *_: {any_number: "even" if ((any_number % 2) == 0) else "odd"}, numbers)
    print(f"labeled numbers: {json_stringify(numbers_labeled, pretty=True)}")
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

    print('# using JavaScript-like Array.map() function "js_like_array_map_v3"')

    numbers_labeled = js_like_array_map_v3(lambda any_number, *_: {any_number: "even" if ((any_number % 2) == 0) else "odd"}, numbers)
    print(f"labeled numbers: {json_stringify(numbers_labeled, pretty=True)}")
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

    print('# using JavaScript-like Array.map() function "js_like_array_map_v4"')

    numbers_labeled = js_like_array_map_v4(lambda any_number, *_: {any_number: "even" if ((any_number % 2) == 0) else "odd"}, numbers)
    print(f"labeled numbers: {json_stringify(numbers_labeled, pretty=True)}")
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

    print('# using JavaScript-like Array.map() function "js_like_array_map_v5"')

    numbers_labeled = js_like_array_map_v5(lambda any_number, *_: {any_number: "even" if ((any_number % 2) == 0) else "odd"}, numbers)
    print(f"labeled numbers: {json_stringify(numbers_labeled, pretty=True)}")
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

    print('# using JavaScript-like Array.map() function "js_like_array_map_v6"')

    numbers_labeled = js_like_array_map_v6(lambda any_number, *_: {any_number: "even" if ((any_number % 2) == 0) else "odd"}, numbers)
    print(f"labeled numbers: {json_stringify(numbers_labeled, pretty=True)}")
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

    numbers_labeled = list(map(lambda any_number: {any_number: "even" if ((any_number % 2) == 0) else "odd"}, numbers))
    print(f"labeled numbers: {json_stringify(numbers_labeled, pretty=True)}")
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

    print('# using Python Array.map() list comprehension, the more "pythonic" way')

    numbers_labeled = [{any_number: "even" if ((any_number % 2) == 0) else "odd"} for any_number in numbers]
    print(f"labeled numbers: {json_stringify(numbers_labeled, pretty=True)}")
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

    print("\n# JavaScript-like Array.map() in Python list of dictionaries")

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

    print('# using JavaScript-like Array.map() function "js_like_array_map_v1"')

    products_labeled = js_like_array_map_v1(lambda any_product, *_: {**any_product, "label": "expensive" if (any_product["price"] > 100) else "cheap"}, products)
    print(f"labeled products: {json_stringify(products_labeled, pretty=True)}")
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

    print('# using JavaScript-like Array.map() function "js_like_array_map_v2"')

    products_labeled = js_like_array_map_v2(lambda any_product, *_: {**any_product, "label": "expensive" if (any_product["price"] > 100) else "cheap"}, products)
    print(f"labeled products: {json_stringify(products_labeled, pretty=True)}")
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

    print('# using JavaScript-like Array.map() function "js_like_array_map_v3"')

    products_labeled = js_like_array_map_v3(lambda any_product, *_: {**any_product, "label": "expensive" if (any_product["price"] > 100) else "cheap"}, products)
    print(f"labeled products: {json_stringify(products_labeled, pretty=True)}")
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

    print('# using JavaScript-like Array.map() function "js_like_array_map_v4"')

    products_labeled = js_like_array_map_v4(lambda any_product, *_: {**any_product, "label": "expensive" if (any_product["price"] > 100) else "cheap"}, products)
    print(f"labeled products: {json_stringify(products_labeled, pretty=True)}")
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

    print('# using JavaScript-like Array.map() function "js_like_array_map_v5"')

    products_labeled = js_like_array_map_v5(lambda any_product, *_: {**any_product, "label": "expensive" if (any_product["price"] > 100) else "cheap"}, products)
    print(f"labeled products: {json_stringify(products_labeled, pretty=True)}")
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

    print('# using JavaScript-like Array.map() function "js_like_array_map_v6"')

    products_labeled = js_like_array_map_v6(lambda any_product, *_: {**any_product, "label": "expensive" if (any_product["price"] > 100) else "cheap"}, products)
    print(f"labeled products: {json_stringify(products_labeled, pretty=True)}")
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

    products_labeled = list(map(lambda any_product: {**any_product, "label": "expensive" if (any_product["price"] > 100) else "cheap"}, products))
    print(f"labeled products: {json_stringify(products_labeled, pretty=True)}")
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

    print('# using Python Array.map() list comprehension, the more "pythonic" way')

    products_labeled = [{**any_product, "label": "expensive" if (any_product["price"] > 100) else "cheap"} for any_product in products]
    print(f"labeled products: {json_stringify(products_labeled, pretty=True)}")
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


if __name__ == "__main__":
    main()
