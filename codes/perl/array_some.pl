use strict;
use warnings;
use List::Util qw(any);
use Scalar::Util qw(looks_like_number);

sub bool_to_string {
    my ($anything) = @_;
    return ($anything ? "true" : "false");
}

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
        $result = ($result . "\"" . $array_item . "\"") if ($is_string && !$is_number);
        $result = ($result . $array_item) if ($is_number);
        $result = ($result . ", ") if (($array_item_index + 1) != $number_of_parameters);
    }
    $result = $result . "]";
    return $result;
}

sub array_some_v1 {
    # JavaScript-like Array.some() function
    my ($callback_function_ref, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    my $is_condition_match = 0;
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        $is_condition_match = $callback_function_ref->($array_item, $array_item_index, $an_array_ref);
        last if ($is_condition_match);
    }
    return $is_condition_match;
}

sub array_some_v2 {
    # JavaScript-like Array.some() function
    my ($callback_function_ref, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    my $is_condition_match = 0;
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        $is_condition_match = $callback_function_ref->($array_item, $array_item_index, $an_array_ref);
        return $is_condition_match if ($is_condition_match);
    }
    return $is_condition_match;
}

sub array_some_v3 {
    # JavaScript-like Array.some() function
    my ($callback_function_ref, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        my $is_condition_match = $callback_function_ref->($array_item, $array_item_index, $an_array_ref);
        return 1 if ($is_condition_match);
    }
    return 0;
}

sub array_some_v4 {
    # JavaScript-like Array.some() function
    my ($callback_function_ref, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        return 1 if ($callback_function_ref->($array_item, $array_item_index, $an_array_ref));
    }
    return 0;
}

print("\n# JavaScript-like Array.some() in Perl List", "\n");

my @numbers = (12, 34, 27, 23, 65, 93, 36, 87, 4, 254);
print("numbers: ", pretty_array_of_primitives(@numbers), "\n");

my $is_any_number_less_than_500;
my $is_any_number_more_than_500;

print("# using JavaScript-like Array.some() function \"array_some_v1\"\n");

$is_any_number_less_than_500 = bool_to_string(array_some_v1(sub { my ($number) = @_; ($number < 500) }, \@numbers));
print("is any number < 500: $is_any_number_less_than_500", "\n");
# is any number < 500: true

$is_any_number_more_than_500 = bool_to_string(array_some_v1(sub { my ($number) = @_; ($number > 500) }, \@numbers));
print("is any number > 500: $is_any_number_more_than_500", "\n");
# is any number > 500: false

print("# using JavaScript-like Array.some() function \"array_some_v2\"\n");

$is_any_number_less_than_500 = bool_to_string(array_some_v2(sub { my ($number) = @_; ($number < 500) }, \@numbers));
print("is any number < 500: $is_any_number_less_than_500", "\n");
# is any number < 500: true

$is_any_number_more_than_500 = bool_to_string(array_some_v2(sub { my ($number) = @_; ($number > 500) }, \@numbers));
print("is any number > 500: $is_any_number_more_than_500", "\n");
# is any number > 500: false

print("# using JavaScript-like Array.some() function \"array_some_v3\"\n");

$is_any_number_less_than_500 = bool_to_string(array_some_v3(sub { my ($number) = @_; ($number < 500) }, \@numbers));
print("is any number < 500: $is_any_number_less_than_500", "\n");
# is any number < 500: true

$is_any_number_more_than_500 = bool_to_string(array_some_v3(sub { my ($number) = @_; ($number > 500) }, \@numbers));
print("is any number > 500: $is_any_number_more_than_500", "\n");
# is any number > 500: false

print("# using JavaScript-like Array.some() function \"array_some_v4\"\n");

$is_any_number_less_than_500 = bool_to_string(array_some_v4(sub { my ($number) = @_; ($number < 500) }, \@numbers));
print("is any number < 500: $is_any_number_less_than_500", "\n");
# is any number < 500: true

$is_any_number_more_than_500 = bool_to_string(array_some_v4(sub { my ($number) = @_; ($number > 500) }, \@numbers));
print("is any number > 500: $is_any_number_more_than_500", "\n");
# is any number > 500: false

print("# using Perl Array.some() built-in function \"List::Util\" \"any\"\n");

$is_any_number_less_than_500 = bool_to_string(any { my $number = $_; ($number < 500) } @numbers);
print("is any number < 500: $is_any_number_less_than_500", "\n");
# is any number < 500: true

$is_any_number_more_than_500 = bool_to_string(any { my $number = $_; ($number > 500) } @numbers);
print("is any number > 500: $is_any_number_more_than_500", "\n");
# is any number > 500: false

print("\n# JavaScript-like Array.some() in Perl List of Hashes", "\n");

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

print("products: ", pretty_json_stringify(\@products), "\n");

my $is_any_product_price_less_than_500;
my $is_any_product_price_more_than_500;

print("# using JavaScript-like Array.some() function \"array_some_v1\"\n");

$is_any_product_price_less_than_500 = bool_to_string(array_some_v1(sub { my ($product) = @_; ($product->{"price"} < 500) }, \@products));
print("is any product price < 500: $is_any_product_price_less_than_500", "\n");
# is any product price < 500: true

$is_any_product_price_more_than_500 = bool_to_string(array_some_v1(sub { my ($product) = @_; ($product->{"price"} > 500) }, \@products));
print("is any product price > 500: $is_any_product_price_more_than_500", "\n");
# is any product price > 500: false

print("# using JavaScript-like Array.some() function \"array_some_v2\"\n");

$is_any_product_price_less_than_500 = bool_to_string(array_some_v2(sub { my ($product) = @_; ($product->{"price"} < 500) }, \@products));
print("is any product price < 500: $is_any_product_price_less_than_500", "\n");
# is any product price < 500: true

$is_any_product_price_more_than_500 = bool_to_string(array_some_v2(sub { my ($product) = @_; ($product->{"price"} > 500) }, \@products));
print("is any product price > 500: $is_any_product_price_more_than_500", "\n");
# is any product price > 500: false

print("# using JavaScript-like Array.some() function \"array_some_v3\"\n");

$is_any_product_price_less_than_500 = bool_to_string(array_some_v3(sub { my ($product) = @_; ($product->{"price"} < 500) }, \@products));
print("is any product price < 500: $is_any_product_price_less_than_500", "\n");
# is any product price < 500: true

$is_any_product_price_more_than_500 = bool_to_string(array_some_v3(sub { my ($product) = @_; ($product->{"price"} > 500) }, \@products));
print("is any product price > 500: $is_any_product_price_more_than_500", "\n");
# is any product price > 500: false

print("# using JavaScript-like Array.some() function \"array_some_v4\"\n");

$is_any_product_price_less_than_500 = bool_to_string(array_some_v4(sub { my ($product) = @_; ($product->{"price"} < 500) }, \@products));
print("is any product price < 500: $is_any_product_price_less_than_500", "\n");
# is any product price < 500: true

$is_any_product_price_more_than_500 = bool_to_string(array_some_v4(sub { my ($product) = @_; ($product->{"price"} > 500) }, \@products));
print("is any product price > 500: $is_any_product_price_more_than_500", "\n");
# is any product price > 500: false

print("# using Perl Array.some() built-in function \"List::Util\" \"any\"\n");

$is_any_number_less_than_500 = bool_to_string(any { my $product = $_; ($product->{"price"} < 500) } @products);
print("is any number < 500: $is_any_number_less_than_500", "\n");
# is any number < 500: true

$is_any_number_more_than_500 = bool_to_string(any { my $product = $_; ($product->{"price"} > 500) } @products);
print("is any number > 500: $is_any_number_more_than_500", "\n");
# is any number > 500: false
