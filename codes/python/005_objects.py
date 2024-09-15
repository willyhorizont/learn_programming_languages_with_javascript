import json
from numbers import Number


def array_reduce(callback_function, an_array, initial_value):
    '''JavaScript-like Array.reduce() function'''
    result = initial_value
    for array_item_index, array_item in enumerate(an_array):
        result = callback_function(result, array_item, array_item_index, an_array)
    return result


# optional_chaining_v3
optional_chaining = lambda anything, *object_properties_array: anything if (((isinstance(anything, dict) == False) and (isinstance(anything, list) == False)) or (len(object_properties_array) == 0)) else array_reduce(lambda current_result, current_item, *_: anything.get(str(current_item)) if ((current_result is None) and (isinstance(anything, dict) == True) and (isinstance(current_item, str) == True)) else anything[int(current_item)] if ((current_result is None) and (isinstance(anything, list) == True) and (isinstance(current_item, Number) == True) and (int(current_item) >= 0) and (len(anything) > int(current_item))) else current_result.get(str(current_item)) if ((isinstance(current_result, dict) == True) and (isinstance(current_item, str) == True)) else current_result[int(current_item)] if ((isinstance(current_result, list) == True) and (isinstance(current_item, Number) == True) and (int(current_item) >= 0) and (len(current_result) > int(current_item))) else None, object_properties_array, None)

# nullish_coalescing_v2
nullish_coalescing = lambda anything, default_value: default_value if (anything is None) else anything

json_stringify = lambda anything, **optional_argument: (json.dumps(anything, indent=4)) if (nullish_coalescing(optional_chaining(optional_argument, "pretty"), False) == True) else (json.dumps(anything).replace("{", "{ ").replace("}", " }"))

print("# JavaScript-like Object in Python (dictionary)")

friend = {
    "name": "Alisa",
    "country": "Finland",
    "age": 25
}
print(f"friend: {json_stringify(friend, pretty=True)}")

print(f"friend, get total object keys: {len(friend)}")
# friend, get total object keys: 3

print(f'friend, get total object keys: {json_stringify(len(list(friend.keys())))}')
# friend, get total object keys: 3

print(f"friend, get country: {friend['country']}")
# friend, get country: Finland

print(f'friend, get country: {optional_chaining(friend, "country")}')
# friend, get country: Finland

# iterate over and print each key-value pair and object entry index
for object_entry_index, (object_key, object_value) in enumerate(friend.items()):
    print(f"friend, for loop, object entry index: {object_entry_index}, key: {object_key}, value: {object_value}")
# friend, for loop, object entry index: 0, key: name, value: Alisa
# friend, for loop, object entry index: 1, key: country, value: Finland
# friend, for loop, object entry index: 2, key: age, value: 25

friend["age"] = 27
print(f"friend: {json_stringify(friend, pretty=True)}")

friend["gender"] = "Female"
print(f"friend: {json_stringify(friend, pretty=True)}")

del friend["country"]
print(f"friend: {json_stringify(friend, pretty=True)}")

# Computed property names: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Object_initializer#computed_property_names
delivery_response_key_message = "message"
delivery_response = {
    delivery_response_key_message: "ok"
}
print(f"delivery_response: {json_stringify(delivery_response, pretty=True)}")
delivery_response_key_status = "status"
delivery_response[delivery_response_key_status] = 200
print(f"delivery_response: {json_stringify(delivery_response, pretty=True)}")
