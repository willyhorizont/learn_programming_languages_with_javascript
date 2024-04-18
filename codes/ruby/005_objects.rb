require "json"

# in Ruby, JavaScript-like Object is called Hash

friend = {
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
}
print("\n", "friend: ", JSON.pretty_generate(friend, { "indent": " " * 4 }), "\n")

print("friend, get country: #{friend["country"]}\n")
# friend, get country: Finland

print("friend, get total object keys: #{friend.length}\n")
# friend, get total object keys: 3

print("friend, get total object keys: #{friend.size}\n")
# friend, get total object keys: 3

# iterate over and get each key-value pair
friend.each { |object_key, object_value| print("friend, forEach loop, key: #{object_key}, value: #{object_value}\n") }
# friend, forEach loop, key: name, value: Alisa
# friend, forEach loop, key: country, value: Finland
# friend, forEach loop, key: age, value: 25

# iterate over and get each key-value pair and object iteration/entry index
friend.each_with_index { |(object_key, object_value), object_entry_index| print("friend, forEach loop, object iteration/entry index: #{object_entry_index}, key: #{object_key}, value: #{object_value}\n") }
# friend, forEach loop, object iteration/entry index: 0, key: name, value: Alisa
# friend, forEach loop, object iteration/entry index: 1, key: country, value: Finland
# friend, forEach loop, object iteration/entry index: 2, key: age, value: 25
