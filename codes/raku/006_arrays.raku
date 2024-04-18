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

# in Raku, JavaScript-like Array is called List

# initialization v1
my $fruits1 = ["apple", "mango", "orange"];
print("fruits1: ", json-stringify($fruits1), "\n");

print("fruits1, length: ", $fruits1.elems, "\n");
# fruits1, length: 3

print("fruits1, length: ", $fruits1.elems(), "\n");
# fruits1, length: 3

print("fruits1, length: ", elems($fruits1), "\n");
# fruits1, length: 3

print("fruits1, get mango: ", $fruits1[1], "\n");
# fruits1, get mango: mango

print("fruits1, first element: ", $fruits1[0], "\n");
# fruits1, first element: apple

print("fruits1, last element: ", $fruits1[*-1], "\n");
# fruits1, last element: orange

for ($fruits1.kv) -> $array-item-index, $array-item {
    print("fruits1, index: {$array-item-index}, value: {$array-item}", "\n");
}
# fruits1, for loop, index: 0, value: apple
# fruits1, for loop, index: 1, value: mango
# fruits1, for loop, index: 2, value: orange

# initialization v2 (the best way)
my @fruits2 = ("apple", "mango", "orange");
print("fruits2: ", json-stringify(@fruits2), "\n");

print("fruits2, length: ", @fruits2.elems, "\n");
# fruits2, length: 3

print("fruits2, length: ", @fruits2.elems(), "\n");
# fruits2, length: 3

print("fruits2, length: ", elems(@fruits2), "\n");
# fruits2, length: 3

print("fruits2, get mango: ", @fruits2[1], "\n");
# fruits2, get mango: mango

print("fruits2, first element: ", @fruits2[0], "\n");
# fruits2, first element: apple

print("fruits2, last element: ", @fruits2[*-1], "\n");
# fruits2, last element: orange

for (@fruits2.kv) -> $array-item-index, $array-item {
    print("fruits2, index: {$array-item-index}, value: {$array-item}", "\n");
}
# fruits2, for loop, index: 0, value: apple
# fruits2, for loop, index: 1, value: mango
# fruits2, for loop, index: 2, value: orange

# initialization v3 (the best way)
my $fruits3 = ("apple", "mango", "orange");
print("fruits3: ", json-stringify($fruits3), "\n");

print("fruits3, length: ", $fruits3.elems, "\n");
# fruits3, length: 3

print("fruits3, length: ", $fruits3.elems(), "\n");
# fruits3, length: 3

print("fruits3, length: ", elems($fruits3), "\n");
# fruits3, length: 3

print("fruits3, get mango: ", $fruits3[1], "\n");
# fruits3, get mango: mango

print("fruits3, first element: ", $fruits3[0], "\n");
# fruits3, first element: apple

print("fruits3, last element: ", $fruits3[*-1], "\n");
# fruits3, last element: orange

for ($fruits3.kv) -> $array-item-index, $array-item {
    print("fruits3, index: {$array-item-index}, value: {$array-item}", "\n");
}
# fruits3, for loop, index: 0, value: apple
# fruits3, for loop, index: 1, value: mango
# fruits3, for loop, index: 2, value: orange

# in Raku, JavaScript-like Array of Objects is called List of Hashes

# initialization v1
my $products1 = [
    {
        "id" => "P1",
        "name" => "bubble gum"
    },
    {
        "id" => "P2",
        "name" => "potato chips"
    }
];
print("products1: ", json-stringify($products1, :pretty(True)), "\n");

for ($products1.kv) -> $array-item-index, $array-item {
    for ($array-item.pairs.kv) -> $object-entry-index, $object-entry {
        my $object-key = $object-entry.key;
        my $object-value = $object-entry.value;
        print("products1, forEach loop, array item index: {$array-item-index}, object iteration/entry index: {$object-entry-index}, key: {$object-key}, value: {$object-value}", "\n");
    }
}
# products1, for loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
# products1, for loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
# products1, for loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
# products1, for loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips

# initialization v2
my $products2 = [
    %(
        "id" => "P1",
        "name" => "bubble gum"
    ),
    %(
        "id" => "P2",
        "name" => "potato chips"
    )
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
    {
        "id" => "P1",
        "name" => "bubble gum"
    },
    {
        "id" => "P2",
        "name" => "potato chips"
    }
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
my @products4 = (
    %(
        "id" => "P1",
        "name" => "bubble gum"
    ),
    %(
        "id" => "P2",
        "name" => "potato chips"
    )
);
print("products4: ", json-stringify(@products4, :pretty(True)), "\n");

for (@products4.kv) -> $array-item-index, $array-item {
    for ($array-item.pairs.kv) -> $object-entry-index, $object-entry {
        my $object-key = $object-entry.key;
        my $object-value = $object-entry.value;
        print("products4, forEach loop, array item index: {$array-item-index}, object iteration/entry index: {$object-entry-index}, key: {$object-key}, value: {$object-value}", "\n");
    }
}
# products4, forEach loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
# products4, forEach loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
# products4, forEach loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
# products4, forEach loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips

# initialization v5 (the best way)
my $products5 = (
    %(
        "id" => "P1",
        "name" => "bubble gum"
    ),
    %(
        "id" => "P2",
        "name" => "potato chips"
    )
);
print("products5: ", json-stringify($products5, :pretty(True)), "\n");

for ($products5.kv) -> $array-item-index, $array-item {
    for ($array-item.pairs.kv) -> $object-entry-index, $object-entry {
        my $object-key = $object-entry.key;
        my $object-value = $object-entry.value;
        print("products5, forEach loop, array item index: {$array-item-index}, object iteration/entry index: {$object-entry-index}, key: {$object-key}, value: {$object-value}", "\n");
    }
}
# products5, forEach loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
# products5, forEach loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
# products5, forEach loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
# products5, forEach loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips
