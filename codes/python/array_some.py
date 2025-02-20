from numbers import Number

js_like_type = {"Null": "Null", "Boolean": "Boolean", "String": "String", "Numeric": "Numeric", "Object": "Object", "Array": "Array", "Function": "Function"}

array_reduce = lambda callback_function, any_array, initial_value_or_current_result, array_item_index=0: (initial_value_or_current_result if (array_item_index >= len(any_array)) else array_reduce_v2(callback_function, any_array, (callback_function(initial_value_or_current_result, any_array[array_item_index], array_item_index, any_array)), (array_item_index + 1)))  # '''JavaScript-like Array.reduce() function array_reduce_v2'''

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


def array_some_v1(callback_function, any_array):
    '''JavaScript-like Array.some() function array_some_v1'''
    is_condition_match = False
    for (array_item_index, array_item) in enumerate(any_array):
        is_condition_match = callback_function(array_item, array_item_index, any_array)
        if (is_condition_match == True):
            break
    return is_condition_match


def array_some_v2(callback_function, any_array):
    '''JavaScript-like Array.some() function array_some_v2'''
    is_condition_match = False
    for (array_item_index, array_item) in enumerate(any_array):
        is_condition_match = callback_function(array_item, array_item_index, any_array)
        if (is_condition_match == True):
            return is_condition_match
    return is_condition_match


def array_some_v3(callback_function, any_array):
    '''JavaScript-like Array.some() function array_some_v3'''
    for (array_item_index, array_item) in enumerate(any_array):
        is_condition_match = callback_function(array_item, array_item_index, any_array)
        if (is_condition_match == True):
            return True
    return False


def array_some_v4(callback_function, any_array):
    '''JavaScript-like Array.some() function array_some_v4'''
    for (array_item_index, array_item) in enumerate(any_array):
        if (callback_function(array_item, array_item_index, any_array) == True):
            return True
    return False


print("\n# JavaScript-like Array.some() in Python list")

numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
print(f'numbers: {json_stringify(numbers)}')

print('# using JavaScript-like Array.some() function "array_some_v1"')

is_any_numbers_less_than500 = array_some_v1(lambda any_number, *_: (any_number < 500), numbers)
print(f"is any number < 500: {is_any_numbers_less_than500}")
# is any number < 500: True

is_any_numbers_more_than500 = array_some_v1(lambda any_number, *_: (any_number > 500), numbers)
print(f"is any number > 500: {is_any_numbers_more_than500}")
# is any number > 500: False

print('# using JavaScript-like Array.some() function "array_some_v2"')

is_any_numbers_less_than500 = array_some_v2(lambda any_number, *_: (any_number < 500), numbers)
print(f"is any number < 500: {is_any_numbers_less_than500}")
# is any number < 500: True

is_any_numbers_more_than500 = array_some_v2(lambda any_number, *_: (any_number > 500), numbers)
print(f"is any number > 500: {is_any_numbers_more_than500}")
# is any number > 500: False

print('# using JavaScript-like Array.some() function "array_some_v3"')

is_any_numbers_less_than500 = array_some_v3(lambda any_number, *_: (any_number < 500), numbers)
print(f"is any number < 500: {is_any_numbers_less_than500}")
# is any number < 500: True

is_any_numbers_more_than500 = array_some_v3(lambda any_number, *_: (any_number > 500), numbers)
print(f"is any number > 500: {is_any_numbers_more_than500}")
# is any number > 500: False

print('# using Python Array.some() built-in function "any", the "pythonic" way')

is_any_numbers_less_than500 = any([(any_number < 500) for any_number in numbers])
print(f"is any number < 500: {is_any_numbers_less_than500}")
# is any number < 500: True

is_any_numbers_more_than500 = any([(any_number > 500) for any_number in numbers])
print(f"is any number > 500: {is_any_numbers_more_than500}")
# is any number > 500: False

print("\n# JavaScript-like Array.some() in Python list of dictionaries")

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

print('# using JavaScript-like Array.every() function "array_some_v1"')

is_any_product_price_less_than_500 = array_some_v1(lambda any_product, *_: (any_product['price'] < 500), products)
print(f"is any product price < 500: {is_any_product_price_less_than_500}")
# is any product price < 500: True

is_any_product_price_more_than_500 = array_some_v1(lambda any_product, *_: (any_product['price'] > 500), products)
print(f"is any product price > 500: {is_any_product_price_more_than_500}")
# is any product price > 500: False

print('# using JavaScript-like Array.every() function "array_some_v2"')

is_any_product_price_less_than_500 = array_some_v2(lambda any_product, *_: (any_product['price'] < 500), products)
print(f"is any product price < 500: {is_any_product_price_less_than_500}")
# is any product price < 500: True

is_any_product_price_more_than_500 = array_some_v2(lambda any_product, *_: (any_product['price'] > 500), products)
print(f"is any product price > 500: {is_any_product_price_more_than_500}")
# is any product price > 500: False

print('# using JavaScript-like Array.every() function "array_some_v3"')

is_any_product_price_less_than_500 = array_some_v3(lambda any_product, *_: (any_product['price'] < 500), products)
print(f"is any product price < 500: {is_any_product_price_less_than_500}")
# is any product price < 500: True

is_any_product_price_more_than_500 = array_some_v3(lambda any_product, *_: (any_product['price'] > 500), products)
print(f"is any product price > 500: {is_any_product_price_more_than_500}")
# is any product price > 500: False

print('# using JavaScript-like Array.every() function "array_some_v4"')

is_any_product_price_less_than_500 = array_some_v4(lambda any_product, *_: (any_product['price'] < 500), products)
print(f"is any product price < 500: {is_any_product_price_less_than_500}")
# is any product price < 500: True

is_any_product_price_more_than_500 = array_some_v4(lambda any_product, *_: (any_product['price'] > 500), products)
print(f"is any product price > 500: {is_any_product_price_more_than_500}")
# is any product price > 500: False

print('# using Python Array.some() built-in function "any", the "pythonic" way')

is_any_product_price_less_than_500 = any([(any_product['price'] < 500) for any_product in products])
print(f"is any product price < 500: {is_any_product_price_less_than_500}")
# is any product price < 500: True

is_any_product_price_more_than_500 = any([(any_product['price'] > 500) for any_product in products])
print(f"is any product price > 500: {is_any_product_price_more_than_500}")
# is any product price > 500: False
