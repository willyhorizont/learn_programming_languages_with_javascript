use strict;
use warnings;
use Scalar::Util qw(looks_like_number);

sub json_stringify {
    my ($anything_ref, %optionalar_gument) = @_;
    my $pretty = $optionalar_gument{"pretty"} // 0;
    my $indent = $optionalar_gument{"indent"} // "    ";
    my $indent_level = 0;
    my $json_stringify_inner;
    $json_stringify_inner = sub {
        my ($anything_inner_ref, $indent_inner) = @_;
        return "null" if (!defined($anything_inner_ref));
        return "$anything_inner_ref" if looks_like_number($anything_inner_ref);
        return "\"" . $anything_inner_ref . "\"" if (ref($anything_inner_ref) eq "");
        if (ref($anything_inner_ref) eq "ARRAY") {
            return "[]" if (scalar(@{$anything_inner_ref}) == 0);
            $indent_level += 1;
            my $result = (!$pretty ? "[" : ("[\n" . ($indent_inner x $indent_level)));
            for my $array_item_index (0..(scalar(@{$anything_inner_ref}) - 1)) {
                my $array_item = $anything_inner_ref->[$array_item_index];
                $result .= $json_stringify_inner->($array_item, $indent_inner);
                $result .= (!$pretty ? ", " : (",\n" . ($indent_inner x $indent_level))) if (($array_item_index + 1) != scalar(@{$anything_inner_ref}));
            }
            $indent_level -= 1;
            $result .= (!$pretty ? "]" : ("\n" . ($indent_inner x $indent_level) . "]"));
            return $result;
        }
        if (ref($anything_inner_ref) eq "HASH") {
            return "{}" if (scalar(keys(%{$anything_inner_ref})) == 0);
            $indent_level += 1;
            my $result = (!$pretty ? "{" : ("{\n" . ($indent_inner x $indent_level)));
            my $object_entry_index = 0;
            foreach my $object_key (keys(%{$anything_inner_ref})) {
                my $object_value = $anything_inner_ref->{$object_key};
                $result .= "\"" . $object_key . "\": " . $json_stringify_inner->($object_value, $indent_inner);
                $result .= (!$pretty ? ", " : (",\n" . ($indent_inner x $indent_level))) if (($object_entry_index + 1) != scalar(keys(%{$anything_inner_ref})));
                $object_entry_index += 1;
            }
            $indent_level -= 1;
            $result .= (!$pretty ? "}" : ("\n" . ($indent_inner x $indent_level) . "}"));
            return $result;
        }
        return "null";
    };
    return $json_stringify_inner->($anything_ref, $indent);
}

# in Perl, JavaScript-like Array is called List

# initialization v1
my @fruits = ("apple", "mango", "orange");
print("fruits: ", json_stringify([@fruits]), "\n");
print("fruits: ", json_stringify(\@fruits), "\n");

print("fruits, length: ", scalar(@fruits), "\n");
# fruits, length: 3

print("fruits, length: ", ($#fruits + 1), "\n");
# fruits, length: 3

print("fruits, get mango: ", $fruits[1], "\n");
# fruits, get mango: mango

print("fruits, first element: ", $fruits[0], "\n");
# fruits, first element: apple

print("fruits, last element: ", $fruits[-1], "\n");
# fruits, last element: orange

# iterate over and get each item and index
sub {
    my $array_item_index = 0;
    while ($array_item_index < scalar(@fruits)) {
        my $array_item = $fruits[$array_item_index];
        print("fruits, index: $array_item_index, value: $array_item, while loop", "\n");
        $array_item_index += 1;
    }
}->();
# fruits, index: 0, value: apple, while loop
# fruits, index: 1, value: mango, while loop
# fruits, index: 2, value: orange, while loop

# iterate over and get each item and index
while (my ($array_item_index, $array_item) = each(@fruits)) {
    print("fruits, index: $array_item_index, value: $array_item, while loop", "\n");
}
# fruits, index: 0, value: apple, while loop
# fruits, index: 1, value: mango, while loop
# fruits, index: 2, value: orange, while loop

# iterate over and get each item and index
for (my $array_item_index = 0; $array_item_index < scalar(@fruits); $array_item_index += 1) {
    my $array_item = $fruits[$array_item_index];
    print("fruits, index: $array_item_index, value: $array_item, for loop", "\n");
}
# fruits, index: 0, value: apple, for loop
# fruits, index: 1, value: mango, for loop
# fruits, index: 2, value: orange, for loop

# iterate over and get each item and index
foreach my $array_item_index (0 .. $#fruits) {
    my $array_item = $fruits[$array_item_index];
    print("fruits, index: $array_item_index, value: $array_item, for each loop", "\n");
}
# fruits, index: 0, value: apple, for each loop
# fruits, index: 1, value: mango, for each loop
# fruits, index: 2, value: orange, for each loop

# iterate over and get each item and index
for my $array_item_index (0 .. $#fruits) {
    my $array_item = $fruits[$array_item_index];
    print("fruits, index: $array_item_index, value: $array_item, for each loop", "\n");
}
# fruits, index: 0, value: apple, for each loop
# fruits, index: 1, value: mango, for each loop
# fruits, index: 2, value: orange, for each loop

# iterate over and get each item and index
foreach my $array_item_index (0 .. (scalar(@fruits) - 1)) {
    my $array_item = $fruits[$array_item_index];
    print("fruits, index: $array_item_index, value: $array_item, for each loop", "\n");
}
# fruits, index: 0, value: apple, for each loop
# fruits, index: 1, value: mango, for each loop
# fruits, index: 2, value: orange, for each loop

# iterate over and get each item and index
for my $array_item_index (0 .. (scalar(@fruits) - 1)) {
    my $array_item = $fruits[$array_item_index];
    print("fruits, index: $array_item_index, value: $array_item, for each loop", "\n");
}
# fruits, index: 0, value: apple, for each loop
# fruits, index: 1, value: mango, for each loop
# fruits, index: 2, value: orange, for each loop

# initialization v2
my $fruits_ref = ["apple", "mango", "orange"];
print("fruits_ref: ", json_stringify($fruits_ref), "\n");

print("fruits_ref, length: ", scalar(@{$fruits_ref}), "\n");
# fruits_ref, length: 3

print("fruits_ref, get mango: ", $$fruits_ref[1], "\n");
# fruits_ref, get mango: mango

print("fruits_ref, get mango: ", ${$fruits_ref}[1], "\n");
# fruits_ref, get mango: mango

print("fruits_ref, get mango: ", $fruits_ref->[1], "\n");
# fruits_ref, get mango: mango

print("fruits_ref, first element: ", $$fruits_ref[0], "\n");
# fruits_ref, first element: apple

print("fruits_ref, first element: ", ${$fruits_ref}[0], "\n");
# fruits_ref, first element: apple

print("fruits_ref, first element: ", $fruits_ref->[0], "\n");
# fruits_ref, first element: apple

print("fruits_ref, last element: ", $$fruits_ref[-1], "\n");
# fruits_ref, last element: orange

print("fruits_ref, last element: ", ${$fruits_ref}[-1], "\n");
# fruits_ref, last element: orange

print("fruits_ref, last element: ", $fruits_ref->[-1], "\n");
# fruits_ref, last element: orange

for my $array_item_index (0..(scalar(@{$fruits_ref}) - 1)) { # we can also replace `(scalar(@{$fruits_ref}) - 1)` with `$#{$fruits_ref}`
    my $array_item = @{$fruits_ref}[$array_item_index];
    print("fruits_ref, index: $array_item_index, value: $array_item", "\n");
}
# fruits_ref, for loop, index: 0, value: apple
# fruits_ref, for loop, index: 1, value: mango
# fruits_ref, for loop, index: 2, value: orange

# in Perl, JavaScript-like Array of Objects is called List of Hashes

# initialization v1
my @products = (
    {
        "id" => "P1",
        "name" => "bubble gum"
    },
    {
        "id" => "P2",
        "name" => "potato chips"
    }
);
print("products: ", json_stringify([@products], "pretty" => 1), "\n");
print("products: ", json_stringify(\@products, "pretty" => 1), "\n");

for my $array_item_index (0..(scalar(@products) - 1)) {
    my $array_item = $products[$array_item_index];
    my @object_entries = %{$array_item};
    for (my $object_entry_index = 0; $object_entry_index < scalar(@object_entries); $object_entry_index += 2) {
        my $object_entry_index = $object_entry_index / 2;
        my $object_key = $object_entries[$object_entry_index];
        my $object_value = $object_entries[$object_entry_index + 1];
        print("products, for loop, array item index: $array_item_index, object iteration/entry index: $object_entry_index, key: $object_key, value: $object_value", "\n");
    }
}
# products, for loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
# products, for loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
# products, for loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
# products, for loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips

for my $array_item_index (0..(scalar(@products) - 1)) {
    my $array_item = $products[$array_item_index];
    my $object_entry_index = 0;
    foreach my $object_key (keys(%{$array_item})) {
        my $object_value = %{$array_item}{$object_key};
        print("products, for loop, array item index: $array_item_index, object iteration/entry index: $object_entry_index, key: $object_key, value: $object_value", "\n");
        $object_entry_index += 1;
    }
}
# products, for loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
# products, for loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
# products, for loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
# products, for loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips

for my $array_item_index (0..(scalar(@products) - 1)) {
    my $array_item = $products[$array_item_index];
    my $object_entry_index = 0;
    while (my ($object_key, $object_value) = each(%{$array_item})) {
        print("products, for loop, array item index: $array_item_index, object iteration/entry index: $object_entry_index, key: $object_key, value: $object_value", "\n");
        $object_entry_index += 1;
    }
}
# products, for loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
# products, for loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
# products, for loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
# products, for loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips

# initialization v2
my $products_ref = [
    {
        "id" => "P1",
        "name" => "bubble gum"
    },
    {
        "id" => "P2",
        "name" => "potato chips"
    }
];
print("products_ref: ", json_stringify($products_ref, "pretty" => 1), "\n");

for my $array_item_index (0..(scalar(@{$products_ref}) - 1)) {
    my $array_item = @{$products_ref}[$array_item_index];
    my @object_entries = %{$array_item};
    for (my $object_entry_index = 0; $object_entry_index < scalar(@object_entries); $object_entry_index += 2) {
        my $object_entry_index = $object_entry_index / 2;
        my $object_key = $object_entries[$object_entry_index];
        my $object_value = $object_entries[$object_entry_index + 1];
        print("products_ref, for loop, array item index: $array_item_index, object iteration/entry index: $object_entry_index, key: $object_key, value: $object_value", "\n");
    }
}
# products_ref, for loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
# products_ref, for loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
# products_ref, for loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
# products_ref, for loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips

for my $array_item_index (0..(scalar(@{$products_ref}) - 1)) {
    my $array_item = @{$products_ref}[$array_item_index];
    my $object_entry_index = 0;
    foreach my $object_key (keys(%{$array_item})) {
        my $object_value = %{$array_item}{$object_key};
        print("products_ref, for loop, array item index: $array_item_index, object iteration/entry index: $object_entry_index, key: $object_key, value: $object_value", "\n");
        $object_entry_index += 1;
    }
}
# products_ref, for loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
# products_ref, for loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
# products_ref, for loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
# products_ref, for loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips

for my $array_item_index (0..(scalar(@{$products_ref}) - 1)) {
    my $array_item = @{$products_ref}[$array_item_index];
    my $object_entry_index = 0;
    foreach my $object_key (keys(%{$array_item})) {
        my $object_value = $array_item->{$object_key};
        print("products_ref, for loop, array item index: $array_item_index, object iteration/entry index: $object_entry_index, key: $object_key, value: $object_value", "\n");
        $object_entry_index += 1;
    }
}
# products_ref, for loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
# products_ref, for loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
# products_ref, for loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
# products_ref, for loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips

for my $array_item_index (0..(scalar(@{$products_ref}) - 1)) {
    my $array_item = @{$products_ref}[$array_item_index];
    my $object_entry_index = 0;
    while (my ($object_key, $object_value) = each(%{$array_item})) {
        print("products_ref, for loop, array item index: $array_item_index, object iteration/entry index: $object_entry_index, key: $object_key, value: $object_value", "\n");
        $object_entry_index += 1;
    }
}
# products_ref, for loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
# products_ref, for loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
# products_ref, for loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
# products_ref, for loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips
