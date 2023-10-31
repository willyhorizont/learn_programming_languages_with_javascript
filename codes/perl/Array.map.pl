use strict;
use warnings;
use JSON;

sub pretty_array_of_primitives { "[", join(", ", @_), "]", "\n" }

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

sub array_map_v1 {
    # JavaScript-like Array.map() function
    my ($callback_function, @an_array) = @_;
    my @new_array = ();
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        my $new_array_item = $callback_function->($array_item, $array_item_index, \@an_array);
        push(@new_array, $new_array_item);
    }
    return @new_array;
};

sub array_map_v2 {
    # JavaScript-like Array.map() function
    my ($callback_function, @an_array) = @_;
    my @new_array = ();
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        push(@new_array, $callback_function->($array_item, $array_item_index, \@an_array));
    }
    return @new_array;
};

print("\n# JavaScript-like Array.map() in Perl Array\n");

my @numbers = (12, 34, 27, 23, 65, 93, 36, 87, 4, 254);
print("numbers: ", pretty_array_of_primitives(@numbers), "\n");

my @numbers_labeled;

print("# using JavaScript-like Array.map() function \"array_map_v1\"\n");

@numbers_labeled = array_map_v1(sub { my ($number) = @_; return { "$number" => $number % 2 == 0 ? "even" : "odd" } }, @numbers);
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

print("# using JavaScript-like Array.map() function \"array_map_v2\"\n");

@numbers_labeled = array_map_v2(sub { my ($number) = @_; return { "$number" => $number % 2 == 0 ? "even" : "odd" } }, @numbers);
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

@numbers_labeled = map { my $number = $_; { "$number" => $number % 2 == 0 ? "even" : "odd" } } @numbers;
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

@products_labeled = array_map_v1(sub { my ($product) = @_; return { spread_syntax_object($product, { "label" => $product->{'price'} > 100 ? "expensive" : "cheap" }) }; }, @products);
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

print("# using JavaScript-like Array.map() function \"array_map_v2\"\n");

@products_labeled = array_map_v2(sub { my ($product) = @_; return { spread_syntax_object($product, { "label" => $product->{'price'} > 100 ? "expensive" : "cheap" }) }; }, @products);
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

@products_labeled = map { my $product = $_; +{ spread_syntax_object($product, { "label" => $product->{'price'} > 100 ? "expensive" : "cheap" }) } } @products;
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
