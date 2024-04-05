use strict;
use warnings;

# There's no JavaScript-like Array.findIndex() in Perl.
# But, we can create our own function to mimic it in Perl.

sub json_stringify {
    use JSON;
    my ($anything_ref, %additional_parameter) = @_;
    my $pretty = $additional_parameter{"pretty"} // 0;
    my $indent = $additional_parameter{"indent"} // "    ";
    return JSON->new->allow_nonref->space_after->encode($anything_ref) if ($pretty == 0);
    my $json_string_pretty = JSON->new->allow_nonref->pretty->encode($anything_ref);
    $json_string_pretty =~ s/   /$indent/g;
    $json_string_pretty =~ s/\n$//g;
    return $json_string_pretty;
}

sub array_find_index_v1 {
    # JavaScript-like Array.findIndex() function
    my ($callback_function_ref, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    my $data_found_index = -1;
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        my $is_condition_match = $callback_function_ref->($array_item, $array_item_index, $an_array_ref);
        if ($is_condition_match) {
            $data_found_index = $array_item_index;
            last;
        }
    }
    return $data_found_index;
}

sub array_find_index_v2 {
    # JavaScript-like Array.findIndex() function
    my ($callback_function_ref, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    my $data_found_index = -1;
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        if ($callback_function_ref->($array_item, $array_item_index, $an_array_ref)) {
            $data_found_index = $array_item_index;
            last;
        }
    }
    return $data_found_index;
}

sub array_find_index_v3 {
    # JavaScript-like Array.findIndex() function
    my ($callback_function_ref, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        my $is_condition_match = $callback_function_ref->($array_item, $array_item_index, $an_array_ref);
        return $array_item_index if ($is_condition_match);
    }
    return -1;
}

sub array_find_index_v4 {
    # JavaScript-like Array.findIndex() function
    my ($callback_function_ref, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        return $array_item_index if ($callback_function_ref->($array_item, $array_item_index, $an_array_ref));
    }
    return -1;
}

print("\n# JavaScript-like Array.findIndex() in Perl List", "\n");

my @numbers = (12, 34, 27, 23, 65, 93, 36, 87, 4, 254);
print("numbers: ", json_stringify(\@numbers), "\n");

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

print("\n# JavaScript-like Array.findIndex() in Perl List of Hashes", "\n");

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
print("products: ", json_stringify(\@products, "pretty" => 1), "\n");

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
