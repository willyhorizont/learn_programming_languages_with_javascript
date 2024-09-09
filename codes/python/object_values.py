import json

print('\n# JavaScript-like Object.values() in Python dictionary')

friend = {
    "name": "Alisa",
    "country": "Finland",
    "age": 25
}
print(f'friend: {json.dumps(friend, indent=4)}')

print(f'friend values: {json.dumps(list(friend.values()))}')
# friend values: ["Alisa", "Finland", 25]
