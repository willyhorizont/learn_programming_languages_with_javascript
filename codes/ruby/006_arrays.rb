require "json"

# in Ruby, JavaScript-like Array is called Array

fruits = ["apple", "mango", "orange"]
print("\n", "fruits: ", fruits)

print("fruits, length: #{fruits.size}\n")
# fruits, length: 3

print("fruits, length: #{fruits.size()}\n")
# fruits, length: 3

print("fruits, get mango: #{fruits[1]}\n")
# fruits, get mango: mango

print("fruits, first element: #{fruits[0]}\n")
# fruits, first element: apple

print("fruits, first element: #{fruits.first}\n")
# fruits, first element: apple

print("fruits, first element: #{fruits.first()}\n")
# fruits, first element: apple

print("fruits, last element: #{fruits[-1]}\n")
# fruits, last element: orange

print("fruits, last element: #{fruits.last}\n")
# fruits, last element: orange

print("fruits, last element: #{fruits.last()}\n")
# fruits, last element: orange

fruits.each_with_index { |array_item, array_item_index| print("fruits, foreach loop, index: #{array_item_index}, value: #{array_item}\n") }
# fruits, foreach loop, index: 0, value: apple
# fruits, foreach loop, index: 1, value: mango
# fruits, foreach loop, index: 2, value: orange

# in Ruby, JavaScript-like Array of Objects is called Array of Hashes

products = [
    {
        "id" => "P1",
        "name" => "bubble gum"
    },
    {
        "id" => "P2",
        "name" => "potato chips"
    }
]
print("\n", "products: ", JSON.pretty_generate(products, { "indent": " " * 4 }), "\n")

products.each_with_index { |array_item, array_item_index| array_item.each_with_index { |(object_key, object_value), entry_index| print("products, foreach loop, array item index: #{array_item_index}, iteration/entry index: #{entry_index}, key: #{object_key}, value: #{object_value}\n") } }
# products, foreach loop, array item index: 0, iteration/entry index: 0, key: id, value: P1
# products, foreach loop, array item index: 0, iteration/entry index: 1, key: name, value: bubble gum
# products, foreach loop, array item index: 1, iteration/entry index: 0, key: id, value: P2
# products, foreach loop, array item index: 1, iteration/entry index: 1, key: name, value: potato chips
