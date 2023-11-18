# Array in Perl

# initialization v1
my @fruits1 = ("apple", "mango", "orange");

print("fruits1, length: ", scalar(@fruits1), "\n");
# fruits1, length: 3

print("fruits1, get mango: ", $fruits1[1], "\n");
# fruits1, get mango: mango

print("fruits1, first element: ", $fruits1[0], "\n");
# fruits1, first element: apple

print("fruits1, last element: ", $fruits1[-1], "\n");
# fruits1, last element: orange

for my $array_item_index (0..(scalar(@fruits1) - 1)) { # we can also replace `(scalar(@fruits1) - 1)` with `$#fruits1`
    my $array_item = $fruits1[$array_item_index];
    print("fruits1, index: $array_item_index, value: $array_item\n");
}
# fruits1, for loop, index: 0, value: apple
# fruits1, for loop, index: 1, value: mango
# fruits1, for loop, index: 2, value: orange

# initialization v2
my $fruits2 = ["apple", "mango", "orange"];

print("fruits2, length: ", scalar(@{$fruits2}), "\n");
# fruits2, length: 3

print("fruits2, get mango: ", $$fruits2[1], "\n");
# fruits2, get mango: mango

print("fruits2, get mango: ", ${$fruits2}[1], "\n");
# fruits2, get mango: mango

print("fruits2, get mango: ", $fruits2->[1], "\n");
# fruits2, get mango: mango

print("fruits2, first element: ", $$fruits2[0], "\n");
# fruits2, first element: apple

print("fruits2, first element: ", ${$fruits2}[0], "\n");
# fruits2, first element: apple

print("fruits2, first element: ", $fruits2->[0], "\n");
# fruits2, first element: apple

print("fruits2, last element: ", $$fruits2[-1], "\n");
# fruits2, last element: orange

print("fruits2, last element: ", ${$fruits2}[-1], "\n");
# fruits2, last element: orange

print("fruits2, last element: ", $fruits2->[-1], "\n");
# fruits2, last element: orange

for my $array_item_index (0..(scalar(@{$fruits2}) - 1)) { # we can also replace `(scalar(@{$fruits2}) - 1)` with `$#fruits2`
    my $array_item = @{$fruits2}[$array_item_index];
    print("fruits2, index: $array_item_index, value: $array_item\n");
}
# fruits2, for loop, index: 0, value: apple
# fruits2, for loop, index: 1, value: mango
# fruits2, for loop, index: 2, value: orange

# Array of Objects in Perl

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

for my $product_index (0..(scalar(@products1) - 1)) {
    my $array_item = $products1[$product_index];
    my @object_entries = %{$array_item};
    for (my $object_entry_index = 0; $object_entry_index < scalar(@object_entries); $object_entry_index += 2) {
        my $object_key = $object_entries[$object_entry_index];
        my $object_value = $object_entries[$object_entry_index + 1];
        print("products1, loop, index: $product_index, key: $object_key, value: $object_value\n");
    }
}
# products1, loop, index: 0, key: id, value: P1
# products1, loop, index: 0, key: name, value: bubble gum
# products1, loop, index: 1, key: id, value: P2
# products1, loop, index: 1, key: name, value: potato chips

for my $product_index (0..(scalar(@products1) - 1)) {
    my $array_item = $products1[$product_index];
    while (my ($object_key, $object_value) = each %{$array_item}) {
        print("products1, loop, index: $product_index, key: $object_key, value: $object_value\n");
    }
}
# products1, loop, index: 0, key: id, value: P1
# products1, loop, index: 0, key: name, value: bubble gum
# products1, loop, index: 1, key: id, value: P2
# products1, loop, index: 1, key: name, value: potato chips

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

for my $product_index (0..(scalar(@{$products2}) - 1)) {
    my $array_item = @{$products2}[$product_index];
    my @object_entries = %{$array_item};
    for (my $object_entry_index = 0; $object_entry_index < scalar(@object_entries); $object_entry_index += 2) {
        my $object_key = $object_entries[$object_entry_index];
        my $object_value = $object_entries[$object_entry_index + 1];
        print("products2, loop, index: $product_index, key: $object_key, value: $object_value\n");
    }
}
# products2, loop, index: 0, key: id, value: P1
# products2, loop, index: 0, key: name, value: bubble gum
# products2, loop, index: 1, key: id, value: P2
# products2, loop, index: 1, key: name, value: potato chips

for my $product_index (0..(scalar(@{$products2}) - 1)) {
    my $array_item = @{$products2}[$product_index];
    while (my ($object_key, $object_value) = each %{$array_item}) {
        print("products2, loop, index: $product_index, key: $object_key, value: $object_value\n");
    }
}
# products2, loop, index: 0, key: id, value: P1
# products2, loop, index: 0, key: name, value: bubble gum
# products2, loop, index: 1, key: id, value: P2
# products2, loop, index: 1, key: name, value: potato chips
