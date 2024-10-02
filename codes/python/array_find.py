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
    for array_item_index, array_item in enumerate(an_array):
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


def pipe(*rest_arguments):
    pipe_last_result = None


    def pipe_array_reduce_callback(current_result, current_argument, *_):
        nonlocal pipe_last_result
        pipe_last_result = current_result
        if (get_type(current_result) == js_like_type["Null"]):
            return current_argument
        if (get_type(current_argument) == js_like_type["Function"]):
            return current_argument(current_result)
        return None


    pipe_result = array_reduce(pipe_array_reduce_callback, rest_arguments, None)
    if (get_type(pipe_result) == js_like_type["Function"]):
        return pipe_result(pipe_last_result)
    return pipe_result


def json_stringify(anything, **optional_argument):
    '''custom JSON.stringify() function json_stringify_v2'''
    indent = " " * 4
    indent_level = 0
    pretty = pipe(optional_chaining(optional_argument, "pretty"), lambda _: nullish_coalescing(_, False))


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
            for object_entry_index, (object_key, object_value) in enumerate(anything_inner.items()):
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


# There's no JavaScript-like Array.find() in Python.
# But, we can create our own function to mimic it in Python.


def array_find_v1(callback_function, an_array):
    '''JavaScript-like Array.find() function array_find_v1'''
    data_found = None
    for array_item_index, array_item in enumerate(an_array):
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == True):
            data_found = array_item
            break
    return data_found


def array_find_v2(callback_function, an_array):
    '''JavaScript-like Array.find() function array_find_v2'''
    data_found = None
    for array_item_index, array_item in enumerate(an_array):
        if (callback_function(array_item, array_item_index, an_array) == True):
            data_found = array_item
            break
    return data_found


def array_find_v3(callback_function, an_array):
    '''JavaScript-like Array.find() function array_find_v3'''
    for array_item_index, array_item in enumerate(an_array):
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == True):
            return array_item
    return None


def array_find_v4(callback_function, an_array):
    '''JavaScript-like Array.find() function array_find_v4'''
    for array_item_index, array_item in enumerate(an_array):
        if (callback_function(array_item, array_item_index, an_array) == True):
            return array_item
    return None


print("\n# JavaScript-like Array.find() in Python list")

numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
print(f'numbers: {json_stringify(numbers)}')

print('# using JavaScript-like Array.find() function "array_find_v1"')

even_number_found = array_find_v1(lambda any_number, *_: ((any_number % 2) == 0), numbers)
print(f"even number found: {even_number_found}")
# even number found: 12

odd_number_found = array_find_v1(lambda any_number, *_: ((any_number % 2) != 0), numbers)
print(f"odd number found: {odd_number_found}")
# odd number found: 27

print('# using JavaScript-like Array.find() function "array_find_v2"')

even_number_found = array_find_v2(lambda any_number, *_: ((any_number % 2) == 0), numbers)
print(f"even number found: {even_number_found}")
# even number found: 12

odd_number_found = array_find_v2(lambda any_number, *_: ((any_number % 2) != 0), numbers)
print(f"odd number found: {odd_number_found}")
# odd number found: 27

print('# using JavaScript-like Array.find() function "array_find_v3"')

even_number_found = array_find_v3(lambda any_number, *_: ((any_number % 2) == 0), numbers)
print(f"even number found: {even_number_found}")
# even number found: 12

odd_number_found = array_find_v3(lambda any_number, *_: ((any_number % 2) != 0), numbers)
print(f"odd number found: {odd_number_found}")
# odd number found: 27

print('# using JavaScript-like Array.find() function "array_find_v4"')

even_number_found = array_find_v4(lambda any_number, *_: ((any_number % 2) == 0), numbers)
print(f"even number found: {even_number_found}")
# even number found: 12

odd_number_found = array_find_v4(lambda any_number, *_: ((any_number % 2) != 0), numbers)
print(f"odd number found: {odd_number_found}")
# odd number found: 27

print("\n# JavaScript-like Array.find() in Python list of dictionaries")

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

product_to_find = "bubble_gum"
print(f"product to find: {product_to_find}")

print('# using JavaScript-like Array.find() function "array_find_v1"')

product_found = array_find_v1(lambda any_product, *_: (any_product['code'] == product_to_find), products)
print(f"product found: {json_stringify(product_found, pretty=True)}")
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

print('# using JavaScript-like Array.find() function "array_find_v2"')

product_found = array_find_v2(lambda any_product, *_: (any_product['code'] == product_to_find), products)
print(f"product found: {json_stringify(product_found, pretty=True)}")
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

print('# using JavaScript-like Array.find() function "array_find_v3"')

product_found = array_find_v3(lambda any_product, *_: (any_product['code'] == product_to_find), products)
print(f"product found: {json_stringify(product_found, pretty=True)}")
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

print('# using JavaScript-like Array.find() function "array_find_v4"')

product_found = array_find_v4(lambda any_product, *_: (any_product['code'] == product_to_find), products)
print(f"product found: {json_stringify(product_found, pretty=True)}")
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }
