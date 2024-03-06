use strict;
use warnings;
use Scalar::Util qw(looks_like_number);

sub pretty_json_stringify {
    my ($anything) = @_;
    use JSON;
    my $pretty_json_string = JSON->new->allow_nonref->pretty->encode($anything);
    $pretty_json_string =~ s/   /    /g;
    return $pretty_json_string;
}

sub pretty_array_of_primitives {
    my $number_of_parameters = @_;
    my $result = "[";
    for (my $array_item_index = 0; $array_item_index < $number_of_parameters; $array_item_index += 1) {
        my $array_item = $_[$array_item_index];
        my $is_string = (defined($array_item) && ref($array_item) eq "");
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
        $new_array[scalar(@new_array)] = $parameter;
    }
    return @new_array;
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
    my @an_array = @{$an_array_ref};
    my $result = $initial_value;
    for (my $array_item_index = 0; $array_item_index < scalar(@an_array); $array_item_index += 1) {
        my $array_item = $an_array[$array_item_index];
        $result = $callback_function->($result, $array_item, $array_item_index, \@an_array);
    }
    return %{$result} if (ref($result) eq "HASH");
    return @{$result} if (ref($result) eq "ARRAY");
    return ${$result} if (ref($result) eq "SCALAR");
    return $result;
}

print("\n# JavaScript-like Array.reduce() in Perl Array\n");

my @numbers = (36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3);
print("numbers: " . pretty_array_of_primitives(@numbers) . "\n");

print("# using JavaScript-like Array.reduce() function \"array_reduce\"\n");

my $numbers_total = array_reduce(sub { my ($current_result, $current_number) = @_; return ($current_result + $current_number); }, \@numbers, 0);
print("total number $numbers_total\n");
# total number: 41.2

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
print("products: " . pretty_json_stringify(\@products));

print("# using JavaScript-like Array.reduce() function \"array_reduce\"\n");

my %products_grouped;

%products_grouped = array_reduce(sub {
    my ($current_result, $current_product) = @_;
    if ($current_product->{"price"} > 100) {
        my @current_result_new_expensive_value = spread_syntax_array(@{$current_result->{"expensive"}}, $current_product);
        my %current_result_new = spread_syntax_object_v1(%{$current_result}, ("expensive" => \@current_result_new_expensive_value));
        return \%current_result_new;
    }
    my @current_result_new_cheap_value = spread_syntax_array(@{$current_result->{"cheap"}}, $current_product);
    my %current_result_new = spread_syntax_object_v1(%{$current_result}, ("cheap" => \@current_result_new_cheap_value));
    return \%current_result_new;
}, \@products, { "expensive" => [], "cheap" => [] });
print("grouped products: " . pretty_json_stringify(\%products_grouped));
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

%products_grouped = array_reduce(sub { my ($current_result, $current_product) = @_; return (($current_product->{"price"} > 100) ? {spread_syntax_object_v1(%{$current_result}, ("expensive" => [spread_syntax_array(@{$current_result->{"expensive"}}, $current_product)]))} : {spread_syntax_object_v1(%{$current_result}, ("cheap" => [spread_syntax_array(@{$current_result->{"cheap"}}, $current_product)]))}); }, \@products, { "expensive" => [], "cheap" => [] });
print("grouped products: " . pretty_json_stringify(\%products_grouped));
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
