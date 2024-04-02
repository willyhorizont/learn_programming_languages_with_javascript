sub json-stringify($anything, Bool :$pretty = False) {
    use JSON::Fast;
    return to-json($anything, :pretty(True), :spacing(4)) if ($pretty === True);
    my $json-string = to-json($anything, :pretty(False));
    $json-string ~~ s:g/\,/\, /;
    $json-string ~~ s:g/\:/\: /;
    return $json-string;;
}

# in Raku, JavaScript-like Array is called List

# initialization v1
my @fruits1 = ("apple", "mango", "orange");
print("fruits1: ", json-stringify(@fruits1), "\n");

print("fruits1, length: ", @fruits1.elems, "\n");
# fruits1, length: 3

print("fruits1, get mango: ", @fruits1[1], "\n");
# fruits1, get mango: mango

print("fruits1, first element: ", @fruits1[0], "\n");
# fruits1, first element: apple

print("fruits1, last element: ", @fruits1[*-1], "\n");
# fruits1, last element: orange

for (@fruits1.kv) -> $array-item-index, $array-item {
    print("fruits1, index: {$array-item-index}, value: {$array-item}", "\n");
}
# fruits1, for loop, index: 0, value: apple
# fruits1, for loop, index: 1, value: mango
# fruits1, for loop, index: 2, value: orange

# initialization v2 (the best way)
my $fruits2 = ["apple", "mango", "orange"];
print("fruits2: ", json-stringify($fruits2), "\n");

print("fruits2, length: ", $fruits2.elems, "\n");
# fruits2, length: 3

print("fruits2, get mango: ", $fruits2[1], "\n");
# fruits2, get mango: mango

print("fruits2, first element: ", $fruits2[0], "\n");
# fruits2, first element: apple

print("fruits2, last element: ", $fruits2[*-1], "\n");
# fruits2, last element: orange

for ($fruits2.kv) -> $array-item-index, $array-item {
    print("fruits2, index: {$array-item-index}, value: {$array-item}", "\n");
}
# fruits2, for loop, index: 0, value: apple
# fruits2, for loop, index: 1, value: mango
# fruits2, for loop, index: 2, value: orange

# in Raku, JavaScript-like Array of Objects is called List of Hashes

# initialization v1
my @products1 = (
    {
        "id" => "P1",
        "name" => "bubble gum"
    },
    {
        "id" => "P2",
        "name" => "potato chips"
    }
);
print("products1: ", json-stringify(@products1, :pretty(True)), "\n");

for (@products1.kv) -> $array-item-index, $array-item {
    for ($array-item.pairs.kv) -> $object-entry-index, $object-entry {
        my $object-key = $object-entry.key;
        my $object-value = $object-entry.value;
        print("products1, forEach loop, array item index: {$array-item-index}, object iteration/entry index: {$object-entry-index}, key: {$object-key}, value: {$object-value}", "\n");
    }
}
# products1, forEach loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
# products1, forEach loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
# products1, forEach loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
# products1, forEach loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips

# initialization v2
my $products2 = [
    {
        "id" => "P1",
        "name" => "bubble gum"
    },
    {
        "id" => "P2",
        "name" => "potato chips"
    }
];
print("products2: ", json-stringify($products2, :pretty(True)), "\n");

for ($products2.kv) -> $array-item-index, $array-item {
    for ($array-item.pairs.kv) -> $object-entry-index, $object-entry {
        my $object-key = $object-entry.key;
        my $object-value = $object-entry.value;
        print("products2, forEach loop, array item index: {$array-item-index}, object iteration/entry index: {$object-entry-index}, key: {$object-key}, value: {$object-value}", "\n");
    }
}
# products2, for loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
# products2, for loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
# products2, for loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
# products2, for loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips

# initialization v3
my @products3 = (
    %(
        "id" => "P1",
        "name" => "bubble gum"
    ),
    %(
        "id" => "P2",
        "name" => "potato chips"
    )
);
print("products3: ", json-stringify(@products3, :pretty(True)), "\n");

for (@products3.kv) -> $array-item-index, $array-item {
    for ($array-item.pairs.kv) -> $object-entry-index, $object-entry {
        my $object-key = $object-entry.key;
        my $object-value = $object-entry.value;
        print("products3, forEach loop, array item index: {$array-item-index}, object iteration/entry index: {$object-entry-index}, key: {$object-key}, value: {$object-value}", "\n");
    }
}
# products3, forEach loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
# products3, forEach loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
# products3, forEach loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
# products3, forEach loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips

# initialization v4 (the best way)
my $products4 = [
    %(
        "id" => "P1",
        "name" => "bubble gum"
    ),
    %(
        "id" => "P2",
        "name" => "potato chips"
    )
];
print("products4: ", json-stringify($products4, :pretty(True)), "\n");

for ($products4.kv) -> $array-item-index, $array-item {
    for ($array-item.pairs.kv) -> $object-entry-index, $object-entry {
        my $object-key = $object-entry.key;
        my $object-value = $object-entry.value;
        print("products4, forEach loop, array item index: {$array-item-index}, object iteration/entry index: {$object-entry-index}, key: {$object-key}, value: {$object-value}", "\n");
    }
}
# products4, for loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
# products4, for loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
# products4, for loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
# products4, for loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips
