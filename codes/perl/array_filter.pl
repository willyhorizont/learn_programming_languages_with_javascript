use strict;
use warnings;
use Scalar::Util qw(looks_like_number);

sub json_stringify {
    my ($anything_ref, %additional_parameter) = @_;
    my $pretty = $additional_parameter{"pretty"} // 0;
    my $indent = $additional_parameter{"indent"} // "    ";
    my $indent_level = 0;
    my $json_stringify_inner;
    $json_stringify_inner = sub {
        my ($anything_inner_ref, $indent_inner) = @_;
        return "null" if (!defined($anything_inner_ref));
        return "$anything_inner_ref" if looks_like_number($anything_inner_ref);
        return "\"" . $anything_inner_ref . "\"" if (ref($anything_inner_ref) eq "");
        if (ref($anything_inner_ref) eq "ARRAY") {
            return "[]" if (scalar(@{$anything_inner_ref}) == 0);
            $indent_level += 1;
            my $result = (!$pretty ? "[" : ("[\n" . ($indent_inner x $indent_level)));
            for my $array_item_index (0..(scalar(@{$anything_inner_ref}) - 1)) {
                my $array_item = $anything_inner_ref->[$array_item_index];
                $result .= $json_stringify_inner->($array_item, $indent_inner);
                $result .= (!$pretty ? ", " : (",\n" . ($indent_inner x $indent_level))) if (($array_item_index + 1) != scalar(@{$anything_inner_ref}));
            }
            $indent_level -= 1;
            $result .= (!$pretty ? "]" : ("\n" . ($indent_inner x $indent_level) . "]"));
            return $result;
        }
        if (ref($anything_inner_ref) eq "HASH") {
            return "{}" if (scalar(keys(%{$anything_inner_ref})) == 0);
            $indent_level += 1;
            my $result = (!$pretty ? "{" : ("{\n" . ($indent_inner x $indent_level)));
            my $object_entry_index = 0;
            foreach my $object_key (keys(%{$anything_inner_ref})) {
                my $object_value = $anything_inner_ref->{$object_key};
                $result .= "\"" . $object_key . "\": " . $json_stringify_inner->($object_value, $indent_inner);
                $result .= (!$pretty ? ", " : (",\n" . ($indent_inner x $indent_level))) if (($object_entry_index + 1) != scalar(keys(%{$anything_inner_ref})));
                $object_entry_index += 1;
            }
            $indent_level -= 1;
            $result .= (!$pretty ? "}" : ("\n" . ($indent_inner x $indent_level) . "}"));
            return $result;
        }
        return "null";
    };
    return $json_stringify_inner->($anything_ref, $indent);
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
            @data_filtered = (@data_filtered, $array_item);
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
            @data_filtered = (@data_filtered, $array_item);
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
