# use strict;
# use warnings;
# use JSON;
# use List::Util qw(all);

sub array-every-v1 ($callback-function, *@an-array) {
    # JavaScript-like Array.every() function
    my $is-condition-match = False;
    for ^@an-array.elems -> $array-item-index {
        my $array-item = @an-array[$array-item-index];
        $is-condition-match = $callback-function($array-item, $array-item-index, @an-array);
        if (!$is-condition-match) {
            last;
        }
    }
    return $is-condition-match;
};

sub array-every-v2 ($callback-function, *@an-array) {
    # JavaScript-like Array.every() function
    my $is-condition-match = False;
    for ^@an-array.elems -> $array-item-index {
        my $array-item = @an-array[$array-item-index];
        $is-condition-match = $callback-function($array-item, $array-item-index, @an-array);
        last if (!$is-condition-match);
    }
    return $is-condition-match;
};

sub array-every-v3 ($callback-function, *@an-array) {
    # JavaScript-like Array.every() function
    my $is-condition-match = False;
    for ^@an-array.elems -> $array-item-index {
        my $array-item = @an-array[$array-item-index];
        $is-condition-match = $callback-function($array-item, $array-item-index, @an-array);
        last unless ($is-condition-match);
    }
    return $is-condition-match;
};

sub array-every-v4 ($callback-function, *@an-array) {
    # JavaScript-like Array.every() function
    my $is-condition-match = False;
    for ^@an-array.elems -> $array-item-index {
        my $array-item = @an-array[$array-item-index];
        $is-condition-match = $callback-function($array-item, $array-item-index, @an-array);
        if (!$is-condition-match) {
            return $is-condition-match;
        }
    }
    return $is-condition-match;
};

sub array-every-v5 ($callback-function, *@an-array) {
    # JavaScript-like Array.every() function
    my $is-condition-match = False;
    for ^@an-array.elems -> $array-item-index {
        my $array-item = @an-array[$array-item-index];
        $is-condition-match = $callback-function($array-item, $array-item-index, @an-array);
        return $is-condition-match if (!$is-condition-match);
    }
    return $is-condition-match;
};

sub array-every-v6 ($callback-function, *@an-array) {
    # JavaScript-like Array.every() function
    my $is-condition-match = False;
    for ^@an-array.elems -> $array-item-index {
        my $array-item = @an-array[$array-item-index];
        $is-condition-match = $callback-function($array-item, $array-item-index, @an-array);
        return $is-condition-match unless ($is-condition-match);
    }
    return $is-condition-match;
};

sub array-every-v7 ($callback-function, *@an-array) {
    # JavaScript-like Array.every() function
    for ^@an-array.elems -> $array-item-index {
        my $array-item = @an-array[$array-item-index];
        my $is-condition-match = $callback-function($array-item, $array-item-index, @an-array);
        if (!$is-condition-match) {
            return 0;
        }
    }
    return 1;
};

sub array-every-v8 ($callback-function, *@an-array) {
    # JavaScript-like Array.every() function
    for ^@an-array.elems -> $array-item-index {
        my $array-item = @an-array[$array-item-index];
        my $is-condition-match = $callback-function($array-item, $array-item-index, @an-array);
        return 0 if (!$is-condition-match);
    }
    return 1;
};

sub array-every-v9 ($callback-function, *@an-array) {
    # JavaScript-like Array.every() function
    for ^@an-array.elems -> $array-item-index {
        my $array-item = @an-array[$array-item-index];
        my $is-condition-match = $callback-function($array-item, $array-item-index, @an-array);
        return 0 unless ($is-condition-match);
    }
    return 1;
};

sub array-every-v10 ($callback-function, *@an-array) {
    # JavaScript-like Array.every() function
    for ^@an-array.elems -> $array-item-index {
        my $array-item = @an-array[$array-item-index];
        if (!$callback-function($array-item, $array-item-index, @an-array)) {
            return 0;
        }
    }
    return 1;
};

sub array-every-v11 ($callback-function, *@an-array) {
    # JavaScript-like Array.every() function
    for ^@an-array.elems -> $array-item-index {
        my $array-item = @an-array[$array-item-index];
        return 0 if (!$callback-function($array-item, $array-item-index, @an-array));
    }
    return 1;
};

sub array-every-v12 ($callback-function, *@an-array) {
    # JavaScript-like Array.every() function
    for ^@an-array.elems -> $array-item-index {
        my $array-item = @an-array[$array-item-index];
        return 0 unless ($callback-function($array-item, $array-item-index, @an-array));
    }
    return 1;
};

put("\n# JavaScript-like Array.every() in Perl Array\n");

my @numbers = (12, 34, 27, 23, 65, 93, 36, 87, 4, 254);
put("numbers: ", "[", join(", ", @numbers), "]", "\n");

my $is-all-number-less-than500;
my $is-all-number-more-than500;

put("# using JavaScript-like Array.every() function \"array-every-v1\"\n");

$is-all-number-less-than500 = array-every-v1(sub ($number, *@_) { return $number < 500; }, @numbers) ?? 'true' !! 'false';
put("is all number < 500: $is-all-number-less-than500\n");
# is all number < 500: true

$is-all-number-more-than500 = array-every-v1(sub ($number, *@_) { return $number > 500; }, @numbers) ?? 'true' !! 'false';
put("is all number > 500: $is-all-number-more-than500\n");
# is all number > 500: false

put("# using JavaScript-like Array.every() function \"array-every-v2\"\n");

$is-all-number-less-than500 = array-every-v2(sub ($number, *@_) { return $number < 500; }, @numbers) ?? 'true' !! 'false';
put("is all number < 500: $is-all-number-less-than500\n");
# is all number < 500: true

$is-all-number-more-than500 = array-every-v2(sub ($number, *@_) { return $number > 500; }, @numbers) ?? 'true' !! 'false';
put("is all number > 500: $is-all-number-more-than500\n");
# is all number > 500: false

put("# using JavaScript-like Array.every() function \"array-every-v3\"\n");

$is-all-number-less-than500 = array-every-v3(sub ($number, *@_) { return $number < 500; }, @numbers) ?? 'true' !! 'false';
put("is all number < 500: $is-all-number-less-than500\n");
# is all number < 500: true

$is-all-number-more-than500 = array-every-v3(sub ($number, *@_) { return $number > 500; }, @numbers) ?? 'true' !! 'false';
put("is all number > 500: $is-all-number-more-than500\n");
# is all number > 500: false

put("# using JavaScript-like Array.every() function \"array-every-v4\"\n");

$is-all-number-less-than500 = array-every-v4(sub ($number, *@_) { return $number < 500; }, @numbers) ?? 'true' !! 'false';
put("is all number < 500: $is-all-number-less-than500\n");
# is all number < 500: true

$is-all-number-more-than500 = array-every-v4(sub ($number, *@_) { return $number > 500; }, @numbers) ?? 'true' !! 'false';
put("is all number > 500: $is-all-number-more-than500\n");
# is all number > 500: false

# put("# using Perl Array.every() built-in function List::Util all\n");

$is-all-number-less-than500 = all(@numbers) < 500 ?? 'true' !! 'false';
put("is all number < 500: $is-all-number-less-than500\n");
# is all number < 500: true

$is-all-number-more-than500 = all(@numbers) > 500 ?? 'true' !! 'false';
put("is all number > 500: $is-all-number-more-than500\n");
# is all number > 500: false

put("\n# JavaScript-like Array.every() in Perl Array of Hashes\n");

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

# put("products: ", JSON->new->allow_nonref->pretty->encode(\@products));
put("products: ", @products);

my $is-all-product-price-less-than500;
my $is-all-product-price-more-than500;

put("# using JavaScript-like Array.every() function \"array-every-v1\"\n");

$is-all-product-price-less-than500 = array-every-v1(sub ($product, *@_) { return $product<price> < 500; }, @products) ?? 'true' !! 'false';
put("is all product price < 500: $is-all-product-price-less-than500\n");
# is all product price < 500: true

$is-all-product-price-more-than500 = array-every-v1(sub ($product, *@_) { return $product<price> > 500; }, @products) ?? 'true' !! 'false';
put("is all product price > 500: $is-all-product-price-more-than500\n");
# is all product price > 500: false

put("# using JavaScript-like Array.every() function \"array-every-v2\"\n");

$is-all-product-price-less-than500 = array-every-v2(sub ($product, *@_) { return $product<price> < 500; }, @products) ?? 'true' !! 'false';
put("is all product price < 500: $is-all-product-price-less-than500\n");
# is all product price < 500: true

$is-all-product-price-more-than500 = array-every-v2(sub ($product, *@_) { return $product<price> > 500; }, @products) ?? 'true' !! 'false';
put("is all product price > 500: $is-all-product-price-more-than500\n");
# is all product price > 500: false

put("# using JavaScript-like Array.every() function \"array-every-v3\"\n");

$is-all-product-price-less-than500 = array-every-v3(sub ($product, *@_) { return $product<price> < 500; }, @products) ?? 'true' !! 'false';
put("is all product price < 500: $is-all-product-price-less-than500\n");
# is all product price < 500: true

$is-all-product-price-more-than500 = array-every-v3(sub ($product, *@_) { return $product<price> > 500; }, @products) ?? 'true' !! 'false';
put("is all product price > 500: $is-all-product-price-more-than500\n");
# is all product price > 500: false

put("# using JavaScript-like Array.every() function \"array-every-v4\"\n");

$is-all-product-price-less-than500 = array-every-v4(sub ($product, *@_) { return $product<price> < 500; }, @products) ?? 'true' !! 'false';
put("is all product price < 500: $is-all-product-price-less-than500\n");
# is all product price < 500: true

$is-all-product-price-more-than500 = array-every-v4(sub ($product, *@_) { return $product<price> > 500; }, @products) ?? 'true' !! 'false';
put("is all product price > 500: $is-all-product-price-more-than500\n");
# is all product price > 500: false

put("# using Perl Array.every() built-in function \"List::Util\" \"all\"\n");

$is-all-number-less-than500 = all(@products)<price> < 500 ?? 'true' !! 'false';
put("is all number < 500: $is-all-number-less-than500\n");
# is all number < 500: true

$is-all-number-more-than500 = all(@products)<price> > 500 ?? 'true' !! 'false';
put("is all number > 500: $is-all-number-more-than500\n");
# is all number > 500: false
