import json
from functools import reduce


def array_reduce(callback_function, an_array, initial_value):
    '''JavaScript-like Array.reduce() function'''
    result = None
    for array_item_index, array_item in enumerate(an_array):
        result = initial_value if result is None else result

        if isinstance(initial_value, list):
            result = [] if result is None else result
            result = callback_function(result, array_item, array_item_index, an_array)
            continue

        if isinstance(initial_value, dict):
            result = {} if result is None else result
            result = callback_function(result, array_item, array_item_index, an_array)
            continue

        if isinstance(initial_value, int) or isinstance(initial_value, float):
            result = 0 if result is None else result
            result = callback_function(result, array_item, array_item_index, an_array)
            continue

        if isinstance(initial_value, str):
            result = '' if result is None else result
            result = callback_function(result, array_item, array_item_index, an_array)
            continue

        if isinstance(initial_value, bool):
            result = False if result is None else result
            result = callback_function(result, array_item, array_item_index, an_array)
            continue

        if initial_value is None:
            result = None if result is None else result
            result = callback_function(result, array_item, array_item_index, an_array)
            continue

    return result

def optional_chaining_v1(an_object={}, *object_properties):
    '''JavaScript-like Optional Chaining Operator (?.) function'''
    return reduce(lambda current_result, current_dictionary: an_object.get(current_dictionary) if current_result is None else current_result.get(current_dictionary), object_properties, None)


# JavaScript-like Optional Chaining Operator (?.) function
optional_chaining_v2 = lambda an_object={}, *object_properties: reduce(lambda current_result, current_dictionary: an_object.get(current_dictionary) if current_result is None else current_result.get(current_dictionary), object_properties, None)

def optional_chaining_v3(an_object={}, *object_properties):
    '''JavaScript-like Optional Chaining Operator (?.) function'''
    return array_reduce(lambda current_result, current_dictionary, *_: an_object.get(current_dictionary) if current_result is None else current_result.get(current_dictionary), object_properties, None)


# JavaScript-like Optional Chaining Operator (?.) function
optional_chaining_v4 = lambda an_object={}, *object_properties: array_reduce(lambda current_result, current_dictionary, *_: an_object.get(current_dictionary) if current_result is None else current_result.get(current_dictionary), object_properties, None)

def optional_chaining_v5(an_object={}, dictionary_properties_string_separated_by_dot=''):
    '''JavaScript-like Optional Chaining Operator (?.) function'''
    object_properties = dictionary_properties_string_separated_by_dot.split('.')
    return reduce(lambda current_result, current_dictionary: an_object.get(current_dictionary) if current_result is None else current_result.get(current_dictionary), object_properties, None)


# JavaScript-like Optional Chaining Operator (?.) function
optional_chaining_v6 = lambda an_object={}, dictionary_properties_string_separated_by_dot='': reduce(lambda current_result, current_dictionary: an_object.get(current_dictionary) if current_result is None else current_result.get(current_dictionary), dictionary_properties_string_separated_by_dot.split('.'), None)

def optional_chaining_v7(an_object={}, dictionary_properties_string_separated_by_dot=''):
    '''JavaScript-like Optional Chaining Operator (?.) function'''
    object_properties = dictionary_properties_string_separated_by_dot.split('.')
    return array_reduce(lambda current_result, current_dictionary, *_: an_object.get(current_dictionary) if current_result is None else current_result.get(current_dictionary), object_properties, None)


# JavaScript-like Optional Chaining Operator (?.) function
optional_chaining_v8 = lambda an_object={}, dictionary_properties_string_separated_by_dot='': array_reduce(lambda current_result, current_dictionary, *_: an_object.get(current_dictionary) if current_result is None else current_result.get(current_dictionary), dictionary_properties_string_separated_by_dot.split('.'), None)

print('\n# JavaScript-like Optional Chaining Operator (?.) in Python')

JSON_OBJECT = {
    "foo": {
        "bar": "baz",
    }
}
print(f'JSON_OBJECT: {json.dumps(JSON_OBJECT, indent=4)}')

print('# using JavaScript-like Optional Chaining Operator (?.) function "optional_chaining_v1"')
print(f'JSON_OBJECT?.foo?.bar: {optional_chaining_v1(JSON_OBJECT, "foo", "bar")}')
# JSON_OBJECT?.foo?.bar: baz

print('# using JavaScript-like Optional Chaining Operator (?.) function "optional_chaining_v1"')
print(f'JSON_OBJECT?.foo?.baz: {optional_chaining_v1(JSON_OBJECT, "foo", "baz")}')
# JSON_OBJECT?.foo?.bar: None

print('# using JavaScript-like Optional Chaining Operator (?.) function "optional_chaining_v2"')
print(f'JSON_OBJECT?.foo?.bar: {optional_chaining_v2(JSON_OBJECT, "foo", "bar")}')
# JSON_OBJECT?.foo?.bar: baz

print('# using JavaScript-like Optional Chaining Operator (?.) function "optional_chaining_v2"')
print(f'JSON_OBJECT?.foo?.baz: {optional_chaining_v2(JSON_OBJECT, "foo", "baz")}')
# JSON_OBJECT?.foo?.bar: None

print('# using JavaScript-like Optional Chaining Operator (?.) function "optional_chaining_v3"')
print(f'JSON_OBJECT?.foo?.bar: {optional_chaining_v3(JSON_OBJECT, "foo", "bar")}')
# JSON_OBJECT?.foo?.bar: baz

print('# using JavaScript-like Optional Chaining Operator (?.) function "optional_chaining_v3"')
print(f'JSON_OBJECT?.foo?.baz: {optional_chaining_v3(JSON_OBJECT, "foo", "baz")}')
# JSON_OBJECT?.foo?.bar: None

print('# using JavaScript-like Optional Chaining Operator (?.) function "optional_chaining_v4"')
print(f'JSON_OBJECT?.foo?.bar: {optional_chaining_v4(JSON_OBJECT, "foo", "bar")}')
# JSON_OBJECT?.foo?.bar: baz

print('# using JavaScript-like Optional Chaining Operator (?.) function "optional_chaining_v4"')
print(f'JSON_OBJECT?.foo?.baz: {optional_chaining_v4(JSON_OBJECT, "foo", "baz")}')
# JSON_OBJECT?.foo?.bar: None

print('# using JavaScript-like Optional Chaining Operator (?.) function "optional_chaining_v5"')
print(f'JSON_OBJECT?.foo?.bar: {optional_chaining_v5(JSON_OBJECT, "foo.bar")}')
# JSON_OBJECT?.foo?.bar: baz

print('# using JavaScript-like Optional Chaining Operator (?.) function "optional_chaining_v5"')
print(f'JSON_OBJECT?.foo?.baz: {optional_chaining_v5(JSON_OBJECT, "foo.baz")}')
# JSON_OBJECT?.foo?.bar: None

print('# using JavaScript-like Optional Chaining Operator (?.) function "optional_chaining_v6"')
print(f'JSON_OBJECT?.foo?.bar: {optional_chaining_v6(JSON_OBJECT, "foo.bar")}')
# JSON_OBJECT?.foo?.bar: baz

print('# using JavaScript-like Optional Chaining Operator (?.) function "optional_chaining_v6"')
print(f'JSON_OBJECT?.foo?.baz: {optional_chaining_v6(JSON_OBJECT, "foo.baz")}')
# JSON_OBJECT?.foo?.bar: None

print('# using JavaScript-like Optional Chaining Operator (?.) function "optional_chaining_v7"')
print(f'JSON_OBJECT?.foo?.bar: {optional_chaining_v7(JSON_OBJECT, "foo.bar")}')
# JSON_OBJECT?.foo?.bar: baz

print('# using JavaScript-like Optional Chaining Operator (?.) function "optional_chaining_v7"')
print(f'JSON_OBJECT?.foo?.baz: {optional_chaining_v7(JSON_OBJECT, "foo.baz")}')
# JSON_OBJECT?.foo?.bar: None

print('# using JavaScript-like Optional Chaining Operator (?.) function "optional_chaining_v8"')
print(f'JSON_OBJECT?.foo?.bar: {optional_chaining_v8(JSON_OBJECT, "foo.bar")}')
# JSON_OBJECT?.foo?.bar: baz

print('# using JavaScript-like Optional Chaining Operator (?.) function "optional_chaining_v8"')
print(f'JSON_OBJECT?.foo?.baz: {optional_chaining_v8(JSON_OBJECT, "foo.baz")}')
# JSON_OBJECT?.foo?.bar: None
