using Printf
using Statistics
using JSON

friend = Dict(
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
)
println("friend: ", JSON.json(friend, 4))

println("friend, get country: ", friend["country"])
# friend, get country: Finland

# iterate over and get each key-value pair
for (object_key, object_value) in friend
    println("friend, for loop, key: ", object_key, ", value: ", object_value)
end
# friend, for loop, key: name, value: Alisa
# friend, for loop, key: country, value: Finland
# friend, for loop, key: age, value: 25

# iterate over and get each key-value pair and iteration/entry index
for (iteration_index, (object_key, object_value)) in enumerate(pairs(friend))
    println("friend, for loop, iteration/entry index: ", iteration_index, ", key: ", object_key, ", value: ", object_value)
end
# friend, for loop, iteration/entry index: 1, key: name, value: Alisa
# friend, for loop, iteration/entry index: 2, key: country, value: Finland
# friend, for loop, iteration/entry index: 3, key: age, value: 25
