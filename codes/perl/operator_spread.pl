use strict;
use warnings;
use JSON;

# There's no JavaScript-like Spread Syntax in Perl.
# But, we can create our own function to mimic it in Perl.

sub spread_syntax_object {
    my %new_object;
    for my $arg_ref (@_) {
        if (ref $arg_ref eq 'HASH') {
            my %arg_item_object = %$arg_ref;
            while (my ($object_key, $object_value) = each %arg_item_object) {
                $new_object{$object_key} = $object_value;
            }
        }
        if (ref $arg_ref eq 'ARRAY') {
            my @arg_item_array = @$arg_ref;
            for my $arg_item_array_index (0..$#arg_item_array) {
                my $array_item_array_item = $arg_item_array[$arg_item_array_index];
                $new_object{$arg_item_array_index} = $array_item_array_item;
            }
        }
    }
    return %new_object;
};

sub spread_syntax_array {
    my @new_array;
    for my $array_of_array_item_ref (@_) {
        my @array_of_array_item_ref = @$array_of_array_item_ref;
        push(@new_array, @array_of_array_item_ref);
    }
    return @new_array;
};

print("\n# Spread Syntax in Perl Array\n");

my @my_fruits_in_fridge = ("apple", "mango", "orange");
print("my fruits in fridge: " , "[", join(", ", @my_fruits_in_fridge), "]", "\n");

my @my_fruits_from_grocery_store = ("melon", "banana");
print("my fruits from grocery store: " , "[", join(", ", @my_fruits_from_grocery_store), "]", "\n");

my @my_fruits1 = spread_syntax_array(\@my_fruits_in_fridge, \@my_fruits_from_grocery_store);
print("my fruits1: " , "[", join(", ", @my_fruits1), "]", "\n");
# my fruits: ["apple", "mango", "orange", "melon", "banana"]

my @my_fruits2 = spread_syntax_array(\@my_fruits_in_fridge, ["kiwi"]);
print("my fruits2: " , "[", join(", ", @my_fruits2), "]", "\n");
# my fruits: ["apple", "mango", "orange", "melon", "banana"]

print("\n# Spread Syntax in Perl Array of Hashes\n");

my %general_car = (
    "wheels" => 4,
    "tires" => 4
);
print("\ngeneral car: ", JSON->new->allow_nonref->pretty->encode(\%general_car));

my %minivan_car_properties = (
    "doors" => 4
);
my %minivan_car = spread_syntax_object(\%general_car, \%minivan_car_properties);
print("\nminivan car: ", JSON->new->allow_nonref->pretty->encode(\%minivan_car));
# minivan car: {
#     "wheels": 4,
#     "tires": 4,
#     "doors": 4
# }

my %super_car = spread_syntax_object(\%general_car, {"doors" => 2});
print("\nsuper car: ", JSON->new->allow_nonref->pretty->encode(\%super_car));
# super car: {
#     "wheels": 4,
#     "tires": 4,
#     "doors": 2
# }