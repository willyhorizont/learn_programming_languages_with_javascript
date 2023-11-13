use strict;
use warnings;
use JSON;
use Scalar::Util qw(looks_like_number);

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

sub spread_syntax_array {
    my @new_array;
    for my $parameter (@_) {
        if (ref $parameter eq "ARRAY") {
            my @an_array = @$parameter;
            my $array_length = scalar(@an_array);
            next if ($array_length == 0);
            push(@new_array, $parameter);
            next;
        }
        push(@new_array, $parameter);
    }
    return @new_array;
}

sub array_to_object {
    my %new_object;
    my (@an_array) = @_;
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        $new_object{$array_item_index} = $array_item;
    }
    return %new_object;
}

sub spread_syntax_object_v1 {
    my %new_object;
    my $number_of_parameters = @_;
    for (my $i = 0; $i < $number_of_parameters; $i += 2) {
        my $object_key = $_[$i];
        my $object_value = $_[$i + 1];
        $new_object{$object_key} = $object_value;
    }
    return %new_object;
}

sub array_reduce {
    # JavaScript-like Array.reduce() function
    my ($callback_function, $an_array_ref, $initial_value) = @_;
    my $result;
    my @an_array = @$an_array_ref;
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        $result = $callback_function->((($array_item_index == 0) ? $initial_value : $result), $array_item, $array_item_index, \@an_array);
    }
    return %$result if (ref $result eq "HASH");
    return @$result if (ref $result eq "ARRAY");
    return $$result if (ref $result eq "SCALAR");
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
        my @current_result_new_expensive_value = spread_syntax_array(@{$current_result->{"expensive"}}, $current_product);
        my %current_result_new = spread_syntax_object_v1(%$current_result, ("expensive" => \@current_result_new_expensive_value));
        return \%current_result_new;
    }
    my @current_result_new_cheap_value = spread_syntax_array(@{$current_result->{"cheap"}}, $current_product);
    my %current_result_new = spread_syntax_object_v1(%$current_result, ("cheap" => \@current_result_new_cheap_value));
    return \%current_result_new;
}, \@products, { "expensive" => [], "cheap" => [] });
print("grouped products: ", JSON->new->allow_nonref->pretty->encode(\%products_grouped));
# grouped products: {
#     "expensive": [
#         {
#             "code": "pasta",
#             "price": 321
#         },
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
#             "code": "potato_chips",
#             "price": 5
#         }
#     ]
# }

%products_grouped = array_reduce(sub { my ($current_result, $current_product) = @_; return (($current_product->{"price"} > 100) ? {spread_syntax_object_v1(%$current_result, ("expensive" => [spread_syntax_array(@{$current_result->{"expensive"}}, $current_product)]))} : {spread_syntax_object_v1(%$current_result, ("cheap" => [spread_syntax_array(@{$current_result->{"cheap"}}, $current_product)]))}); }, \@products, { "expensive" => [], "cheap" => [] });
print("grouped products: ", JSON->new->allow_nonref->pretty->encode(\%products_grouped));
# grouped products: {
#     "expensive": [
#         {
#             "code": "pasta",
#             "price": 321
#         },
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
#             "code": "potato_chips",
#             "price": 5
#         }
#     ]
# }
