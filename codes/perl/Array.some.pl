use strict;
use warnings;
use JSON;
use List::Util qw(any);
use Scalar::Util qw(looks_like_number);

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

sub array_some_v1 {
    # JavaScript-like Array.some() function
    my ($callback_function, $an_array_ref) = @_;
    my @an_array = @$an_array_ref;
    my $is_condition_match = 0;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        $is_condition_match = $callback_function->($array_item, $array_item_index, \@an_array);
        if ($is_condition_match) {
            last;
        }
    }
    return $is_condition_match;
}

sub array_some_v2 {
    # JavaScript-like Array.some() function
    my ($callback_function, $an_array_ref) = @_;
    my @an_array = @$an_array_ref;
    my $is_condition_match = 0;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        $is_condition_match = $callback_function->($array_item, $array_item_index, \@an_array);
        last if ($is_condition_match);
    }
    return $is_condition_match;
}

sub array_some_v3 {
    # JavaScript-like Array.some() function
    my ($callback_function, $an_array_ref) = @_;
    my @an_array = @$an_array_ref;
    my $is_condition_match = 0;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        $is_condition_match = $callback_function->($array_item, $array_item_index, \@an_array);
        if ($is_condition_match) {
            return $is_condition_match;
        }
    }
    return $is_condition_match;
}

sub array_some_v4 {
    # JavaScript-like Array.some() function
    my ($callback_function, $an_array_ref) = @_;
    my @an_array = @$an_array_ref;
    my $is_condition_match = 0;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        $is_condition_match = $callback_function->($array_item, $array_item_index, \@an_array);
        return $is_condition_match if ($is_condition_match);
    }
    return $is_condition_match;
}

sub array_some_v5 {
    # JavaScript-like Array.some() function
    my ($callback_function, $an_array_ref) = @_;
    my @an_array = @$an_array_ref;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        my $is_condition_match = $callback_function->($array_item, $array_item_index, \@an_array);
        if ($is_condition_match) {
            return 1;
        }
    }
    return 0;
}

sub array_some_v6 {
    # JavaScript-like Array.some() function
    my ($callback_function, $an_array_ref) = @_;
    my @an_array = @$an_array_ref;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        my $is_condition_match = $callback_function->($array_item, $array_item_index, \@an_array);
        return 1 if ($is_condition_match);
    }
    return 0;
}

sub array_some_v7 {
    # JavaScript-like Array.some() function
    my ($callback_function, $an_array_ref) = @_;
    my @an_array = @$an_array_ref;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        if ($callback_function->($array_item, $array_item_index, \@an_array)) {
            return 1;
        }
    }
    return 0;
}

sub array_some_v8 {
    # JavaScript-like Array.some() function
    my ($callback_function, $an_array_ref) = @_;
    my @an_array = @$an_array_ref;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        return 1 if ($callback_function->($array_item, $array_item_index, \@an_array));
    }
    return 0;
}

print("\n# JavaScript-like Array.some() in Perl Array\n");

my @numbers = (12, 34, 27, 23, 65, 93, 36, 87, 4, 254);
print("numbers: ", pretty_array_of_primitives(@numbers), "\n");

my $is_any_number_less_than_500;
my $is_any_number_more_than_500;

print("# using JavaScript-like Array.some() function \"array_some_v1\"\n");

$is_any_number_less_than_500 = (array_some_v1(sub { my ($number) = @_; return ($number < 500); }, \@numbers) ? "true" : "false");
print("is any number < 500: $is_any_number_less_than_500\n");
# is any number < 500: true

$is_any_number_more_than_500 = (array_some_v1(sub { my ($number) = @_; return ($number > 500); }, \@numbers) ? "true" : "false");
print("is any number > 500: $is_any_number_more_than_500\n");
# is any number > 500: false

print("# using JavaScript-like Array.some() function \"array_some_v2\"\n");

$is_any_number_less_than_500 = (array_some_v2(sub { my ($number) = @_; return ($number < 500); }, \@numbers) ? "true" : "false");
print("is any number < 500: $is_any_number_less_than_500\n");
# is any number < 500: true

$is_any_number_more_than_500 = (array_some_v2(sub { my ($number) = @_; return ($number > 500); }, \@numbers) ? "true" : "false");
print("is any number > 500: $is_any_number_more_than_500\n");
# is any number > 500: false

print("# using JavaScript-like Array.some() function \"array_some_v3\"\n");

$is_any_number_less_than_500 = (array_some_v3(sub { my ($number) = @_; return ($number < 500); }, \@numbers) ? "true" : "false");
print("is any number < 500: $is_any_number_less_than_500\n");
# is any number < 500: true

$is_any_number_more_than_500 = (array_some_v3(sub { my ($number) = @_; return ($number > 500); }, \@numbers) ? "true" : "false");
print("is any number > 500: $is_any_number_more_than_500\n");
# is any number > 500: false

print("# using JavaScript-like Array.some() function \"array_some_v4\"\n");

$is_any_number_less_than_500 = (array_some_v4(sub { my ($number) = @_; return ($number < 500); }, \@numbers) ? "true" : "false");
print("is any number < 500: $is_any_number_less_than_500\n");
# is any number < 500: true

$is_any_number_more_than_500 = (array_some_v4(sub { my ($number) = @_; return ($number > 500); }, \@numbers) ? "true" : "false");
print("is any number > 500: $is_any_number_more_than_500\n");
# is any number > 500: false

print("# using JavaScript-like Array.some() function \"array_some_v5\"\n");

$is_any_number_less_than_500 = (array_some_v5(sub { my ($number) = @_; return ($number < 500); }, \@numbers) ? "true" : "false");
print("is any number < 500: $is_any_number_less_than_500\n");
# is any number < 500: true

$is_any_number_more_than_500 = (array_some_v5(sub { my ($number) = @_; return ($number > 500); }, \@numbers) ? "true" : "false");
print("is any number > 500: $is_any_number_more_than_500\n");
# is any number > 500: false

print("# using JavaScript-like Array.some() function \"array_some_v6\"\n");

$is_any_number_less_than_500 = (array_some_v6(sub { my ($number) = @_; return ($number < 500); }, \@numbers) ? "true" : "false");
print("is any number < 500: $is_any_number_less_than_500\n");
# is any number < 500: true

$is_any_number_more_than_500 = (array_some_v6(sub { my ($number) = @_; return ($number > 500); }, \@numbers) ? "true" : "false");
print("is any number > 500: $is_any_number_more_than_500\n");
# is any number > 500: false

print("# using JavaScript-like Array.some() function \"array_some_v7\"\n");

$is_any_number_less_than_500 = (array_some_v7(sub { my ($number) = @_; return ($number < 500); }, \@numbers) ? "true" : "false");
print("is any number < 500: $is_any_number_less_than_500\n");
# is any number < 500: true

$is_any_number_more_than_500 = (array_some_v7(sub { my ($number) = @_; return ($number > 500); }, \@numbers) ? "true" : "false");
print("is any number > 500: $is_any_number_more_than_500\n");
# is any number > 500: false

print("# using JavaScript-like Array.some() function \"array_some_v8\"\n");

$is_any_number_less_than_500 = (array_some_v8(sub { my ($number) = @_; return ($number < 500); }, \@numbers) ? "true" : "false");
print("is any number < 500: $is_any_number_less_than_500\n");
# is any number < 500: true

$is_any_number_more_than_500 = (array_some_v8(sub { my ($number) = @_; return ($number > 500); }, \@numbers) ? "true" : "false");
print("is any number > 500: $is_any_number_more_than_500\n");
# is any number > 500: false

print("# using Perl Array.some() built-in function List::Util any\n");

$is_any_number_less_than_500 = ((any { my $number = $_; return ($number < 500); } @numbers) ? "true" : "false");
print("is any number < 500: $is_any_number_less_than_500\n");
# is any number < 500: true

$is_any_number_more_than_500 = ((any { my $number = $_; return ($number > 500); } @numbers) ? "true" : "false");
print("is any number > 500: $is_any_number_more_than_500\n");
# is any number > 500: false

print("\n# JavaScript-like Array.some() in Perl Array of Hashes\n");

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

my $is_any_product_price_less_than_500;
my $is_any_product_price_more_than_500;

print("# using JavaScript-like Array.some() function \"array_some_v1\"\n");

$is_any_product_price_less_than_500 = (array_some_v1(sub { my ($product) = @_; return ($product->{"price"} < 500); }, \@products) ? "true" : "false");
print("is any product price < 500: $is_any_product_price_less_than_500\n");
# is any product price < 500: true

$is_any_product_price_more_than_500 = (array_some_v1(sub { my ($product) = @_; return ($product->{"price"} > 500); }, \@products) ? "true" : "false");
print("is any product price > 500: $is_any_product_price_more_than_500\n");
# is any product price > 500: false

print("# using JavaScript-like Array.some() function \"array_some_v2\"\n");

$is_any_product_price_less_than_500 = (array_some_v2(sub { my ($product) = @_; return ($product->{"price"} < 500); }, \@products) ? "true" : "false");
print("is any product price < 500: $is_any_product_price_less_than_500\n");
# is any product price < 500: true

$is_any_product_price_more_than_500 = (array_some_v2(sub { my ($product) = @_; return ($product->{"price"} > 500); }, \@products) ? "true" : "false");
print("is any product price > 500: $is_any_product_price_more_than_500\n");
# is any product price > 500: false

print("# using JavaScript-like Array.some() function \"array_some_v3\"\n");

$is_any_product_price_less_than_500 = (array_some_v3(sub { my ($product) = @_; return ($product->{"price"} < 500); }, \@products) ? "true" : "false");
print("is any product price < 500: $is_any_product_price_less_than_500\n");
# is any product price < 500: true

$is_any_product_price_more_than_500 = (array_some_v3(sub { my ($product) = @_; return ($product->{"price"} > 500); }, \@products) ? "true" : "false");
print("is any product price > 500: $is_any_product_price_more_than_500\n");
# is any product price > 500: false

print("# using JavaScript-like Array.some() function \"array_some_v4\"\n");

$is_any_product_price_less_than_500 = (array_some_v4(sub { my ($product) = @_; return ($product->{"price"} < 500); }, \@products) ? "true" : "false");
print("is any product price < 500: $is_any_product_price_less_than_500\n");
# is any product price < 500: true

$is_any_product_price_more_than_500 = (array_some_v4(sub { my ($product) = @_; return ($product->{"price"} > 500); }, \@products) ? "true" : "false");
print("is any product price > 500: $is_any_product_price_more_than_500\n");
# is any product price > 500: false

print("# using JavaScript-like Array.some() function \"array_some_v5\"\n");

$is_any_product_price_less_than_500 = (array_some_v5(sub { my ($product) = @_; return ($product->{"price"} < 500); }, \@products) ? "true" : "false");
print("is any product price < 500: $is_any_product_price_less_than_500\n");
# is any product price < 500: true

$is_any_product_price_more_than_500 = (array_some_v5(sub { my ($product) = @_; return ($product->{"price"} > 500); }, \@products) ? "true" : "false");
print("is any product price > 500: $is_any_product_price_more_than_500\n");
# is any product price > 500: false

print("# using JavaScript-like Array.some() function \"array_some_v6\"\n");

$is_any_product_price_less_than_500 = (array_some_v6(sub { my ($product) = @_; return ($product->{"price"} < 500); }, \@products) ? "true" : "false");
print("is any product price < 500: $is_any_product_price_less_than_500\n");
# is any product price < 500: true

$is_any_product_price_more_than_500 = (array_some_v6(sub { my ($product) = @_; return ($product->{"price"} > 500); }, \@products) ? "true" : "false");
print("is any product price > 500: $is_any_product_price_more_than_500\n");
# is any product price > 500: false

print("# using JavaScript-like Array.some() function \"array_some_v7\"\n");

$is_any_product_price_less_than_500 = (array_some_v7(sub { my ($product) = @_; return ($product->{"price"} < 500); }, \@products) ? "true" : "false");
print("is any product price < 500: $is_any_product_price_less_than_500\n");
# is any product price < 500: true

$is_any_product_price_more_than_500 = (array_some_v7(sub { my ($product) = @_; return ($product->{"price"} > 500); }, \@products) ? "true" : "false");
print("is any product price > 500: $is_any_product_price_more_than_500\n");
# is any product price > 500: false

print("# using JavaScript-like Array.some() function \"array_some_v8\"\n");

$is_any_product_price_less_than_500 = (array_some_v8(sub { my ($product) = @_; return ($product->{"price"} < 500); }, \@products) ? "true" : "false");
print("is any product price < 500: $is_any_product_price_less_than_500\n");
# is any product price < 500: true

$is_any_product_price_more_than_500 = (array_some_v8(sub { my ($product) = @_; return ($product->{"price"} > 500); }, \@products) ? "true" : "false");
print("is any product price > 500: $is_any_product_price_more_than_500\n");
# is any product price > 500: false

print("# using Perl Array.some() built-in function \"List::Util\" \"any\"\n");

$is_any_number_less_than_500 = ((any { my $product = $_; return ($product->{"price"} < 500); } @products) ? "true" : "false");
print("is any number < 500: $is_any_number_less_than_500\n");
# is any number < 500: true

$is_any_number_more_than_500 = ((any { my $product = $_; return ($product->{"price"} > 500); } @products) ? "true" : "false");
print("is any number > 500: $is_any_number_more_than_500\n");
# is any number > 500: false
