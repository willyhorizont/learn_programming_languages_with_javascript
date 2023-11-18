# Array in Julia

fruits = ["apple", "mango", "orange"]

println("fruits, length: ", length(fruits))
# fruits, length: 3

println("fruits, get mango: ", fruits[2])
# fruits, get mango: mango

println("fruits, first element: ", fruits[1])
# fruits, first element: apple

println("fruits, last element: ", fruits[end])
# fruits, last element: orange

for (array_item_index, array_item) in enumerate(fruits)
    println("fruits, for loop, index: ", array_item_index, ", value: ", array_item)
end
# fruits, for loop, index: 1, value: apple
# fruits, for loop, index: 2, value: mango
# fruits, for loop, index: 3, value: orange

# Array of Objects in Julia

products = [
    Dict(
        "id" => "P1",
        "name" => "bubble gum"
    ),
    Dict(
        "id" => "P2",
        "name" => "potato chips"
    )
]

for (array_item_index, array_item) in enumerate(products)
    for (object_key, object_value) in array_item
        println("products, loop, index: ", array_item_index, ", key: ", object_key, ", value: ", object_value)
    end
end
# products, loop, index: 1, key: name, value: bubble gum
# products, loop, index: 1, key: id, value: P1
# products, loop, index: 2, key: name, value: potato chips
# products, loop, index: 2, key: id, value: P2
