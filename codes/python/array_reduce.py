from functools import reduce


def js_like_array_reduce_v1(callback_function, any_array, initial_value):
    '''JavaScript-like Array.reduce() function js_like_array_reduce_v1'''
    result = initial_value
    for (array_item_index, array_item) in enumerate(any_array):
        result = callback_function(result, array_item, array_item_index, any_array)
    return result


js_like_array_reduce_v2 = lambda callback_function, any_array, initial_value: (array_reduce_v2_inner := lambda result, array_item_index=0: (result if (array_item_index >= len(any_array)) else array_reduce_v2_inner(callback_function(result, any_array[array_item_index], array_item_index, any_array), (array_item_index + 1))))(initial_value)  # '''JavaScript-like Array.reduce() function js_like_array_reduce_v2'''


def main():
    from utils import json_stringify

    print("\n# JavaScript-like Array.reduce() in Python list")

    numbers = [36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3]
    print(f'numbers: {json_stringify(numbers)}')

    print('# using JavaScript-like Array.map() function "js_like_array_reduce_v1"')

    numbers_total = js_like_array_reduce_v1(lambda current_result, current_number, *_: (current_result + current_number), numbers, 0)
    print(f"total number: {numbers_total}")
    # total number: 41.2

    print('# using JavaScript-like Array.map() function "js_like_array_reduce_v2"')

    numbers_total = js_like_array_reduce_v2(lambda current_result, current_number, *_: (current_result + current_number), numbers, 0)
    print(f"total number: {numbers_total}")
    # total number: 41.2

    print('# using Python Array.map() built-in function "functools.reduce"')

    numbers_total = reduce(lambda current_result, current_number: (current_result + current_number), numbers, 0)
    print(f"total number: {numbers_total}")
    # total number: 41.2

    print("\n# JavaScript-like Array.reduce() in Python list of dictionaries")

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

    print('# using JavaScript-like Array.map() function "js_like_array_reduce_v1"')

    products_grouped = js_like_array_reduce_v1(lambda current_result, current_product, *_: {**current_result, 'expensive': [*current_result['expensive'], current_product]} if (current_product['price'] > 100) else {**current_result, 'cheap': [*current_result['cheap'], current_product]}, products, {"expensive": [], "cheap": []})
    print(f"grouped products: {json_stringify(products_grouped, pretty=True)}")
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

    print('# using JavaScript-like Array.map() function "js_like_array_reduce_v2"')

    products_grouped = js_like_array_reduce_v2(lambda current_result, current_product, *_: {**current_result, 'expensive': [*current_result['expensive'], current_product]} if (current_product['price'] > 100) else {**current_result, 'cheap': [*current_result['cheap'], current_product]}, products, {"expensive": [], "cheap": []})
    print(f"grouped products: {json_stringify(products_grouped, pretty=True)}")
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

    products_grouped = reduce(lambda current_result, current_product: {**current_result, 'expensive': [*current_result['expensive'], current_product]} if (current_product['price'] > 100) else {**current_result, 'cheap': [*current_result['cheap'], current_product]}, products, {"expensive": [], "cheap": []})
    print(f"grouped products: {json_stringify(products_grouped, pretty=True)}")
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


if __name__ == "__main__":
    main()
