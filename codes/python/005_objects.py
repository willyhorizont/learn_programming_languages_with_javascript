import json

# in Python, JavaScript-like Object is called dict / dictionary

friend = {
    "name": "Alisa",
    "country": "Finland",
    "age": 25
}
print(f'friend: {json.dumps(friend, indent=4)}')

print(f"friend, get country: {friend['country']}")
# friend, get country: Finland

print(f"friend, get total object keys: {len(friend)}")
# friend, get total object keys: 3

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
