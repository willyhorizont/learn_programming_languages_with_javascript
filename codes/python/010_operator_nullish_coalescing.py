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


print("\n# JavaScript-like Nullish Coalescing Operator (??) in Python")

# There's no JavaScript-like Nullish Coalescing Operator (??) in Python.
# But, we can create our own function to mimic it in Python.


def nullish_coalescing_v1(anything, default_value):
    '''JavaScript-like Nullish Coalescing Operator (??) function nullish_coalescing_v1'''
    return (default_value if (is_like_js_null(anything) == True) else anything)


nullish_coalescing_v2 = lambda anything, default_value: (default_value if (is_like_js_null(anything) == True) else anything)  # '''JavaScript-like Nullish Coalescing Operator (??) function nullish_coalescing_v2'''

JSON_OBJECT = {
    "foo": {
        "bar": "baz",
    },
    "fruits": ["apple", "mango", "banana"],
    "get_rectangle_area": lambda rectangle_width, rectangle_length: (rectangle_width * rectangle_length)
}
print(f'JSON_OBJECT: {json_stringify(JSON_OBJECT, pretty=True)}')

print('# using JavaScript-like Nullish Coalescing Operator (??) function "nullish_coalescing_v1"')

print(f'(JSON_OBJECT?.foo?.bar ?? "not found") or (JSON_OBJECT?.["foo"]?.["bar"] ?? "not found"): {json_stringify(nullish_coalescing_v1(optional_chaining(lambda: JSON_OBJECT["foo"]["bar"]), "not found"))}')
# (JSON_OBJECT?.foo?.bar ?? "not found") or (JSON_OBJECT?.["foo"]?.["bar"] ?? "not found"): "baz"

print(f'(JSON_OBJECT?.foo?.baz ?? "not found") or (JSON_OBJECT?.["foo"]?.["baz"] ?? "not found"): {json_stringify(nullish_coalescing_v1(optional_chaining(lambda: JSON_OBJECT["foo"]["baz"]), "not found"))}')
# (JSON_OBJECT?.foo?.baz ?? "not found") or (JSON_OBJECT?.["foo"]?.["baz"] ?? "not found"): "not found"

print(f'(JSON_OBJECT?.fruits?.[2] ?? "not found") or (JSON_OBJECT?.["fruits"]?.[2] ?? "not found"): {json_stringify(nullish_coalescing_v1(optional_chaining(lambda: JSON_OBJECT["fruits"][2]), "not found"))}')
# (JSON_OBJECT?.fruits?.[2] ?? "not found") or (JSON_OBJECT?.["fruits"]?.[2] ?? "not found"): "banana"

print(f'(JSON_OBJECT?.fruits?.[5] ?? "not found") or (JSON_OBJECT?.["fruits"]?.[5] ?? "not found"): {json_stringify(nullish_coalescing_v1(optional_chaining(lambda: JSON_OBJECT["fruits"][5]), "not found"))}')
# (JSON_OBJECT?.fruits?.[5] ?? "not found") or (JSON_OBJECT?.["fruits"]?.[5] ?? "not found"): "not found"

print(f'(JSON_OBJECT?.get_rectangle_area?.(7, 5) ?? "not found") or (JSON_OBJECT?.["get_rectangle_area"]?.(7, 5) ?? "not found"): {json_stringify(nullish_coalescing_v1(optional_chaining(lambda: JSON_OBJECT["get_rectangle_area"](7, 5)), "not found"))}')
# (JSON_OBJECT?.get_rectangle_area?.(7, 5) ?? "not found") or (JSON_OBJECT?.["get_rectangle_area"]?.(7, 5) ?? "not found"): 35

print(f'(JSON_OBJECT?.get_circle_area?.(7) ?? "not found") or (JSON_OBJECT?.["get_circle_area"]?.(7) ?? "not found"): {json_stringify(nullish_coalescing_v1(optional_chaining(lambda: JSON_OBJECT["get_circle_area"](7)), "not found"))}')
# (JSON_OBJECT?.get_circle_area?.(7) ?? "not found") or (JSON_OBJECT?.["get_circle_area"]?.(7) ?? "not found"): "not found"

print('# using JavaScript-like Nullish Coalescing Operator (??) function "nullish_coalescing_v2"')

print(f'(JSON_OBJECT?.foo?.bar ?? "not found") or (JSON_OBJECT?.["foo"]?.["bar"] ?? "not found"): {json_stringify(nullish_coalescing_v2(optional_chaining(lambda: JSON_OBJECT["foo"]["bar"]), "not found"))}')
# (JSON_OBJECT?.foo?.bar ?? "not found") or (JSON_OBJECT?.["foo"]?.["bar"] ?? "not found"): "baz"

print(f'(JSON_OBJECT?.foo?.baz ?? "not found") or (JSON_OBJECT?.["foo"]?.["baz"] ?? "not found"): {json_stringify(nullish_coalescing_v2(optional_chaining(lambda: JSON_OBJECT["foo"]["baz"]), "not found"))}')
# (JSON_OBJECT?.foo?.baz ?? "not found") or (JSON_OBJECT?.["foo"]?.["baz"] ?? "not found"): "not found"

print(f'(JSON_OBJECT?.fruits?.[2] ?? "not found") or (JSON_OBJECT?.["fruits"]?.[2] ?? "not found"): {json_stringify(nullish_coalescing_v2(optional_chaining(lambda: JSON_OBJECT["fruits"][2]), "not found"))}')
# (JSON_OBJECT?.fruits?.[2] ?? "not found") or (JSON_OBJECT?.["fruits"]?.[2] ?? "not found"): "banana"

print(f'(JSON_OBJECT?.fruits?.[5] ?? "not found") or (JSON_OBJECT?.["fruits"]?.[5] ?? "not found"): {json_stringify(nullish_coalescing_v2(optional_chaining(lambda: JSON_OBJECT["fruits"][5]), "not found"))}')
# (JSON_OBJECT?.fruits?.[5] ?? "not found") or (JSON_OBJECT?.["fruits"]?.[5] ?? "not found"): "not found"

print(f'(JSON_OBJECT?.get_rectangle_area?.(7, 5) ?? "not found") or (JSON_OBJECT?.["get_rectangle_area"]?.(7, 5) ?? "not found"): {json_stringify(nullish_coalescing_v2(optional_chaining(lambda: JSON_OBJECT["get_rectangle_area"](7, 5)), "not found"))}')
# (JSON_OBJECT?.get_rectangle_area?.(7, 5) ?? "not found") or (JSON_OBJECT?.["get_rectangle_area"]?.(7, 5) ?? "not found"): 35

print(f'(JSON_OBJECT?.get_circle_area?.(7) ?? "not found") or (JSON_OBJECT?.["get_circle_area"]?.(7) ?? "not found"): {json_stringify(nullish_coalescing_v2(optional_chaining(lambda: JSON_OBJECT["get_circle_area"](7)), "not found"))}')
# (JSON_OBJECT?.get_circle_area?.(7) ?? "not found") or (JSON_OBJECT?.["get_circle_area"]?.(7) ?? "not found"): "not found"
