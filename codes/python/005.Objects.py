import json

friend = {
    "name": "Alisa",
    "country": "Finland",
    "age": 25
}
print(f'friend: {json.dumps(friend, indent=4)}')

print(f"friend, get country: {friend['country']}")
# friend, get country: Finland

# iterate over and get each key-value pair
for object_key, object_value in friend.items():
    print(f"friend, for loop, key: {object_key}, value: {object_value}")
# friend, for loop, key: name, value: Alisa
# friend, for loop, key: country, value: Finland
# friend, for loop, key: age, value: 25

# iterate over and get each key-value pair and iteration/entry index
for iteration_index, (object_key, object_value) in enumerate(friend.items()):
    print(f"friend, for loop, index: {iteration_index}, key: {object_key}, value: {object_value}")
# friend, for loop, index: 0, key: name, value: Alisa
# friend, for loop, index: 1, key: country, value: Finland
# friend, for loop, index: 2, key: age, value: 25
