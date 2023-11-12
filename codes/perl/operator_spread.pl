use strict;
use warnings;
use JSON;
use Scalar::Util qw(looks_like_number);

print("\n# JavaScript-like Spread Syntax (...) in Perl\n");

# There's no JavaScript-like Spread Syntax (...) in Perl.
# But, we can create our own function to mimic it in Perl.

sub pretty_array_of_primitives {
    my $number_of_parameters = @_;
    my $result = "[";
    for (my $array_item_index = 0; $array_item_index < $number_of_parameters; $array_item_index += 1) {
        my $array_item = $_[$array_item_index];
        my $is_string = (defined($array_item) && $array_item =~ /[0-9a-zA-Z`~!@#%&_=;':", \(\)\[\]\{\}\|\*\+\?\^\$\/\\\<\>\.\-]/);
        my $is_number = looks_like_number($array_item);
        last if (!$is_string && !$is_number);
        $result = $result . "\"" . $array_item . "\"" if ($is_string);
        $result = $result . $array_item if ($is_number);
        $result = $result . ", " if (($array_item_index + 1) != $number_of_parameters);
    }
    $result = $result . "]";
    return $result;
}

sub spread_syntax_array {
    my @new_array;
    for my $parameter (@_) {
        if (ref $parameter eq "ARRAY") {
            my @an_array = @$parameter;
            my $array_length = scalar(@an_array);
            next if ($array_length == 0);
            push(@new_array, $parameter);
            next;
        }
        push(@new_array, $parameter);
    }
    return @new_array;
}

sub array_to_object {
    my %new_object;
    my (@an_array) = @_;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        $new_object{$array_item_index} = $array_item;
    }
    return %new_object;
}

sub spread_syntax_object_v1 {
    my %new_object;
    my $number_of_parameters = @_;
    for (my $i = 0; $i < $number_of_parameters; $i += 2) {
        my $object_key = $_[$i];
        my $object_value = $_[$i + 1];
        $new_object{$object_key} = $object_value;
    }
    return %new_object;
}

sub spread_syntax_object_v2 {
    my %new_object;
    for my $ref (@_) {
        if (ref $ref eq "HASH") {
            my %an_object = %$ref;
            while (my ($object_key, $object_value) = each %an_object) {
                $new_object{$object_key} = $object_value;
            }
            next;
        }
        if (ref $ref eq "ARRAY") {
            my @an_array = @$ref;
            for my $array_item_index (0..$#an_array) {
                my $array_item = $an_array[$array_item_index];
                $new_object{$array_item_index} = $array_item;
            }
            next;
        }
    }
    return %new_object;
}

my @fruits = ("Mango", "Melon", "Banana");
print("fruits: " , pretty_array_of_primitives(@fruits), "\n");

my @vegetables = ("Carrot", "Tomato");
print("vegetables: " , pretty_array_of_primitives(@vegetables), "\n");

my %country_capitals_in_asia = (
    "Thailand" => "Bangkok",
    "China" => "Beijing",
    "Japan" => "Tokyo"
);
print("country_capitals_in_asia: ", JSON->new->allow_nonref->pretty->encode(\%country_capitals_in_asia));

my %country_capitals_in_europe = (
    "France" => "Paris",
    "England" => "London"
);
print("country_capitals_in_europe: ", JSON->new->allow_nonref->pretty->encode(\%country_capitals_in_europe));

print("\n// [...array1, ...array2]:\n\n");

my @combination1 = spread_syntax_array(@fruits, @vegetables);
print("combination1: " , JSON->new->allow_nonref->pretty->encode(\@combination1));
# combination1: [
#     "Mango",
#     "Melon",
#     "Banana",
#     "Carrot",
#     "Tomato"
# ]

my @combination2 = spread_syntax_array(@fruits, ("Cucumber", "Onions"));
print("combination2: " , JSON->new->allow_nonref->pretty->encode(\@combination2));
# combination2: [
#     "Mango",
#     "Melon",
#     "Banana",
#     "Cucumber",
#     "Onions"
# ]

print("\n// { ...object1, ...object2 }:\n\n");

my %combination3;

%combination3 = spread_syntax_object_v1(%country_capitals_in_asia, %country_capitals_in_europe);
print("combination3: " , JSON->new->allow_nonref->pretty->encode(\%combination3));
# combination3: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "France": "Paris",
#     "England": "London"
# }

%combination3 = spread_syntax_object_v2(\%country_capitals_in_asia, \%country_capitals_in_europe);
print("combination3: " , JSON->new->allow_nonref->pretty->encode(\%combination3));
# combination3: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "France": "Paris",
#     "England": "London"
# }

my %combination4;

%combination4 = spread_syntax_object_v1(%country_capitals_in_asia, ("Germany" => "Berlin", "Italy" => "Rome"));
print("combination4: " , JSON->new->allow_nonref->pretty->encode(\%combination4));
# combination4: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "Germany": "Berlin",
#     "Italy": "Rome"
# }

%combination4 = spread_syntax_object_v2(\%country_capitals_in_asia, {"Germany" => "Berlin", "Italy" => "Rome"});
print("combination4: " , JSON->new->allow_nonref->pretty->encode(\%combination4));
# combination4: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "Germany": "Berlin",
#     "Italy": "Rome"
# }

print("\n// [...array1, array2]:\n\n");

my @combination5 = spread_syntax_array(@fruits, \@vegetables);
print("combination5: " , JSON->new->allow_nonref->pretty->encode(\@combination5));
# combination5: [
#     "Mango",
#     "Melon",
#     "Banana",
#     [
#         "Carrot",
#         "Tomato"
#     ]
# ]

my @combination6 = spread_syntax_array(@fruits, ["Cucumber", "Onions"]);
print("combination6: " , JSON->new->allow_nonref->pretty->encode(\@combination6));
# combination6: [
#     "Mango",
#     "Melon",
#     "Banana",
#     [
#         "Cucumber",
#         "Onions"
#     ]
# ]

print("\n// [...array1, object1]:\n\n");

my @combination7 = spread_syntax_array(@fruits, \%country_capitals_in_asia);
print("combination7: " , JSON->new->allow_nonref->pretty->encode(\@combination7));
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

my @combination8 = spread_syntax_array(@fruits, {"Germany" => "Berlin", "Italy" => "Rome"});
print("combination8: " , JSON->new->allow_nonref->pretty->encode(\@combination8));
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

my %combination9;

%combination9 = spread_syntax_object_v1(%country_capitals_in_asia, ("country_capitals_in_europe" => \%country_capitals_in_europe));
print("combination9: " , JSON->new->allow_nonref->pretty->encode(\%combination9));
# combination9: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "country_capitals_in_europe" : {
#       "France" : "Paris",
#       "England" : "London"
#    }
# }

%combination9 = spread_syntax_object_v2(\%country_capitals_in_asia, {"country_capitals_in_europe" => \%country_capitals_in_europe});
print("combination9: " , JSON->new->allow_nonref->pretty->encode(\%combination9));
# combination9: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "country_capitals_in_europe" : {
#       "France" : "Paris",
#       "England" : "London"
#    }
# }

my %combination10;

%combination10 = spread_syntax_object_v1(%country_capitals_in_asia, ("country_capitals_in_europe" => {"Germany" => "Berlin", "Italy" => "Rome"}));
print("combination10: " , JSON->new->allow_nonref->pretty->encode(\%combination10));
# combination10: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "country_capitals_in_europe": {
#         "Germany": "Berlin",
#         "Italy": "Rome"
#     }
# }

%combination10 = spread_syntax_object_v2(\%country_capitals_in_asia, {"country_capitals_in_europe" => {"Germany" => "Berlin", "Italy" => "Rome"}});
print("combination10: " , JSON->new->allow_nonref->pretty->encode(\%combination10));
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

my %combination11;

%combination11 = spread_syntax_object_v1(%country_capitals_in_asia, ("vegetables" => \@vegetables));
print("combination11: " , JSON->new->allow_nonref->pretty->encode(\%combination11));
# combination11: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "vegetables": [
#         "Carrot",
#         "Tomato"
#     ]
# }

%combination11 = spread_syntax_object_v2(\%country_capitals_in_asia, {"vegetables" => \@vegetables});
print("combination11: " , JSON->new->allow_nonref->pretty->encode(\%combination11));
# combination11: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "vegetables": [
#         "Carrot",
#         "Tomato"
#     ]
# }

my %combination12;

%combination12 = spread_syntax_object_v1(%country_capitals_in_asia, ("vegetables" => ["Cucumber", "Onions"]));
print("combination12: " , JSON->new->allow_nonref->pretty->encode(\%combination12));
# combination12: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "vegetables": [
#         "Cucumber",
#         "Onions"
#     ]
# }

%combination12 = spread_syntax_object_v2(\%country_capitals_in_asia, {"vegetables" => ["Cucumber", "Onions"]});
print("combination12: " , JSON->new->allow_nonref->pretty->encode(\%combination12));
# combination12: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "vegetables": [
#         "Cucumber",
#         "Onions"
#     ]
# }

print("\n// { ...object1, ...array2 }:\n\n");

my %combination13;

%combination13 = spread_syntax_object_v1(%country_capitals_in_asia, array_to_object(@vegetables));
print("combination13: " , JSON->new->allow_nonref->pretty->encode(\%combination13));
# combination13: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "0" : "Carrot",
#    "1" : "Tomato"
# }

%combination13 = spread_syntax_object_v2(\%country_capitals_in_asia, \@vegetables);
print("combination13: " , JSON->new->allow_nonref->pretty->encode(\%combination13));
# combination13: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "0" : "Carrot",
#    "1" : "Tomato"
# }

my %combination14;

%combination14 = spread_syntax_object_v1(%country_capitals_in_asia, ("Cucumber", "Onions"));
print("combination14: " , JSON->new->allow_nonref->pretty->encode(\%combination14));
# combination14: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "0" : "Cucumber",
#    "1" : "Onions"
# }

%combination14 = spread_syntax_object_v2(\%country_capitals_in_asia, ["Cucumber", "Onions"]);
print("combination14: " , JSON->new->allow_nonref->pretty->encode(\%combination14));
# combination14: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "0" : "Cucumber",
#    "1" : "Onions"
# }

# print("\n// [...array1, ...object1]: // this combination throw an error in JavaScript\n\n");

# this combination throw an error in JavaScript
# my @combination_error_in_javascript1 = spread_syntax_array(@fruits, %country_capitals_in_asia);
# print("combination_error_in_javascript1: " , JSON->new->allow_nonref->pretty->encode(\@combination_error_in_javascript1));

# this combination throw an error in JavaScript
# my @combination_error_in_javascript2 = spread_syntax_array(@fruits, ("Germany" => "Berlin", "Italy" => "Rome"));
# print("combination_error_in_javascript2: " , JSON->new->allow_nonref->pretty->encode(\@combination_error_in_javascript2));
