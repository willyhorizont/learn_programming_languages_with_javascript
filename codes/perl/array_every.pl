use strict;
use warnings;
use List::Util qw(all);
use Scalar::Util qw(looks_like_number);

sub json_stringify {
    my ($anything_ref, %optionalar_gument) = @_;
    my $pretty = $optionalar_gument{"pretty"} // 0;
    my $indent = $optionalar_gument{"indent"} // "    ";
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

sub is_false {
    my ($anything) = @_;
    return (($anything == 0) || ($anything eq "0") || !defined($anything) || ($anything eq "") || (ref($anything) eq "ARRAY" && scalar(@{$anything}) == 0));
}

sub bool_to_string {
    my ($anything) = @_;
    return (is_false($anything) ? "false" : "true");
}

sub array_every_v1 {
    # JavaScript-like Array.every() function
    my ($callback_function_ref, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    my $is_condition_match = 0;
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        $is_condition_match = $callback_function_ref->($array_item, $array_item_index, $an_array_ref);
        last if (!$is_condition_match);
    }
    return $is_condition_match;
}

sub array_every_v2 {
    # JavaScript-like Array.every() function
    my ($callback_function_ref, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    my $is_condition_match = 0;
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        $is_condition_match = $callback_function_ref->($array_item, $array_item_index, $an_array_ref);
        last unless ($is_condition_match);
    }
    return $is_condition_match;
}

sub array_every_v3 {
    # JavaScript-like Array.every() function
    my ($callback_function_ref, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    my $is_condition_match = 0;
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        $is_condition_match = $callback_function_ref->($array_item, $array_item_index, $an_array_ref);
        return $is_condition_match if (!$is_condition_match);
    }
    return $is_condition_match;
}

sub array_every_v4 {
    # JavaScript-like Array.every() function
    my ($callback_function_ref, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    my $is_condition_match = 0;
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        $is_condition_match = $callback_function_ref->($array_item, $array_item_index, $an_array_ref);
        return $is_condition_match unless ($is_condition_match);
    }
    return $is_condition_match;
}

sub array_every_v5 {
    # JavaScript-like Array.every() function
    my ($callback_function_ref, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        my $is_condition_match = $callback_function_ref->($array_item, $array_item_index, $an_array_ref);
        return 0 if (!$is_condition_match);
    }
    return 1;
}

sub array_every_v6 {
    # JavaScript-like Array.every() function
    my ($callback_function_ref, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        my $is_condition_match = $callback_function_ref->($array_item, $array_item_index, $an_array_ref);
        return 0 unless ($is_condition_match);
    }
    return 1;
}

sub array_every_v7 {
    # JavaScript-like Array.every() function
    my ($callback_function_ref, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        return 0 if (!$callback_function_ref->($array_item, $array_item_index, $an_array_ref));
    }
    return 1;
}

sub array_every_v8 {
    # JavaScript-like Array.every() function
    my ($callback_function_ref, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        return 0 unless ($callback_function_ref->($array_item, $array_item_index, $an_array_ref));
    }
    return 1;
}

print("\n# JavaScript-like Array.every() in Perl List", "\n");

my @numbers = (12, 34, 27, 23, 65, 93, 36, 87, 4, 254);
print("numbers: ", json_stringify(\@numbers), "\n");

my $is_all_number_less_than_500;
my $is_all_number_more_than_500;

print("# using JavaScript-like Array.every() function \"array_every_v1\"\n");

$is_all_number_less_than_500 = array_every_v1(sub { my ($number) = @_; ($number < 500) }, \@numbers);
print("is all number < 500: ", bool_to_string($is_all_number_less_than_500), "\n");
# is all number < 500: true

$is_all_number_more_than_500 = array_every_v1(sub { my ($number) = @_; ($number > 500) }, \@numbers);
print("is all number > 500: ", bool_to_string($is_all_number_more_than_500), "\n");
# is all number > 500: false

print("# using JavaScript-like Array.every() function \"array_every_v2\"\n");

$is_all_number_less_than_500 = array_every_v2(sub { my ($number) = @_; ($number < 500) }, \@numbers);
print("is all number < 500: ", bool_to_string($is_all_number_less_than_500), "\n");
# is all number < 500: true

$is_all_number_more_than_500 = array_every_v2(sub { my ($number) = @_; ($number > 500) }, \@numbers);
print("is all number > 500: ", bool_to_string($is_all_number_more_than_500), "\n");
# is all number > 500: false

print("# using JavaScript-like Array.every() function \"array_every_v3\"\n");

$is_all_number_less_than_500 = array_every_v3(sub { my ($number) = @_; ($number < 500) }, \@numbers);
print("is all number < 500: ", bool_to_string($is_all_number_less_than_500), "\n");
# is all number < 500: true

$is_all_number_more_than_500 = array_every_v3(sub { my ($number) = @_; ($number > 500) }, \@numbers);
print("is all number > 500: ", bool_to_string($is_all_number_more_than_500), "\n");
# is all number > 500: false

print("# using JavaScript-like Array.every() function \"array_every_v4\"\n");

$is_all_number_less_than_500 = array_every_v4(sub { my ($number) = @_; ($number < 500) }, \@numbers);
print("is all number < 500: ", bool_to_string($is_all_number_less_than_500), "\n");
# is all number < 500: true

$is_all_number_more_than_500 = array_every_v4(sub { my ($number) = @_; ($number > 500) }, \@numbers);
print("is all number > 500: ", bool_to_string($is_all_number_more_than_500), "\n");
# is all number > 500: false

print("# using JavaScript-like Array.every() function \"array_every_v5\"\n");

$is_all_number_less_than_500 = array_every_v5(sub { my ($number) = @_; ($number < 500) }, \@numbers);
print("is all number < 500: ", bool_to_string($is_all_number_less_than_500), "\n");
# is all number < 500: true

$is_all_number_more_than_500 = array_every_v5(sub { my ($number) = @_; ($number > 500) }, \@numbers);
print("is all number > 500: ", bool_to_string($is_all_number_more_than_500), "\n");
# is all number > 500: false

print("# using JavaScript-like Array.every() function \"array_every_v6\"\n");

$is_all_number_less_than_500 = array_every_v6(sub { my ($number) = @_; ($number < 500) }, \@numbers);
print("is all number < 500: ", bool_to_string($is_all_number_less_than_500), "\n");
# is all number < 500: true

$is_all_number_more_than_500 = array_every_v6(sub { my ($number) = @_; ($number > 500) }, \@numbers);
print("is all number > 500: ", bool_to_string($is_all_number_more_than_500), "\n");
# is all number > 500: false

print("# using JavaScript-like Array.every() function \"array_every_v7\"\n");

$is_all_number_less_than_500 = array_every_v7(sub { my ($number) = @_; ($number < 500) }, \@numbers);
print("is all number < 500: ", bool_to_string($is_all_number_less_than_500), "\n");
# is all number < 500: true

$is_all_number_more_than_500 = array_every_v7(sub { my ($number) = @_; ($number > 500) }, \@numbers);
print("is all number > 500: ", bool_to_string($is_all_number_more_than_500), "\n");
# is all number > 500: false

print("# using JavaScript-like Array.every() function \"array_every_v8\"\n");

$is_all_number_less_than_500 = array_every_v8(sub { my ($number) = @_; ($number < 500) }, \@numbers);
print("is all number < 500: ", bool_to_string($is_all_number_less_than_500), "\n");
# is all number < 500: true

$is_all_number_more_than_500 = array_every_v8(sub { my ($number) = @_; ($number > 500) }, \@numbers);
print("is all number > 500: ", bool_to_string($is_all_number_more_than_500), "\n");
# is all number > 500: false

print("# using Perl Array.every() built-in function \"List::Util\" \"all\"\n");

$is_all_number_less_than_500 = all { my $number = $_; ($number < 500) } @numbers;
print("is all number < 500: ", bool_to_string($is_all_number_less_than_500), "\n");
# is all number < 500: true

$is_all_number_more_than_500 = all { my $number = $_; ($number > 500) } @numbers;
print("is all number > 500: ", bool_to_string($is_all_number_more_than_500), "\n");
# is all number > 500: false

print("\n# JavaScript-like Array.every() in Perl List of Hashes", "\n");

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

my $is_all_product_price_less_than_500;
my $is_all_product_price_more_than_500;

print("# using JavaScript-like Array.every() function \"array_every_v1\"\n");

$is_all_product_price_less_than_500 = array_every_v1(sub { my ($product) = @_; ($product->{"price"} < 500) }, \@products);
print("is all product price < 500: ", bool_to_string($is_all_product_price_less_than_500), "\n");
# is all product price < 500: true

$is_all_product_price_more_than_500 = array_every_v1(sub { my ($product) = @_; ($product->{"price"} > 500) }, \@products);
print("is all product price > 500: ", bool_to_string($is_all_product_price_more_than_500), "\n");
# is all product price > 500: false

print("# using JavaScript-like Array.every() function \"array_every_v2\"\n");

$is_all_product_price_less_than_500 = array_every_v2(sub { my ($product) = @_; ($product->{"price"} < 500) }, \@products);
print("is all product price < 500: ", bool_to_string($is_all_product_price_less_than_500), "\n");
# is all product price < 500: true

$is_all_product_price_more_than_500 = array_every_v2(sub { my ($product) = @_; ($product->{"price"} > 500) }, \@products);
print("is all product price > 500: ", bool_to_string($is_all_product_price_more_than_500), "\n");
# is all product price > 500: false

print("# using JavaScript-like Array.every() function \"array_every_v3\"\n");

$is_all_product_price_less_than_500 = array_every_v3(sub { my ($product) = @_; ($product->{"price"} < 500) }, \@products);
print("is all product price < 500: ", bool_to_string($is_all_product_price_less_than_500), "\n");
# is all product price < 500: true

$is_all_product_price_more_than_500 = array_every_v3(sub { my ($product) = @_; ($product->{"price"} > 500) }, \@products);
print("is all product price > 500: ", bool_to_string($is_all_product_price_more_than_500), "\n");
# is all product price > 500: false

print("# using JavaScript-like Array.every() function \"array_every_v4\"\n");

$is_all_product_price_less_than_500 = array_every_v4(sub { my ($product) = @_; ($product->{"price"} < 500) }, \@products);
print("is all product price < 500: ", bool_to_string($is_all_product_price_less_than_500), "\n");
# is all product price < 500: true

$is_all_product_price_more_than_500 = array_every_v4(sub { my ($product) = @_; ($product->{"price"} > 500) }, \@products);
print("is all product price > 500: ", bool_to_string($is_all_product_price_more_than_500), "\n");
# is all product price > 500: false

print("# using JavaScript-like Array.every() function \"array_every_v5\"\n");

$is_all_product_price_less_than_500 = array_every_v5(sub { my ($product) = @_; ($product->{"price"} < 500) }, \@products);
print("is all product price < 500: ", bool_to_string($is_all_product_price_less_than_500), "\n");
# is all product price < 500: true

$is_all_product_price_more_than_500 = array_every_v5(sub { my ($product) = @_; ($product->{"price"} > 500) }, \@products);
print("is all product price > 500: ", bool_to_string($is_all_product_price_more_than_500), "\n");
# is all product price > 500: false

print("# using JavaScript-like Array.every() function \"array_every_v6\"\n");

$is_all_product_price_less_than_500 = array_every_v6(sub { my ($product) = @_; ($product->{"price"} < 500) }, \@products);
print("is all product price < 500: ", bool_to_string($is_all_product_price_less_than_500), "\n");
# is all product price < 500: true

$is_all_product_price_more_than_500 = array_every_v6(sub { my ($product) = @_; ($product->{"price"} > 500) }, \@products);
print("is all product price > 500: ", bool_to_string($is_all_product_price_more_than_500), "\n");
# is all product price > 500: false

print("# using JavaScript-like Array.every() function \"array_every_v7\"\n");

$is_all_product_price_less_than_500 = array_every_v7(sub { my ($product) = @_; ($product->{"price"} < 500) }, \@products);
print("is all product price < 500: ", bool_to_string($is_all_product_price_less_than_500), "\n");
# is all product price < 500: true

$is_all_product_price_more_than_500 = array_every_v7(sub { my ($product) = @_; ($product->{"price"} > 500) }, \@products);
print("is all product price > 500: ", bool_to_string($is_all_product_price_more_than_500), "\n");
# is all product price > 500: false

print("# using JavaScript-like Array.every() function \"array_every_v8\"\n");

$is_all_product_price_less_than_500 = array_every_v8(sub { my ($product) = @_; ($product->{"price"} < 500) }, \@products);
print("is all product price < 500: ", bool_to_string($is_all_product_price_less_than_500), "\n");
# is all product price < 500: true

$is_all_product_price_more_than_500 = array_every_v8(sub { my ($product) = @_; ($product->{"price"} > 500) }, \@products);
print("is all product price > 500: ", bool_to_string($is_all_product_price_more_than_500), "\n");
# is all product price > 500: false

print("# using Perl Array.every() built-in function \"List::Util\" \"all\"\n");

$is_all_product_price_less_than_500 = all { my $product = $_; ($product->{"price"} < 500) } @products;
print("is all product price < 500: ", bool_to_string($is_all_product_price_less_than_500), "\n");
# is all product price < 500: true

$is_all_product_price_more_than_500 = all { my $product = $_; ($product->{"price"} > 500) } @products;
print("is all product price > 500: ", bool_to_string($is_all_product_price_more_than_500), "\n");
# is all product price > 500: false
