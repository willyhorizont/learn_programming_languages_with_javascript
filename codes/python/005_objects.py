import json

# in Python, JavaScript-like Object is called dict / dictionary

friend = {
    "name": "Alisa",
    "country": "Finland",
    "age": 25
}
print(f'friend: {json.dumps(friend, indent=4)}')

print(f"friend, get total object keys: {len(friend)}")
# friend, get total object keys: 3

print(f"friend, get country: {friend['country']}")
# friend, get country: Finland

# iterate over and get each key-value pair
for object_key, object_value in friend.items():
    print(f"friend, for loop, key: {object_key}, value: {object_value}")
# friend, for loop, key: name, value: Alisa
# friend, for loop, key: country, value: Finland
# friend, for loop, key: age, value: 25

# iterate over and get each key-value pair and object iteration/entry index
for object_entry_index, (object_key, object_value) in enumerate(friend.items()):
    print(f"friend, for loop, object iteration/entry index: {object_entry_index}, key: {object_key}, value: {object_value}")
# friend, for loop, object iteration/entry index: 0, key: name, value: Alisa
# friend, for loop, object iteration/entry index: 1, key: country, value: Finland
# friend, for loop, object iteration/entry index: 2, key: age, value: 25

friend["age"] = 27
print(f'friend: {json.dumps(friend, indent=4)}')

friend["gender"] = "Female"
print(f'friend: {json.dumps(friend, indent=4)}')

del friend["country"]
print(f'friend: {json.dumps(friend, indent=4)}')

# Computed property names: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Object_initializer#computed_property_names
delivery_response_key_message = "message"
delivery_response = {
    delivery_response_key_message: "ok"
}
print(f'delivery_response: {json.dumps(delivery_response, indent=4)}')
delivery_response_key_status = "status"
delivery_response[delivery_response_key_status] = 200
print(f'delivery_response: {json.dumps(delivery_response, indent=4)}')
