use strict;
use warnings;

print("\n# JavaScript-like Spread Syntax (...) in Perl", "\n");

sub json_stringify {
    use JSON;
    my ($anything_ref, %additional_parameter) = @_;
    my $pretty = $additional_parameter{"pretty"} // 0;
    my $indent = $additional_parameter{"indent"} // "    ";
    return JSON->new->allow_nonref->space_after->encode($anything_ref) if ($pretty == 0);
    my $json_string_pretty = JSON->new->allow_nonref->pretty->encode($anything_ref);
    $json_string_pretty =~ s/   /$indent/g;
    $json_string_pretty =~ s/\n$//g;
    return $json_string_pretty;
}

sub array_to_object {
    my %new_object;
    for (my $array_item_index = 0; $array_item_index < scalar(@_); $array_item_index += 1) {
        my $array_item = $_[$array_item_index];
        $new_object{"$array_item_index"} = $array_item;
    }
    return %new_object;
}

my @fruits = ("Mango", "Melon", "Banana");
print("fruits: ", json_stringify(\@fruits), "\n");

my @vegetables = ("Carrot", "Tomato");
print("vegetables: ", json_stringify(\@vegetables), "\n");

my %country_capitals_in_asia = (
    "Thailand" => "Bangkok",
    "China" => "Beijing",
    "Japan" => "Tokyo"
);
print("country_capitals_in_asia: ", json_stringify(\%country_capitals_in_asia, "pretty" => 1), "\n");

my %country_capitals_in_europe = (
    "France" => "Paris",
    "England" => "London"
);
print("country_capitals_in_europe: ", json_stringify(\%country_capitals_in_europe, "pretty" => 1), "\n");

print("\n# [...array1, ...array2]:\n", "\n");

my @combination1 = (@fruits, @vegetables);
print("combination1: ", json_stringify(\@combination1, "pretty" => 1), "\n");
# combination1: [
#     "Mango",
#     "Melon",
#     "Banana",
#     "Carrot",
#     "Tomato"
# ]

my @combination2 = (@fruits, ("Cucumber", "Cabbage"));
print("combination2: ", json_stringify(\@combination2, "pretty" => 1), "\n");
# combination2: [
#     "Mango",
#     "Melon",
#     "Banana",
#     "Cucumber",
#     "Cabbage"
# ]

print("\n# { ...object1, ...object2 }:\n", "\n");

my %combination3 = (%country_capitals_in_asia, %country_capitals_in_europe);
print("combination3: ", json_stringify(\%combination3, "pretty" => 1), "\n");
# combination3: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "France": "Paris",
#     "England": "London"
# }

my %combination4 = (%country_capitals_in_asia, ("Germany" => "Berlin", "Italy" => "Rome"));
print("combination4: ", json_stringify(\%combination4, "pretty" => 1), "\n");
# combination4: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "Germany": "Berlin",
#     "Italy": "Rome"
# }

print("\n# [...array1, array2] || [...array1, newArrayItem1, newArrayItem2]:\n", "\n");

my @combination5 = (@fruits, \@vegetables);
print("combination5: ", json_stringify(\@combination5, "pretty" => 1), "\n");
# combination5: [
#     "Mango",
#     "Melon",
#     "Banana",
#     [
#         "Carrot",
#         "Tomato"
#     ]
# ]

my @combination6 = (@fruits, ["Cucumber", "Cabbage"]);
print("combination6: ", json_stringify(\@combination6, "pretty" => 1), "\n");
# combination6: [
#     "Mango",
#     "Melon",
#     "Banana",
#     [
#         "Cucumber",
#         "Cabbage"
#     ]
# ]

print("\n# [...array1, object1] || [...array1, newArrayItem1, newArrayItem2]:\n", "\n");

my @combination7 = (@fruits, \%country_capitals_in_asia);
print("combination7: ", json_stringify(\@combination7, "pretty" => 1), "\n");
# combination7: [
#     "Mango",
#     "Melon",
#     "Banana",
#     {
#         "Thailand": "Bangkok",
#         "China": "Beijing",
#         "Japan": "Tokyo"
#     }
# ]

my @combination8 = (@fruits, {"Germany" => "Berlin", "Italy" => "Rome"} );
print("combination8: ", json_stringify(\@combination8, "pretty" => 1), "\n");
# combination8: [
#     "Mango",
#     "Melon",
#     "Banana",
#     {
#         "Germany": "Berlin",
#         "Italy": "Rome"
#     }
# ]

print("\n# { ...object1, object2 } || { ...object1, objectKey: objectValue }:\n", "\n");

my %combination9 = (%country_capitals_in_asia, ("country_capitals_in_europe" => \%country_capitals_in_europe));
print("combination9: ", json_stringify(\%combination9, "pretty" => 1), "\n");
# combination9: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "country_capitals_in_europe" : {
#       "France" : "Paris",
#       "England" : "London"
#    }
# }

my %combination10 = (%country_capitals_in_asia, ("country_capitals_in_europe" => {"Germany" => "Berlin", "Italy" => "Rome"}));
print("combination10: ", json_stringify(\%combination10, "pretty" => 1), "\n");
# combination10: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "country_capitals_in_europe": {
#         "Germany": "Berlin",
#         "Italy": "Rome"
#     }
# }

print("\n# { ...object1, array2 } || { ...object1, objectKey: objectValue }:\n", "\n");

my %combination11 = (%country_capitals_in_asia, ("vegetables" => \@vegetables));
print("combination11: ", json_stringify(\%combination11, "pretty" => 1), "\n");
# combination11: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "vegetables": [
#         "Carrot",
#         "Tomato"
#     ]
# }

my %combination12 = (%country_capitals_in_asia, ("vegetables" => ["Cucumber", "Cabbage"]));
print("combination12: ", json_stringify(\%combination12, "pretty" => 1), "\n");
# combination12: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "vegetables": [
#         "Cucumber",
#         "Cabbage"
#     ]
# }

print("\n# { ...object1, ...array2 }:\n", "\n");

my %combination13 = (%country_capitals_in_asia, array_to_object(@vegetables));
print("combination13: ", json_stringify(\%combination13, "pretty" => 1), "\n");
# combination13: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "0" : "Carrot",
#    "1" : "Tomato"
# }

my %combination14 = (%country_capitals_in_asia, array_to_object("Cucumber", "Cabbage"));
print("combination14: ", json_stringify(\%combination14, "pretty" => 1), "\n");
# combination14: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "0" : "Cucumber",
#    "1" : "Cabbage"
# }

# print("\n# [...array1, ...object1]: # this combination throw an error in JavaScript\n", "\n");

# this combination throw an error in JavaScript
# my @combination_error_in_javascript1 = (@fruits, %country_capitals_in_asia);
# print("combination_error_in_javascript1: ", json_stringify(\@combination_error_in_javascript1, "pretty" => 1), "\n");

# this combination throw an error in JavaScript
# my @combination_error_in_javascript2 = (@fruits, ("country_capitals_in_europe" => {"Germany" => "Berlin", "Italy" => "Rome"}));
# print("combination_error_in_javascript2: ", json_stringify(\@combination_error_in_javascript2, "pretty" => 1), "\n");
