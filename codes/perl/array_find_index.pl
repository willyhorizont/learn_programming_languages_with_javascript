use strict;
use warnings;
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

# There's no JavaScript-like Array.findIndex() in Perl.
# But, we can create our own function to mimic it in Perl.

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
