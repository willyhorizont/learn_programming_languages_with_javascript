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

sub array_map_v1 {
    # JavaScript-like Array.map() function
    my ($callback_function_ref, $an_array_ref) = @_;
    my @new_array = ();
    my @an_array = @{$an_array_ref};
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        my $new_array_item = $callback_function_ref->($array_item, $array_item_index, $an_array_ref);
        @new_array = (@new_array, $new_array_item);
    }
    return @new_array;
}

sub array_map_v2 {
    # JavaScript-like Array.map() function
    my ($callback_function_ref, $an_array_ref) = @_;
    my @new_array = ();
    my @an_array = @{$an_array_ref};
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        @new_array = (@new_array, $callback_function_ref->($array_item, $array_item_index, $an_array_ref));
    }
    return @new_array;
}

print("\n# JavaScript-like Array.map() in Perl List", "\n");

my @numbers = (12, 34, 27, 23, 65, 93, 36, 87, 4, 254);
print("numbers: ", json_stringify(\@numbers), "\n");

my @numbers_labeled;

print("# using JavaScript-like Array.map() function \"array_map_v1\"\n");

@numbers_labeled = array_map_v1(sub { my ($number) = @_; return {"$number" => ((($number % 2) == 0) ? "even" : "odd")} }, \@numbers);
print("labeled numbers: ", json_stringify(\@numbers_labeled, "pretty" => 1), "\n");
# labeled numbers: [
#     {
#         "12": "even"
#     },
#     {
#         "34": "even"
#     },
#     {
#         "27": "odd"
#     },
#     {
#         "23": "odd"
#     },
#     {
#         "65": "odd"
#     },
#     {
#         "93": "odd"
#     },
#     {
#         "36": "even"
#     },
#     {
#         "87": "odd"
#     },
#     {
#         "4": "even"
#     },
#     {
#         "254": "even"
#     }
# ]

print("# using JavaScript-like Array.map() function \"array_map_v2\"\n");

@numbers_labeled = array_map_v2(sub { my ($number) = @_; return {"$number" => ((($number % 2) == 0) ? "even" : "odd")} }, \@numbers);
print("labeled numbers: ", json_stringify(\@numbers_labeled, "pretty" => 1), "\n");
# labeled numbers: [
#     {
#         "12": "even"
#     },
#     {
#         "34": "even"
#     },
#     {
#         "27": "odd"
#     },
#     {
#         "23": "odd"
#     },
#     {
#         "65": "odd"
#     },
#     {
#         "93": "odd"
#     },
#     {
#         "36": "even"
#     },
#     {
#         "87": "odd"
#     },
#     {
#         "4": "even"
#     },
#     {
#         "254": "even"
#     }
# ]

print("# using Perl Array.map() built-in function \"map\"\n");

@numbers_labeled = map { my $number = $_; {"$number" => ((($number % 2) == 0) ? "even" : "odd")} } @numbers;
print("labeled numbers: ", json_stringify(\@numbers_labeled, "pretty" => 1), "\n");
# labeled numbers: [
#     {
#         "12": "even"
#     },
#     {
#         "34": "even"
#     },
#     {
#         "27": "odd"
#     },
#     {
#         "23": "odd"
#     },
#     {
#         "65": "odd"
#     },
#     {
#         "93": "odd"
#     },
#     {
#         "36": "even"
#     },
#     {
#         "87": "odd"
#     },
#     {
#         "4": "even"
#     },
#     {
#         "254": "even"
#     }
# ]

print("\n# JavaScript-like Array.map() in Perl List of Hashes", "\n");

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

my @products_labeled;

print("# using JavaScript-like Array.map() function \"array_map_v1\"\n");

@products_labeled = array_map_v1(sub {
    my ($product) = @_;
    my %new_product = (%{$product}, ("label" => (($product->{"price"} > 100) ? "expensive" : "cheap")));
    return \%new_product;
}, \@products);
print("labeled products: ", json_stringify(\@products_labeled, "pretty" => 1), "\n");
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato_chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]

@products_labeled = array_map_v1(sub {
    my ($product) = @_;
    return {(%{$product}, ("label" => (($product->{"price"} > 100) ? "expensive" : "cheap")))};
}, \@products);
print("labeled products: ", json_stringify(\@products_labeled, "pretty" => 1), "\n");
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato_chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]

@products_labeled = array_map_v1(sub { my ($product) = @_; +{(%{$product}, ("label" => (($product->{"price"} > 100) ? "expensive" : "cheap")))} }, \@products);
print("labeled products: ", json_stringify(\@products_labeled, "pretty" => 1), "\n");
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato_chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]

print("# using JavaScript-like Array.map() function \"array_map_v2\"\n");

@products_labeled = array_map_v2(sub {
    my ($product) = @_;
    my %new_product = (%{$product}, ("label" => (($product->{"price"} > 100) ? "expensive" : "cheap")));
    return \%new_product;
}, \@products);
print("labeled products: ", json_stringify(\@products_labeled, "pretty" => 1), "\n");
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato_chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]

@products_labeled = array_map_v2(sub {
    my ($product) = @_;
    return {(%{$product}, ("label" => (($product->{"price"} > 100) ? "expensive" : "cheap")))};
}, \@products);
print("labeled products: ", json_stringify(\@products_labeled, "pretty" => 1), "\n");
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato_chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]

@products_labeled = array_map_v2(sub { my ($product) = @_; +{(%{$product}, ("label" => (($product->{"price"} > 100) ? "expensive" : "cheap")))} }, \@products);
print("labeled products: ", json_stringify(\@products_labeled, "pretty" => 1), "\n");
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato_chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]

print("# using Perl Array.map() built-in function \"map\"\n");

@products_labeled = map { my $product = $_; +{(%{$product}, ("label" => (($product->{"price"} > 100) ? "expensive" : "cheap")))} } @products;
print("labeled products: ", json_stringify(\@products_labeled, "pretty" => 1), "\n");
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato_chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]
