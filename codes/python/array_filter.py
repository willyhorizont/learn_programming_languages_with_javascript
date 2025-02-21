from numbers import Number

js_like_type = {"Null": "Null", "Boolean": "Boolean", "String": "String", "Numeric": "Numeric", "Object": "Object", "Array": "Array", "Function": "Function"}

array_reduce = lambda callback_function, any_array, initial_value_or_current_result, array_item_index=0: (initial_value_or_current_result if (array_item_index >= len(any_array)) else array_reduce(callback_function, any_array, (callback_function(initial_value_or_current_result, any_array[array_item_index], array_item_index, any_array)), (array_item_index + 1)))  # '''JavaScript-like Array.reduce() function array_reduce_v2'''

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
    except Exception as any_exception:
        return None


nullish_coalescing = lambda anything, default_value: (default_value if (is_like_js_null(anything) == True) else anything)  # '''JavaScript-like Nullish Coalescing Operator (??) function nullish_coalescing_v2'''

json_stringify = (json_stringify_v10_inner := lambda anything, pretty=False, indent=(" " * 4), indent_level=0: ("null" if ((anything_type := get_type(anything)) == js_like_type["Null"]) else ('"' + str(anything) + '"') if (anything_type == js_like_type["String"]) else str(anything) if (anything_type == js_like_type["Numeric"]) else "true" if ((anything_type == js_like_type["Boolean"]) and (anything == True)) else "false" if ((anything_type == js_like_type["Boolean"]) and (anything == False)) else (("{" + "}") if (len(anything) == 0) else ("".join([(("{\n" + (indent * (indent_level + 1))) if (pretty == True) else "{ "), *[((('"' + str(object_key) + '": ' + json_stringify_v10_inner(object_value, pretty=pretty, indent_level=(indent_level + 1))) + ((",\n" + (indent * (indent_level + 1))) if (pretty == True) else ", ")) if ((object_entry_index + 1) != len(anything)) else ('"' + str(object_key) + '": ' + json_stringify_v10_inner(object_value, pretty=pretty, indent_level=(indent_level + 1)))) for (object_entry_index, (object_key, object_value)) in enumerate(anything.items())], (("\n" + (indent * indent_level) + "}") if (pretty == True) else " }")]))) if (anything_type == js_like_type["Object"]) else ("[]" if (len(anything) == 0) else ("".join([(("[\n" + (indent * (indent_level + 1))) if (pretty == True) else "["), *[((json_stringify_v10_inner(array_item, pretty=pretty, indent_level=(indent_level + 1)) + ((",\n" + (indent * (indent_level + 1))) if (pretty == True) else ", ")) if ((array_item_index + 1) != len(anything)) else json_stringify_v10_inner(array_item, pretty=pretty, indent_level=(indent_level + 1))) for (array_item_index, array_item) in enumerate(anything)], (("\n" + (indent * indent_level) + "]") if (pretty == True) else "]")]))) if (anything_type == js_like_type["Array"]) else "[object Function]" if (anything_type == js_like_type["Function"]) else anything_type))  # '''custom JSON.stringify() function json_stringify_v10'''


def array_filter_v1(callback_function, any_array):
    '''JavaScript-like Array.filter() function array_filter_v1'''
    data_filtered = []
    for (array_item_index, array_item) in enumerate(any_array):
        is_condition_match = callback_function(array_item, array_item_index, any_array)
        if (is_condition_match == True):
            data_filtered.append(array_item)
    return data_filtered


def array_filter_v2(callback_function, any_array):
    '''JavaScript-like Array.filter() function array_filter_v2'''
    data_filtered = []
    for (array_item_index, array_item) in enumerate(any_array):
        is_condition_match = callback_function(array_item, array_item_index, any_array)
        if (is_condition_match == True):
            data_filtered = [*data_filtered, array_item]
    return data_filtered


def array_filter_v3(callback_function, any_array):
    '''JavaScript-like Array.filter() function array_filter_v3'''
    data_filtered = []
    for (array_item_index, array_item) in enumerate(any_array):
        if (callback_function(array_item, array_item_index, any_array) == True):
            data_filtered.append(array_item)
    return data_filtered


def array_filter_v4(callback_function, any_array):
    '''JavaScript-like Array.filter() function array_filter_v4'''
    data_filtered = []
    for (array_item_index, array_item) in enumerate(any_array):
        if (callback_function(array_item, array_item_index, any_array) == True):
            data_filtered = [*data_filtered, array_item]
    return data_filtered


def array_filter_v5(callback_function, any_array):
    '''JavaScript-like Array.filter() function array_filter_v5'''
    return [array_item for (array_item_index, array_item) in enumerate(any_array) if (callback_function(array_item, array_item_index, any_array) == True)]


array_filter_v6 = lambda callback_function, any_array: [array_item for (array_item_index, array_item) in enumerate(any_array) if (callback_function(array_item, array_item_index, any_array) == True)]  # '''JavaScript-like Array.filter() function array_filter_v6'''

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

products_below_100 = array_filter_v1(lambda any_product, *_: (optional_chaining(lambda: any_product["price"]) <= 100), products)
print(f"products with price <= 100 only: {json_stringify(products_below_100, pretty=True)}")
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v1(lambda any_product, *_: (optional_chaining(lambda: any_product["price"]) > 100), products)
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

products_below_100 = array_filter_v2(lambda any_product, *_: (optional_chaining(lambda: any_product["price"]) <= 100), products)
print(f"products with price <= 100 only: {json_stringify(products_below_100, pretty=True)}")
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v2(lambda any_product, *_: (optional_chaining(lambda: any_product["price"]) > 100), products)
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

products_below_100 = array_filter_v3(lambda any_product, *_: (optional_chaining(lambda: any_product["price"]) <= 100), products)
print(f"products with price <= 100 only: {json_stringify(products_below_100, pretty=True)}")
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v3(lambda any_product, *_: (optional_chaining(lambda: any_product["price"]) > 100), products)
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

products_below_100 = array_filter_v4(lambda any_product, *_: (optional_chaining(lambda: any_product["price"]) <= 100), products)
print(f"products with price <= 100 only: {json_stringify(products_below_100, pretty=True)}")
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v4(lambda any_product, *_: (optional_chaining(lambda: any_product["price"]) > 100), products)
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

products_below_100 = array_filter_v5(lambda any_product, *_: (optional_chaining(lambda: any_product["price"]) <= 100), products)
print(f"products with price <= 100 only: {json_stringify(products_below_100, pretty=True)}")
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v5(lambda any_product, *_: (optional_chaining(lambda: any_product["price"]) > 100), products)
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

products_below_100 = array_filter_v6(lambda any_product, *_: (optional_chaining(lambda: any_product["price"]) <= 100), products)
print(f"products with price <= 100 only: {json_stringify(products_below_100, pretty=True)}")
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v6(lambda any_product, *_: (optional_chaining(lambda: any_product["price"]) > 100), products)
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

products_below_100 = list(filter(lambda any_product: (optional_chaining(lambda: any_product["price"]) <= 100), products))
print(f"products with price <= 100 only: {json_stringify(products_below_100, pretty=True)}")
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = list(filter(lambda any_product: (optional_chaining(lambda: any_product["price"]) > 100), products))
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
