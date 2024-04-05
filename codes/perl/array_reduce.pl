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

sub array_reduce {
    # JavaScript-like Array.reduce() function
    my ($callback_function_ref, $an_array_ref, $initial_value) = @_;
    my @an_array = @{$an_array_ref};
    my $result = $initial_value;
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        $result = $callback_function_ref->($result, $array_item, $array_item_index, $an_array_ref);
    }
    return %{$result} if (ref($result) eq "HASH");
    return @{$result} if (ref($result) eq "ARRAY");
    return $result;
}

print("\n# JavaScript-like Array.reduce() in Perl List", "\n");

my @numbers = (36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3);
print("numbers: ", json_stringify(\@numbers), "\n");

print("# using JavaScript-like Array.reduce() function \"array_reduce\"\n");

my $numbers_total = array_reduce(sub { my ($current_result, $current_number) = @_; ($current_result + $current_number); }, \@numbers, 0);
print("total number: $numbers_total", "\n");
# total number: 41.2

print("\n# JavaScript-like Array.reduce() in Perl List of Hashes", "\n");

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

print("# using JavaScript-like Array.reduce() function \"array_reduce\"\n");

my %products_grouped;

%products_grouped = array_reduce(sub {
    my ($current_result_ref, $current_product_ref) = @_;
    if ($current_product_ref->{"price"} > 100) {
        my @current_result_new_expensive_value = (@{$current_result_ref->{"expensive"}}, $current_product_ref);
        my %current_result_new = (%{$current_result_ref}, ("expensive" => \@current_result_new_expensive_value));
        return \%current_result_new;
    }
    my @current_result_new_cheap_value = (@{$current_result_ref->{"cheap"}}, $current_product_ref);
    my %current_result_new = (%{$current_result_ref}, ("cheap" => \@current_result_new_cheap_value));
    return \%current_result_new;
}, \@products, {"expensive" => [], "cheap" => []});
print("grouped products: ", json_stringify(\%products_grouped, "pretty" => 1), "\n");
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

%products_grouped = array_reduce(sub {
    my ($current_result_ref, $current_product_ref) = @_;
    return {(%{$current_result_ref}, ("expensive" => [(@{$current_result_ref->{"expensive"}}, $current_product_ref)]))} if ($current_product_ref->{"price"} > 100);
    return {(%{$current_result_ref}, ("cheap" => [(@{$current_result_ref->{"cheap"}}, $current_product_ref)]))};
}, \@products, {"expensive" => [], "cheap" => []});
print("grouped products: ", json_stringify(\%products_grouped, "pretty" => 1), "\n");
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

%products_grouped = array_reduce(sub { my ($current_result_ref, $current_product_ref) = @_; (($current_product_ref->{"price"} > 100) ? {(%{$current_result_ref}, ("expensive" => [(@{$current_result_ref->{"expensive"}}, $current_product_ref)]))} : {(%{$current_result_ref}, ("cheap" => [(@{$current_result_ref->{"cheap"}}, $current_product_ref)]))}) }, \@products, {"expensive" => [], "cheap" => []});
print("grouped products: ", json_stringify(\%products_grouped, "pretty" => 1), "\n");
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
