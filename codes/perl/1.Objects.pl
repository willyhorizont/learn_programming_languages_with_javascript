# initialization v1
my %friend1 = (
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
);

# iterate over and get each key-value pair
my @friend1_data = %friend1;
for (my $friend1_data_index = 0; $friend1_data_index < scalar(@friend1_data); $friend1_data_index += 2) {
    my $object_key = $friend1_data[$friend1_data_index];
    my $object_value = $friend1_data[$friend1_data_index + 1];
    print("friend1, for loop, key: $object_key, value: $object_value\n");
}
# friend1, for loop, key: name, value: Alisa
# friend1, for loop, key: country, value: Finland
# friend1, for loop, key: age, value: 25

# iterate over and get each key-value pair
while (my ($object_key, $object_value) = each %friend1) {
    print("friend1, while loop, key: $object_key, value: $object_value\n");
}
# friend1, while loop, key: age, value: 25
# friend1, while loop, key: country, value: Finland
# friend1, while loop, key: name, value: Alisa

# initialization v2
my $friend2 = {
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
};

# iterate over and get each key-value pair
my @friend2_data = %{$friend2};
for (my $friend2_data_index = 0; $friend2_data_index < scalar(@friend2_data); $friend2_data_index += 2) {
    my $object_key = $friend2_data[$friend2_data_index];
    my $object_value = $friend2_data[$friend2_data_index + 1];
    print("friend2, for loop, key: $object_key, value: $object_value\n");
}
# friend2, for loop, key: name, value: Alisa
# friend2, for loop, key: country, value: Finland
# friend2, for loop, key: age, value: 25

# iterate over and get each key-value pair
while (my ($object_key, $object_value) = each %{$friend2}) {
    print("friend2, while loop, key: $object_key, value: $object_value\n");
}
# friend2, while loop, key: country, value: Finland
# friend2, while loop, key: age, value: 25
# friend2, while loop, key: name, value: Alisa
