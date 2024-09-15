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

# in Perl, JavaScript-like Object is called Hash

# initialization v1
my %friend = (
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
);
print("friend: ", json_stringify({%friend}, "pretty" => 1), "\n");
print("friend: ", json_stringify(\%friend, "pretty" => 1), "\n");

print("friend, get total object keys: ", scalar(keys(%friend)), "\n");
# friend, get total object keys: 3

print("friend, get country: ", $friend{"country"}, "\n");
# friend, get country: Finland

# iterate over and get each key-value pair
my @friend1_entries1 = %friend;
for (my $friend1_entries1 = 0; ($friend1_entries1 < scalar(@friend1_entries1)); $friend1_entries1 += 2) {
    my $object_key = $friend1_entries1[$friend1_entries1];
    my $object_value = $friend1_entries1[$friend1_entries1 + 1];
    print("friend, for loop, key: $object_key, value: $object_value", "\n");
}
# friend, for loop, key: name, value: Alisa
# friend, for loop, key: country, value: Finland
# friend, for loop, key: age, value: 25

# iterate over and get each key-value pair
foreach my $object_key (keys(%friend)) {
    my $object_value = $friend{$object_key};
    print("friend, forEach loop, key: $object_key, value: $object_value", "\n");
}
# friend, forEach loop, key: name, value: Alisa
# friend, forEach loop, key: country, value: Finland
# friend, forEach loop, key: age, value: 25

# iterate over and get each key-value pair
while (my ($object_key, $object_value) = each(%friend)) {
    print("friend, while loop, key: $object_key, value: $object_value", "\n");
}
# friend, forEach loop, key: name, value: Alisa
# friend, forEach loop, key: country, value: Finland
# friend, forEach loop, key: age, value: 25

# iterate over and get each key-value pair and object iteration/entry index
my @friend1_entries2 = %friend;
for (my $object_entries_index = 0; ($object_entries_index < scalar(@friend1_entries2)); $object_entries_index += 2) {
    my $object_entry_index = ($object_entries_index / 2);
    my $object_key = $friend1_entries2[$object_entry_index];
    my $object_value = $friend1_entries2[$object_entry_index + 1];
    print("friend, for loop, object iteration/entry index: $object_entry_index, key: $object_key, value: $object_value", "\n");
}
# friend, for loop, object iteration/entry index: 0, key: name, value: Alisa
# friend, for loop, object iteration/entry index: 1, key: country, value: Finland
# friend, for loop, object iteration/entry index: 2, key: age, value: 25

# iterate over and get each key-value pair and object iteration/entry index
my $iteration_index2 = 0;
while (my ($object_key, $object_value) = each(%friend)) {
    print("friend, while loop, object iteration/entry index: $iteration_index2, key: $object_key, value: $object_value", "\n");
    $iteration_index2 += 1;
}
# friend, forEach loop, object iteration/entry index: 0, key: name, value: Alisa
# friend, forEach loop, object iteration/entry index: 1, key: country, value: Finland
# friend, forEach loop, object iteration/entry index: 2, key: age, value: 25

# iterate over and get each key-value pair and object iteration/entry index (the best way)
my $iteration_index1 = 0;
foreach my $object_key (keys(%friend)) {
    my $object_value = $friend{$object_key};
    print("friend, forEach loop, object iteration/entry index: $iteration_index1, key: $object_key, value: $object_value", "\n");
    $iteration_index1 += 1;
}
# friend, forEach loop, object iteration/entry index: 0, key: name, value: Alisa
# friend, forEach loop, object iteration/entry index: 1, key: country, value: Finland
# friend, forEach loop, object iteration/entry index: 2, key: age, value: 25

$friend{"age"} = 27;
print("friend: ", json_stringify({%friend}, "pretty" => 1), "\n");
print("friend: ", json_stringify(\%friend, "pretty" => 1), "\n");

$friend{"gender"} = "Female";
print("friend: ", json_stringify({%friend}, "pretty" => 1), "\n");
print("friend: ", json_stringify(\%friend, "pretty" => 1), "\n");

delete $friend{"country"};
print("friend: ", json_stringify({%friend}, "pretty" => 1), "\n");
print("friend: ", json_stringify(\%friend, "pretty" => 1), "\n");

# Computed property names: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Object_initializer#computed_property_names
my $delivery_response_key_message = "message";
my %delivery_response = (
    $delivery_response_key_message => "ok"
);
print("delivery_response: ", json_stringify({%delivery_response}, "pretty" => 1), "\n");
print("delivery_response: ", json_stringify(\%delivery_response, "pretty" => 1), "\n");
my $delivery_response_key_status = "status";
$delivery_response{$delivery_response_key_status} = 200;
print("delivery_response: ", json_stringify({%delivery_response}, "pretty" => 1), "\n");
print("delivery_response: ", json_stringify(\%delivery_response, "pretty" => 1), "\n");

# initialization v2
my $friend_ref = {
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
};
print("friend_ref: ", json_stringify(\%{$friend_ref}, "pretty" => 1), "\n");
print("friend_ref: ", json_stringify($friend_ref, "pretty" => 1), "\n");

print("friend_ref, get total object keys: ", scalar(keys(%{$friend_ref})), "\n");
# friend_ref, get total object keys: 3

print("friend_ref, get country: ", $$friend_ref{"country"}, "\n");
# friend_ref, get country: Finland

print("friend_ref, get country: ", ${$friend_ref}{"country"}, "\n");
# friend_ref, get country: Finland

# (the best way)
print("friend_ref, get country: ", $friend_ref->{"country"}, "\n");
# friend_ref, get country: Finland

# iterate over and get each key-value pair
my @friend2_entries1 = %{$friend_ref};
for (my $friend2_entries1_index = 0; ($friend2_entries1_index < scalar(@friend2_entries1)); $friend2_entries1_index += 2) {
    my $object_key = $friend2_entries1[$friend2_entries1_index];
    my $object_value = $friend2_entries1[$friend2_entries1_index + 1];
    print("friend_ref, for loop, key: $object_key, value: $object_value", "\n");
}
# friend_ref, for loop, key: name, value: Alisa
# friend_ref, for loop, key: country, value: Finland
# friend_ref, for loop, key: age, value: 25

# iterate over and get each key-value pair
foreach my $object_key (keys(%{$friend_ref})) {
    my $object_value = %$friend_ref{$object_key};
    print("friend_ref, forEach loop, key: $object_key, value: $object_value", "\n");
}
# friend_ref, forEach loop, key: name, value: Alisa
# friend_ref, forEach loop, key: country, value: Finland
# friend_ref, forEach loop, key: age, value: 25

# iterate over and get each key-value pair
foreach my $object_key (keys(%{$friend_ref})) {
    my $object_value = %{$friend_ref}{$object_key};
    print("friend_ref, forEach loop, key: $object_key, value: $object_value", "\n");
}
# friend_ref, forEach loop, key: name, value: Alisa
# friend_ref, forEach loop, key: country, value: Finland
# friend_ref, forEach loop, key: age, value: 25

# iterate over and get each key-value pair
foreach my $object_key (keys(%{$friend_ref})) {
    my $object_value = $friend_ref->{$object_key};
    print("friend_ref, forEach loop, key: $object_key, value: $object_value", "\n");
}
# friend_ref, forEach loop, key: name, value: Alisa
# friend_ref, forEach loop, key: country, value: Finland
# friend_ref, forEach loop, key: age, value: 25

# iterate over and get each key-value pair
while (my ($object_key, $object_value) = each(%{$friend_ref})) {
    print("friend_ref, while loop, key: $object_key, value: $object_value", "\n");
}
# friend_ref, forEach loop, key: name, value: Alisa
# friend_ref, forEach loop, key: country, value: Finland
# friend_ref, forEach loop, key: age, value: 25

# iterate over and get each key-value pair and object iteration/entry index
my @friend2_entries2 = %{$friend_ref};
for (my $object_entries_index = 0; ($object_entries_index < scalar(@friend2_entries2)); $object_entries_index += 2) {
    my $object_entry_index = ($object_entries_index / 2);
    my $object_key = $friend2_entries2[$object_entry_index];
    my $object_value = $friend2_entries2[$object_entry_index + 1];
    print("friend_ref, for loop, object iteration/entry index: $object_entry_index, key: $object_key, value: $object_value", "\n");
}
# friend_ref, for loop, object iteration/entry index: 0, key: name, value: Alisa
# friend_ref, for loop, object iteration/entry index: 1, key: country, value: Finland
# friend_ref, for loop, object iteration/entry index: 2, key: age, value: 25

# iterate over and get each key-value pair and object iteration/entry index
my $iteration_index5 = 0;
while (my ($object_key, $object_value) = each(%{$friend_ref})) {
    print("friend_ref, while loop, object iteration/entry index: $iteration_index5, key: $object_key, value: $object_value", "\n");
    $iteration_index5 += 1;
}
# friend_ref, forEach loop, object iteration/entry index: 0, key: name, value: Alisa
# friend_ref, forEach loop, object iteration/entry index: 1, key: country, value: Finland
# friend_ref, forEach loop, object iteration/entry index: 2, key: age, value: 25

# iterate over and get each key-value pair and object iteration/entry index (the best way)
my $iteration_index3 = 0;
foreach my $object_key (keys(%{$friend_ref})) {
    my $object_value = %{$friend_ref}{$object_key};
    print("friend_ref, forEach loop, object iteration/entry index: $iteration_index3, key: $object_key, value: $object_value", "\n");
    $iteration_index3 += 1;
}
# friend_ref, forEach loop, object iteration/entry index: 0, key: name, value: Alisa
# friend_ref, forEach loop, object iteration/entry index: 1, key: country, value: Finland
# friend_ref, forEach loop, object iteration/entry index: 2, key: age, value: 25

# iterate over and get each key-value pair and object iteration/entry index (the best way)
my $iteration_index4 = 0;
foreach my $object_key (keys(%{$friend_ref})) {
    my $object_value = $friend_ref->{$object_key};
    print("friend_ref, forEach loop, object iteration/entry index: $iteration_index4, key: $object_key, value: $object_value", "\n");
    $iteration_index4 += 1;
}
# friend_ref, forEach loop, object iteration/entry index: 0, key: name, value: Alisa
# friend_ref, forEach loop, object iteration/entry index: 1, key: country, value: Finland
# friend_ref, forEach loop, object iteration/entry index: 2, key: age, value: 25

$friend_ref->{"age"} = 27;
print("friend_ref: ", json_stringify(\%{$friend_ref}, "pretty" => 1), "\n");
print("friend_ref: ", json_stringify($friend_ref, "pretty" => 1), "\n");

$friend_ref->{"gender"} = "Female";
print("friend_ref: ", json_stringify(\%{$friend_ref}, "pretty" => 1), "\n");
print("friend_ref: ", json_stringify($friend_ref, "pretty" => 1), "\n");

delete $friend_ref->{"country"};
print("friend_ref: ", json_stringify(\%{$friend_ref}, "pretty" => 1), "\n");
print("friend_ref: ", json_stringify($friend_ref, "pretty" => 1), "\n");

# Computed property names: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Object_initializer#computed_property_names
my $delivery_response_ref_key_message = "message";
my $delivery_response_ref = {
    $delivery_response_ref_key_message => "ok"
};
print("delivery_response_ref: ", json_stringify(\%{$delivery_response_ref}, "pretty" => 1), "\n");
print("delivery_response_ref: ", json_stringify($delivery_response_ref, "pretty" => 1), "\n");
my $delivery_response_ref_key_status = "status";
$delivery_response_ref->{$delivery_response_ref_key_status} = 200;
print("delivery_response_ref: ", json_stringify(\%{$delivery_response_ref}, "pretty" => 1), "\n");
print("delivery_response_ref: ", json_stringify($delivery_response_ref, "pretty" => 1), "\n");
