use strict;
use warnings;
use Scalar::Util qw(looks_like_number);

sub json_stringify {
    my ($anything_ref, %additional_parameter) = @_;
    my $pretty = $additional_parameter{"pretty"} // 0;
    my $indent = $additional_parameter{"indent"} // "    ";
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
my @fruits1 = ("apple", "mango", "orange");
print("fruits1: ", json_stringify(\@fruits1), "\n");

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
    print("fruits1, index: $array_item_index, value: $array_item", "\n");
}
# fruits1, for loop, index: 0, value: apple
# fruits1, for loop, index: 1, value: mango
# fruits1, for loop, index: 2, value: orange

# initialization v2
my $fruits2 = ["apple", "mango", "orange"];
print("fruits2: ", json_stringify($fruits2), "\n");

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

for my $array_item_index (0..(scalar(@{$fruits2}) - 1)) { # we can also replace `(scalar(@{$fruits2}) - 1)` with `$#{$fruits2}`
    my $array_item = @{$fruits2}[$array_item_index];
    print("fruits2, index: $array_item_index, value: $array_item", "\n");
}
# fruits2, for loop, index: 0, value: apple
# fruits2, for loop, index: 1, value: mango
# fruits2, for loop, index: 2, value: orange

# in Perl, JavaScript-like Array of Objects is called List of Hashes

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
print("products1: ", json_stringify(\@products1, "pretty" => 1), "\n");

for my $array_item_index (0..(scalar(@products1) - 1)) {
    my $array_item = $products1[$array_item_index];
    my @object_entries = %{$array_item};
    for (my $object_entry_index = 0; $object_entry_index < scalar(@object_entries); $object_entry_index += 2) {
        my $object_entry_index = $object_entry_index / 2;
        my $object_key = $object_entries[$object_entry_index];
        my $object_value = $object_entries[$object_entry_index + 1];
        print("products1, for loop, array item index: $array_item_index, object iteration/entry index: $object_entry_index, key: $object_key, value: $object_value", "\n");
    }
}
# products1, for loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
# products1, for loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
# products1, for loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
# products1, for loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips

for my $array_item_index (0..(scalar(@products1) - 1)) {
    my $array_item = $products1[$array_item_index];
    my $object_entry_index = 0;
    foreach my $object_key (keys(%{$array_item})) {
        my $object_value = %{$array_item}{$object_key};
        print("products1, for loop, array item index: $array_item_index, object iteration/entry index: $object_entry_index, key: $object_key, value: $object_value", "\n");
        $object_entry_index += 1;
    }
}
# products1, for loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
# products1, for loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
# products1, for loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
# products1, for loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips

for my $array_item_index (0..(scalar(@products1) - 1)) {
    my $array_item = $products1[$array_item_index];
    my $object_entry_index = 0;
    while (my ($object_key, $object_value) = each(%{$array_item})) {
        print("products1, for loop, array item index: $array_item_index, object iteration/entry index: $object_entry_index, key: $object_key, value: $object_value", "\n");
        $object_entry_index += 1;
    }
}
# products1, for loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
# products1, for loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
# products1, for loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
# products1, for loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips

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
print("products2: ", json_stringify($products2, "pretty" => 1), "\n");

for my $array_item_index (0..(scalar(@{$products2}) - 1)) {
    my $array_item = @{$products2}[$array_item_index];
    my @object_entries = %{$array_item};
    for (my $object_entry_index = 0; $object_entry_index < scalar(@object_entries); $object_entry_index += 2) {
        my $object_entry_index = $object_entry_index / 2;
        my $object_key = $object_entries[$object_entry_index];
        my $object_value = $object_entries[$object_entry_index + 1];
        print("products2, for loop, array item index: $array_item_index, object iteration/entry index: $object_entry_index, key: $object_key, value: $object_value", "\n");
    }
}
# products2, for loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
# products2, for loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
# products2, for loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
# products2, for loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips

for my $array_item_index (0..(scalar(@{$products2}) - 1)) {
    my $array_item = @{$products2}[$array_item_index];
    my $object_entry_index = 0;
    foreach my $object_key (keys(%{$array_item})) {
        my $object_value = %{$array_item}{$object_key};
        print("products2, for loop, array item index: $array_item_index, object iteration/entry index: $object_entry_index, key: $object_key, value: $object_value", "\n");
        $object_entry_index += 1;
    }
}
# products2, for loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
# products2, for loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
# products2, for loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
# products2, for loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips

for my $array_item_index (0..(scalar(@{$products2}) - 1)) {
    my $array_item = @{$products2}[$array_item_index];
    my $object_entry_index = 0;
    foreach my $object_key (keys(%{$array_item})) {
        my $object_value = $array_item->{$object_key};
        print("products2, for loop, array item index: $array_item_index, object iteration/entry index: $object_entry_index, key: $object_key, value: $object_value", "\n");
        $object_entry_index += 1;
    }
}
# products2, for loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
# products2, for loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
# products2, for loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
# products2, for loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips

for my $array_item_index (0..(scalar(@{$products2}) - 1)) {
    my $array_item = @{$products2}[$array_item_index];
    my $object_entry_index = 0;
    while (my ($object_key, $object_value) = each(%{$array_item})) {
        print("products2, for loop, array item index: $array_item_index, object iteration/entry index: $object_entry_index, key: $object_key, value: $object_value", "\n");
        $object_entry_index += 1;
    }
}
# products2, for loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
# products2, for loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
# products2, for loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
# products2, for loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips
