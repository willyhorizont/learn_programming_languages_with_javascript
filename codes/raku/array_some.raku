sub json-stringify($anything, Bool :$pretty = False, Str :$indent = " " x 4) {
    my $indent-level = 0;
    my $json-stringify-inner = sub ($anything-inner, $indent-inner) {
        return "null" if ($anything-inner === Nil);
        return "\"{$anything-inner}\"" if ($anything-inner ~~ Str);
        return "{$anything-inner}" if (($anything-inner ~~ Numeric) || ($anything-inner ~~ Bool));
        if ($anything-inner.^name eq "List" || $anything-inner.^name eq "Seq") {
            return "[]" if ($anything-inner.elems == 0);
            $indent-level += 1;
            my $result = (($pretty == True) ?? "[\n{$indent-inner x $indent-level}" !! "[");
            for ($anything-inner.kv) -> $array-item-index, $array-item {
                $result ~= $json-stringify-inner($array-item, $indent-inner);
                $result ~= (($pretty == True) ?? ",\n{$indent-inner x $indent-level}" !! ", ") if (($array-item-index + 1) !== $anything-inner.elems);
            }
            $indent-level -= 1;
            $result ~= (($pretty == True) ?? "\n{$indent-inner x $indent-level}]" !! "]");
            return $result;
        }
        if ($anything-inner.^name eq "Hash") {
            return "\{}" if ($anything-inner.elems == 0);
            $indent-level += 1;
            my $result = (($pretty == True) ?? "\{\n{$indent-inner x $indent-level}" !! "\{");
            for ($anything-inner.pairs.kv) -> $object-entry-index, $object-entry {
                my $object-key = $object-entry.key;
                my $object-value = $object-entry.value;
                $result ~= "\"{$object-key}\": " ~ $json-stringify-inner($object-value, $indent-inner);
                $result ~= (($pretty == True) ?? ",\n{$indent-inner x $indent-level}" !! ", ") if (($object-entry-index + 1) !== $anything-inner.elems);
            }
            $indent-level -= 1;
            $result ~= (($pretty == True) ?? "\n{$indent-inner x $indent-level}}" !! "}");
            return $result;
        }
        return "null";
    };
    return $json-stringify-inner($anything, $indent);
}

# There's no JavaScript-like Array.some() in Raku.
# But, we can create our own function to mimic it in Raku.

sub array-some-v1($callback-function, $an-array) {
    # JavaScript-like Array.some() function
    my $is-condition-match = False;
    for ($an-array.kv) -> $array-item-index, $array-item {
        $is-condition-match = $callback-function($array-item, $array-item-index, $an-array);
        last if ($is-condition-match);
    }
    return $is-condition-match;
}

sub array-some-v2($callback-function, $an-array) {
    # JavaScript-like Array.some() function
    my $is-condition-match = False;
    for ($an-array.kv) -> $array-item-index, $array-item {
        $is-condition-match = $callback-function($array-item, $array-item-index, $an-array);
        return $is-condition-match if ($is-condition-match);
    }
    return $is-condition-match;
}

sub array-some-v3($callback-function, $an-array) {
    # JavaScript-like Array.some() function
    for ($an-array.kv) -> $array-item-index, $array-item {
        my $is-condition-match = $callback-function($array-item, $array-item-index, $an-array);
        return True if ($is-condition-match);
    }
    return False;
}

sub array-some-v4($callback-function, $an-array) {
    # JavaScript-like Array.some() function
    for ($an-array.kv) -> $array-item-index, $array-item {
        return True if ($callback-function($array-item, $array-item-index, $an-array));
    }
    return False;
}

print("\n# JavaScript-like Array.some() in Raku List", "\n");

my $numbers = (12, 34, 27, 23, 65, 93, 36, 87, 4, 254);
print("numbers: ", json-stringify($numbers), "\n");

my $is-any-number-less-than500;
my $is-any-number-more-than500;

print("# using JavaScript-like Array.some() function \"array-some-v1\"\n");

$is-any-number-less-than500 = array-some-v1(sub ($number, |args) { ($number < 500) }, $numbers);
print("is any number < 500: ", json-stringify($is-any-number-less-than500), "\n");
# is any number < 500: true

$is-any-number-more-than500 = array-some-v1(sub ($number, |args) { ($number > 500) }, $numbers);
print("is any number > 500: ", json-stringify($is-any-number-more-than500), "\n");
# is any number > 500: false

print("# using JavaScript-like Array.some() function \"array-some-v2\"\n");

$is-any-number-less-than500 = array-some-v2(sub ($number, |args) { ($number < 500) }, $numbers);
print("is any number < 500: ", json-stringify($is-any-number-less-than500), "\n");
# is any number < 500: true

$is-any-number-more-than500 = array-some-v2(sub ($number, |args) { ($number > 500) }, $numbers);
print("is any number > 500: ", json-stringify($is-any-number-more-than500), "\n");
# is any number > 500: false

print("# using JavaScript-like Array.some() function \"array-some-v3\"\n");

$is-any-number-less-than500 = array-some-v3(sub ($number, |args) { ($number < 500) }, $numbers);
print("is any number < 500: ", json-stringify($is-any-number-less-than500), "\n");
# is any number < 500: true

$is-any-number-more-than500 = array-some-v3(sub ($number, |args) { ($number > 500) }, $numbers);
print("is any number > 500: ", json-stringify($is-any-number-more-than500), "\n");
# is any number > 500: false

print("# using JavaScript-like Array.some() function \"array-some-v4\"\n");

$is-any-number-less-than500 = array-some-v4(sub ($number, |args) { ($number < 500) }, $numbers);
print("is any number < 500: ", json-stringify($is-any-number-less-than500), "\n");
# is any number < 500: true

$is-any-number-more-than500 = array-some-v4(sub ($number, |args) { ($number > 500) }, $numbers);
print("is any number > 500: ", json-stringify($is-any-number-more-than500), "\n");
# is any number > 500: false

print("\n# JavaScript-like Array.some() in Raku List of Hashes", "\n");

my $products = (
    %(
        "code" => "pasta",
        "price" => 321
    ),
    %(
        "code" => "bubble-gum",
        "price" => 233
    ),
    %(
        "code" => "potato-chips",
        "price" => 5
    ),
    %(
        "code" => "towel",
        "price" => 499
    )
);

print("products: ", json-stringify($products, :pretty(True)), "\n");

my $is-any-product-price-less-than500;
my $is-any-product-price-more-than500;

print("# using JavaScript-like Array.some() function \"array-some-v1\"\n");

$is-any-product-price-less-than500 = array-some-v1(sub ($product, |args) { ($product{"price"} < 500) }, $products);
print("is any product price < 500: ", json-stringify($is-any-product-price-less-than500), "\n");
# is any product price < 500: true

$is-any-product-price-more-than500 = array-some-v1(sub ($product, |args) { ($product{"price"} > 500) }, $products);
print("is any product price > 500: ", json-stringify($is-any-product-price-more-than500), "\n");
# is any product price > 500: false

print("# using JavaScript-like Array.some() function \"array-some-v2\"\n");

$is-any-product-price-less-than500 = array-some-v2(sub ($product, |args) { ($product{"price"} < 500) }, $products);
print("is any product price < 500: ", json-stringify($is-any-product-price-less-than500), "\n");
# is any product price < 500: true

$is-any-product-price-more-than500 = array-some-v2(sub ($product, |args) { ($product{"price"} > 500) }, $products);
print("is any product price > 500: ", json-stringify($is-any-product-price-more-than500), "\n");
# is any product price > 500: false

print("# using JavaScript-like Array.some() function \"array-some-v3\"\n");

$is-any-product-price-less-than500 = array-some-v3(sub ($product, |args) { ($product{"price"} < 500) }, $products);
print("is any product price < 500: ", json-stringify($is-any-product-price-less-than500), "\n");
# is any product price < 500: true

$is-any-product-price-more-than500 = array-some-v3(sub ($product, |args) { ($product{"price"} > 500) }, $products);
print("is any product price > 500: ", json-stringify($is-any-product-price-more-than500), "\n");
# is any product price > 500: false

print("# using JavaScript-like Array.some() function \"array-some-v4\"\n");

$is-any-product-price-less-than500 = array-some-v4(sub ($product, |args) { ($product{"price"} < 500) }, $products);
print("is any product price < 500: ", json-stringify($is-any-product-price-less-than500), "\n");
# is any product price < 500: true

$is-any-product-price-more-than500 = array-some-v4(sub ($product, |args) { ($product{"price"} > 500) }, $products);
print("is any product price > 500: ", json-stringify($is-any-product-price-more-than500), "\n");
# is any product price > 500: false
