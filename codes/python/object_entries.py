import json

print('\n# JavaScript-like Object.entries() in Python dictionary')

friend = {
    "name": "Alisa",
    "country": "Finland",
    "age": 25
}
print(f'friend: {json.dumps(friend, indent=4)}')

print(f'friend entries: {json.dumps(list(friend.items()))}')
# friend entries: [["name", "Alisa"], ["country", "Finland"], ["age", 25]]
