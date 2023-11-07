use strict;
use warnings;
use JSON;
use Scalar::Util qw(looks_like_number);

# There's no JavaScript-like Array.filter() in Perl.
# But, we can create our own function to mimic it in Perl.

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

sub array_filter_v1 {
    # JavaScript-like Array.filter() function
    my ($callback_function, @an_array) = @_;
    my @data_filtered = ();
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        my $is_condition_match = $callback_function->($array_item, $array_item_index, \@an_array);
        if ($is_condition_match) {
            push(@data_filtered, $array_item);
        }
    }
    return @data_filtered;
}

sub array_filter_v2 {
    # JavaScript-like Array.filter() function
    my ($callback_function, @an_array) = @_;
    my @data_filtered = ();
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        my $is_condition_match = $callback_function->($array_item, $array_item_index, \@an_array);
        push(@data_filtered, $array_item) if ($is_condition_match);
    }
    return @data_filtered;
}

sub array_filter_v3 {
    # JavaScript-like Array.filter() function
    my ($callback_function, @an_array) = @_;
    my @data_filtered = ();
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        if ($callback_function->($array_item, $array_item_index, \@an_array)) {
            push(@data_filtered, $array_item);
        }
    }
    return @data_filtered;
}

sub array_filter_v4 {
    # JavaScript-like Array.filter() function
    my ($callback_function, @an_array) = @_;
    my @data_filtered = ();
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        push(@data_filtered, $array_item) if ($callback_function->($array_item, $array_item_index, \@an_array));
    }
    return @data_filtered;
}

print("\n# JavaScript-like Array.filter() in Perl Array\n");

my @numbers = (12, 34, 27, 23, 65, 93, 36, 87, 4, 254);
print("numbers: ", pretty_array_of_primitives(@numbers), "\n");

my @numbers_even;
my @numbers_odd;

print("# using JavaScript-like Array.filter() function \"array_filter_v1\"\n");

@numbers_even = array_filter_v1(sub { my ($number) = @_; return (($number % 2) == 0); }, @numbers);
print("even numbers only: ", pretty_array_of_primitives(@numbers_even), "\n");
# even numbers only: [12, 34, 36, 4, 254]

@numbers_odd = array_filter_v1(sub { my ($number) = @_; return (($number % 2) != 0); }, @numbers);
print("odd numbers only: ", pretty_array_of_primitives(@numbers_odd), "\n");
# odd numbers only: [27, 23, 65, 93, 87]

print("# using JavaScript-like Array.filter() function \"array_filter_v2\"\n");

@numbers_even = array_filter_v2(sub { my ($number) = @_; return (($number % 2) == 0); }, @numbers);
print("even numbers only: ", pretty_array_of_primitives(@numbers_even), "\n");
# even numbers only: [12, 34, 36, 4, 254]

@numbers_odd = array_filter_v2(sub { my ($number) = @_; return (($number % 2) != 0); }, @numbers);
print("odd numbers only: ", pretty_array_of_primitives(@numbers_odd), "\n");
# odd numbers only: [27, 23, 65, 93, 87]

print("# using JavaScript-like Array.filter() function \"array_filter_v3\"\n");

@numbers_even = array_filter_v3(sub { my ($number) = @_; return (($number % 2) == 0); }, @numbers);
print("even numbers only: ", pretty_array_of_primitives(@numbers_even), "\n");
# even numbers only: [12, 34, 36, 4, 254]

@numbers_odd = array_filter_v3(sub { my ($number) = @_; return (($number % 2) != 0); }, @numbers);
print("odd numbers only: ", pretty_array_of_primitives(@numbers_odd), "\n");
# odd numbers only: [27, 23, 65, 93, 87]

print("# using JavaScript-like Array.filter() function \"array_filter_v4\"\n");

@numbers_even = array_filter_v4(sub { my ($number) = @_; return (($number % 2) == 0); }, @numbers);
print("even numbers only: ", pretty_array_of_primitives(@numbers_even), "\n");
# even numbers only: [12, 34, 36, 4, 254]

@numbers_odd = array_filter_v4(sub { my ($number) = @_; return (($number % 2) != 0); }, @numbers);
print("odd numbers only: ", pretty_array_of_primitives(@numbers_odd), "\n");
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

my @products_below_100;
my @products_above_100;

print("# using JavaScript-like Array.filter() function \"array_filter_v1\"\n");

@products_below_100 = array_filter_v1(sub { my ($product) = @_; return $product->{"price"} <= 100; }, @products);
print("products with price <= 100 only: ", JSON->new->allow_nonref->pretty->encode(\@products_below_100));
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

@products_above_100 = array_filter_v1(sub { my ($product) = @_; return $product->{"price"} >= 100; }, @products);
print("products with price >= 100 only: ", JSON->new->allow_nonref->pretty->encode(\@products_above_100));
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

@products_below_100 = array_filter_v2(sub { my ($product) = @_; return $product->{"price"} <= 100; }, @products);
print("products with price <= 100 only: ", JSON->new->allow_nonref->pretty->encode(\@products_below_100));
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

@products_above_100 = array_filter_v2(sub { my ($product) = @_; return $product->{"price"} >= 100; }, @products);
print("products with price >= 100 only: ", JSON->new->allow_nonref->pretty->encode(\@products_above_100));
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

print("# using JavaScript-like Array.filter() function \"array_filter_v3\"\n");

@products_below_100 = array_filter_v3(sub { my ($product) = @_; return $product->{"price"} <= 100; }, @products);
print("products with price <= 100 only: ", JSON->new->allow_nonref->pretty->encode(\@products_below_100));
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

@products_above_100 = array_filter_v3(sub { my ($product) = @_; return $product->{"price"} >= 100; }, @products);
print("products with price >= 100 only: ", JSON->new->allow_nonref->pretty->encode(\@products_above_100));
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

print("# using JavaScript-like Array.filter() function \"array_filter_v4\"\n");

@products_below_100 = array_filter_v4(sub { my ($product) = @_; return $product->{"price"} <= 100; }, @products);
print("products with price <= 100 only: ", JSON->new->allow_nonref->pretty->encode(\@products_below_100));
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

@products_above_100 = array_filter_v4(sub { my ($product) = @_; return $product->{"price"} >= 100; }, @products);
print("products with price >= 100 only: ", JSON->new->allow_nonref->pretty->encode(\@products_above_100));
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
