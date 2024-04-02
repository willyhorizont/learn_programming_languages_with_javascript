import json

# in Python, JavaScript-like Array is called list

fruits = ["apple", "mango", "orange"]
print(f'fruits: {json.dumps(fruits)}')

print(f"fruits, length: {len(fruits)}")
# fruits, length: 3

print(f"fruits, get mango: {fruits[1]}")
# fruits, get mango: mango

print(f"fruits, first element: {fruits[0]}")
# fruits, first element: apple

print(f"fruits, last element: {fruits[-1]}")
# fruits, last element: orange


for (array_item_index, array_item) in enumerate(fruits):
    print(f"fruits, for loop, index: {array_item_index}, value: {array_item}")


# fruits, for loop, index: 0, value: apple
# fruits, for loop, index: 1, value: mango
# fruits, for loop, index: 2, value: orange

# in Python, JavaScript-like Array of Objects is called list of dictionaries

products = [
    {
        "id": "P1",
        "name": "bubble gum"
    },
    {
        "id": "P2",
        "name": "potato chips"
    }
]
print(f'products: {json.dumps(products, indent=4)}')

for array_item_index, array_item in enumerate(products):
    for object_entry_index, (object_key, object_value) in enumerate(array_item.items()):
        print(f"products, for loop, array item index: {array_item_index}, object iteration/entry index: {object_entry_index}, key: {object_key}, value: {object_value}")
# products, for loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
# products, for loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
# products, for loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
# products, for loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips
