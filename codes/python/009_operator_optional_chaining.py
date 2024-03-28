import json
from numbers import Number
from functools import reduce

print('\n# JavaScript-like Optional Chaining Operator (?.) in Python')

# There's no JavaScript-like Optional Chaining Operator (?.) in Python.
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


def optional_chaining_v2(anything, *object_properties_array):
    '''JavaScript-like Optional Chaining Operator (?.) function'''
    if (((isinstance(anything, dict) == False) and (isinstance(anything, list) == False)) or (len(object_properties_array) == 0)):
        return anything
    def array_reduce_callback(current_result, current_item):
        if ((current_result is None) and (isinstance(anything, dict) == True) and (isinstance(current_item, str) == True)):
            return anything.get(str(current_item))
        if ((current_result is None) and (isinstance(anything, list) == True) and (isinstance(current_item, Number) == True) and (int(current_item) >= 0) and (len(anything) > int(current_item))):
            return anything[int(current_item)]
        if ((isinstance(current_result, dict) == True) and (isinstance(current_item, str) == True)):
            return current_result.get(str(current_item))
        if ((isinstance(current_result, list) == True) and (isinstance(current_item, Number) == True) and (int(current_item) >= 0) and (len(current_result) > int(current_item))):
            return current_result[int(current_item)]
        return None
    return reduce(array_reduce_callback, object_properties_array, None)


'''JavaScript-like Optional Chaining Operator (?.) function'''
optional_chaining_v3 = lambda anything, *object_properties_array: anything if (((isinstance(anything, dict) == False) and (isinstance(anything, list) == False)) or (len(object_properties_array) == 0)) else array_reduce(lambda current_result, current_item, *_: anything.get(str(current_item)) if ((current_result is None) and (isinstance(anything, dict) == True) and (isinstance(current_item, str) == True)) else anything[int(current_item)] if ((current_result is None) and (isinstance(anything, list) == True) and (isinstance(current_item, Number) == True) and (int(current_item) >= 0) and (len(anything) > int(current_item))) else current_result.get(str(current_item)) if ((isinstance(current_result, dict) == True) and (isinstance(current_item, str) == True)) else current_result[int(current_item)] if ((isinstance(current_result, list) == True) and (isinstance(current_item, Number) == True) and (int(current_item) >= 0) and (len(current_result) > int(current_item))) else None, object_properties_array, None)

'''JavaScript-like Optional Chaining Operator (?.) function'''
optional_chaining_v4 = lambda anything, *object_properties_array: anything if (((isinstance(anything, dict) == False) and (isinstance(anything, list) == False)) or (len(object_properties_array) == 0)) else reduce(lambda current_result, current_item: anything.get(str(current_item)) if ((current_result is None) and (isinstance(anything, dict) == True) and (isinstance(current_item, str) == True)) else anything[int(current_item)] if ((current_result is None) and (isinstance(anything, list) == True) and (isinstance(current_item, Number) == True) and (int(current_item) >= 0) and (len(anything) > int(current_item))) else current_result.get(str(current_item)) if ((isinstance(current_result, dict) == True) and (isinstance(current_item, str) == True)) else current_result[int(current_item)] if ((isinstance(current_result, list) == True) and (isinstance(current_item, Number) == True) and (int(current_item) >= 0) and (len(current_result) > int(current_item))) else None, object_properties_array, None)


JSON_OBJECT = {
    "foo": {
        "bar": "baz",
    },
    "fruits": ["apple", "mango", "banana"]
}
print(f'JSON_OBJECT: {json.dumps(JSON_OBJECT, indent=4)}')

print('# using JavaScript-like Optional Chaining Operator (?.) function "optional_chaining_v1"')

print(f'JSON_OBJECT?.foo?.bar or JSON_OBJECT?.["foo"]?.["bar"]: {optional_chaining_v1(JSON_OBJECT, "foo", "bar")}')
# JSON_OBJECT?.foo?.bar or JSON_OBJECT?.["foo"]?.["bar"]: baz

print(f'JSON_OBJECT?.foo?.baz or JSON_OBJECT?.["foo"]?.["baz"]: {optional_chaining_v1(JSON_OBJECT, "foo", "baz")}')
# JSON_OBJECT?.foo?.baz or JSON_OBJECT?.["foo"]?.["baz"]: None

print(f'JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.["fruits"]?.[2]: {optional_chaining_v1(JSON_OBJECT, "fruits", 2)}')
# JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.["fruits"]?.[2]: banana

print(f'JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.["fruits"]?.[5]: {optional_chaining_v1(JSON_OBJECT, "fruits", 5)}')
# JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.["fruits"]?.[5]: None

print('# using JavaScript-like Optional Chaining Operator (?.) function "optional_chaining_v2"')

print(f'JSON_OBJECT?.foo?.bar or JSON_OBJECT?.["foo"]?.["bar"]: {optional_chaining_v2(JSON_OBJECT, "foo", "bar")}')
# JSON_OBJECT?.foo?.bar or JSON_OBJECT?.["foo"]?.["bar"]: baz

print(f'JSON_OBJECT?.foo?.baz or JSON_OBJECT?.["foo"]?.["baz"]: {optional_chaining_v2(JSON_OBJECT, "foo", "baz")}')
# JSON_OBJECT?.foo?.baz or JSON_OBJECT?.["foo"]?.["baz"]: None

print(f'JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.["fruits"]?.[2]: {optional_chaining_v2(JSON_OBJECT, "fruits", 2)}')
# JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.["fruits"]?.[2]: banana

print(f'JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.["fruits"]?.[5]: {optional_chaining_v2(JSON_OBJECT, "fruits", 5)}')
# JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.["fruits"]?.[5]: None

print('# using JavaScript-like Optional Chaining Operator (?.) function "optional_chaining_v3"')

print(f'JSON_OBJECT?.foo?.bar or JSON_OBJECT?.["foo"]?.["bar"]: {optional_chaining_v3(JSON_OBJECT, "foo", "bar")}')
# JSON_OBJECT?.foo?.bar or JSON_OBJECT?.["foo"]?.["bar"]: baz

print(f'JSON_OBJECT?.foo?.baz or JSON_OBJECT?.["foo"]?.["baz"]: {optional_chaining_v3(JSON_OBJECT, "foo", "baz")}')
# JSON_OBJECT?.foo?.baz or JSON_OBJECT?.["foo"]?.["baz"]: None

print(f'JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.["fruits"]?.[2]: {optional_chaining_v3(JSON_OBJECT, "fruits", 2)}')
# JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.["fruits"]?.[2]: banana

print(f'JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.["fruits"]?.[5]: {optional_chaining_v3(JSON_OBJECT, "fruits", 5)}')
# JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.["fruits"]?.[5]: None

print('# using JavaScript-like Optional Chaining Operator (?.) function "optional_chaining_v4"')

print(f'JSON_OBJECT?.foo?.bar or JSON_OBJECT?.["foo"]?.["bar"]: {optional_chaining_v4(JSON_OBJECT, "foo", "bar")}')
# JSON_OBJECT?.foo?.bar or JSON_OBJECT?.["foo"]?.["bar"]: baz

print(f'JSON_OBJECT?.foo?.baz or JSON_OBJECT?.["foo"]?.["baz"]: {optional_chaining_v4(JSON_OBJECT, "foo", "baz")}')
# JSON_OBJECT?.foo?.baz or JSON_OBJECT?.["foo"]?.["baz"]: None

print(f'JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.["fruits"]?.[2]: {optional_chaining_v4(JSON_OBJECT, "fruits", 2)}')
# JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.["fruits"]?.[2]: banana

print(f'JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.["fruits"]?.[5]: {optional_chaining_v4(JSON_OBJECT, "fruits", 5)}')
# JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.["fruits"]?.[5]: None
