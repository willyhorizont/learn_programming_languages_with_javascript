import json
from numbers import Number

print('\n# JavaScript-like Nullish Coalescing Operator (??) in Python')

# There's no JavaScript-like Nullish Coalescing Operator (??) in Python.
# But, we can create our own function to mimic it in Python.


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


# JavaScript-like Optional Chaining Operator (?.) function
qmd = lambda an_object={}, object_properties_string='': array_reduce(lambda current_result, current_item, *_: an_object.get(current_item) if current_result is None else current_result.get(current_item), object_properties_string.split('.'), None)


def nullish_coalescing_v1(an_object={}, object_properties_string='', default_value=None):
    '''JavaScript-like Nullish Coalescing Operator (??) function'''
    value = qmd(an_object, object_properties_string)
    return default_value if value is None else value


def nullish_coalescing_v2(an_object={}, object_properties_string='', default_value=None):
    '''JavaScript-like Nullish Coalescing Operator (??) function'''
    return default_value if (value := qmd(an_object, object_properties_string)) is None else value


'''JavaScript-like Nullish Coalescing Operator (??) function'''
nullish_coalescing_v3 = lambda an_object={}, object_properties_string='', default_value=None: default_value if (value := qmd(an_object, object_properties_string)) is None else value

JSON_OBJECT = {
    "foo": {
        "bar": "baz",
    }
}
print(f'JSON_OBJECT: {json.dumps(JSON_OBJECT, indent=4)}')

print('# using JavaScript-like Nullish Coalescing Operator (??) function "nullish_coalescing_v1"')

print(f'JSON_OBJECT?.foo?.bar: {nullish_coalescing_v1(JSON_OBJECT, "foo.bar", "not found")}')
# JSON_OBJECT?.foo?.bar: baz

print(f'JSON_OBJECT?.foo?.baz: {nullish_coalescing_v1(JSON_OBJECT, "foo.baz", "not found")}')
# JSON_OBJECT?.foo?.baz: not found

print('# using JavaScript-like Nullish Coalescing Operator (??) function "nullish_coalescing_v2"')

print(f'JSON_OBJECT?.foo?.bar: {nullish_coalescing_v2(JSON_OBJECT, "foo.bar", "not found")}')
# JSON_OBJECT?.foo?.bar: baz

print(f'JSON_OBJECT?.foo?.baz: {nullish_coalescing_v2(JSON_OBJECT, "foo.baz", "not found")}')
# JSON_OBJECT?.foo?.baz: not found

print('# using JavaScript-like Nullish Coalescing Operator (??) function "nullish_coalescing_v3"')

print(f'JSON_OBJECT?.foo?.bar: {nullish_coalescing_v3(JSON_OBJECT, "foo.bar", "not found")}')
# JSON_OBJECT?.foo?.bar: baz

print(f'JSON_OBJECT?.foo?.baz: {nullish_coalescing_v3(JSON_OBJECT, "foo.baz", "not found")}')
# JSON_OBJECT?.foo?.baz: not found

print('# change JavaScript-like Nullish Coalescing Operator (??) function "nullish_coalescing_v3" to "dqm" to make it shorter')

# dqm stands for double question mark / Nullish Coalescing Operator (??)
dqm = nullish_coalescing_v3

print(f'JSON_OBJECT?.foo?.bar: {dqm(JSON_OBJECT, "foo.bar", "not found")}')
# JSON_OBJECT?.foo?.bar: baz

print(f'JSON_OBJECT?.foo?.baz: {dqm(JSON_OBJECT, "foo.baz", "not found")}')
# JSON_OBJECT?.foo?.baz: not found

print('# using the "pythonic" way')

print(f'JSON_OBJECT?.foo?.bar: {"not found" if (result := qmd(JSON_OBJECT, "foo.bar")) is None else result}')
# JSON_OBJECT?.foo?.bar: baz

print(f'JSON_OBJECT?.foo?.baz: {"not found" if (result := qmd(JSON_OBJECT, "foo.baz")) is None else result}')
# JSON_OBJECT?.foo?.baz: not found
