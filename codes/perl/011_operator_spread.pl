use strict;
use warnings;
use Scalar::Util qw(looks_like_number);

print("\n# JavaScript-like Spread Syntax (...) in Perl\n");

# There's no JavaScript-like Spread Syntax (...) in Perl.
# But, we can create our own function to mimic it in Perl.

sub pretty_json_stringify {
    my ($anything) = @_;
    use JSON;
    my $pretty_json_string = JSON->new->allow_nonref->pretty->encode($anything);
    $pretty_json_string =~ s/   /    /g;
    $pretty_json_string =~ s/\n$//g;
    return $pretty_json_string;
}

sub pretty_array_of_primitives {
    my $number_of_parameters = @_;
    my $result = "[";
    for (my $array_item_index = 0; $array_item_index < $number_of_parameters; $array_item_index += 1) {
        my $array_item = $_[$array_item_index];
        my $is_string = (defined($array_item) && ref($array_item) eq "");
        my $is_number = looks_like_number($array_item);
        last if (!$is_string && !$is_number);
        $result = $result . "\"" . $array_item . "\"" if ($is_string && !$is_number);
        $result = $result . $array_item if ($is_number);
        $result = $result . ", " if (($array_item_index + 1) != $number_of_parameters);
    }
    $result = $result . "]";
    return $result;
}

sub spread_syntax_object {
    my %new_object;
    for my $parameter_ref (@_) {
        if (ref($parameter_ref) eq "HASH") {
            my %parameter = %{$parameter_ref};
            while (my ($object_key, $object_value) = each(%parameter)) {
                $new_object{$object_key} = $object_value;
            }
            next;
        }
        if (ref($parameter_ref) eq "ARRAY") {
            my @parameter = @{$parameter_ref};
            for (my $array_item_index = 0; $array_item_index < scalar(@parameter); $array_item_index += 1) {
                my $array_item = $parameter[$array_item_index];
                $new_object{$array_item_index} = $array_item;
            }
            next;
        }
    }
    return %new_object;
}

sub spread_syntax_array {
    my @new_array;
    for my $parameter_ref (@_) {
        if (ref($parameter_ref) eq "HASH") {
            my %parameter = %{$parameter_ref};
            if (keys(%parameter) == 1) {
                while (my ($object_key, $object_value) = each(%parameter)) {
                    push(@new_array, $object_value);
                }
                next;
            }
            push(@new_array, \%parameter);
            next;
        }
        if (ref($parameter_ref) eq "ARRAY") {
            my @parameter = @{$parameter_ref};
            for (my $array_item_index = 0; $array_item_index < scalar(@parameter); $array_item_index += 1) {
                my $array_item = $parameter[$array_item_index];
                push(@new_array, $array_item);
            }
            next;
        }
    }
    return @new_array;
}

my @fruits = ("Mango", "Melon", "Banana");
print("fruits: " . pretty_array_of_primitives(@fruits) . "\n");

my @vegetables = ("Carrot", "Tomato");
print("vegetables: " . pretty_array_of_primitives(@vegetables) . "\n");

my %country_capitals_in_asia = (
    "Thailand" => "Bangkok",
    "China" => "Beijing",
    "Japan" => "Tokyo"
);
print("country_capitals_in_asia: " . pretty_json_stringify(\%country_capitals_in_asia) . "\n");

my %country_capitals_in_europe = (
    "France" => "Paris",
    "England" => "London"
);
print("country_capitals_in_europe: " . pretty_json_stringify(\%country_capitals_in_europe) . "\n");

print("\n// [...array1, ...array2]:\n\n");

my @combination1 = spread_syntax_array(\@fruits, \@vegetables);
print("combination1: " . pretty_json_stringify(\@combination1) . "\n");
# combination1: [
#     "Mango",
#     "Melon",
#     "Banana",
#     "Carrot",
#     "Tomato"
# ]

my @combination2 = spread_syntax_array(\@fruits, ["Cucumber", "Onion"]);
print("combination2: " . pretty_json_stringify(\@combination2) . "\n");
# combination2: [
#     "Mango",
#     "Melon",
#     "Banana",
#     "Cucumber",
#     "Onion"
# ]

print("\n// { ...object1, ...object2 }:\n\n");

my %combination3 = spread_syntax_object(\%country_capitals_in_asia, \%country_capitals_in_europe);
print("combination3: " . pretty_json_stringify(\%combination3) . "\n");
# combination3: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "France": "Paris",
#     "England": "London"
# }

my %combination4 = spread_syntax_object(\%country_capitals_in_asia, { "Germany" => "Berlin", "Italy" => "Rome" });
print("combination4: " . pretty_json_stringify(\%combination4) . "\n");
# combination4: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "Germany": "Berlin",
#     "Italy": "Rome"
# }

print("\n// [...array1, array2]:\n\n");

my @combination5 = spread_syntax_array(\@fruits, { "vegetables" => \@vegetables });
print("combination5: " . pretty_json_stringify(\@combination5) . "\n");
# combination5: [
#     "Mango",
#     "Melon",
#     "Banana",
#     [
#         "Carrot",
#         "Tomato"
#     ]
# ]

my @combination6 = spread_syntax_array(\@fruits, { "vegetables" => ["Cucumber", "Onion"] });
print("combination6: " . pretty_json_stringify(\@combination6) . "\n");
# combination6: [
#     "Mango",
#     "Melon",
#     "Banana",
#     [
#         "Cucumber",
#         "Onion"
#     ]
# ]

print("\n// [...array1, object1]:\n\n");

my @combination7 = spread_syntax_array(\@fruits, { "country_capitals_in_asia" => \%country_capitals_in_asia });
print("combination7: " . pretty_json_stringify(\@combination7) . "\n");
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

my @combination8 = spread_syntax_array(\@fruits, { "country_capitals_in_asia" => { "Germany" => "Berlin", "Italy" => "Rome" }} );
print("combination8: " . pretty_json_stringify(\@combination8) . "\n");
# combination8: [
#     "Mango",
#     "Melon",
#     "Banana",
#     {
#         "Germany": "Berlin",
#         "Italy": "Rome"
#     }
# ]

print("\n// { ...object1, object2 }:\n\n");

my %combination9 = spread_syntax_object(\%country_capitals_in_asia, { "country_capitals_in_europe" => \%country_capitals_in_europe });
print("combination9: " . pretty_json_stringify(\%combination9) . "\n");
# combination9: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "country_capitals_in_europe" : {
#       "France" : "Paris",
#       "England" : "London"
#    }
# }

my %combination10 = spread_syntax_object(\%country_capitals_in_asia, { "country_capitals_in_europe" => { "Germany" => "Berlin", "Italy" => "Rome" } });
print("combination10: " . pretty_json_stringify(\%combination10) . "\n");
# combination10: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "country_capitals_in_europe": {
#         "Germany": "Berlin",
#         "Italy": "Rome"
#     }
# }

print("\n// { ...object1, array2 }:\n\n");

my %combination11 = spread_syntax_object(\%country_capitals_in_asia, { "vegetables" => \@vegetables });
print("combination11: " . pretty_json_stringify(\%combination11) . "\n");
# combination11: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "vegetables": [
#         "Carrot",
#         "Tomato"
#     ]
# }

my %combination12 = spread_syntax_object(\%country_capitals_in_asia, { "vegetables" => ["Cucumber", "Onion"] });
print("combination12: " . pretty_json_stringify(\%combination12) . "\n");
# combination12: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "vegetables": [
#         "Cucumber",
#         "Onion"
#     ]
# }

print("\n// { ...object1, ...array2 }:\n\n");

my %combination13 = spread_syntax_object(\%country_capitals_in_asia, \@vegetables);
print("combination13: " . pretty_json_stringify(\%combination13) . "\n");
# combination13: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "0" : "Carrot",
#    "1" : "Tomato"
# }

my %combination14 = spread_syntax_object(\%country_capitals_in_asia, ["Cucumber", "Onion"]);
print("combination14: " . pretty_json_stringify(\%combination14) . "\n");
# combination14: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "0" : "Cucumber",
#    "1" : "Onion"
# }

# print("\n// [...array1, ...object1]: // this combination throw an error in JavaScript\n\n");

# this combination throw an error in JavaScript
# my @combination_error_in_javascript1 = spread_syntax_array(\@fruits, \%country_capitals_in_asia);
# print("combination_error_in_javascript1: " . pretty_json_stringify(\@combination_error_in_javascript1) . "\n");

# this combination throw an error in JavaScript
# my @combination_error_in_javascript2 = spread_syntax_array(\@fruits, { "country_capitals_in_europe" => { "Germany" => "Berlin", "Italy" => "Rome" } });
# print("combination_error_in_javascript2: " . pretty_json_stringify(\@combination_error_in_javascript2) . "\n");
