sub json-stringify($anything, Bool :$pretty = False, Str :$indent = " " x 4) {
    my $indent-level = 0;
    my $json-stringify-inner = sub ($anything-inner, $indent-inner) {
        return "null" if ($anything-inner === Nil);
        return "\"{$anything-inner}\"" if ($anything-inner ~~ Str);
        return "{$anything-inner}" if (($anything-inner ~~ Numeric) || ($anything-inner ~~ Bool));
        if ($anything-inner.^name eq "List" || $anything-inner.^name eq "Seq") {
            return "[]" if ($anything-inner.elems == 0);
            $indent-level += 1;
            my $result = (($pretty == True) ?? "[\n{$indent-inner x $indent-level}" !! "[");
            for ($anything-inner.kv) -> $array-item-index, $array-item {
                $result ~= $json-stringify-inner($array-item, $indent-inner);
                $result ~= (($pretty == True) ?? ",\n{$indent-inner x $indent-level}" !! ", ") if (($array-item-index + 1) !== $anything-inner.elems);
            }
            $indent-level -= 1;
            $result ~= (($pretty == True) ?? "\n{$indent-inner x $indent-level}]" !! "]");
            return $result;
        }
        if ($anything-inner.^name eq "Hash") {
            return "\{}" if ($anything-inner.elems == 0);
            $indent-level += 1;
            my $result = (($pretty == True) ?? "\{\n{$indent-inner x $indent-level}" !! "\{");
            for ($anything-inner.pairs.kv) -> $object-entry-index, $object-entry {
                my $object-key = $object-entry.key;
                my $object-value = $object-entry.value;
                $result ~= "\"{$object-key}\": " ~ $json-stringify-inner($object-value, $indent-inner);
                $result ~= (($pretty == True) ?? ",\n{$indent-inner x $indent-level}" !! ", ") if (($object-entry-index + 1) !== $anything-inner.elems);
            }
            $indent-level -= 1;
            $result ~= (($pretty == True) ?? "\n{$indent-inner x $indent-level}}" !! "}");
            return $result;
        }
        return "null";
    };
    return $json-stringify-inner($anything, $indent);
}

# in Raku, JavaScript-like Object is called Hash

# initialization v1
my %friend1 = (
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
);
print("friend1: ", json-stringify(%friend1, :pretty(True)), "\n");

print("friend1, get total object keys: ", %friend1.elems, "\n");
# friend1, get total object keys: 3

print("friend1, get total object keys: ", elems(%friend1), "\n");
# friend1, get total object keys: 3

print("friend1, get total object keys: ", %friend1.elems(), "\n");
# friend1, get total object keys: 3

print("friend1, get country: ", %friend1{"country"}, "\n");
# friend1, get country: Finland

# another way but I personally don't like it
# print("friend1, get country: ", %friend1<country>, "\n");
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

%friend1{"age"} = 27;
print("friend1: ", json-stringify(%friend1, :pretty(True)), "\n");

%friend1{"gender"} = "Female";
print("friend1: ", json-stringify(%friend1, :pretty(True)), "\n");

# another way but I personally don't like it
# %friend1<job> = "Streamer";

%friend1{"country"}:delete;
print("friend1: ", json-stringify(%friend1, :pretty(True)), "\n");

# Computed property names: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Object_initializer#computed_property_names
my $delivery-response1-key-message = "message";
my %delivery-response1 = (
    $delivery-response1-key-message => "ok"
);
print("delivery-response1: ", json-stringify(%delivery-response1, :pretty(True)), "\n");
my $delivery-response1-key-status = "status";
%delivery-response1{$delivery-response1-key-status} = 200;
print("delivery-response1: ", json-stringify(%delivery-response1, :pretty(True)), "\n");

# initialization v2
my $friend2 = {
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
};
print("friend2: ", json-stringify($friend2, :pretty(True)), "\n");

print("friend2, get total object keys: ", $friend2.elems, "\n");
# friend2, get total object keys: 3

print("friend2, get total object keys: ", elems($friend2), "\n");
# friend2, get total object keys: 3

print("friend2, get total object keys: ", $friend2.elems(), "\n");
# friend2, get total object keys: 3

print("friend2, get country: ", $friend2{"country"}, "\n");
# friend2, get country: Finland

# another way but I personally don't like it
# print("friend2, get country: ", $friend2<country>, "\n");
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

$friend2{"age"} = 27;
print("friend2: ", json-stringify($friend2, :pretty(True)), "\n");

$friend2{"gender"} = "Female";
print("friend2: ", json-stringify($friend2, :pretty(True)), "\n");

# another way but I personally don't like it
# $friend2<job> = "Streamer";

$friend2{"country"}:delete;
print("friend2: ", json-stringify($friend2, :pretty(True)), "\n");

# Computed property names: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Object_initializer#computed_property_names
my $delivery-response2-key-message = "message";
my $delivery-response2 = {
    $delivery-response2-key-message => "ok"
};
print("delivery-response2: ", json-stringify($delivery-response2, :pretty(True)), "\n");
my $delivery-response2-key-status = "status";
$delivery-response2{$delivery-response2-key-status} = 200;
print("delivery-response2: ", json-stringify($delivery-response2, :pretty(True)), "\n");

# initialization v3 (the best way)
my $friend3 = %(
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
);
print("friend3: ", json-stringify($friend3, :pretty(True)), "\n");

print("friend3, get total object keys: ", $friend3.elems, "\n");
# friend3, get total object keys: 3

print("friend3, get total object keys: ", elems($friend3), "\n");
# friend3, get total object keys: 3

print("friend3, get total object keys: ", $friend3.elems(), "\n");
# friend3, get total object keys: 3

print("friend3, get country: ", $friend3{"country"}, "\n");
# friend3, get country: Finland

# another way but I personally don't like it
# print("friend3, get country: ", $friend3<country>, "\n");
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

$friend3{"age"} = 27;
print("friend3: ", json-stringify($friend3, :pretty(True)), "\n");

$friend3{"gender"} = "Female";
print("friend3: ", json-stringify($friend3, :pretty(True)), "\n");

# another way but I personally don't like it
# $friend3<job> = "Streamer";

$friend3{"country"}:delete;
print("friend3: ", json-stringify($friend3, :pretty(True)), "\n");

# Computed property names: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Object_initializer#computed_property_names
my $delivery-response3-key-message = "message";
my $delivery-response3 = %(
    $delivery-response3-key-message => "ok"
);
print("delivery-response3: ", json-stringify($delivery-response3, :pretty(True)), "\n");
my $delivery-response3-key-status = "status";
$delivery-response3{$delivery-response3-key-status} = 200;
print("delivery-response3: ", json-stringify($delivery-response3, :pretty(True)), "\n");
