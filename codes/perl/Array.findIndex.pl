use strict;
use warnings;
use JSON;
use Scalar::Util qw(looks_like_number);

# There's no JavaScript-like Array.findIndex() in Perl.
# But, we can create our own function to mimic it in Perl.

sub pretty_array_of_primitives {
    my (@an_array_of_primitives) = @_;
    my $result = "[";
    for my $array_item_index (0..$#an_array_of_primitives) {
        my $array_item = $an_array_of_primitives[$array_item_index];
        my $isString = defined($array_item) && $array_item =~ /[0-9a-zA-Z`~!@#%&_=;':", \(\)\[\]\{\}\|\*\+\?\^\$\/\\\<\>\.\-]/;
        my $isNumber = looks_like_number($array_item);
        last if (!$isString && !$isNumber);
        $result = $result . "\"" . $array_item . "\"" if ($isString);
        $result = $result . $array_item if ($isNumber);
        $result = $result . ", " if ($array_item_index != $#an_array_of_primitives);
    }
    $result = $result . "]";
    return $result;
}

sub array_find_index_v1 {
    # JavaScript-like Array.findIndex() function
    my ($callback_function, @an_array) = @_;
    my $item_index = -1;
    for my $array_item_index (0..$#an_array) {
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
    my ($callback_function, @an_array) = @_;
    my $item_index = -1;
    for my $array_item_index (0..$#an_array) {
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
    my ($callback_function, @an_array) = @_;
    my $item_index = -1;
    for my $array_item_index (0..$#an_array) {
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
    my ($callback_function, @an_array) = @_;
    my $item_index = -1;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        my $is_condition_match = $callback_function->($array_item, $array_item_index, \@an_array);
        return $array_item_index if ($is_condition_match);
    }
    return $item_index;
}

sub array_find_index_v5 {
    # JavaScript-like Array.findIndex() function
    my ($callback_function, @an_array) = @_;
    my $item_index = -1;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        if ($callback_function->($array_item, $array_item_index, \@an_array)) {
            return $array_item_index;
        }
    }
    return $item_index;
}

sub array_find_index_v6 {
    # JavaScript-like Array.findIndex() function
    my ($callback_function, @an_array) = @_;
    my $item_index = -1;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        return $array_item_index if ($callback_function->($array_item, $array_item_index, \@an_array));
    }
    return $item_index;
}

sub array_find_index_v7 {
    # JavaScript-like Array.findIndex() function
    my ($callback_function, @an_array) = @_;
    for my $array_item_index (0..$#an_array) {
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
    my ($callback_function, @an_array) = @_;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        my $is_condition_match = $callback_function->($array_item, $array_item_index, \@an_array);
        return $array_item_index if ($is_condition_match);
    }
    return -1;
}

sub array_find_index_v9 {
    # JavaScript-like Array.findIndex() function
    my ($callback_function, @an_array) = @_;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        if ($callback_function->($array_item, $array_item_index, \@an_array)) {
            return $array_item_index;
        }
    }
    return -1;
}

sub array_find_index_v10 {
    # JavaScript-like Array.findIndex() function
    my ($callback_function, @an_array) = @_;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        return $array_item_index if ($callback_function->($array_item, $array_item_index, \@an_array));
    }
    return -1;
}

print("\n# JavaScript-like Array.findIndex() in Perl Array\n");

my @numbers = (12, 34, 27, 23, 65, 93, 36, 87, 4, 254);
print("numbers: ", pretty_array_of_primitives(@numbers), "\n");

my $my_lucky_number = 27;
print("my lucky number: ", $my_lucky_number, "\n");

my $my_lucky_number_index = -1;

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v1\"\n");

$my_lucky_number_index = array_find_index_v1(sub { my ($number) = @_; return $number % 2 == 0; }, @numbers);
print("my lucky number is at index: ", $my_lucky_number_index, "\n");
# my lucky number is at index: 2

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v2\"\n");

$my_lucky_number_index = array_find_index_v2(sub { my ($number) = @_; return $number % 2 == 0; }, @numbers);
print("my lucky number is at index: ", $my_lucky_number_index, "\n");
# my lucky number is at index: 2

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v3\"\n");

$my_lucky_number_index = array_find_index_v3(sub { my ($number) = @_; return $number % 2 == 0; }, @numbers);
print("my lucky number is at index: ", $my_lucky_number_index, "\n");
# my lucky number is at index: 2

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v4\"\n");

$my_lucky_number_index = array_find_index_v4(sub { my ($number) = @_; return $number % 2 == 0; }, @numbers);
print("my lucky number is at index: ", $my_lucky_number_index, "\n");
# my lucky number is at index: 2

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v5\"\n");

$my_lucky_number_index = array_find_index_v5(sub { my ($number) = @_; return $number % 2 == 0; }, @numbers);
print("my lucky number is at index: ", $my_lucky_number_index, "\n");
# my lucky number is at index: 2

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v6\"\n");

$my_lucky_number_index = array_find_index_v6(sub { my ($number) = @_; return $number % 2 == 0; }, @numbers);
print("my lucky number is at index: ", $my_lucky_number_index, "\n");
# my lucky number is at index: 2

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v7\"\n");

$my_lucky_number_index = array_find_index_v7(sub { my ($number) = @_; return $number % 2 == 0; }, @numbers);
print("my lucky number is at index: ", $my_lucky_number_index, "\n");
# my lucky number is at index: 2

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v8\"\n");

$my_lucky_number_index = array_find_index_v8(sub { my ($number) = @_; return $number % 2 == 0; }, @numbers);
print("my lucky number is at index: ", $my_lucky_number_index, "\n");
# my lucky number is at index: 2

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v9\"\n");

$my_lucky_number_index = array_find_index_v9(sub { my ($number) = @_; return $number % 2 == 0; }, @numbers);
print("my lucky number is at index: ", $my_lucky_number_index, "\n");
# my lucky number is at index: 2

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v10\"\n");

$my_lucky_number_index = array_find_index_v10(sub { my ($number) = @_; return $number % 2 == 0; }, @numbers);
print("my lucky number is at index: ", $my_lucky_number_index, "\n");
# my lucky number is at index: 2

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

my $product_to_buy = 'pasta';
print("product to buy: ", $product_to_buy, "\n");

my $product_to_buy_index = -1;

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v1\"\n");

$product_to_buy_index = array_find_index_v1(sub { my ($product) = @_; return $product->{'code'} eq $product_to_buy; }, @products);
print("product to buy is at index: ", $product_to_buy_index, "\n");
# product to buy is at index: 0

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v2\"\n");

$product_to_buy_index = array_find_index_v2(sub { my ($product) = @_; return $product->{'code'} eq $product_to_buy; }, @products);
print("product to buy is at index: ", $product_to_buy_index, "\n");
# product to buy is at index: 0

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v3\"\n");

$product_to_buy_index = array_find_index_v3(sub { my ($product) = @_; return $product->{'code'} eq $product_to_buy; }, @products);
print("product to buy is at index: ", $product_to_buy_index, "\n");
# product to buy is at index: 0

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v4\"\n");

$product_to_buy_index = array_find_index_v4(sub { my ($product) = @_; return $product->{'code'} eq $product_to_buy; }, @products);
print("product to buy is at index: ", $product_to_buy_index, "\n");
# product to buy is at index: 0

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v5\"\n");

$product_to_buy_index = array_find_index_v5(sub { my ($product) = @_; return $product->{'code'} eq $product_to_buy; }, @products);
print("product to buy is at index: ", $product_to_buy_index, "\n");
# product to buy is at index: 0

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v6\"\n");

$product_to_buy_index = array_find_index_v6(sub { my ($product) = @_; return $product->{'code'} eq $product_to_buy; }, @products);
print("product to buy is at index: ", $product_to_buy_index, "\n");
# product to buy is at index: 0

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v7\"\n");

$product_to_buy_index = array_find_index_v7(sub { my ($product) = @_; return $product->{'code'} eq $product_to_buy; }, @products);
print("product to buy is at index: ", $product_to_buy_index, "\n");
# product to buy is at index: 0

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v8\"\n");

$product_to_buy_index = array_find_index_v8(sub { my ($product) = @_; return $product->{'code'} eq $product_to_buy; }, @products);
print("product to buy is at index: ", $product_to_buy_index, "\n");
# product to buy is at index: 0

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v9\"\n");

$product_to_buy_index = array_find_index_v9(sub { my ($product) = @_; return $product->{'code'} eq $product_to_buy; }, @products);
print("product to buy is at index: ", $product_to_buy_index, "\n");
# product to buy is at index: 0

print("# using JavaScript-like Array.findIndex() function \"array_find_index_v10\"\n");

$product_to_buy_index = array_find_index_v10(sub { my ($product) = @_; return $product->{'code'} eq $product_to_buy; }, @products);
print("product to buy is at index: ", $product_to_buy_index, "\n");
# product to buy is at index: 0
