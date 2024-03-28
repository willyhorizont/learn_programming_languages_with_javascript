import json
from numbers import Number

print('\n# JavaScript-like Nullish Coalescing Operator (??) in Python')

# There's no JavaScript-like Nullish Coalescing Operator (??) in Python.
# But, we can create our own function to mimic it in Python.


def array_reduce(callback_function, an_array, initial_value):
    '''JavaScript-like Array.reduce() function'''
    result = initial_value
    for array_item_index, array_item in enumerate(an_array):
        result = callback_function(result, array_item, array_item_index, an_array)
    return result


def optional_chaining_v1(anything, *object_properties_array):
    '''JavaScript-like Optional Chaining Operator (?.) function'''
    if (((isinstance(anything, dict) == False) and (isinstance(anything, list) == False)) or (len(object_properties_array) == 0)):
        return anything
    def array_reduce_callback(current_result, current_item, *_):
        if ((current_result is None) and (isinstance(anything, dict) == True) and (isinstance(current_item, str) == True)):
            return anything.get(str(current_item))
        if ((current_result is None) and (isinstance(anything, list) == True) and (isinstance(current_item, Number) == True) and (int(current_item) >= 0) and (len(anything) > int(current_item))):
            return anything[int(current_item)]
        if ((isinstance(current_result, dict) == True) and (isinstance(current_item, str) == True)):
            return current_result.get(str(current_item))
        if ((isinstance(current_result, list) == True) and (isinstance(current_item, Number) == True) and (int(current_item) >= 0) and (len(current_result) > int(current_item))):
            return current_result[int(current_item)]
        return None
    return array_reduce(array_reduce_callback, object_properties_array, None)


def nullish_coalescing_v1(anything, default_value):
    '''JavaScript-like Nullish Coalescing Operator (??) function'''
    return default_value if (anything is None) else anything


'''JavaScript-like Nullish Coalescing Operator (??) function'''
nullish_coalescing_v2 = lambda anything, default_value: default_value if (anything is None) else anything

JSON_OBJECT = {
    "foo": {
        "bar": "baz",
    },
    "fruits": ["apple", "mango", "banana"]
}
print(f'JSON_OBJECT: {json.dumps(JSON_OBJECT, indent=4)}')

print('# using JavaScript-like Nullish Coalescing Operator (??) function "nullish_coalescing_v1"')

print(f'(JSON_OBJECT?.foo?.bar ?? "not found") or (JSON_OBJECT?.["foo"]?.["bar"] ?? "not found"): {nullish_coalescing_v1(optional_chaining_v1(JSON_OBJECT, "foo", "bar"), "not found")}')
# (JSON_OBJECT?.foo?.bar ?? "not found") or (JSON_OBJECT?.["foo"]?.["bar"] ?? "not found"): baz

print(f'(JSON_OBJECT?.foo?.baz ?? "not found") or (JSON_OBJECT?.["foo"]?.["baz"] ?? "not found"): {nullish_coalescing_v1(optional_chaining_v1(JSON_OBJECT, "foo", "baz"), "not found")}')
# (JSON_OBJECT?.foo?.baz ?? "not found") or (JSON_OBJECT?.["foo"]?.["baz"] ?? "not found"): not found

print(f'(JSON_OBJECT?.fruits?.[2] ?? "not found") or (JSON_OBJECT?.["fruits"]?.[2] ?? "not found"): {nullish_coalescing_v1(optional_chaining_v1(JSON_OBJECT, "fruits", 2), "not found")}')
# (JSON_OBJECT?.fruits?.[2] ?? "not found") or (JSON_OBJECT?.["fruits"]?.[2] ?? "not found"): banana

print(f'(JSON_OBJECT?.fruits?.[5] ?? "not found") or (JSON_OBJECT?.["fruits"]?.[5] ?? "not found"): {nullish_coalescing_v1(optional_chaining_v1(JSON_OBJECT, "fruits", 5), "not found")}')
# (JSON_OBJECT?.fruits?.[5] ?? "not found") or (JSON_OBJECT?.["fruits"]?.[5] ?? "not found"): not found

print('# using JavaScript-like Nullish Coalescing Operator (??) function "nullish_coalescing_v2"')

print(f'(JSON_OBJECT?.foo?.bar ?? "not found") or (JSON_OBJECT?.["foo"]?.["bar"] ?? "not found"): {nullish_coalescing_v2(optional_chaining_v1(JSON_OBJECT, "foo", "bar"), "not found")}')
# (JSON_OBJECT?.foo?.bar ?? "not found") or (JSON_OBJECT?.["foo"]?.["bar"] ?? "not found"): baz

print(f'(JSON_OBJECT?.foo?.baz ?? "not found") or (JSON_OBJECT?.["foo"]?.["baz"] ?? "not found"): {nullish_coalescing_v2(optional_chaining_v1(JSON_OBJECT, "foo", "baz"), "not found")}')
# (JSON_OBJECT?.foo?.baz ?? "not found") or (JSON_OBJECT?.["foo"]?.["baz"] ?? "not found"): not found

print(f'(JSON_OBJECT?.fruits?.[2] ?? "not found") or (JSON_OBJECT?.["fruits"]?.[2] ?? "not found"): {nullish_coalescing_v2(optional_chaining_v1(JSON_OBJECT, "fruits", 2), "not found")}')
# (JSON_OBJECT?.fruits?.[2] ?? "not found") or (JSON_OBJECT?.["fruits"]?.[2] ?? "not found"): banana

print(f'(JSON_OBJECT?.fruits?.[5] ?? "not found") or (JSON_OBJECT?.["fruits"]?.[5] ?? "not found"): {nullish_coalescing_v2(optional_chaining_v1(JSON_OBJECT, "fruits", 5), "not found")}')
# (JSON_OBJECT?.fruits?.[5] ?? "not found") or (JSON_OBJECT?.["fruits"]?.[5] ?? "not found"): not found

print('# using Python Ternary Syntax And Python Walrus Operator (:=), the "pythonic" way')

print(f'(JSON_OBJECT?.foo?.bar ?? "not found") or (JSON_OBJECT?.["foo"]?.["bar"] ?? "not found"): {"not found" if (anything := optional_chaining_v1(JSON_OBJECT, "foo", "bar")) else anything}')
# (JSON_OBJECT?.foo?.bar ?? "not found") or (JSON_OBJECT?.["foo"]?.["bar"] ?? "not found"): baz

print(f'(JSON_OBJECT?.foo?.baz ?? "not found") or (JSON_OBJECT?.["foo"]?.["baz"] ?? "not found"): {"not found" if (anything := optional_chaining_v1(JSON_OBJECT, "foo", "baz")) else anything}')
# (JSON_OBJECT?.foo?.baz ?? "not found") or (JSON_OBJECT?.["foo"]?.["baz"] ?? "not found"): not found

print(f'(JSON_OBJECT?.fruits?.[2] ?? "not found") or (JSON_OBJECT?.["fruits"]?.[2] ?? "not found"): {"not found" if (anything := optional_chaining_v1(JSON_OBJECT, "fruits", 2)) else anything}')
# (JSON_OBJECT?.fruits?.[2] ?? "not found") or (JSON_OBJECT?.["fruits"]?.[2] ?? "not found"): banana

print(f'(JSON_OBJECT?.fruits?.[5] ?? "not found") or (JSON_OBJECT?.["fruits"]?.[5] ?? "not found"): {"not found" if (anything := optional_chaining_v1(JSON_OBJECT, "fruits", 5)) else anything}')
# (JSON_OBJECT?.fruits?.[5] ?? "not found") or (JSON_OBJECT?.["fruits"]?.[5] ?? "not found"): not found
