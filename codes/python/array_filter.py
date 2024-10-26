from numbers import Number

js_like_type = {"Null": "Null", "Boolean": "Boolean", "String": "String", "Numeric": "Numeric", "Object": "Object", "Array": "Array", "Function": "Function"}


def array_reduce(callback_function, an_array, initial_value):
    '''JavaScript-like Array.reduce() function'''
    result = initial_value
    for (array_item_index, array_item) in enumerate(an_array):
        result = callback_function(result, array_item, array_item_index, an_array)
    return result


is_like_js_null = lambda anything: (anything is None)

is_like_js_boolean = lambda anything: ((isinstance(anything, bool) == True) and ((anything == True) or (anything == False)))

is_like_js_string = lambda anything: (isinstance(anything, str) == True)

is_like_js_numeric = lambda anything: (isinstance(anything, Number) == True)

is_like_js_object = lambda anything: (isinstance(anything, dict) == True)

is_like_js_array = lambda anything: (isinstance(anything, list) == True)

is_like_js_function = lambda anything: (callable(anything) == True)

get_type = lambda anything: (js_like_type["Null"] if (is_like_js_null(anything) == True) else js_like_type["Boolean"] if (is_like_js_boolean(anything) == True) else js_like_type["String"] if (is_like_js_string(anything) == True) else js_like_type["Numeric"] if (is_like_js_numeric(anything) == True) else js_like_type["Object"] if (is_like_js_object(anything) == True) else js_like_type["Array"] if (is_like_js_array(anything) == True) else js_like_type["Function"] if (is_like_js_function(anything) == True) else str(type(anything)))  # '''get_type_v2'''


def optional_chaining(callback_function):
    try:
        return callback_function()
    except Exception as an_exception:
        return None


nullish_coalescing = lambda anything, default_value: (default_value if (is_like_js_null(anything) == True) else anything)  # '''JavaScript-like Nullish Coalescing Operator (??) function nullish_coalescing_v2'''


def json_stringify(anything, pretty=False):
    '''custom JSON.stringify() function json_stringify_v3'''
    indent = (" " * 4)
    indent_level = 0


    def json_stringify_inner(anything_inner):
        nonlocal indent_level
        anything_inner_type = get_type(anything_inner)
        if (anything_inner_type == js_like_type["Null"]):
            return "null"
        if (anything_inner_type == js_like_type["String"]):
            return f'"{anything_inner}"'
        if (anything_inner_type == js_like_type["Numeric"]):
            return f"{anything_inner}"
        if ((anything_inner_type == js_like_type["Boolean"]) and (anything_inner == True)):
            return "true"
        if ((anything_inner_type == js_like_type["Boolean"]) and (anything_inner == False)):
            return "false"
        if (anything_inner_type == js_like_type["Object"]):
            if (len(anything_inner) == 0):
                return "{" + "}"
            indent_level += 1
            result = (("{\n" + (indent * indent_level)) if (pretty == True) else "{ ")
            for (object_entry_index, (object_key, object_value)) in enumerate(anything_inner.items()):
                result += f'"{object_key}": {json_stringify_inner(object_value)}'
                if ((object_entry_index + 1) != len(anything_inner)):
                    result += ((f",\n{(indent * indent_level)}") if (pretty == True) else ", ")
            indent_level -= 1
            result += ((f"\n{(indent * indent_level)}" + "}") if (pretty == True) else " }")
            return result
        if (anything_inner_type == js_like_type["Array"]):
            if (len(anything_inner) == 0):
                return "[]"
            indent_level += 1
            result = ((f"[\n{(indent * indent_level)}") if (pretty == True) else "[")
            for (array_item_index, array_item) in enumerate(anything_inner):
                result += json_stringify_inner(array_item)
                if ((array_item_index + 1) != len(anything_inner)):
                    result += (f",\n{(indent * indent_level)}" if (pretty == True) else ", ")
            indent_level -= 1
            result += (f"\n{(indent * indent_level)}]" if (pretty == True) else "]")
            return result
        if (anything_inner_type == js_like_type["Function"]):
            return "[object Function]"
        return anything_inner_type


    return json_stringify_inner(anything)


def array_filter_v1(callback_function, an_array):
    '''JavaScript-like Array.filter() function array_filter_v1'''
    data_filtered = []
    for (array_item_index, array_item) in enumerate(an_array):
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == True):
            data_filtered.append(array_item)
    return data_filtered


def array_filter_v2(callback_function, an_array):
    '''JavaScript-like Array.filter() function array_filter_v2'''
    data_filtered = []
    for (array_item_index, array_item) in enumerate(an_array):
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == True):
            data_filtered = [*data_filtered, array_item]
    return data_filtered


def array_filter_v3(callback_function, an_array):
    '''JavaScript-like Array.filter() function array_filter_v3'''
    data_filtered = []
    for (array_item_index, array_item) in enumerate(an_array):
        if (callback_function(array_item, array_item_index, an_array) == True):
            data_filtered.append(array_item)
    return data_filtered


def array_filter_v4(callback_function, an_array):
    '''JavaScript-like Array.filter() function array_filter_v4'''
    data_filtered = []
    for (array_item_index, array_item) in enumerate(an_array):
        if (callback_function(array_item, array_item_index, an_array) == True):
            data_filtered = [*data_filtered, array_item]
    return data_filtered


def array_filter_v5(callback_function, an_array):
    '''JavaScript-like Array.filter() function array_filter_v5'''
    return [array_item for (array_item_index, array_item) in enumerate(an_array) if (callback_function(array_item, array_item_index, an_array) == True)]


array_filter_v6 = lambda callback_function, an_array: [array_item for (array_item_index, array_item) in enumerate(an_array) if (callback_function(array_item, array_item_index, an_array) == True)]  # '''JavaScript-like Array.filter() function array_filter_v6'''

print("\n# JavaScript-like Array.filter() in Python list")

numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
print(f'numbers: {json_stringify(numbers)}')

print('# using JavaScript-like Array.filter() function "array_filter_v1"')

numbers_even = array_filter_v1(lambda any_number, *_: ((any_number % 2) == 0), numbers)
print(f'even numbers only: {json_stringify(numbers_even)}')
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd = array_filter_v1(lambda any_number, *_: ((any_number % 2) != 0), numbers)
print(f'odd numbers only: {json_stringify(numbers_odd)}')
# odd numbers only: [27, 23, 65, 93, 87]

print('# using JavaScript-like Array.filter() function "array_filter_v2"')

numbers_even = array_filter_v2(lambda any_number, *_: ((any_number % 2) == 0), numbers)
print(f'even numbers only: {json_stringify(numbers_even)}')
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd = array_filter_v2(lambda any_number, *_: ((any_number % 2) != 0), numbers)
print(f'odd numbers only: {json_stringify(numbers_odd)}')
# odd numbers only: [27, 23, 65, 93, 87]

print('# using JavaScript-like Array.filter() function "array_filter_v3"')

numbers_even = array_filter_v3(lambda any_number, *_: ((any_number % 2) == 0), numbers)
print(f'even numbers only: {json_stringify(numbers_even)}')
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd = array_filter_v3(lambda any_number, *_: ((any_number % 2) != 0), numbers)
print(f'odd numbers only: {json_stringify(numbers_odd)}')
# odd numbers only: [27, 23, 65, 93, 87]

print('# using JavaScript-like Array.filter() function "array_filter_v4"')

numbers_even = array_filter_v4(lambda any_number, *_: ((any_number % 2) == 0), numbers)
print(f'even numbers only: {json_stringify(numbers_even)}')
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd = array_filter_v4(lambda any_number, *_: ((any_number % 2) != 0), numbers)
print(f'odd numbers only: {json_stringify(numbers_odd)}')
# odd numbers only: [27, 23, 65, 93, 87]

print('# using JavaScript-like Array.filter() function "array_filter_v5"')

numbers_even = array_filter_v5(lambda any_number, *_: ((any_number % 2) == 0), numbers)
print(f'even numbers only: {json_stringify(numbers_even)}')
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd = array_filter_v5(lambda any_number, *_: ((any_number % 2) != 0), numbers)
print(f'odd numbers only: {json_stringify(numbers_odd)}')
# odd numbers only: [27, 23, 65, 93, 87]

print('# using JavaScript-like Array.filter() function "array_filter_v6"')

numbers_even = array_filter_v6(lambda any_number, *_: ((any_number % 2) == 0), numbers)
print(f'even numbers only: {json_stringify(numbers_even)}')
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd = array_filter_v6(lambda any_number, *_: ((any_number % 2) != 0), numbers)
print(f'odd numbers only: {json_stringify(numbers_odd)}')
# odd numbers only: [27, 23, 65, 93, 87]

print('# using Python Array.filter() built-in function "filter", the "pythonic" way')

numbers_even = list(filter(lambda any_number: ((any_number % 2) == 0), numbers))
print(f'even numbers only: {json_stringify(numbers_even)}')
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd = list(filter(lambda any_number: ((any_number % 2) != 0), numbers))
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

products_below_100 = array_filter_v1(lambda any_product, *_: (any_product['price'] <= 100), products)
print(f"products with price <= 100 only: {json_stringify(products_below_100, pretty=True)}")
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v1(lambda any_product, *_: (any_product['price'] > 100), products)
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

products_below_100 = array_filter_v2(lambda any_product, *_: (any_product['price'] <= 100), products)
print(f"products with price <= 100 only: {json_stringify(products_below_100, pretty=True)}")
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v2(lambda any_product, *_: (any_product['price'] > 100), products)
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

products_below_100 = array_filter_v3(lambda any_product, *_: (any_product['price'] <= 100), products)
print(f"products with price <= 100 only: {json_stringify(products_below_100, pretty=True)}")
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v3(lambda any_product, *_: (any_product['price'] > 100), products)
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

products_below_100 = array_filter_v4(lambda any_product, *_: (any_product['price'] <= 100), products)
print(f"products with price <= 100 only: {json_stringify(products_below_100, pretty=True)}")
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v4(lambda any_product, *_: (any_product['price'] > 100), products)
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

products_below_100 = array_filter_v5(lambda any_product, *_: (any_product['price'] <= 100), products)
print(f"products with price <= 100 only: {json_stringify(products_below_100, pretty=True)}")
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v5(lambda any_product, *_: (any_product['price'] > 100), products)
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

products_below_100 = array_filter_v6(lambda any_product, *_: (any_product['price'] <= 100), products)
print(f"products with price <= 100 only: {json_stringify(products_below_100, pretty=True)}")
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v6(lambda any_product, *_: (any_product['price'] > 100), products)
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

products_below_100 = list(filter(lambda any_product: (any_product['price'] <= 100), products))
print(f"products with price <= 100 only: {json_stringify(products_below_100, pretty=True)}")
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = list(filter(lambda any_product: (any_product['price'] > 100), products))
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
