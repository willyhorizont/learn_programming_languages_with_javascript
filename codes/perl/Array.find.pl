use strict;
use warnings;
use JSON;
use Scalar::Util qw(looks_like_number);

# There's no JavaScript-like Array.find() in Perl.
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

sub array_find_v1 {
    # JavaScript-like Array.find() function
    my ($callback_function, @an_array) = @_;
    my $data_found;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        my $is_condition_match = $callback_function->($array_item, $array_item_index, \@an_array);
        if ($is_condition_match) {
            $data_found = $array_item;
            last;
        }
    }
    return $data_found;
}

sub array_find_v2 {
    # JavaScript-like Array.find() function
    my ($callback_function, @an_array) = @_;
    my $data_found;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        if ($callback_function->($array_item, $array_item_index, \@an_array)) {
            $data_found = $array_item;
            last;
        }
    }
    return $data_found;
}

sub array_find_v3 {
    # JavaScript-like Array.find() function
    my ($callback_function, @an_array) = @_;
    my $data_found;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        my $is_condition_match = $callback_function->($array_item, $array_item_index, \@an_array);
        if ($is_condition_match) {
            return $array_item;
        }
    }
    return $data_found;
}

sub array_find_v4 {
    # JavaScript-like Array.find() function
    my ($callback_function, @an_array) = @_;
    my $data_found;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        my $is_condition_match = $callback_function->($array_item, $array_item_index, \@an_array);
        return $array_item if ($is_condition_match);
    }
    return $data_found;
}

sub array_find_v5 {
    # JavaScript-like Array.find() function
    my ($callback_function, @an_array) = @_;
    my $data_found;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        if ($callback_function->($array_item, $array_item_index, \@an_array)) {
            return $array_item;
        }
    }
    return $data_found;
}

sub array_find_v6 {
    # JavaScript-like Array.find() function
    my ($callback_function, @an_array) = @_;
    my $data_found;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        return $array_item if ($callback_function->($array_item, $array_item_index, \@an_array));
    }
    return $data_found;
}

sub array_find_v7 {
    # JavaScript-like Array.find() function
    my ($callback_function, @an_array) = @_;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        my $is_condition_match = $callback_function->($array_item, $array_item_index, \@an_array);
        if ($is_condition_match) {
            return $array_item;
        }
    }
    return undef;
}

sub array_find_v8 {
    # JavaScript-like Array.find() function
    my ($callback_function, @an_array) = @_;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        my $is_condition_match = $callback_function->($array_item, $array_item_index, \@an_array);
        return $array_item if ($is_condition_match);
    }
    return undef;
}

sub array_find_v9 {
    # JavaScript-like Array.find() function
    my ($callback_function, @an_array) = @_;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        if ($callback_function->($array_item, $array_item_index, \@an_array)) {
            return $array_item;
        }
    }
    return undef;
}

sub array_find_v10 {
    # JavaScript-like Array.find() function
    my ($callback_function, @an_array) = @_;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        return $array_item if ($callback_function->($array_item, $array_item_index, \@an_array));
    }
    return undef;
}

print("\n# JavaScript-like Array.find() in Perl Array\n");

my @numbers = (12, 34, 27, 23, 65, 93, 36, 87, 4, 254);
print("numbers: ", pretty_array_of_primitives(@numbers), "\n");

my $even_number_found;
my $odd_number_found;

print("# using JavaScript-like Array.find() function \"array_find_v1\"\n");

$even_number_found = array_find_v1(sub { my ($number) = @_; return (($number % 2) == 0); }, @numbers);
print("even number found: ", $even_number_found, "\n");
# even number found: 12

$odd_number_found = array_find_v1(sub { my ($number) = @_; return (($number % 2) != 0); }, @numbers);
print("odd number found: ", $odd_number_found, "\n");
# odd number found: 27

print("# using JavaScript-like Array.find() function \"array_find_v2\"\n");

$even_number_found = array_find_v2(sub { my ($number) = @_; return (($number % 2) == 0); }, @numbers);
print("even number found: ", $even_number_found, "\n");
# even number found: 12

$odd_number_found = array_find_v2(sub { my ($number) = @_; return (($number % 2) != 0); }, @numbers);
print("odd number found: ", $odd_number_found, "\n");
# odd number found: 27

print("# using JavaScript-like Array.find() function \"array_find_v3\"\n");

$even_number_found = array_find_v3(sub { my ($number) = @_; return (($number % 2) == 0); }, @numbers);
print("even number found: ", $even_number_found, "\n");
# even number found: 12

$odd_number_found = array_find_v3(sub { my ($number) = @_; return (($number % 2) != 0); }, @numbers);
print("odd number found: ", $odd_number_found, "\n");
# odd number found: 27

print("# using JavaScript-like Array.find() function \"array_find_v4\"\n");

$even_number_found = array_find_v4(sub { my ($number) = @_; return (($number % 2) == 0); }, @numbers);
print("even number found: ", $even_number_found, "\n");
# even number found: 12

$odd_number_found = array_find_v4(sub { my ($number) = @_; return (($number % 2) != 0); }, @numbers);
print("odd number found: ", $odd_number_found, "\n");
# odd number found: 27

print("# using JavaScript-like Array.find() function \"array_find_v5\"\n");

$even_number_found = array_find_v5(sub { my ($number) = @_; return (($number % 2) == 0); }, @numbers);
print("even number found: ", $even_number_found, "\n");
# even number found: 12

$odd_number_found = array_find_v5(sub { my ($number) = @_; return (($number % 2) != 0); }, @numbers);
print("odd number found: ", $odd_number_found, "\n");
# odd number found: 27

print("# using JavaScript-like Array.find() function \"array_find_v6\"\n");

$even_number_found = array_find_v6(sub { my ($number) = @_; return (($number % 2) == 0); }, @numbers);
print("even number found: ", $even_number_found, "\n");
# even number found: 12

$odd_number_found = array_find_v6(sub { my ($number) = @_; return (($number % 2) != 0); }, @numbers);
print("odd number found: ", $odd_number_found, "\n");
# odd number found: 27

print("# using JavaScript-like Array.find() function \"array_find_v7\"\n");

$even_number_found = array_find_v7(sub { my ($number) = @_; return (($number % 2) == 0); }, @numbers);
print("even number found: ", $even_number_found, "\n");
# even number found: 12

$odd_number_found = array_find_v7(sub { my ($number) = @_; return (($number % 2) != 0); }, @numbers);
print("odd number found: ", $odd_number_found, "\n");
# odd number found: 27

print("# using JavaScript-like Array.find() function \"array_find_v8\"\n");

$even_number_found = array_find_v8(sub { my ($number) = @_; return (($number % 2) == 0); }, @numbers);
print("even number found: ", $even_number_found, "\n");
# even number found: 12

$odd_number_found = array_find_v8(sub { my ($number) = @_; return (($number % 2) != 0); }, @numbers);
print("odd number found: ", $odd_number_found, "\n");
# odd number found: 27

print("# using JavaScript-like Array.find() function \"array_find_v9\"\n");

$even_number_found = array_find_v9(sub { my ($number) = @_; return (($number % 2) == 0); }, @numbers);
print("even number found: ", $even_number_found, "\n");
# even number found: 12

$odd_number_found = array_find_v9(sub { my ($number) = @_; return (($number % 2) != 0); }, @numbers);
print("odd number found: ", $odd_number_found, "\n");
# odd number found: 27

print("# using JavaScript-like Array.find() function \"array_find_v10\"\n");

$even_number_found = array_find_v10(sub { my ($number) = @_; return (($number % 2) == 0); }, @numbers);
print("even number found: ", $even_number_found, "\n");
# even number found: 12

$odd_number_found = array_find_v10(sub { my ($number) = @_; return (($number % 2) != 0); }, @numbers);
print("odd number found: ", $odd_number_found, "\n");
# odd number found: 27

print("\n# JavaScript-like Array.find() in Perl Array of Hashes\n");

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

my $product_found;

print("# using JavaScript-like Array.find() function \"array_find_v1\"\n");

$product_found = array_find_v1(sub { my ($product) = @_; return ($product->{"code"} eq "bubble_gum"); }, @products);
print("product found: ", defined($product_found) ? JSON->new->allow_nonref->pretty->encode(\%$product_found) : "undefined\n");
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

print("# using JavaScript-like Array.find() function \"array_find_v2\"\n");

$product_found = array_find_v2(sub { my ($product) = @_; return ($product->{"code"} eq "bubble_gum"); }, @products);
print("product found: ", defined($product_found) ? JSON->new->allow_nonref->pretty->encode(\%$product_found) : "undefined\n");
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

print("# using JavaScript-like Array.find() function \"array_find_v3\"\n");

$product_found = array_find_v3(sub { my ($product) = @_; return ($product->{"code"} eq "bubble_gum"); }, @products);
print("product found: ", defined($product_found) ? JSON->new->allow_nonref->pretty->encode(\%$product_found) : "undefined\n");
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

print("# using JavaScript-like Array.find() function \"array_find_v4\"\n");

$product_found = array_find_v4(sub { my ($product) = @_; return ($product->{"code"} eq "bubble_gum"); }, @products);
print("product found: ", defined($product_found) ? JSON->new->allow_nonref->pretty->encode(\%$product_found) : "undefined\n");
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

print("# using JavaScript-like Array.find() function \"array_find_v5\"\n");

$product_found = array_find_v5(sub { my ($product) = @_; return ($product->{"code"} eq "bubble_gum"); }, @products);
print("product found: ", defined($product_found) ? JSON->new->allow_nonref->pretty->encode(\%$product_found) : "undefined\n");
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

print("# using JavaScript-like Array.find() function \"array_find_v6\"\n");

$product_found = array_find_v6(sub { my ($product) = @_; return ($product->{"code"} eq "bubble_gum"); }, @products);
print("product found: ", defined($product_found) ? JSON->new->allow_nonref->pretty->encode(\%$product_found) : "undefined\n");
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

print("# using JavaScript-like Array.find() function \"array_find_v7\"\n");

$product_found = array_find_v7(sub { my ($product) = @_; return ($product->{"code"} eq "bubble_gum"); }, @products);
print("product found: ", defined($product_found) ? JSON->new->allow_nonref->pretty->encode(\%$product_found) : "undefined\n");
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

print("# using JavaScript-like Array.find() function \"array_find_v8\"\n");

$product_found = array_find_v8(sub { my ($product) = @_; return ($product->{"code"} eq "bubble_gum"); }, @products);
print("product found: ", defined($product_found) ? JSON->new->allow_nonref->pretty->encode(\%$product_found) : "undefined\n");
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

print("# using JavaScript-like Array.find() function \"array_find_v9\"\n");

$product_found = array_find_v9(sub { my ($product) = @_; return ($product->{"code"} eq "bubble_gum"); }, @products);
print("product found: ", defined($product_found) ? JSON->new->allow_nonref->pretty->encode(\%$product_found) : "undefined\n");
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

print("# using JavaScript-like Array.find() function \"array_find_v10\"\n");

$product_found = array_find_v10(sub { my ($product) = @_; return ($product->{"code"} eq "bubble_gum"); }, @products);
print("product found: ", defined($product_found) ? JSON->new->allow_nonref->pretty->encode(\%$product_found) : "undefined\n");
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }
