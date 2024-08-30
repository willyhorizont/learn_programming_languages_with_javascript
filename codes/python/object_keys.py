import json

print('\n# JavaScript-like Object.keys() in Python dictionary')

friend = {
    "name": "Alisa",
    "country": "Finland",
    "age": 25
}
print(f'friend: {json.dumps(friend, indent=4)}')

print(f'friend keys: {json.dumps(list(friend.keys()))}')
# friend keys: ["name", "country", "age"]
