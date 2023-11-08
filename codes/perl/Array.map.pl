use strict;
use warnings;
use JSON;
use Scalar::Util qw(looks_like_number);

sub pretty_array_of_primitives {
    my $number_of_parameters = @_;
    my $result = "[";
    for (my $array_item_index = 0; $array_item_index < $number_of_parameters; $array_item_index += 1) {
        my $array_item = $_[$array_item_index];
        my $is_string = defined($array_item) && $array_item =~ /[0-9a-zA-Z`~!@#%&_=;':", \(\)\[\]\{\}\|\*\+\?\^\$\/\\\<\>\.\-]/;
        my $is_number = looks_like_number($array_item);
        last if (!$is_string && !$is_number);
        $result = $result . "\"" . $array_item . "\"" if ($is_string);
        $result = $result . $array_item if ($is_number);
        $result = $result . ", " if (($array_item_index + 1) != $number_of_parameters);
    }
    $result = $result . "]";
    return $result;
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

sub array_map_v1 {
    # JavaScript-like Array.map() function
    my ($callback_function, $an_array_ref) = @_;
    my @new_array = ();
    my @an_array = @$an_array_ref;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        my $new_array_item = $callback_function->($array_item, $array_item_index, \@an_array);
        if (ref $new_array_item eq "ARRAY") {
            my @new_array_item_as_an_array = @$new_array_item;
            my $new_array_item_as_an_array_array_length = scalar(@new_array_item_as_an_array);
            next if ($new_array_item_as_an_array_array_length == 0);
            push(@new_array, $new_array_item);
            next;
        }
        push(@new_array, $new_array_item);
    }
    return @new_array;
}

print("\n# JavaScript-like Array.map() in Perl Array\n");

my @numbers = (12, 34, 27, 23, 65, 93, 36, 87, 4, 254);
print("numbers: ", pretty_array_of_primitives(@numbers), "\n");

my @numbers_labeled;

print("# using JavaScript-like Array.map() function \"array_map_v1\"\n");

@numbers_labeled = array_map_v1(sub { my ($number) = @_; return { "$number" => ((($number % 2) == 0) ? "even" : "odd") } }, \@numbers);
print("labeled numbers ", JSON->new->allow_nonref->pretty->encode(\@numbers_labeled));
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
print("labeled numbers ", JSON->new->allow_nonref->pretty->encode(\@numbers_labeled));
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

print("products: ", JSON->new->allow_nonref->pretty->encode(\@products));

my @products_labeled;

print("# using JavaScript-like Array.map() function \"array_map_v1\"\n");

@products_labeled = array_map_v1(sub {
    my ($product) = @_;
    my %new_product = spread_syntax_object_v1(%$product, ("label" => (($product->{"price"} > 100) ? "expensive" : "cheap")));
    return \%new_product;
}, \@products);
print("labeled products: ", JSON->new->allow_nonref->pretty->encode(\@products_labeled));
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

@products_labeled = map { my $product = $_; +{ spread_syntax_object_v1(%$product, ("label" => (($product->{"price"} > 100) ? "expensive" : "cheap"))) } } @products;
print("labeled products ", JSON->new->allow_nonref->pretty->encode(\@products_labeled));
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
