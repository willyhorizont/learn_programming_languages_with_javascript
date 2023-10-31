import json
from numbers import Number
from functools import reduce

print('\n# JavaScript-like Optional Chaining Operator (?.) in Python')


def array_reduce(callback_function, an_array, initial_value):
    '''JavaScript-like Array.reduce() function'''
    result = None
    for array_item_index, array_item in enumerate(an_array):
        result = initial_value if result is None else result
        if isinstance(initial_value, list) == True:
            result = [] if result is None else result
            result = callback_function(result, array_item, array_item_index, an_array)
            continue
        if isinstance(initial_value, dict) == True:
            result = {} if result is None else result
            result = callback_function(result, array_item, array_item_index, an_array)
            continue
        if isinstance(initial_value, Number) == True:
            result = 0 if result is None else result
            result = callback_function(result, array_item, array_item_index, an_array)
            continue
        if isinstance(initial_value, str) == True:
            result = '' if result is None else result
            result = callback_function(result, array_item, array_item_index, an_array)
            continue
        if isinstance(initial_value, bool) == True:
            result = False if result is None else result
            result = callback_function(result, array_item, array_item_index, an_array)
            continue
        if initial_value is None:
            result = None if result is None else result
            result = callback_function(result, array_item, array_item_index, an_array)
            continue
    return result


def optional_chaining_v1(an_object={}, *object_properties_array):
    '''JavaScript-like Optional Chaining Operator (?.) function'''
    return array_reduce(lambda current_result, current_item, *_: an_object.get(current_item) if current_result is None else current_result.get(current_item), object_properties_array, None)


# JavaScript-like Optional Chaining Operator (?.) function
optional_chaining_v2 = lambda an_object={}, *object_properties_array: array_reduce(lambda current_result, current_item, *_: an_object.get(current_item) if current_result is None else current_result.get(current_item), object_properties_array, None)


def optional_chaining_v3(an_object={}, *object_properties_array):
    '''JavaScript-like Optional Chaining Operator (?.) function'''
    return reduce(lambda current_result, current_item: an_object.get(current_item) if current_result is None else current_result.get(current_item), object_properties_array, None)


# JavaScript-like Optional Chaining Operator (?.) function
optional_chaining_v4 = lambda an_object={}, *object_properties_array: reduce(lambda current_result, current_item: an_object.get(current_item) if current_result is None else current_result.get(current_item), object_properties_array, None)


def optional_chaining_v5(an_object={}, object_properties_string=''):
    '''JavaScript-like Optional Chaining Operator (?.) function'''
    object_properties_array = object_properties_string.split('.')
    return array_reduce(lambda current_result, current_item, *_: an_object.get(current_item) if current_result is None else current_result.get(current_item), object_properties_array, None)


# JavaScript-like Optional Chaining Operator (?.) function
optional_chaining_v6 = lambda an_object={}, object_properties_string='': array_reduce(lambda current_result, current_item, *_: an_object.get(current_item) if current_result is None else current_result.get(current_item), object_properties_string.split('.'), None)


def optional_chaining_v7(an_object={}, object_properties_string=''):
    '''JavaScript-like Optional Chaining Operator (?.) function'''
    object_properties_array = object_properties_string.split('.')
    return reduce(lambda current_result, current_item: an_object.get(current_item) if current_result is None else current_result.get(current_item), object_properties_array, None)


# JavaScript-like Optional Chaining Operator (?.) function
optional_chaining_v8 = lambda an_object={}, object_properties_string='': reduce(lambda current_result, current_item: an_object.get(current_item) if current_result is None else current_result.get(current_item), object_properties_string.split('.'), None)

JSON_OBJECT = {
    "foo": {
        "bar": "baz",
    }
}
print(f'JSON_OBJECT: {json.dumps(JSON_OBJECT, indent=4)}')

print('# using JavaScript-like Optional Chaining Operator (?.) function "optional_chaining_v1"')

print(f'JSON_OBJECT?.foo?.bar: {optional_chaining_v1(JSON_OBJECT, "foo", "bar")}')
# JSON_OBJECT?.foo?.bar: baz

print(f'JSON_OBJECT?.foo?.baz: {optional_chaining_v1(JSON_OBJECT, "foo", "baz")}')
# JSON_OBJECT?.foo?.bar: None

print('# using JavaScript-like Optional Chaining Operator (?.) function "optional_chaining_v2"')

print(f'JSON_OBJECT?.foo?.bar: {optional_chaining_v2(JSON_OBJECT, "foo", "bar")}')
# JSON_OBJECT?.foo?.bar: baz

print(f'JSON_OBJECT?.foo?.baz: {optional_chaining_v2(JSON_OBJECT, "foo", "baz")}')
# JSON_OBJECT?.foo?.bar: None

print('# using JavaScript-like Optional Chaining Operator (?.) function "optional_chaining_v3"')

print(f'JSON_OBJECT?.foo?.bar: {optional_chaining_v3(JSON_OBJECT, "foo", "bar")}')
# JSON_OBJECT?.foo?.bar: baz

print(f'JSON_OBJECT?.foo?.baz: {optional_chaining_v3(JSON_OBJECT, "foo", "baz")}')
# JSON_OBJECT?.foo?.bar: None

print('# using JavaScript-like Optional Chaining Operator (?.) function "optional_chaining_v4"')

print(f'JSON_OBJECT?.foo?.bar: {optional_chaining_v4(JSON_OBJECT, "foo", "bar")}')
# JSON_OBJECT?.foo?.bar: baz

print(f'JSON_OBJECT?.foo?.baz: {optional_chaining_v4(JSON_OBJECT, "foo", "baz")}')
# JSON_OBJECT?.foo?.bar: None

print('# using JavaScript-like Optional Chaining Operator (?.) function "optional_chaining_v5"')

print(f'JSON_OBJECT?.foo?.bar: {optional_chaining_v5(JSON_OBJECT, "foo.bar")}')
# JSON_OBJECT?.foo?.bar: baz

print(f'JSON_OBJECT?.foo?.baz: {optional_chaining_v5(JSON_OBJECT, "foo.baz")}')
# JSON_OBJECT?.foo?.bar: None

print('# using JavaScript-like Optional Chaining Operator (?.) function "optional_chaining_v6"')

print(f'JSON_OBJECT?.foo?.bar: {optional_chaining_v6(JSON_OBJECT, "foo.bar")}')
# JSON_OBJECT?.foo?.bar: baz

print(f'JSON_OBJECT?.foo?.baz: {optional_chaining_v6(JSON_OBJECT, "foo.baz")}')
# JSON_OBJECT?.foo?.bar: None

print('# using JavaScript-like Optional Chaining Operator (?.) function "optional_chaining_v7"')

print(f'JSON_OBJECT?.foo?.bar: {optional_chaining_v7(JSON_OBJECT, "foo.bar")}')
# JSON_OBJECT?.foo?.bar: baz

print(f'JSON_OBJECT?.foo?.baz: {optional_chaining_v7(JSON_OBJECT, "foo.baz")}')
# JSON_OBJECT?.foo?.bar: None

print('# using JavaScript-like Optional Chaining Operator (?.) function "optional_chaining_v8"')

print(f'JSON_OBJECT?.foo?.bar: {optional_chaining_v8(JSON_OBJECT, "foo.bar")}')
# JSON_OBJECT?.foo?.bar: baz

print(f'JSON_OBJECT?.foo?.baz: {optional_chaining_v8(JSON_OBJECT, "foo.baz")}')
# JSON_OBJECT?.foo?.bar: None

print('# change JavaScript-like Optional Chaining Operator (?.) function "optional_chaining_v6" to "qmd" to make it shorter')

# qmd stands for question mark dot / Optional Chaining Operator (?.)
qmd = optional_chaining_v6

print(f'JSON_OBJECT?.foo?.bar: {qmd(JSON_OBJECT, "foo.bar")}')
# JSON_OBJECT?.foo?.bar: baz

print(f'JSON_OBJECT?.foo?.baz: {qmd(JSON_OBJECT, "foo.baz")}')
# JSON_OBJECT?.foo?.bar: None
