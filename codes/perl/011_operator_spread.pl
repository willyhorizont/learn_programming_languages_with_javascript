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

print("\n# JavaScript-like Spread Syntax (...) in Perl", "\n");

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

my %combination9 = (%country_capitals_in_asia, "country_capitals_in_europe" => \%country_capitals_in_europe);
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

my %combination10 = (%country_capitals_in_asia, "country_capitals_in_europe" => {"Germany" => "Berlin", "Italy" => "Rome"});
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

my %combination11 = (%country_capitals_in_asia, "vegetables" => \@vegetables);
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

my %combination12 = (%country_capitals_in_asia, "vegetables" => ["Cucumber", "Cabbage"]);
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
