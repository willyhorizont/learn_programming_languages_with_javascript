friend = {
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
}
# print("\nfriend: ", JSON.pretty_generate(friend, { "indent": " " * 4 }), "\n")

print("friend, get country: #{friend["country"]}\n")
# friend, get country: Finland

# iterate over and get each key-value pair
friend.each { |object_key, object_value| print("friend, foreach loop, key: #{object_key} value: #{object_value}\n") }
# friend, foreach loop, key: name value: Alisa
# friend, foreach loop, key: country value: Finland
# friend, foreach loop, key: age value: 25

# iterate over and get each key-value pair and iteration/entry index
friend.each_with_index do |(object_key, object_value), iteration_index|
    print("friend, foreach loop, index: #{iteration_index}, key: #{object_key} value: #{object_value}\n")
end
# friend, foreach loop, index: 0, key: name value: Alisa
# friend, foreach loop, index: 1, key: country value: Finland
# friend, foreach loop, index: 2, key: age value: 25
