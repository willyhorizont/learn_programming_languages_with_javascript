import json

print('\n# JavaScript-like Nullish Coalescing Operator (??) in Python')

# There's no JavaScript-like Nullish Coalescing Operator (??) in Python.
# But, we can create our own function to mimic it in Python.


def array_reduce(callback_function, an_array, initial_value):
    '''JavaScript-like Array.reduce() function'''
    result = None
    for array_item_index, array_item in enumerate(an_array):
        result = callback_function(initial_value if (array_item_index == 0) else result, array_item, array_item_index, an_array)
    return result


# JavaScript-like Optional Chaining Operator (?.) function
optional_chaining_v6 = lambda an_object={}, object_properties_string='': array_reduce(lambda current_result, current_item, *_: an_object.get(current_item) if current_result is None else current_result.get(current_item), object_properties_string.split('.'), None)


def nullish_coalescing_v1(anything, default_value):
    '''JavaScript-like Nullish Coalescing Operator (??) function'''
    return default_value if anything is None else anything


'''JavaScript-like Nullish Coalescing Operator (??) function'''
nullish_coalescing_v2 = lambda anything, default_value: default_value if anything is None else anything

JSON_OBJECT = {
    "foo": {
        "bar": "baz",
    }
}
print(f'JSON_OBJECT: {json.dumps(JSON_OBJECT, indent=4)}')

print('# using JavaScript-like Nullish Coalescing Operator (??) function "nullish_coalescing_v1"')

print(f'JSON_OBJECT?.foo?.bar ?? \"not found\": {nullish_coalescing_v1(optional_chaining_v6(JSON_OBJECT, "foo.bar"), "not found")}')
# JSON_OBJECT?.foo?.bar ?? "not found": baz

print(f'JSON_OBJECT?.foo?.baz ?? \"not found\": {nullish_coalescing_v1(optional_chaining_v6(JSON_OBJECT, "foo.baz"), "not found")}')
# JSON_OBJECT?.foo?.baz ?? "not found": not found

print('# using JavaScript-like Nullish Coalescing Operator (??) function "nullish_coalescing_v2"')

print(f'JSON_OBJECT?.foo?.bar ?? \"not found\": {nullish_coalescing_v2(optional_chaining_v6(JSON_OBJECT, "foo.bar"), "not found")}')
# JSON_OBJECT?.foo?.bar ?? "not found": baz

print(f'JSON_OBJECT?.foo?.baz ?? \"not found\": {nullish_coalescing_v2(optional_chaining_v6(JSON_OBJECT, "foo.baz"), "not found")}')
# JSON_OBJECT?.foo?.baz ?? "not found": not found
