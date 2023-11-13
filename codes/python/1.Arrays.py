# Array in Python

fruits = ["apple", "mango", "orange"]

print(f"fruits, length: {len(fruits)}")
# fruits, length: 3


for (array_item_index, array_item) in enumerate(fruits):
    print(f"fruits, for loop, index: {array_item_index}, value: {array_item}")


# fruits, for loop, index: 0, value: apple
# fruits, for loop, index: 1, value: mango
# fruits, for loop, index: 2, value: orange

# Array of Objects in Python

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

print(f"products, length: {len(products)}")
# products, length: 2

for array_item_index, array_item in enumerate(products):
    for object_key, object_value in array_item.items():
        print(f"products, loop, index: {array_item_index}, key: {object_key}, value: {object_value}")
# products, loop, index: 0, key: id, value: P1
# products, loop, index: 0, key: name, value: bubble gum
# products, loop, index: 1, key: id, value: P2
# products, loop, index: 1, key: name, value: potato chips
