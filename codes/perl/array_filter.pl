use strict;
use warnings;

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

sub array_filter_v1 {
    # JavaScript-like Array.filter() function
    my ($callback_function_ref, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    my @data_filtered = ();
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        my $is_condition_match = $callback_function_ref->($array_item, $array_item_index, $an_array_ref);
        if ($is_condition_match) {
            $data_filtered[scalar(@data_filtered)] = $array_item;
        }
    }
    return @data_filtered;
}

sub array_filter_v2 {
    # JavaScript-like Array.filter() function
    my ($callback_function_ref, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    my @data_filtered = ();
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        if ($callback_function_ref->($array_item, $array_item_index, $an_array_ref)) {
            $data_filtered[scalar(@data_filtered)] = $array_item;
        }
    }
    return @data_filtered;
}

print("\n# JavaScript-like Array.filter() in Perl List", "\n");

my @numbers = (12, 34, 27, 23, 65, 93, 36, 87, 4, 254);
print("numbers: ", json_stringify(\@numbers), "\n");

my @numbers_even;
my @numbers_odd;

print("# using JavaScript-like Array.filter() function \"array_filter_v1\"\n");

@numbers_even = array_filter_v1(sub { my ($number) = @_; return (($number % 2) == 0); }, \@numbers);
print("even numbers only: ", json_stringify(\@numbers_even), "\n");
# even numbers only: [12, 34, 36, 4, 254]

@numbers_odd = array_filter_v1(sub { my ($number) = @_; return (($number % 2) != 0); }, \@numbers);
print("odd numbers only: ", json_stringify(\@numbers_odd), "\n");
# odd numbers only: [27, 23, 65, 93, 87]

print("# using JavaScript-like Array.filter() function \"array_filter_v2\"\n");

@numbers_even = array_filter_v2(sub { my ($number) = @_; return (($number % 2) == 0); }, \@numbers);
print("even numbers only: ", json_stringify(\@numbers_even), "\n");
# even numbers only: [12, 34, 36, 4, 254]

@numbers_odd = array_filter_v2(sub { my ($number) = @_; return (($number % 2) != 0); }, \@numbers);
print("odd numbers only: ", json_stringify(\@numbers_odd), "\n");
# odd numbers only: [27, 23, 65, 93, 87]

print("# using Perl Array.filter() built-in function \"grep\"\n");

@numbers_even = grep { (($_ % 2) == 0) } @numbers;
print("even numbers only: ", json_stringify(\@numbers_even), "\n");
# even numbers only: [12, 34, 36, 4, 254]

@numbers_odd = grep { (($_ % 2) != 0) } @numbers;
print("odd numbers only: ", json_stringify(\@numbers_odd), "\n");
# odd numbers only: [27, 23, 65, 93, 87]

print("\n# JavaScript-like Array.filter() in Perl List of Hashes", "\n");

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

my @products_below_100;
my @products_above_100;

print("# using JavaScript-like Array.filter() function \"array_filter_v1\"\n");

@products_below_100 = array_filter_v1(sub { my ($product) = @_; return ($product->{"price"} <= 100); }, \@products);
print("products with price <= 100 only: ", json_stringify(\@products_below_100, "pretty" => 1), "\n");
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

@products_above_100 = array_filter_v1(sub { my ($product) = @_; return ($product->{"price"} > 100); }, \@products);
print("products with price > 100 only: ", json_stringify(\@products_above_100, "pretty" => 1), "\n");
# products with price > 100 only: [
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

@products_below_100 = array_filter_v2(sub { my ($product) = @_; return ($product->{"price"} <= 100); }, \@products);
print("products with price <= 100 only: ", json_stringify(\@products_below_100, "pretty" => 1), "\n");
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

@products_above_100 = array_filter_v2(sub { my ($product) = @_; return ($product->{"price"} > 100); }, \@products);
print("products with price > 100 only: ", json_stringify(\@products_above_100, "pretty" => 1), "\n");
# products with price > 100 only: [
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

print("# using Perl Array.filter() built-in function \"grep\"\n");

@products_below_100 = grep { ($_->{"price"} <= 100) } @products;
print("products with price <= 100 only: ", json_stringify(\@products_below_100, "pretty" => 1), "\n");
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

@products_above_100 = grep { ($_->{"price"} > 100) } @products;
print("products with price > 100 only: ", json_stringify(\@products_above_100, "pretty" => 1), "\n");
# products with price > 100 only: [
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
