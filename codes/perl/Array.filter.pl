use strict;
use warnings;
use JSON;

# There's no JavaScript-like Array.filter() in Perl.
# But, we can create our own function to mimic it in Perl.

sub array_filter_v1 {
    # JavaScript-like Array.filter() function
    my ($callback_function, @an_array) = @_;
    my @filtered_data = ();
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        my $is_condition_match = $callback_function->($array_item, $array_item_index, \@an_array);
        if ($is_condition_match) {
            push(@filtered_data, $array_item);
        }
    }
    return @filtered_data;
};

sub array_filter_v2 {
    # JavaScript-like Array.filter() function
    my ($callback_function, @an_array) = @_;
    my @filtered_data = ();
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        if ($callback_function->($array_item, $array_item_index, \@an_array)) {
            push(@filtered_data, $array_item);
        }
    }
    return @filtered_data;
};

print("\n# JavaScript-like Array.filter() in Perl Array\n");

my @numbers = (12, 34, 27, 23, 65, 93, 36, 87, 4, 254);
print("numbers: ", "[", join(", ", @numbers), "]", "\n");

my @even_numbers_only;
my @odd_numbers_only;

print("# using JavaScript-like Array.filter() function \"array_filter_v1\"\n");

@even_numbers_only = array_filter_v1(sub { my ($number) = @_; return $number % 2 == 0; }, @numbers);
print("even numbers only: ", "[", join(", ", @even_numbers_only), "]", "\n");
# even numbers only: [12, 34, 36, 4, 254]

@odd_numbers_only = array_filter_v1(sub { my ($number) = @_; return $number % 2 != 0; }, @numbers);
print("odd numbers only: ", "[", join(", ", @odd_numbers_only), "]", "\n");
# odd numbers only: [27, 23, 65, 93, 87]

print("# using JavaScript-like Array.filter() function \"array_filter_v2\"\n");

@even_numbers_only = array_filter_v2(sub { my ($number) = @_; return $number % 2 == 0; }, @numbers);
print("even numbers only: ", "[", join(", ", @even_numbers_only), "]", "\n");
# even numbers only: [12, 34, 36, 4, 254]

@odd_numbers_only = array_filter_v2(sub { my ($number) = @_; return $number % 2 != 0; }, @numbers);
print("odd numbers only: ", "[", join(", ", @odd_numbers_only), "]", "\n");
# odd numbers only: [27, 23, 65, 93, 87]

print("\n# JavaScript-like Array.filter() in Perl Array of Hashes\n");

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

my @products_with_price_less_than_or_equal_to_100_only;
my @products_with_price_more_than_or_equal_to_100_only;

print("# using JavaScript-like Array.filter() function \"array_filter_v1\"\n");

@products_with_price_less_than_or_equal_to_100_only = array_filter_v1(sub { my ($product) = @_; return $product->{'price'} <= 100; }, @products);
print("products with price <= 100 only: ", JSON->new->allow_nonref->pretty->encode(\@products_with_price_less_than_or_equal_to_100_only));
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

@products_with_price_more_than_or_equal_to_100_only = array_filter_v1(sub { my ($product) = @_; return $product->{'price'} >= 100; }, @products);
print("products with price >= 100 only: ", JSON->new->allow_nonref->pretty->encode(\@products_with_price_more_than_or_equal_to_100_only));
# products with price >= 100 only: [
#     {
#         "code": "pasta",
#         "price": 321
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233
#     },
#     {
#         "code": "towel",
#         "price": 499
#     }
# ]

print("# using JavaScript-like Array.filter() function \"array_filter_v2\"\n");

@products_with_price_less_than_or_equal_to_100_only = array_filter_v2(sub { my ($product) = @_; return $product->{'price'} <= 100; }, @products);
print("products with price <= 100 only: ", JSON->new->allow_nonref->pretty->encode(\@products_with_price_less_than_or_equal_to_100_only));
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

@products_with_price_more_than_or_equal_to_100_only = array_filter_v2(sub { my ($product) = @_; return $product->{'price'} >= 100; }, @products);
print("products with price >= 100 only: ", JSON->new->allow_nonref->pretty->encode(\@products_with_price_more_than_or_equal_to_100_only));
# products with price >= 100 only: [
#     {
#         "code": "pasta",
#         "price": 321
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233
#     },
#     {
#         "code": "towel",
#         "price": 499
#     }
# ]
