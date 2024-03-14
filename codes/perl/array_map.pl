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

sub array_map {
    # JavaScript-like Array.map() function
    my ($callback_function_ref, $an_array_ref) = @_;
    my @new_array = ();
    my @an_array = @{$an_array_ref};
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        my $new_array_item = $callback_function_ref->($array_item, $array_item_index, $an_array_ref);
        $new_array[scalar(@new_array)] = $new_array_item;
    }
    return @new_array;
}

print("\n# JavaScript-like Array.map() in Perl Array\n");

my @numbers = (12, 34, 27, 23, 65, 93, 36, 87, 4, 254);
print("numbers: " . pretty_array_of_primitives(@numbers) . "\n");

my @numbers_labeled;

print("# using JavaScript-like Array.map() function \"array_map\"\n");

@numbers_labeled = array_map(sub { my ($number) = @_; return { "$number" => ((($number % 2) == 0) ? "even" : "odd") } }, \@numbers);
print("labeled numbers " . pretty_json_stringify(\@numbers_labeled) . "\n");
# labeled numbers: [
#     {
#         "12": "even"
#     },
#     {
#         "34": "even"
#     },
#     {
#         "27": "odd"
#     },
#     {
#         "23": "odd"
#     },
#     {
#         "65": "odd"
#     },
#     {
#         "93": "odd"
#     },
#     {
#         "36": "even"
#     },
#     {
#         "87": "odd"
#     },
#     {
#         "4": "even"
#     },
#     {
#         "254": "even"
#     }
# ]

print("# using Perl Array.map() built-in function \"map\"\n");

@numbers_labeled = map { my $number = $_; { "$number" => ((($number % 2) == 0) ? "even" : "odd") } } @numbers;
print("labeled numbers " . pretty_json_stringify(\@numbers_labeled) . "\n");
# labeled numbers: [
#     {
#         "12": "even"
#     },
#     {
#         "34": "even"
#     },
#     {
#         "27": "odd"
#     },
#     {
#         "23": "odd"
#     },
#     {
#         "65": "odd"
#     },
#     {
#         "93": "odd"
#     },
#     {
#         "36": "even"
#     },
#     {
#         "87": "odd"
#     },
#     {
#         "4": "even"
#     },
#     {
#         "254": "even"
#     }
# ]

print("\n# JavaScript-like Array.map() in Perl Array of Hashes\n");

my @products = (
    {
        "code" => "pasta",
        "price" => 321
    },
    {
        "code" => "bubble_gum",
        "price" => 233
    },
    {
        "code" => "potato_chips",
        "price" => 5
    },
    {
        "code" => "towel",
        "price" => 499
    }
);

print("products: " . pretty_json_stringify(\@products) . "\n");

my @products_labeled;

print("# using JavaScript-like Array.map() function \"array_map\"\n");

@products_labeled = array_map(sub {
    my ($product) = @_;
    my %new_product = spread_syntax_object(\%{$product}, { "label" => (($product->{"price"} > 100) ? "expensive" : "cheap") });
    return \%new_product;
}, \@products);
print("labeled products: " . pretty_json_stringify(\@products_labeled) . "\n");
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato_chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]

print("# using Perl Array.map() built-in function \"map\"\n");

@products_labeled = map { my $product = $_; +{ spread_syntax_object(\%{$product}, { "label" => (($product->{"price"} > 100) ? "expensive" : "cheap") }) } } @products;
print("labeled products " . pretty_json_stringify(\@products_labeled) . "\n");
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato_chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]
