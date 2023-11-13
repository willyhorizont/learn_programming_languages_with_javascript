use strict;
use warnings;
use JSON;
use Scalar::Util qw(looks_like_number);

# There's no JavaScript-like Array.findIndex() in Perl.
# But, we can create our own function to mimic it in Perl.

sub pretty_array_of_primitives {
    my $number_of_parameters = @_;
    my $result = "[";
    for (my $array_item_index = 0; $array_item_index < $number_of_parameters; $array_item_index += 1) {
        my $array_item = $_[$array_item_index];
        my $is_string = (defined($array_item) && $array_item =~ /[0-9a-zA-Z`~!@#%&_=;':", \(\)\[\]\{\}\|\*\+\?\^\$\/\\\<\>\.\-]/);
        my $is_number = looks_like_number($array_item);
        last if (!$is_string && !$is_number);
        $result = $result . "\"" . $array_item . "\"" if ($is_string && !$is_number);
        $result = $result . $array_item if ($is_number);
        $result = $result . ", " if (($array_item_index + 1) != $number_of_parameters);
    }
    $result = $result . "]";
    return $result;
}

sub array_find_index_v1 {
    # JavaScript-like Array.findIndex() function
    my ($callback_function, $an_array_ref) = @_;
    my @an_array = @$an_array_ref;
    my $item_index = -1;
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        my $is_condition_match = $callback_function->($array_item, $array_item_index, \@an_array);
        if ($is_condition_match) {
            $item_index = $array_item_index;
            last;
        }
    }
    return $item_index;
}

sub array_find_index_v2 {
    # JavaScript-like Array.findIndex() function
    my ($callback_function, $an_array_ref) = @_;
    my @an_array = @$an_array_ref;
    my $item_index = -1;
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        if ($callback_function->($array_item, $array_item_index, \@an_array)) {
            $item_index = $array_item_index;
            last;
        }
    }
    return $item_index;
}

sub array_find_index_v3 {
    # JavaScript-like Array.findIndex() function
    my ($callback_function, $an_array_ref) = @_;
    my @an_array = @$an_array_ref;
    my $item_index = -1;
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        my $is_condition_match = $callback_function->($array_item, $array_item_index, \@an_array);
        if ($is_condition_match) {
            return $array_item_index;
        }
    }
    return $item_index;
}

sub array_find_index_v4 {
    # JavaScript-like Array.findIndex() function
    my ($callback_function, $an_array_ref) = @_;
    my @an_array = @$an_array_ref;
    my $item_index = -1;
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        my $is_condition_match = $callback_function->($array_item, $array_item_index, \@an_array);
        return $array_item_index if ($is_condition_match);
    }
    return $item_index;
}

sub array_find_index_v5 {
    # JavaScript-like Array.findIndex() function
    my ($callback_function, $an_array_ref) = @_;
    my @an_array = @$an_array_ref;
    my $item_index = -1;
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        if ($callback_function->($array_item, $array_item_index, \@an_array)) {
            return $array_item_index;
        }
    }
    return $item_index;
}

sub array_find_index_v6 {
    # JavaScript-like Array.findIndex() function
    my ($callback_function, $an_array_ref) = @_;
    my @an_array = @$an_array_ref;
    my $item_index = -1;
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        return $array_item_index if ($callback_function->($array_item, $array_item_index, \@an_array));
    }
    return $item_index;
}

sub array_find_index_v7 {
    # JavaScript-like Array.findIndex() function
    my ($callback_function, $an_array_ref) = @_;
    my @an_array = @$an_array_ref;
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        my $is_condition_match = $callback_function->($array_item, $array_item_index, \@an_array);
        if ($is_condition_match) {
            return $array_item_index;
        }
    }
    return -1;
}

sub array_find_index_v8 {
    # JavaScript-like Array.findIndex() function
    my ($callback_function, $an_array_ref) = @_;
    my @an_array = @$an_array_ref;
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        my $is_condition_match = $callback_function->($array_item, $array_item_index, \@an_array);
        return $array_item_index if ($is_condition_match);
    }
    return -1;
}

sub array_find_index_v9 {
    # JavaScript-like Array.findIndex() function
    my ($callback_function, $an_array_ref) = @_;
    my @an_array = @$an_array_ref;
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        if ($callback_function->($array_item, $array_item_index, \@an_array)) {
            return $array_item_index;
        }
    }
    return -1;
}

sub array_find_index_v10 {
    # JavaScript-like Array.findIndex() function
    my ($callback_function, $an_array_ref) = @_;
    my @an_array = @$an_array_ref;
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        return $array_item_index if ($callback_function->($array_item, $array_item_index, \@an_array));
    }
    return -1;
}

print("\n# JavaScript-like Array.findIndex() in Perl Array\n");

my @numbers = (12, 34, 27, 23, 65, 93, 36, 87, 4, 254);
print("numbers: ", pretty_array_of_primitives(@numbers), "\n");

my $number_to_find = 27;
print("number to find: ", $number_to_find, "\n");

my $number_found_index;

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v1\"\n");

$number_found_index = array_find_index_v1(sub { my ($number) = @_; return ($number == $number_to_find); }, \@numbers);
print("number found index: ", $number_found_index, "\n");
# number found index: 2

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v2\"\n");

$number_found_index = array_find_index_v2(sub { my ($number) = @_; return ($number == $number_to_find); }, \@numbers);
print("number found index: ", $number_found_index, "\n");
# number found index: 2

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v3\"\n");

$number_found_index = array_find_index_v3(sub { my ($number) = @_; return ($number == $number_to_find); }, \@numbers);
print("number found index: ", $number_found_index, "\n");
# number found index: 2

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v4\"\n");

$number_found_index = array_find_index_v4(sub { my ($number) = @_; return ($number == $number_to_find); }, \@numbers);
print("number found index: ", $number_found_index, "\n");
# number found index: 2

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v5\"\n");

$number_found_index = array_find_index_v5(sub { my ($number) = @_; return ($number == $number_to_find); }, \@numbers);
print("number found index: ", $number_found_index, "\n");
# number found index: 2

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v6\"\n");

$number_found_index = array_find_index_v6(sub { my ($number) = @_; return ($number == $number_to_find); }, \@numbers);
print("number found index: ", $number_found_index, "\n");
# number found index: 2

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v7\"\n");

$number_found_index = array_find_index_v7(sub { my ($number) = @_; return ($number == $number_to_find); }, \@numbers);
print("number found index: ", $number_found_index, "\n");
# number found index: 2

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v8\"\n");

$number_found_index = array_find_index_v8(sub { my ($number) = @_; return ($number == $number_to_find); }, \@numbers);
print("number found index: ", $number_found_index, "\n");
# number found index: 2

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v9\"\n");

$number_found_index = array_find_index_v9(sub { my ($number) = @_; return ($number == $number_to_find); }, \@numbers);
print("number found index: ", $number_found_index, "\n");
# number found index: 2

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v10\"\n");

$number_found_index = array_find_index_v10(sub { my ($number) = @_; return ($number == $number_to_find); }, \@numbers);
print("number found index: ", $number_found_index, "\n");
# number found index: 2

print("\n# JavaScript-like Array.findIndex() in Perl Array of Hashes\n");

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

my $product_to_find = "pasta";
print("product to find: ", $product_to_find, "\n");

my $product_found_index;

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v1\"\n");

$product_found_index = array_find_index_v1(sub { my ($product) = @_; return ($product->{"code"} eq $product_to_find); }, \@products);
print("product found index: ", $product_found_index, "\n");
# product found index: 0

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v2\"\n");

$product_found_index = array_find_index_v2(sub { my ($product) = @_; return ($product->{"code"} eq $product_to_find); }, \@products);
print("product found index: ", $product_found_index, "\n");
# product found index: 0

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v3\"\n");

$product_found_index = array_find_index_v3(sub { my ($product) = @_; return ($product->{"code"} eq $product_to_find); }, \@products);
print("product found index: ", $product_found_index, "\n");
# product found index: 0

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v4\"\n");

$product_found_index = array_find_index_v4(sub { my ($product) = @_; return ($product->{"code"} eq $product_to_find); }, \@products);
print("product found index: ", $product_found_index, "\n");
# product found index: 0

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v5\"\n");

$product_found_index = array_find_index_v5(sub { my ($product) = @_; return ($product->{"code"} eq $product_to_find); }, \@products);
print("product found index: ", $product_found_index, "\n");
# product found index: 0

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v6\"\n");

$product_found_index = array_find_index_v6(sub { my ($product) = @_; return ($product->{"code"} eq $product_to_find); }, \@products);
print("product found index: ", $product_found_index, "\n");
# product found index: 0

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v7\"\n");

$product_found_index = array_find_index_v7(sub { my ($product) = @_; return ($product->{"code"} eq $product_to_find); }, \@products);
print("product found index: ", $product_found_index, "\n");
# product found index: 0

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v8\"\n");

$product_found_index = array_find_index_v8(sub { my ($product) = @_; return ($product->{"code"} eq $product_to_find); }, \@products);
print("product found index: ", $product_found_index, "\n");
# product found index: 0

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v9\"\n");

$product_found_index = array_find_index_v9(sub { my ($product) = @_; return ($product->{"code"} eq $product_to_find); }, \@products);
print("product found index: ", $product_found_index, "\n");
# product found index: 0

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v10\"\n");

$product_found_index = array_find_index_v10(sub { my ($product) = @_; return ($product->{"code"} eq $product_to_find); }, \@products);
print("product found index: ", $product_found_index, "\n");
# product found index: 0
