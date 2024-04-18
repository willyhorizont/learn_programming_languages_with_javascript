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

# in Perl, JavaScript-like Object is called Hash

# initialization v1
my %friend1 = (
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
);
print("friend1: ", json_stringify(\%friend1, "pretty" => 1), "\n");

print("friend1, get country: ", $friend1{"country"}, "\n");
# friend1, get country: Finland

print("friend1, get total object keys: ", scalar(keys(%friend1)), "\n");
# friend1, get total object keys: 3

# iterate over and get each key-value pair
my @friend1_entries1 = %friend1;
for (my $friend1_entries1 = 0; ($friend1_entries1 < scalar(@friend1_entries1)); $friend1_entries1 += 2) {
    my $object_key = $friend1_entries1[$friend1_entries1];
    my $object_value = $friend1_entries1[$friend1_entries1 + 1];
    print("friend1, for loop, key: $object_key, value: $object_value", "\n");
}
# friend1, for loop, key: name, value: Alisa
# friend1, for loop, key: country, value: Finland
# friend1, for loop, key: age, value: 25

# iterate over and get each key-value pair
foreach my $object_key (keys(%friend1)) {
    my $object_value = $friend1{$object_key};
    print("friend1, forEach loop, key: $object_key, value: $object_value", "\n");
}
# friend1, forEach loop, key: name, value: Alisa
# friend1, forEach loop, key: country, value: Finland
# friend1, forEach loop, key: age, value: 25

# iterate over and get each key-value pair
while (my ($object_key, $object_value) = each(%friend1)) {
    print("friend1, while loop, key: $object_key, value: $object_value", "\n");
}
# friend1, forEach loop, key: name, value: Alisa
# friend1, forEach loop, key: country, value: Finland
# friend1, forEach loop, key: age, value: 25

# iterate over and get each key-value pair and object iteration/entry index
my @friend1_entries2 = %friend1;
for (my $object_entries_index = 0; ($object_entries_index < scalar(@friend1_entries2)); $object_entries_index += 2) {
    my $object_entry_index = ($object_entries_index / 2);
    my $object_key = $friend1_entries2[$object_entry_index];
    my $object_value = $friend1_entries2[$object_entry_index + 1];
    print("friend1, for loop, object iteration/entry index: $object_entry_index, key: $object_key, value: $object_value", "\n");
}
# friend1, for loop, object iteration/entry index: 0, key: name, value: Alisa
# friend1, for loop, object iteration/entry index: 1, key: country, value: Finland
# friend1, for loop, object iteration/entry index: 2, key: age, value: 25

# iterate over and get each key-value pair and object iteration/entry index
my $iteration_index2 = 0;
while (my ($object_key, $object_value) = each(%friend1)) {
    print("friend1, while loop, object iteration/entry index: $iteration_index2, key: $object_key, value: $object_value", "\n");
    $iteration_index2 += 1;
}
# friend1, forEach loop, object iteration/entry index: 0, key: name, value: Alisa
# friend1, forEach loop, object iteration/entry index: 1, key: country, value: Finland
# friend1, forEach loop, object iteration/entry index: 2, key: age, value: 25

# iterate over and get each key-value pair and object iteration/entry index (the best way)
my $iteration_index1 = 0;
foreach my $object_key (keys(%friend1)) {
    my $object_value = $friend1{$object_key};
    print("friend1, forEach loop, object iteration/entry index: $iteration_index1, key: $object_key, value: $object_value", "\n");
    $iteration_index1 += 1;
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
print("friend2: ", json_stringify($friend2, "pretty" => 1), "\n");

print("friend2, get country: ", $$friend2{"country"}, "\n");
# friend2, get country: Finland

print("friend2, get country: ", ${$friend2}{"country"}, "\n");
# friend2, get country: Finland

print("friend2, get country: ", $friend2->{"country"}, "\n");
# friend2, get country: Finland

print("friend2, get total object keys: ", scalar(keys(%{$friend2})), "\n");
# friend2, get total object keys: 3

# iterate over and get each key-value pair
my @friend2_entries1 = %{$friend2};
for (my $friend2_entries1_index = 0; ($friend2_entries1_index < scalar(@friend2_entries1)); $friend2_entries1_index += 2) {
    my $object_key = $friend2_entries1[$friend2_entries1_index];
    my $object_value = $friend2_entries1[$friend2_entries1_index + 1];
    print("friend2, for loop, key: $object_key, value: $object_value", "\n");
}
# friend2, for loop, key: name, value: Alisa
# friend2, for loop, key: country, value: Finland
# friend2, for loop, key: age, value: 25

# iterate over and get each key-value pair
foreach my $object_key (keys(%{$friend2})) {
    my $object_value = %$friend2{$object_key};
    print("friend2, forEach loop, key: $object_key, value: $object_value", "\n");
}
# friend2, forEach loop, key: name, value: Alisa
# friend2, forEach loop, key: country, value: Finland
# friend2, forEach loop, key: age, value: 25

# iterate over and get each key-value pair
foreach my $object_key (keys(%{$friend2})) {
    my $object_value = %{$friend2}{$object_key};
    print("friend2, forEach loop, key: $object_key, value: $object_value", "\n");
}
# friend2, forEach loop, key: name, value: Alisa
# friend2, forEach loop, key: country, value: Finland
# friend2, forEach loop, key: age, value: 25

# iterate over and get each key-value pair
foreach my $object_key (keys(%{$friend2})) {
    my $object_value = $friend2->{$object_key};
    print("friend2, forEach loop, key: $object_key, value: $object_value", "\n");
}
# friend2, forEach loop, key: name, value: Alisa
# friend2, forEach loop, key: country, value: Finland
# friend2, forEach loop, key: age, value: 25

# iterate over and get each key-value pair
while (my ($object_key, $object_value) = each(%{$friend2})) {
    print("friend2, while loop, key: $object_key, value: $object_value", "\n");
}
# friend2, forEach loop, key: name, value: Alisa
# friend2, forEach loop, key: country, value: Finland
# friend2, forEach loop, key: age, value: 25

# iterate over and get each key-value pair and object iteration/entry index
my @friend2_entries2 = %{$friend2};
for (my $object_entries_index = 0; ($object_entries_index < scalar(@friend2_entries2)); $object_entries_index += 2) {
    my $object_entry_index = ($object_entries_index / 2);
    my $object_key = $friend2_entries2[$object_entry_index];
    my $object_value = $friend2_entries2[$object_entry_index + 1];
    print("friend2, for loop, object iteration/entry index: $object_entry_index, key: $object_key, value: $object_value", "\n");
}
# friend2, for loop, object iteration/entry index: 0, key: name, value: Alisa
# friend2, for loop, object iteration/entry index: 1, key: country, value: Finland
# friend2, for loop, object iteration/entry index: 2, key: age, value: 25

# iterate over and get each key-value pair and object iteration/entry index
my $iteration_index5 = 0;
while (my ($object_key, $object_value) = each(%{$friend2})) {
    print("friend2, while loop, object iteration/entry index: $iteration_index5, key: $object_key, value: $object_value", "\n");
    $iteration_index5 += 1;
}
# friend2, forEach loop, object iteration/entry index: 0, key: name, value: Alisa
# friend2, forEach loop, object iteration/entry index: 1, key: country, value: Finland
# friend2, forEach loop, object iteration/entry index: 2, key: age, value: 25

# iterate over and get each key-value pair and object iteration/entry index (the best way)
my $iteration_index3 = 0;
foreach my $object_key (keys(%{$friend2})) {
    my $object_value = %{$friend2}{$object_key};
    print("friend2, forEach loop, object iteration/entry index: $iteration_index3, key: $object_key, value: $object_value", "\n");
    $iteration_index3 += 1;
}
# friend2, forEach loop, object iteration/entry index: 0, key: name, value: Alisa
# friend2, forEach loop, object iteration/entry index: 1, key: country, value: Finland
# friend2, forEach loop, object iteration/entry index: 2, key: age, value: 25

# iterate over and get each key-value pair and object iteration/entry index (the best way)
my $iteration_index4 = 0;
foreach my $object_key (keys(%{$friend2})) {
    my $object_value = $friend2->{$object_key};
    print("friend2, forEach loop, object iteration/entry index: $iteration_index4, key: $object_key, value: $object_value", "\n");
    $iteration_index4 += 1;
}
# friend2, forEach loop, object iteration/entry index: 0, key: name, value: Alisa
# friend2, forEach loop, object iteration/entry index: 1, key: country, value: Finland
# friend2, forEach loop, object iteration/entry index: 2, key: age, value: 25
