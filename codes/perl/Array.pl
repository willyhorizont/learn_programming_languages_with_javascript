my @my_fruits_in_fridge = ("apple", "mango", "orange");

print("\$#my_fruits_in_fridge: ", $#my_fruits_in_fridge, "\n");
print("array length: ", scalar @my_fruits_in_fridge, "\n");

for my $array_item_index (0..$#my_fruits_in_fridge) {
    my $array_item = $my_fruits_in_fridge[$array_item_index];
    print($array_item_index, "\n");
}

# $#my_fruits_in_fridge: 2
# array length: 3
# 0
# 1
# 2