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

# in Perl, JavaScript-like Object is called Hash

# initialization v1
my %friend1 = (
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
);
print("friend1: ", pretty_json_stringify(\%friend1), "\n");

print("friend1, get country: ", $friend1{"country"}, "\n");
# friend1, get country: Finland

# iterate over and get each key-value pair
my @friend1_entries1 = %friend1;
for (my $friend1_entry_index = 0; $friend1_entry_index < scalar(@friend1_entries1); $friend1_entry_index += 2) {
    my $object_key = $friend1_entries1[$friend1_entry_index];
    my $object_value = $friend1_entries1[$friend1_entry_index + 1];
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
for (my $friend1_entry_index = 0; $friend1_entry_index < scalar(@friend1_entries2); $friend1_entry_index += 2) {
    my $object_entry_index = $friend1_entry_index / 2;
    my $object_key = $friend1_entries2[$friend1_entry_index];
    my $object_value = $friend1_entries2[$friend1_entry_index + 1];
    print("friend1, for loop, object iteration/entry index: $object_entry_index, key: $object_key, value: $object_value", "\n");
}
# friend1, for loop, object iteration/entry index: 0, key: name, value: Alisa
# friend1, for loop, object iteration/entry index: 1, key: country, value: Finland
# friend1, for loop, object iteration/entry index: 2, key: age, value: 25

# iterate over and get each key-value pair and object iteration/entry index
my $iteration_index1 = 0;
foreach my $object_key (keys(%friend1)) {
    my $object_value = $friend1{$object_key};
    print("friend1, forEach loop, object iteration/entry index: $iteration_index1, key: $object_key, value: $object_value", "\n");
    $iteration_index1 += 1;
}
# friend1, forEach loop, object iteration/entry index: 0, key: name, value: Alisa
# friend1, forEach loop, object iteration/entry index: 1, key: country, value: Finland
# friend1, forEach loop, object iteration/entry index: 2, key: age, value: 25

# iterate over and get each key-value pair and object iteration/entry index
my $iteration_index2 = 0;
while (my ($object_key, $object_value) = each(%friend1)) {
    print("friend1, while loop, object iteration/entry index: $iteration_index2, key: $object_key, value: $object_value", "\n");
    $iteration_index2 += 1;
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
print("friend2: ", pretty_json_stringify($friend2), "\n");

print("friend2, get country: ", $$friend2{"country"}, "\n");
# friend2, get country: Finland

print("friend2, get country: ", ${$friend2}{"country"}, "\n");
# friend2, get country: Finland

print("friend2, get country: ", $friend2->{"country"}, "\n");
# friend2, get country: Finland

# iterate over and get each key-value pair
my @friend2_entries1 = %{$friend2};
for (my $friend2_entry_index = 0; $friend2_entry_index < scalar(@friend2_entries1); $friend2_entry_index += 2) {
    my $object_key = $friend2_entries1[$friend2_entry_index];
    my $object_value = $friend2_entries1[$friend2_entry_index + 1];
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
for (my $friend2_entry_index = 0; $friend2_entry_index < scalar(@friend2_entries2); $friend2_entry_index += 2) {
    my $object_entry_index = $friend2_entry_index / 2;
    my $object_key = $friend2_entries2[$friend2_entry_index];
    my $object_value = $friend2_entries2[$friend2_entry_index + 1];
    print("friend2, for loop, object iteration/entry index: $object_entry_index, key: $object_key, value: $object_value", "\n");
}
# friend2, for loop, object iteration/entry index: 0, key: name, value: Alisa
# friend2, for loop, object iteration/entry index: 1, key: country, value: Finland
# friend2, for loop, object iteration/entry index: 2, key: age, value: 25

# iterate over and get each key-value pair and object iteration/entry index
my $iteration_index3 = 0;
foreach my $object_key (keys(%{$friend2})) {
    my $object_value = %{$friend2}{$object_key};
    print("friend2, forEach loop, object iteration/entry index: $iteration_index3, key: $object_key, value: $object_value", "\n");
    $iteration_index3 += 1;
}
# friend2, forEach loop, object iteration/entry index: 0, key: name, value: Alisa
# friend2, forEach loop, object iteration/entry index: 1, key: country, value: Finland
# friend2, forEach loop, object iteration/entry index: 2, key: age, value: 25

# iterate over and get each key-value pair and object iteration/entry index
my $iteration_index4 = 0;
foreach my $object_key (keys(%{$friend2})) {
    my $object_value = $friend2->{$object_key};
    print("friend2, forEach loop, object iteration/entry index: $iteration_index4, key: $object_key, value: $object_value", "\n");
    $iteration_index4 += 1;
}
# friend2, forEach loop, object iteration/entry index: 0, key: name, value: Alisa
# friend2, forEach loop, object iteration/entry index: 1, key: country, value: Finland
# friend2, forEach loop, object iteration/entry index: 2, key: age, value: 25

# iterate over and get each key-value pair and object iteration/entry index
my $iteration_index5 = 0;
while (my ($object_key, $object_value) = each(%{$friend2})) {
    print("friend2, while loop, object iteration/entry index: $iteration_index5, key: $object_key, value: $object_value", "\n");
    $iteration_index5 += 1;
}
# friend2, forEach loop, object iteration/entry index: 0, key: name, value: Alisa
# friend2, forEach loop, object iteration/entry index: 1, key: country, value: Finland
# friend2, forEach loop, object iteration/entry index: 2, key: age, value: 25
