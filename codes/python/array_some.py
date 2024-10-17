from numbers import Number

js_like_type = {
    "Null": "Null",
    "Boolean": "Boolean",
    "String": "String",
    "Numeric": "Numeric",
    "Object": "Object",
    "Array": "Array",
    "Function": "Function"
}


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

get_type = lambda anything: (js_like_type["Null"] if (is_like_js_null(anything) == True) else js_like_type["Boolean"] if (is_like_js_boolean(anything) == True) else js_like_type["String"] if (is_like_js_string(anything) == True) else js_like_type["Numeric"] if (is_like_js_numeric(anything) == True) else js_like_type["Object"] if (is_like_js_object(anything) == True) else js_like_type["Array"] if (is_like_js_array(anything) == True) else js_like_type["Function"] if (is_like_js_function(anything) == True) else f'"{(str(type(anything)))}"')  # '''get_type_v2'''

optional_chaining = lambda anything, *rest_arguments: ((anything(*rest_arguments)) if (get_type(anything) == js_like_type["Function"]) else (anything if (((get_type(anything) != js_like_type["Object"]) and (get_type(anything) != js_like_type["Array"])) or (len(rest_arguments) == 0)) else (array_reduce(lambda current_result, current_item, *_: anything.get(str(current_item)) if ((get_type(current_result) == js_like_type["Null"]) and (get_type(anything) == js_like_type["Object"]) and (get_type(current_item) == js_like_type["String"])) else anything[int(current_item)] if ((get_type(current_result) == js_like_type["Null"]) and (get_type(anything) == js_like_type["Array"]) and (get_type(current_item) == js_like_type["Numeric"]) and ((int(current_item) >= 0) or (int(current_item) == -1)) and (len(anything) > int(current_item))) else current_result.get(str(current_item)) if ((get_type(current_result) == js_like_type["Object"]) and (get_type(current_item) == js_like_type["String"])) else current_result[int(current_item)] if ((get_type(current_result) == js_like_type["Array"]) and (get_type(current_item) == js_like_type["Numeric"]) and ((int(current_item) >= 0) or (int(current_item) == -1)) and (len(current_result) > int(current_item))) else None, rest_arguments, None))))  # '''JavaScript-like Optional Chaining Operator (?.) function optional_chaining_v4'''

nullish_coalescing = lambda anything, default_value: (default_value if (is_like_js_null(anything) == True) else anything)  # '''JavaScript-like Nullish Coalescing Operator (??) function nullish_coalescing_v2'''


def json_stringify(anything, pretty=False):
    '''custom JSON.stringify() function json_stringify_v2'''
    indent = (" " * 4)
    indent_level = 0


    def json_stringify_inner(anything_inner):
        nonlocal indent_level
        if (get_type(anything_inner) == js_like_type["Null"]):
            return "null"
        if (get_type(anything_inner) == js_like_type["String"]):
            return f'"{anything_inner}"'
        if (get_type(anything_inner) == js_like_type["Numeric"]):
            return f"{anything_inner}"
        if ((get_type(anything_inner) == js_like_type["Boolean"]) and (anything_inner == True)):
            return "true"
        if ((get_type(anything_inner) == js_like_type["Boolean"]) and (anything_inner == False)):
            return "false"
        if (get_type(anything_inner) == js_like_type["Object"]):
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
        if (get_type(anything_inner) == js_like_type["Array"]):
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
        if (get_type(anything_inner) == js_like_type["Function"]):
            return '"[object Function]"'
        return f'"{(str(type(anything_inner)))}"'


    return json_stringify_inner(anything)


def array_some_v1(callback_function, an_array):
    '''JavaScript-like Array.some() function array_some_v1'''
    is_condition_match = False
    for (array_item_index, array_item) in enumerate(an_array):
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == True):
            break
    return is_condition_match


def array_some_v2(callback_function, an_array):
    '''JavaScript-like Array.some() function array_some_v2'''
    is_condition_match = False
    for (array_item_index, array_item) in enumerate(an_array):
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == True):
            return is_condition_match
    return is_condition_match


def array_some_v3(callback_function, an_array):
    '''JavaScript-like Array.some() function array_some_v3'''
    for (array_item_index, array_item) in enumerate(an_array):
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == True):
            return True
    return False


def array_some_v4(callback_function, an_array):
    '''JavaScript-like Array.some() function array_some_v4'''
    for (array_item_index, array_item) in enumerate(an_array):
        if (callback_function(array_item, array_item_index, an_array) == True):
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
