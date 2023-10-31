use strict;
use warnings;
use JSON;
use Scalar::Util qw(looks_like_number);

# There's no JavaScript-like Array.reduce() in Perl.
# But, we can create our own function to mimic it in Perl.

sub pretty_array_of_primitives { "[", join(", ", @_), "]", "\n" }

sub spread_syntax_object {
    my %new_object;
    for my $arg_ref (@_) {
        if (ref $arg_ref eq 'HASH') {
            my %arg_item_object = %$arg_ref;
            while (my ($object_key, $object_value) = each %arg_item_object) {
                $new_object{$object_key} = $object_value;
            }
        }
        if (ref $arg_ref eq 'ARRAY') {
            my @arg_item_array = @$arg_ref;
            for my $arg_item_array_index (0..$#arg_item_array) {
                my $array_item_array_item = $arg_item_array[$arg_item_array_index];
                $new_object{$arg_item_array_index} = $array_item_array_item;
            }
        }
    }
    return %new_object;
};

sub array_reduce {
    # JavaScript-like Array.reduce() function
    my ($callback_function, $an_array_ref, $initial_value) = @_;
    my @an_array = @$an_array_ref;
    my $result;
    for my $array_item_index (0..$#an_array) {
        my $array_item = $an_array[$array_item_index];
        $result = !$result ? $initial_value : $result;

        if (ref $initial_value eq 'ARRAY' || ref $initial_value eq 'HASH') {
            $result = !$result ? () : $result;
            $result = $callback_function->($result, $array_item, $array_item_index, \@an_array);
            next;
        }
        # if (ref $initial_value eq 'ARRAY') {
        #     $result = !$result ? () : $result;
        #     $result = $callback_function->($result, $array_item, $array_item_index, \@an_array);
        #     next;
        # }
        # if (ref $initial_value eq 'HASH') {
        #     $result = !$result ? {} : $result;
        #     $result = $callback_function->($result, $array_item, $array_item_index, \@an_array);
        #     next;
        # }
        if (looks_like_number($initial_value) && ($initial_value == 0 || $initial_value == 1)) {
            $result = !$result ? 0 : $result;
            $result = $callback_function->($result, $array_item, $array_item_index, \@an_array);
            next;
        }
        if (looks_like_number($initial_value)) {
            $result = !$result ? 0 : $result;
            $result = $callback_function->($result, $array_item, $array_item_index, \@an_array);
            next;
        }
        if (defined($initial_value) && $initial_value =~ /[0-9a-zA-Z`~!@#%&_=;':", \(\)\[\]\{\}\|\*\+\?\^\$\/\\\<\>\.\-]/) {
            $result = !$result ? "" : $result;
            $result = $callback_function->($result, $array_item, $array_item_index, \@an_array);
            next;
        }
        if (!$initial_value) {
            $result = !$result ? undef : $result;
            $result = $callback_function->($result, $array_item, $array_item_index, \@an_array);
            next;
        }
    }
    return $result;
};

print("\n# JavaScript-like Array.reduce() in Perl Array\n");

my @numbers = (12, 34, 27, 23, 65, 93, 36, 87, 4, 254);
print("numbers: ", pretty_array_of_primitives(@numbers), "\n");


print("# using JavaScript-like Array.reduce() function \"array_reduce\"\n");

my $numbers_total = array_reduce(sub { my ($current_result, $current_number) = @_; return $current_result + $current_number; }, \@numbers, 0);
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

my @products_grouped = array_reduce(sub { my ($current_result, $current_product) = @_; return $current_product->{"price"} > 100 ? { spread_syntax_object($current_result, { "expensive" => { spread_syntax_object($current_result->{"expensive"}, $current_product) } }) } : { spread_syntax_object($current_result, { "cheap" => { spread_syntax_object($current_result->{"cheap"}, $current_product) } }) }; }, \@products, { "expensive" => (), "cheap" => (), });
print("labeled products: ", JSON->new->allow_nonref->pretty->encode(\@products_grouped));
