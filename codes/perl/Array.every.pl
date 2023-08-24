use strict;
use warnings;
use JSON;
use List::Util qw(all);

sub array_every_v1 {
    # JavaScript-like Array.every() function
    my ($callback_function, @an_array) = @_;
    my $is_condition_match = 0;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        $is_condition_match = $callback_function->($array_item, $array_item_index, \@an_array);
        if (!$is_condition_match) {
            last;
        }
    }
    return $is_condition_match;
};

sub array_every_v2 {
    # JavaScript-like Array.every() function
    my ($callback_function, @an_array) = @_;
    my $is_condition_match = 0;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        $is_condition_match = $callback_function->($array_item, $array_item_index, \@an_array);
        if (!$is_condition_match) {
            return $is_condition_match;
        }
    }
    return $is_condition_match;
};

sub array_every_v3 {
    # JavaScript-like Array.every() function
    my ($callback_function, @an_array) = @_;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        my $is_condition_match = $callback_function->($array_item, $array_item_index, \@an_array);
        if (!$is_condition_match) {
            return 0;
        }
    }
    return 1;
};

sub array_every_v4 {
    # JavaScript-like Array.every() function
    my ($callback_function, @an_array) = @_;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        if (!$callback_function->($array_item, $array_item_index, \@an_array)) {
            return 0;
        }
    }
    return 1;
};

print("\n# JavaScript-like Array.every() in Perl Array\n");

my @numbers = (12, 34, 27, 23, 65, 93, 36, 87, 4, 254);
print("numbers: ", "[", join(", ", @numbers), "]", "\n");

my $is_all_number_less_than500;
my $is_all_number_more_than500;

print("# using JavaScript-like Array.every() function \"array_every_v1\"\n");

$is_all_number_less_than500 = array_every_v1(sub { my ($number) = @_; return $number < 500; }, @numbers) ? 'true' : 'false';
print("is all number < 500: $is_all_number_less_than500\n");
# is all number < 500: true

$is_all_number_more_than500 = array_every_v1(sub { my ($number) = @_; return $number > 500; }, @numbers) ? 'true' : 'false';
print("is all number > 500: $is_all_number_more_than500\n");
# is all number > 500: false

print("# using JavaScript-like Array.every() function \"array_every_v2\"\n");

$is_all_number_less_than500 = array_every_v2(sub { my ($number) = @_; return $number < 500; }, @numbers) ? 'true' : 'false';
print("is all number < 500: $is_all_number_less_than500\n");
# is all number < 500: true

$is_all_number_more_than500 = array_every_v2(sub { my ($number) = @_; return $number > 500; }, @numbers) ? 'true' : 'false';
print("is all number > 500: $is_all_number_more_than500\n");
# is all number > 500: false

print("# using JavaScript-like Array.every() function \"array_every_v3\"\n");

$is_all_number_less_than500 = array_every_v3(sub { my ($number) = @_; return $number < 500; }, @numbers) ? 'true' : 'false';
print("is all number < 500: $is_all_number_less_than500\n");
# is all number < 500: true

$is_all_number_more_than500 = array_every_v3(sub { my ($number) = @_; return $number > 500; }, @numbers) ? 'true' : 'false';
print("is all number > 500: $is_all_number_more_than500\n");
# is all number > 500: false

print("# using JavaScript-like Array.every() function \"array_every_v4\"\n");

$is_all_number_less_than500 = array_every_v4(sub { my ($number) = @_; return $number < 500; }, @numbers) ? 'true' : 'false';
print("is all number < 500: $is_all_number_less_than500\n");
# is all number < 500: true

$is_all_number_more_than500 = array_every_v4(sub { my ($number) = @_; return $number > 500; }, @numbers) ? 'true' : 'false';
print("is all number > 500: $is_all_number_more_than500\n");
# is all number > 500: false

print("# using Perl Array.every() built-in function List::Util all\n");

$is_all_number_less_than500 = (all { my $number = $_; return $number < 500; } @numbers) ? 'true' : 'false';
print("is all number < 500: $is_all_number_less_than500\n");
# is all number < 500: true

$is_all_number_more_than500 = (all { my $number = $_; return $number > 500; } @numbers) ? 'true' : 'false';
print("is all number > 500: $is_all_number_more_than500\n");
# is all number > 500: false

print("\n# JavaScript-like Array.every() in Perl Array of Hashes\n");

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

my $is_all_product_price_less_than500;
my $is_all_product_price_more_than500;

print("# using JavaScript-like Array.every() function \"array_every_v1\"\n");

$is_all_product_price_less_than500 = array_every_v1(sub { my ($product) = @_; return $product->{'price'} < 500; }, @products) ? 'true' : 'false';
print("is all product price < 500: $is_all_product_price_less_than500\n");
# is all product price < 500: true

$is_all_product_price_more_than500 = array_every_v1(sub { my ($product) = @_; return $product->{'price'} > 500; }, @products) ? 'true' : 'false';
print("is all product price > 500: $is_all_product_price_more_than500\n");
# is all product price > 500: false

print("# using JavaScript-like Array.every() function \"array_every_v2\"\n");

$is_all_product_price_less_than500 = array_every_v2(sub { my ($product) = @_; return $product->{'price'} < 500; }, @products) ? 'true' : 'false';
print("is all product price < 500: $is_all_product_price_less_than500\n");
# is all product price < 500: true

$is_all_product_price_more_than500 = array_every_v2(sub { my ($product) = @_; return $product->{'price'} > 500; }, @products) ? 'true' : 'false';
print("is all product price > 500: $is_all_product_price_more_than500\n");
# is all product price > 500: false

print("# using JavaScript-like Array.every() function \"array_every_v3\"\n");

$is_all_product_price_less_than500 = array_every_v3(sub { my ($product) = @_; return $product->{'price'} < 500; }, @products) ? 'true' : 'false';
print("is all product price < 500: $is_all_product_price_less_than500\n");
# is all product price < 500: true

$is_all_product_price_more_than500 = array_every_v3(sub { my ($product) = @_; return $product->{'price'} > 500; }, @products) ? 'true' : 'false';
print("is all product price > 500: $is_all_product_price_more_than500\n");
# is all product price > 500: false

print("# using JavaScript-like Array.every() function \"array_every_v4\"\n");

$is_all_product_price_less_than500 = array_every_v4(sub { my ($product) = @_; return $product->{'price'} < 500; }, @products) ? 'true' : 'false';
print("is all product price < 500: $is_all_product_price_less_than500\n");
# is all product price < 500: true

$is_all_product_price_more_than500 = array_every_v4(sub { my ($product) = @_; return $product->{'price'} > 500; }, @products) ? 'true' : 'false';
print("is all product price > 500: $is_all_product_price_more_than500\n");
# is all product price > 500: false

print("# using Perl Array.every() built-in function \"List::Util\" \"all\"\n");

$is_all_number_less_than500 = (all { my $product = $_; return $product->{'price'} < 500; } @products) ? 'true' : 'false';
print("is all number < 500: $is_all_number_less_than500\n");
# is all number < 500: true

$is_all_number_more_than500 = (all { my $product = $_; return $product->{'price'} > 500; } @products) ? 'true' : 'false';
print("is all number > 500: $is_all_number_more_than500\n");
# is all number > 500: false
