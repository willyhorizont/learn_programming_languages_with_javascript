friend = Dict(
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
)

println("friend, get country: ", friend["country"])
# friend, get country: Finland

# iterate over and get each key-value pair
for (object_key, object_value) in friend
    println("friend, for loop, key: ", object_key, ", value: ", object_value)
end
# friend, for loop, key: name, value: Alisa
# friend, for loop, key: country, value: Finland
# friend, for loop, key: age, value: 25

# iterate over and get each key-value pair and iteration index
for (iteration_index, (object_key, object_value)) in enumerate(pairs(friend))
    println("friend, for loop, index: ", iteration_index, ", key: ", object_key, ", value: ", object_value)
end
# friend, for loop, index: 1, key: name, value: Alisa
# friend, for loop, index: 2, key: country, value: Finland
# friend, for loop, index: 3, key: age, value: 25
