sub json-stringify($anything, Bool :$pretty = False) {
    use JSON::Fast;
    return to-json($anything, :pretty(True), :spacing(4)) if ($pretty === True);
    my $json-string = to-json($anything, :pretty(False));
    $json-string ~~ s:g/\,/\, /;
    $json-string ~~ s:g/\:/\: /;
    return $json-string;;
}

# in Raku, JavaScript-like Object is called Hash

# initialization v1
my %friend1 = (
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
);
print("friend1: ", json-stringify(%friend1, :pretty(True)), "\n");

print("friend1, get country: ", %friend1{"country"}, "\n");
# friend1, get country: Finland

# iterate over and get each key-value pair
for (%friend1.kv) -> $object-key, $object-value {
    print("friend1, forEach loop v1, key: {$object-key}, value: {$object-value}", "\n");
}
# friend1, forEach loop v1, key: name, value: Alisa
# friend1, forEach loop v1, key: country, value: Finland
# friend1, forEach loop v1, key: age, value: 25

# iterate over and get each key-value pair
for (%friend1.pairs) -> $object-entry {
    my $object-key = $object-entry.key;
    my $object-value = $object-entry.value;
    print("friend1, forEach loop v2, key: {$object-key}, value: {$object-value}", "\n");
}
# friend1, forEach loop v2, key: name, value: Alisa
# friend1, forEach loop v2, key: country, value: Finland
# friend1, forEach loop v2, key: age, value: 25

# iterate over and get each key-value pair and object iteration/entry index
for (%friend1.pairs.kv) -> $object-entry-index, $object-entry {
    my $object-key = $object-entry.key;
    my $object-value = $object-entry.value;
    print("friend1, forEach loop, object iteration/entry index: {$object-entry-index}, key: {$object-key}, value: {$object-value}", "\n");
}
# friend1, forEach loop, object iteration/entry index: 0, key: name, value: Alisa
# friend1, forEach loop, object iteration/entry index: 1, key: country, value: Finland
# friend1, forEach loop, object iteration/entry index: 2, key: age, value: 25

# initialization v2
my $friend2 = {
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
};
print("friend2: ", json-stringify($friend2, :pretty(True)), "\n");

print("friend2, get country: ", $friend2{"country"}, "\n");
# friend2, get country: Finland

# iterate over and get each key-value pair
for ($friend2.kv) -> $object-key, $object-value {
    print("friend2, forEach loop v1, key: {$object-key}, value: {$object-value}", "\n");
}
# friend2, forEach loop v1, key: name, value: Alisa
# friend2, forEach loop v1, key: country, value: Finland
# friend2, forEach loop v1, key: age, value: 25

# iterate over and get each key-value pair
for ($friend2.pairs) -> $object-entry {
    my $object-key = $object-entry.key;
    my $object-value = $object-entry.value;
    print("friend2, forEach loop v2, key: {$object-key}, value: {$object-value}", "\n");
}
# friend2, forEach loop v2, key: name, value: Alisa
# friend2, forEach loop v2, key: country, value: Finland
# friend2, forEach loop v2, key: age, value: 25

# iterate over and get each key-value pair and object iteration/entry index
for ($friend2.pairs.kv) -> $object-entry-index, $object-entry {
    my $object-key = $object-entry.key;
    my $object-value = $object-entry.value;
    print("friend2, forEach loop, object iteration/entry index: {$object-entry-index}, key: {$object-key}, value: {$object-value}", "\n");
}
# friend2, forEach loop, object iteration/entry index: 0, key: name, value: Alisa
# friend2, forEach loop, object iteration/entry index: 1, key: country, value: Finland
# friend2, forEach loop, object iteration/entry index: 2, key: age, value: 25

# initialization v3 (the best way)
my $friend3 = %(
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
);
print("friend3: ", json-stringify($friend3, :pretty(True)), "\n");

print("friend3, get country: ", $friend3{"country"}, "\n");
# friend3, get country: Finland

# iterate over and get each key-value pair
for ($friend3.kv) -> $object-key, $object-value {
    print("friend3, forEach loop v1, key: {$object-key}, value: {$object-value}", "\n");
}
# friend3, forEach loop v1, key: name, value: Alisa
# friend3, forEach loop v1, key: country, value: Finland
# friend3, forEach loop v1, key: age, value: 25

# iterate over and get each key-value pair
for ($friend3.pairs) -> $object-entry {
    my $object-key = $object-entry.key;
    my $object-value = $object-entry.value;
    print("friend3, forEach loop v2, key: {$object-key}, value: {$object-value}", "\n");
}
# friend3, forEach loop v2, key: name, value: Alisa
# friend3, forEach loop v2, key: country, value: Finland
# friend3, forEach loop v2, key: age, value: 25

# iterate over and get each key-value pair and object iteration/entry index
for ($friend3.pairs.kv) -> $object-entry-index, $object-entry {
    my $object-key = $object-entry.key;
    my $object-value = $object-entry.value;
    print("friend3, forEach loop, object iteration/entry index: {$object-entry-index}, key: {$object-key}, value: {$object-value}", "\n");
}
# friend3, forEach loop, object iteration/entry index: 0, key: name, value: Alisa
# friend3, forEach loop, object iteration/entry index: 1, key: country, value: Finland
# friend3, forEach loop, object iteration/entry index: 2, key: age, value: 25
