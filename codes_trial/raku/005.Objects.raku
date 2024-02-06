# initialization v1
my %friend1 = %(
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
);
# print("friend1: ", pretty_json_stringify(\%friend1));

print("friend1, get country: {%friend1{"country"}}\n");
# friend1, get country: Finland

# iterate over and get each key-value pair
for %friend1.kv -> $object_key, $object_value {
    print("friend1, for loop, key: {$object_key}, value: {$object_value}\n");
}
# friend1, for loop, key: name, value: Alisa
# friend1, for loop, key: country, value: Finland
# friend1, for loop, key: age, value: 25

# iterate over and get each key-value pair and iteration/entry index
for %friend1.pairs.kv -> $entry_index, $object_entry {
    my ($object_key, $object_value) = $object_entry.kv;
    print("friend1, for loop, iteration/entry index: {$entry_index}, key: {$object_key}, value: {$object_value}\n");
}
# friend1, for loop, iteration/entry index: 0, key: name, value: Alisa
# friend1, for loop, iteration/entry index: 1, key: country, value: Finland
# friend1, for loop, iteration/entry index: 2, key: age, value: 25

# initialization v2
my $friend2 = {
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
};
# print("friend2: ", pretty_json_stringify($friend2));

print("friend2, get country: {$friend2{"country"}}\n");
# friend2, get country: Finland

# print("friend2, get country: {${$friend2}{"country"}}\n");
# friend2, get country: Finland

# print("friend2, get country: {$friend2->{"country"}}\n");
# friend2, get country: Finland
