friend = Dict(
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
)

# iterate over and get each key-value pair
for (object_key, object_value) in friend
    println("friend, for loop, key: ", object_key, ", value: ", object_value)
end
# friend, for loop, key: name, value: Alisa
# friend, for loop, key: country, value: Finland
# friend, for loop, key: age, value: 25
