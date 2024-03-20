use strict;
use warnings;
use Scalar::Util qw(looks_like_number);

sub pretty_json_stringify {
    my ($anything) = @_;
    use JSON;
    my $pretty_json_string = JSON->new->allow_nonref->pretty->encode($anything);
    $pretty_json_string =~ s/   /    /g;
    $pretty_json_string =~ s/\n$//g;
    return $pretty_json_string;
}

sub pretty_array_of_primitives {
    my $number_of_parameters = @_;
    my $result = "[";
    for (my $array_item_index = 0; $array_item_index < $number_of_parameters; $array_item_index += 1) {
        my $array_item = $_[$array_item_index];
        my $is_string = (defined($array_item) && ref($array_item) eq "");
        my $is_number = looks_like_number($array_item);
        last if (!$is_string && !$is_number);
        $result = $result . "\"" . $array_item . "\"" if ($is_string && !$is_number);
        $result = $result . $array_item if ($is_number);
        $result = $result . ", " if (($array_item_index + 1) != $number_of_parameters);
    }
    $result = $result . "]";
    return $result;
}

# in Perl, JavaScript-like Array is called Array

# initialization v1
my @fruits1 = ("apple", "mango", "orange");
print("fruits1: " . pretty_array_of_primitives(@fruits1) . "\n");

print("fruits1, length: " . scalar(@fruits1) . "\n");
# fruits1, length: 3

print("fruits1, get mango: " . $fruits1[1] . "\n");
# fruits1, get mango: mango

print("fruits1, first element: " . $fruits1[0] . "\n");
# fruits1, first element: apple

print("fruits1, last element: " . $fruits1[-1] . "\n");
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
print("fruits2: " . pretty_array_of_primitives($fruits2) . "\n");

print("fruits2, length: " . scalar(@{$fruits2}) . "\n");
# fruits2, length: 3

print("fruits2, get mango: " . $$fruits2[1] . "\n");
# fruits2, get mango: mango

print("fruits2, get mango: " . ${$fruits2}[1] . "\n");
# fruits2, get mango: mango

print("fruits2, get mango: " . $fruits2->[1] . "\n");
# fruits2, get mango: mango

print("fruits2, first element: " . $$fruits2[0] . "\n");
# fruits2, first element: apple

print("fruits2, first element: " . ${$fruits2}[0] . "\n");
# fruits2, first element: apple

print("fruits2, first element: " . $fruits2->[0] . "\n");
# fruits2, first element: apple

print("fruits2, last element: " . $$fruits2[-1] . "\n");
# fruits2, last element: orange

print("fruits2, last element: " . ${$fruits2}[-1] . "\n");
# fruits2, last element: orange

print("fruits2, last element: " . $fruits2->[-1] . "\n");
# fruits2, last element: orange

for my $array_item_index (0..(scalar(@{$fruits2}) - 1)) { # we can also replace `(scalar(@{$fruits2}) - 1)` with `$#{$fruits2}`
    my $array_item = @{$fruits2}[$array_item_index];
    print("fruits2, index: $array_item_index, value: $array_item\n");
}
# fruits2, for loop, index: 0, value: apple
# fruits2, for loop, index: 1, value: mango
# fruits2, for loop, index: 2, value: orange

# in Perl, JavaScript-like Array of Objects is called Array of Hashes

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
print("products1: " . pretty_json_stringify(\@products1) . "\n");

for my $array_item_index (0..(scalar(@products1) - 1)) {
    my $array_item = $products1[$array_item_index];
    my @object_entries = %{$array_item};
    for (my $entry_index = 0; $entry_index < scalar(@object_entries); $entry_index += 2) {
        my $entry_index = $entry_index / 2;
        my $object_key = $object_entries[$entry_index];
        my $object_value = $object_entries[$entry_index + 1];
        print("products1, for loop, array item index: $array_item_index, iteration/entry index: $entry_index, key: $object_key, value: $object_value\n");
    }
}
# products1, for loop, array item index: 0, iteration/entry index: 0, key: id, value: P1
# products1, for loop, array item index: 0, iteration/entry index: 1, key: name, value: bubble gum
# products1, for loop, array item index: 1, iteration/entry index: 0, key: id, value: P2
# products1, for loop, array item index: 1, iteration/entry index: 1, key: name, value: potato chips

for my $array_item_index (0..(scalar(@products1) - 1)) {
    my $array_item = $products1[$array_item_index];
    my $entry_index = 0;
    foreach my $object_key (keys(%{$array_item})) {
        my $object_value = %{$array_item}{$object_key};
        print("products1, for loop, array item index: $array_item_index, iteration/entry index: $entry_index, key: $object_key, value: $object_value\n");
        $entry_index += 1;
    }
}
# products1, for loop, array item index: 0, iteration/entry index: 0, key: id, value: P1
# products1, for loop, array item index: 0, iteration/entry index: 1, key: name, value: bubble gum
# products1, for loop, array item index: 1, iteration/entry index: 0, key: id, value: P2
# products1, for loop, array item index: 1, iteration/entry index: 1, key: name, value: potato chips

for my $array_item_index (0..(scalar(@products1) - 1)) {
    my $array_item = $products1[$array_item_index];
    my $entry_index = 0;
    while (my ($object_key, $object_value) = each(%{$array_item})) {
        print("products1, for loop, array item index: $array_item_index, iteration/entry index: $entry_index, key: $object_key, value: $object_value\n");
        $entry_index += 1;
    }
}
# products1, for loop, array item index: 0, iteration/entry index: 0, key: id, value: P1
# products1, for loop, array item index: 0, iteration/entry index: 1, key: name, value: bubble gum
# products1, for loop, array item index: 1, iteration/entry index: 0, key: id, value: P2
# products1, for loop, array item index: 1, iteration/entry index: 1, key: name, value: potato chips

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
print("products2: " . pretty_json_stringify($products2) . "\n");

for my $array_item_index (0..(scalar(@{$products2}) - 1)) {
    my $array_item = @{$products2}[$array_item_index];
    my @object_entries = %{$array_item};
    for (my $entry_index = 0; $entry_index < scalar(@object_entries); $entry_index += 2) {
        my $entry_index = $entry_index / 2;
        my $object_key = $object_entries[$entry_index];
        my $object_value = $object_entries[$entry_index + 1];
        print("products2, for loop, array item index: $array_item_index, iteration/entry index: $entry_index, key: $object_key, value: $object_value\n");
    }
}
# products2, for loop, array item index: 0, iteration/entry index: 0, key: id, value: P1
# products2, for loop, array item index: 0, iteration/entry index: 1, key: name, value: bubble gum
# products2, for loop, array item index: 1, iteration/entry index: 0, key: id, value: P2
# products2, for loop, array item index: 1, iteration/entry index: 1, key: name, value: potato chips

for my $array_item_index (0..(scalar(@{$products2}) - 1)) {
    my $array_item = @{$products2}[$array_item_index];
    my $entry_index = 0;
    foreach my $object_key (keys(%{$array_item})) {
        my $object_value = %{$array_item}{$object_key};
        print("products2, for loop, array item index: $array_item_index, iteration/entry index: $entry_index, key: $object_key, value: $object_value\n");
        $entry_index += 1;
    }
}
# products2, for loop, array item index: 0, iteration/entry index: 0, key: id, value: P1
# products2, for loop, array item index: 0, iteration/entry index: 1, key: name, value: bubble gum
# products2, for loop, array item index: 1, iteration/entry index: 0, key: id, value: P2
# products2, for loop, array item index: 1, iteration/entry index: 1, key: name, value: potato chips

for my $array_item_index (0..(scalar(@{$products2}) - 1)) {
    my $array_item = @{$products2}[$array_item_index];
    my $entry_index = 0;
    foreach my $object_key (keys(%{$array_item})) {
        my $object_value = $array_item->{$object_key};
        print("products2, for loop, array item index: $array_item_index, iteration/entry index: $entry_index, key: $object_key, value: $object_value\n");
        $entry_index += 1;
    }
}
# products2, for loop, array item index: 0, iteration/entry index: 0, key: id, value: P1
# products2, for loop, array item index: 0, iteration/entry index: 1, key: name, value: bubble gum
# products2, for loop, array item index: 1, iteration/entry index: 0, key: id, value: P2
# products2, for loop, array item index: 1, iteration/entry index: 1, key: name, value: potato chips

for my $array_item_index (0..(scalar(@{$products2}) - 1)) {
    my $array_item = @{$products2}[$array_item_index];
    my $entry_index = 0;
    while (my ($object_key, $object_value) = each(%{$array_item})) {
        print("products2, for loop, array item index: $array_item_index, iteration/entry index: $entry_index, key: $object_key, value: $object_value\n");
        $entry_index += 1;
    }
}
# products2, for loop, array item index: 0, iteration/entry index: 0, key: id, value: P1
# products2, for loop, array item index: 0, iteration/entry index: 1, key: name, value: bubble gum
# products2, for loop, array item index: 1, iteration/entry index: 0, key: id, value: P2
# products2, for loop, array item index: 1, iteration/entry index: 1, key: name, value: potato chips
