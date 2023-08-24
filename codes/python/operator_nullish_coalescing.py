import json


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


# JavaScript-like Optional Chaining Operator (?.) function
optional_chaining = lambda an_object={}, dictionary_properties_string_separated_by_dot='': array_reduce(lambda current_result, current_dictionary, *_: an_object.get(current_dictionary) if current_result is None else current_result.get(current_dictionary), dictionary_properties_string_separated_by_dot.split('.'), None)

def nullish_coalescing_v1(value, default_value):
    '''JavaScript-like Nullish Coalescing Operator (??) function'''
    return default_value if value is None else value

# JavaScript-like Nullish Coalescing Operator (??) function
nullish_coalescing_v2 = lambda value, default_value: default_value if value is None else value

print('\n# JavaScript-like Nullish Coalescing Operator (??) in Python')

JSON_OBJECT = {
    "foo": {
        "bar": "baz",
    }
}
print(f'JSON_OBJECT: {json.dumps(JSON_OBJECT, indent=4)}')

print('# using JavaScript-like Nullish Coalescing Operator (??) function "nullish_coalescing_v1"')
print(f'JSON_OBJECT?.foo?.bar: {nullish_coalescing_v1(optional_chaining(JSON_OBJECT, "foo.bar"), "not found")}')
# JSON_OBJECT?.foo?.bar: baz

print('# using JavaScript-like Nullish Coalescing Operator (??) function "nullish_coalescing_v1"')
print(f'JSON_OBJECT?.foo?.baz: {nullish_coalescing_v1(optional_chaining(JSON_OBJECT, "foo.baz"), "not found")}')
# JSON_OBJECT?.foo?.bar: not found

print('# using JavaScript-like Nullish Coalescing Operator (??) function "nullish_coalescing_v2"')
print(f'JSON_OBJECT?.foo?.bar: {nullish_coalescing_v2(optional_chaining(JSON_OBJECT, "foo.bar"), "not found")}')
# JSON_OBJECT?.foo?.bar: baz

print('# using JavaScript-like Nullish Coalescing Operator (??) function "nullish_coalescing_v2"')
print(f'JSON_OBJECT?.foo?.baz: {nullish_coalescing_v2(optional_chaining(JSON_OBJECT, "foo.baz"), "not found")}')
# JSON_OBJECT?.foo?.bar: not found

print('# using the "pythonic" way')
print(f'JSON_OBJECT?.foo?.bar: {"not found" if (result := optional_chaining(JSON_OBJECT, "foo.bar")) is None else result}')
# JSON_OBJECT?.foo?.bar: baz

print('# using the "pythonic" way')
print(f'JSON_OBJECT?.foo?.baz: {"not found" if (result := optional_chaining(JSON_OBJECT, "foo.baz")) is None else result}')
# JSON_OBJECT?.foo?.bar: not found
