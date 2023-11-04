use strict;
use warnings;
use JSON;
use Scalar::Util qw(looks_like_number);

print("\n# JavaScript-like Spread Syntax in Perl\n");

# There's no JavaScript-like Spread Syntax in Perl.
# But, we can create our own function to mimic it in Perl.

sub pretty_array_of_primitives {
    my (@an_array_of_primitives) = @_;
    my $result = "[";
    for my $array_item_index (0..$#an_array_of_primitives) {
        my $array_item = $an_array_of_primitives[$array_item_index];
        my $isString = defined($array_item) && $array_item =~ /[0-9a-zA-Z`~!@#%&_=;':", \(\)\[\]\{\}\|\*\+\?\^\$\/\\\<\>\.\-]/;
        my $isNumber = looks_like_number($array_item);
        last if (!$isString && !$isNumber);
        $result = $result . "\"" . $array_item . "\"" if ($isString);
        $result = $result . $array_item if ($isNumber);
        $result = $result . ", " if ($array_item_index != $#an_array_of_primitives);
    }
    $result = $result . "]";
    return $result;
}

sub spread_syntax_object {
    my %new_object;
    for my $parameter (@_) {
        if (ref $parameter eq "HASH") {
            my %an_object = %$parameter;
            while (my ($object_key, $object_value) = each %an_object) {
                $new_object{$object_key} = $object_value;
            }
            next;
        }
        if (ref $parameter eq "ARRAY") {
            my @an_array = @$parameter;
            for my $array_item_index (0..$#an_array) {
                my $array_item = $an_array[$array_item_index];
                $new_object{$array_item_index} = $array_item;
            }
            next;
        }
    }
    return %new_object;
}

sub spread_syntax_array {
    my @new_array;
    for my $parameter (@_) {
        if (ref $parameter eq "HASH") {
            my %an_object = %$parameter;
            push(@new_array, \%an_object);
            next;
        }
        if (ref $parameter eq "ARRAY") {
            my @an_array = @$parameter;
            for my $array_item_index (0..$#an_array) {
                my $array_item = $an_array[$array_item_index];
                push(@new_array, $array_item);
            }
            next;
        }
        push(@new_array, $parameter);
    }
    return @new_array;
}

my @fruits = ("Mango", "Melon", "Banana");
print("fruits: " , pretty_array_of_primitives(@fruits), "\n");

my @vegetables = ("Carrot", "Tomato");
print("vegetables: " , pretty_array_of_primitives(@vegetables), "\n");

my %country_capitals_in_europe = (
    "France" => "Paris",
    "England" => "London"
);
print("country capitals in europe: ", JSON->new->allow_nonref->pretty->encode(\%country_capitals_in_europe));

my %country_capitals_in_asia = (
    "Thailand" => "Bangkok",
    "China" => "Beijing",
    "Japan" => "Tokyo"
);
print("country capitals in asia: ", JSON->new->allow_nonref->pretty->encode(\%country_capitals_in_asia));

my @combination1 = spread_syntax_array(\@fruits, \@vegetables);
print("combination1: " , JSON->new->allow_nonref->pretty->encode(\@combination1));
# combination1: [
#    "Mango",
#    "Melon",
#    "Banana",
#    "Carrot",
#    "Tomato"
# ]

my @combination2 = spread_syntax_array(\@fruits, ["Cucumber", "Onions"]);
print("combination2: " , JSON->new->allow_nonref->pretty->encode(\@combination2));
# combination2: [
#    "Mango",
#    "Melon",
#    "Banana",
#    "Cucumber",
#    "Onions"
# ]

my %combination3 = spread_syntax_object(\%country_capitals_in_asia, \%country_capitals_in_europe);
print("combination3: " , JSON->new->allow_nonref->pretty->encode(\%combination3));
# combination3: {
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "England" : "London",
#    "Thailand" : "Bangkok",
#    "France" : "Paris"
# }

my %combination4 = spread_syntax_object(\%country_capitals_in_asia, {"Germany" => "Berlin", "Italy" => "Rome"});
print("combination4: " , JSON->new->allow_nonref->pretty->encode(\%combination4));
# combination4: {
#    "Germany" : "Berlin",
#    "Thailand" : "Bangkok",
#    "Italy" : "Rome",
#    "Japan" : "Tokyo",
#    "China" : "Beijing"
# }

my @combination5 = spread_syntax_array(\@fruits, [\@vegetables]);
print("combination5: " , JSON->new->allow_nonref->pretty->encode(\@combination5));
# combination5: [
#    "Mango",
#    "Melon",
#    "Banana",
#    [
#       "Carrot",
#       "Tomato"
#    ]
# ]

my @combination6 = spread_syntax_array(\@fruits, [["Cucumber", "Onions"]]);
print("combination6: " , JSON->new->allow_nonref->pretty->encode(\@combination6));
# combination6: [
#    "Mango",
#    "Melon",
#    "Banana",
#    [
#       "Cucumber",
#       "Onions"
#    ]
# ]

my @combination7 = spread_syntax_array(\@fruits, \%country_capitals_in_asia);
print("combination7: " , JSON->new->allow_nonref->pretty->encode(\@combination7));
# combination7: [
#    "Mango",
#    "Melon",
#    "Banana",
#    {
#       "China" : "Beijing",
#       "Thailand" : "Bangkok",
#       "Japan" : "Tokyo"
#    }
# ]

my @combination8 = spread_syntax_array(\@fruits, {"Germany" => "Berlin", "Italy" => "Rome"});
print("combination8: " , JSON->new->allow_nonref->pretty->encode(\@combination8));
# combination8: [
#    "Mango",
#    "Melon",
#    "Banana",
#    {
#       "Italy" : "Rome",
#       "Germany" : "Berlin"
#    }
# ]

my %combination9 = spread_syntax_object(\%country_capitals_in_asia, \@vegetables);
print("combination9: " , JSON->new->allow_nonref->pretty->encode(\%combination9));
# combination9: {
#    "China" : "Beijing",
#    "Thailand" : "Bangkok",
#    "Japan" : "Tokyo",
#    "0" : "Carrot",
#    "1" : "Tomato"
# }

my %combination10 = spread_syntax_object(\%country_capitals_in_asia, ["Cucumber", "Onions"]);
print("combination10: " , JSON->new->allow_nonref->pretty->encode(\%combination10));
# combination10: {
#    "Thailand" : "Bangkok",
#    "Japan" : "Tokyo",
#    "1" : "Onions",
#    "0" : "Cucumber",
#    "China" : "Beijing"
# }

my %combination11 = spread_syntax_object(\%country_capitals_in_asia, {"country_capitals_in_europe" => \%country_capitals_in_europe});
print("combination11: " , JSON->new->allow_nonref->pretty->encode(\%combination11));
# ombination11: {
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "Thailand" : "Bangkok",
#    "country_capitals_in_europe" : {
#       "England" : "London",
#       "France" : "Paris"
#    }
# }

my %combination12 = spread_syntax_object(\%country_capitals_in_asia, {"country_capitals_in_europe" => {"Germany" => "Berlin", "Italy" => "Rome"}});
print("combination12: " , JSON->new->allow_nonref->pretty->encode(\%combination12));
# combination12: {
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "Thailand" : "Bangkok",
#    "country_capitals_in_europe" : {
#       "Italy" : "Rome",
#       "Germany" : "Berlin"
#    }
# }

my %combination13 = spread_syntax_object(\%country_capitals_in_asia, {"vegetables" => \@vegetables});
print("combination13: " , JSON->new->allow_nonref->pretty->encode(\%combination13));
# combination13: {
#    "vegetables" : [
#       "Carrot",
#       "Tomato"
#    ],
#    "Japan" : "Tokyo",
#    "Thailand" : "Bangkok",
#    "China" : "Beijing"
# }

my %combination14 = spread_syntax_object(\%country_capitals_in_asia, {"vegetables" => ["Cucumber", "Onions"]});
print("combination14: " , JSON->new->allow_nonref->pretty->encode(\%combination14));
# combination14: {
#    "Thailand" : "Bangkok",
#    "vegetables" : [
#       "Cucumber",
#       "Onions"
#    ],
#    "China" : "Beijing",
#    "Japan" : "Tokyo"
# }
