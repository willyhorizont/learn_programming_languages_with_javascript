using JSON

# in Julia, JavaScript-like Object is called Dict / Dictionary

friend = Dict(
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
)
println("friend: ", chomp(JSON.json(friend, 4)))

println("friend, get country: ", friend["country"])
# friend, get country: Finland

# iterate over and get each key-value pair
for (object_key, object_value) in friend
    println("friend, for loop, key: ", object_key, ", value: ", object_value)
end
# friend, for loop, key: name, value: Alisa
# friend, for loop, key: country, value: Finland
# friend, for loop, key: age, value: 25

# iterate over and get each key-value pair and object iteration/entry index
for (object_entry_index, (object_key, object_value)) in enumerate(pairs(friend))
    println("friend, for loop, object iteration/entry index: ", object_entry_index, ", key: ", object_key, ", value: ", object_value)
end
# friend, for loop, object iteration/entry index: 1, key: name, value: Alisa
# friend, for loop, object iteration/entry index: 2, key: country, value: Finland
# friend, for loop, object iteration/entry index: 3, key: age, value: 25
