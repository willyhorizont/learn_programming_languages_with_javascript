use strict;
use warnings;
use JSON;
use List::Util qw(reduce);
use Scalar::Util qw(looks_like_number);

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

sub spread_syntax_object {
    my %new_object;
    for my $parameter (@_) {
        if (ref $parameter eq "HASH") {
            my %an_object = %$parameter;
            while (my ($object_key, $object_value) = each %an_object) {
                $new_object{$object_key} = $object_value;
            }
            next;
        }
        if (ref $parameter eq "ARRAY") {
            my @an_array = @$parameter;
            for my $array_item_index (0..$#an_array) {
                my $array_item = $an_array[$array_item_index];
                $new_object{$array_item_index} = $array_item;
            }
            next;
        }
    }
    return %new_object;
}

sub spread_syntax_array {
    my @new_array;
    for my $parameter (@_) {
        if (ref $parameter eq "HASH") {
            my %an_object = %$parameter;
            push(@new_array, \%an_object);
            next;
        }
        if (ref $parameter eq "ARRAY") {
            my @an_array = @$parameter;
            for my $array_item_index (0..$#an_array) {
                my $array_item = $an_array[$array_item_index];
                push(@new_array, $array_item);
            }
            next;
        }
        push(@new_array, $parameter);
    }
    return @new_array;
}

sub array_reduce {
    # JavaScript-like Array.reduce() function
    my ($callback_function, $an_array_ref, $initial_value) = @_;
    my @an_array = @$an_array_ref;
    my $result;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        $result = $callback_function->((($array_item_index == 0) ? $initial_value : $result), $array_item, $array_item_index, \@an_array);
    }
    return $result;
}

print("\n# JavaScript-like Array.reduce() in Perl Array\n");

my @numbers = (12, 34, 27, 23, 65, 93, 36, 87, 4, 254);
print("numbers: ", pretty_array_of_primitives(@numbers), "\n");

print("# using JavaScript-like Array.reduce() function \"array_reduce\"\n");

my $numbers_total = array_reduce(sub { my ($current_result, $current_number) = @_; return ($current_result + $current_number); }, \@numbers, 0);
print("total number $numbers_total\n");
# total number: 635

print("\n# JavaScript-like Array.reduce() in Perl Array of Hashes\n");

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

print("# using JavaScript-like Array.reduce() function \"array_reduce\"\n");

my %products_grouped;

%products_grouped = array_reduce(sub {
    my ($current_result, $current_product) = @_;
    if ($current_product->{"price"} > 100) {
        my @current_label_value = spread_syntax_array($current_result->{"expensive"}, $current_product);
        my %current_label = spread_syntax_object($current_result, { "expensive" => \@current_label_value });
        return \%current_label;
    }
    my @current_label_value = spread_syntax_array($current_result->{"cheap"}, $current_product);
    my %current_label = spread_syntax_object($current_result, { "cheap" => \@current_label_value });
    return \%current_label;
}, \@products, { "expensive" => [], "cheap" => [] });
print("grouped products: ", JSON->new->allow_nonref->pretty->encode(\%products_grouped));
# grouped products: {
#     "expensive": [
#         {
#             "code": "bubble_gum",
#             "price": 233
#         },
#         {
#             "code": "towel",
#             "price": 499
#         }
#     ],
#     "cheap": [
#         {
#             "code": "pasta",
#             "price": 30
#         },
#         {
#             "code": "potato_chips",
#             "price": 5
#         }
#     ]
# }

%products_grouped = array_reduce(sub {
    my ($current_result, $current_product) = @_;
    if ($current_product->{"price"} > 100) {
        my %current_label = spread_syntax_object($current_result, { "expensive" => [spread_syntax_array($current_result->{"expensive"}, $current_product)] });
        return \%current_label;
    }
    my %current_label = spread_syntax_object($current_result, { "cheap" => [spread_syntax_array($current_result->{"cheap"}, $current_product)] });
    return \%current_label
}, \@products, { "expensive" => [], "cheap" => [] });
print("grouped products: ", JSON->new->allow_nonref->pretty->encode(\%products_grouped));
# grouped products: {
#     "expensive": [
#         {
#             "code": "bubble_gum",
#             "price": 233
#         },
#         {
#             "code": "towel",
#             "price": 499
#         }
#     ],
#     "cheap": [
#         {
#             "code": "pasta",
#             "price": 30
#         },
#         {
#             "code": "potato_chips",
#             "price": 5
#         }
#     ]
# }

%products_grouped = array_reduce(sub {
    my ($current_result, $current_product) = @_;
    if ($current_product->{"price"} > 100) {
        return { spread_syntax_object($current_result, { "expensive" => [spread_syntax_array($current_result->{"expensive"}, $current_product)] }) };
    }
    return { spread_syntax_object($current_result, { "cheap" => [spread_syntax_array($current_result->{"cheap"}, $current_product)] }) };
}, \@products, { "expensive" => [], "cheap" => [] });
print("grouped products: ", JSON->new->allow_nonref->pretty->encode(\%products_grouped));
# grouped products: {
#     "expensive": [
#         {
#             "code": "bubble_gum",
#             "price": 233
#         },
#         {
#             "code": "towel",
#             "price": 499
#         }
#     ],
#     "cheap": [
#         {
#             "code": "pasta",
#             "price": 30
#         },
#         {
#             "code": "potato_chips",
#             "price": 5
#         }
#     ]
# }

%products_grouped = array_reduce(sub {
    my ($current_result, $current_product) = @_;
    return (($current_product->{"price"} > 100) ? { spread_syntax_object($current_result, { "cheap" => [spread_syntax_array($current_result->{"cheap"}, $current_product)] }) } : { spread_syntax_object($current_result, { "expensive" => [spread_syntax_array($current_result->{"expensive"}, $current_product)] }) });
}, \@products, { "expensive" => [], "cheap" => [] });
print("grouped products: ", JSON->new->allow_nonref->pretty->encode(\%products_grouped));
# grouped products: {
#     "expensive": [
#         {
#             "code": "bubble_gum",
#             "price": 233
#         },
#         {
#             "code": "towel",
#             "price": 499
#         }
#     ],
#     "cheap": [
#         {
#             "code": "pasta",
#             "price": 30
#         },
#         {
#             "code": "potato_chips",
#             "price": 5
#         }
#     ]
# }
