use strict;
use warnings;
use Scalar::Util qw(looks_like_number);

sub pretty_json_stringify {
    my ($anything) = @_;
    use JSON;
    my $pretty_json_string = JSON->new->allow_nonref->pretty->encode($anything);
    $pretty_json_string =~ s/   /    /g;
    $pretty_json_string =~ s/\n$//g;
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

sub spread_syntax_object {
    my %new_object;
    for my $parameter_ref (@_) {
        if (ref($parameter_ref) eq "HASH") {
            my %parameter = %{$parameter_ref};
            while (my ($object_key, $object_value) = each(%parameter)) {
                $new_object{$object_key} = $object_value;
            }
            next;
        }
        if (ref($parameter_ref) eq "ARRAY") {
            my @parameter = @{$parameter_ref};
            for (my $array_item_index = 0; $array_item_index < scalar(@parameter); $array_item_index += 1) {
                my $array_item = $parameter[$array_item_index];
                $new_object{$array_item_index} = $array_item;
            }
            next;
        }
    }
    return %new_object;
}

sub spread_syntax_array {
    my @new_array;
    for my $parameter_ref (@_) {
        if (ref($parameter_ref) eq "HASH") {
            my %parameter = %{$parameter_ref};
            if (keys(%parameter) == 1) {
                while (my ($object_key, $object_value) = each(%parameter)) {
                    push(@new_array, $object_value);
                }
                next;
            }
            push(@new_array, \%parameter);
            next;
        }
        if (ref($parameter_ref) eq "ARRAY") {
            my @parameter = @{$parameter_ref};
            for (my $array_item_index = 0; $array_item_index < scalar(@parameter); $array_item_index += 1) {
                my $array_item = $parameter[$array_item_index];
                push(@new_array, $array_item);
            }
            next;
        }
    }
    return @new_array;
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

print("\n# JavaScript-like Array.reduce() in Perl Array\n");

my @numbers = (36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3);
print("numbers: " . pretty_array_of_primitives(@numbers) . "\n");

print("# using JavaScript-like Array.reduce() function \"array_reduce\"\n");

my $numbers_total = array_reduce(sub { my ($current_result, $current_number) = @_; return ($current_result + $current_number); }, \@numbers, 0);
print("total number: $numbers_total\n");
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
print("products: " . pretty_json_stringify(\@products) . "\n");

print("# using JavaScript-like Array.reduce() function \"array_reduce\"\n");

my %products_grouped;

%products_grouped = array_reduce(sub {
    my ($current_result_ref, $current_product_ref) = @_;
    if ($current_product_ref->{"price"} > 100) {
        my @current_result_new_expensive_value = spread_syntax_array($current_result_ref->{"expensive"}, $current_product_ref);
        my %current_result_new = spread_syntax_object($current_result_ref, { "expensive" => \@current_result_new_expensive_value });
        return \%current_result_new;
    }
    my @current_result_new_cheap_value = spread_syntax_array($current_result_ref->{"cheap"}, $current_product_ref);
    my %current_result_new = spread_syntax_object($current_result_ref, { "cheap" => \@current_result_new_cheap_value });
    return \%current_result_new;
}, \@products, { "expensive" => [], "cheap" => [] });
print("grouped products: " . pretty_json_stringify(\%products_grouped) . "\n");
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
    return {spread_syntax_object($current_result_ref, { "expensive" => [spread_syntax_array($current_result_ref->{"expensive"}, $current_product_ref)] })} if ($current_product_ref->{"price"} > 100);
    return {spread_syntax_object($current_result_ref, { "cheap" => [spread_syntax_array($current_result_ref->{"cheap"}, $current_product_ref)] })};
}, \@products, { "expensive" => [], "cheap" => [] });
print("grouped products: " . pretty_json_stringify(\%products_grouped) . "\n");
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

%products_grouped = array_reduce(sub { my ($current_result_ref, $current_product_ref) = @_; (($current_product_ref->{"price"} > 100) ? {spread_syntax_object($current_result_ref, { "expensive" => [spread_syntax_array($current_result_ref->{"expensive"}, $current_product_ref)] })} : {spread_syntax_object($current_result_ref, { "cheap" => [spread_syntax_array($current_result_ref->{"cheap"}, $current_product_ref)] })}) }, \@products, { "expensive" => [], "cheap" => [] });
print("grouped products: " . pretty_json_stringify(\%products_grouped) . "\n");
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
