using Printf
using Statistics
using JSON

function pretty_array_of_primitives(an_array_of_primitives)
    result = "["
    for (array_item_index, array_item) in enumerate(an_array_of_primitives)
        if ((isa(array_item, AbstractString) === false) && (isa(array_item, Number) === false))
            continue
        end
        if (isa(array_item, AbstractString) === true)
            result = string(result, "\"", array_item, "\"")
        end
        if (isa(array_item, Number) === true)
            result = string(result, array_item)
        end
        if (array_item_index !== length(an_array_of_primitives))
            result = string(result, ", ")
        end
    end
    result = string(result, "]")
    return result
end

# Array in Julia

fruits = ["apple", "mango", "orange"]
println("fruits: ", pretty_array_of_primitives(fruits))

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
println("products: ", JSON.json(products, 4))

for (array_item_index, array_item) in enumerate(products)
    for (entry_index, (object_key, object_value)) in enumerate(pairs(array_item))
        println("products, for loop, array item index: ", array_item_index, ", iteration/entry index: ", entry_index, ", key: ", object_key, ", value: ", object_value)
    end
end
# products, for loop, array item index: 1, iteration/entry index: 1, key: name, value: bubble gum
# products, for loop, array item index: 1, iteration/entry index: 2, key: id, value: P1
# products, for loop, array item index: 2, iteration/entry index: 1, key: name, value: potato chips
# products, for loop, array item index: 2, iteration/entry index: 2, key: id, value: P2
