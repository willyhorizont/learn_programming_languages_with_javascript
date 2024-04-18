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

sub array-find-v1($callback-function, $an-array) {
    # JavaScript-like Array.find() function
    my $data-found;
    for ($an-array.kv) -> $array-item-index, $array-item {
        my $is-condition-match = $callback-function($array-item, $array-item-index, $an-array);
        if ($is-condition-match) {
            $data-found = $array-item;
            last;
        }
    }
    return $data-found;
}

sub array-find-v2($callback-function, $an-array) {
    # JavaScript-like Array.find() function
    my $data-found;
    for ($an-array.kv) -> $array-item-index, $array-item {
        if ($callback-function($array-item, $array-item-index, $an-array)) {
            $data-found = $array-item;
            last;
        }
    }
    return $data-found;
}

sub array-find-v3($callback-function, $an-array) {
    # JavaScript-like Array.find() function
    for ($an-array.kv) -> $array-item-index, $array-item {
        my $is-condition-match = $callback-function($array-item, $array-item-index, $an-array);
        return $array-item if ($is-condition-match);
    }
    return Nil;
}

sub array-find-v4($callback-function, $an-array) {
    # JavaScript-like Array.find() function
    for ($an-array.kv) -> $array-item-index, $array-item {
        return $array-item if ($callback-function($array-item, $array-item-index, $an-array));
    }
    return Nil;
}

print("\n# JavaScript-like Array.find() in Raku List", "\n");

my $numbers = (12, 34, 27, 23, 65, 93, 36, 87, 4, 254);
print("numbers: ", json-stringify($numbers), "\n");

my $even-number-found;
my $odd-number-found;

print("# using JavaScript-like Array.find() function \"array-find-v1\"\n");

$even-number-found = array-find-v1(sub ($number, |args) { (($number % 2) === 0) }, $numbers);
print("even number found: ", $even-number-found, "\n");
# even number found: 12

$odd-number-found = array-find-v1(sub ($number, |args) { (($number % 2) !== 0) }, $numbers);
print("odd number found: ", $odd-number-found, "\n");
# odd number found: 27

print("# using JavaScript-like Array.find() function \"array-find-v2\"\n");

$even-number-found = array-find-v2(sub ($number, |args) { (($number % 2) === 0) }, $numbers);
print("even number found: ", $even-number-found, "\n");
# even number found: 12

$odd-number-found = array-find-v2(sub ($number, |args) { (($number % 2) !== 0) }, $numbers);
print("odd number found: ", $odd-number-found, "\n");
# odd number found: 27

print("# using JavaScript-like Array.find() function \"array-find-v3\"\n");

$even-number-found = array-find-v3(sub ($number, |args) { (($number % 2) === 0) }, $numbers);
print("even number found: ", $even-number-found, "\n");
# even number found: 12

$odd-number-found = array-find-v3(sub ($number, |args) { (($number % 2) !== 0) }, $numbers);
print("odd number found: ", $odd-number-found, "\n");
# odd number found: 27

print("# using JavaScript-like Array.find() function \"array-find-v4\"\n");

$even-number-found = array-find-v4(sub ($number, |args) { (($number % 2) === 0) }, $numbers);
print("even number found: ", $even-number-found, "\n");
# even number found: 12

$odd-number-found = array-find-v4(sub ($number, |args) { (($number % 2) !== 0) }, $numbers);
print("odd number found: ", $odd-number-found, "\n");
# odd number found: 27

print("# using Raku Array.find() built-in method/function \"first\"\n");

$even-number-found = $numbers.first({ (($_ % 2) === 0) });
print("even number found: ", $even-number-found, "\n");
# even number found: 12

$odd-number-found = $numbers.first({ (($_ % 2) !== 0) });
print("odd number found: ", $odd-number-found, "\n");
# odd number found: 27

$even-number-found = $numbers.first({ (($^number % 2) === 0) });
print("even number found: ", $even-number-found, "\n");
# even number found: 12

$odd-number-found = $numbers.first({ (($^number % 2) !== 0) });
print("odd number found: ", $odd-number-found, "\n");
# odd number found: 27

print("\n# JavaScript-like Array.find() in Raku List of Hashes", "\n");

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

my $product-to-find = "bubble-gum";
print("product to find: ", json-stringify($product-to-find), "\n");

my $product-found;

print("# using JavaScript-like Array.find() function \"array-find-v1\"\n");

$product-found = array-find-v1(sub ($product, |args) { ($product{"code"} === $product-to-find) }, $products);
print("product found: ", json-stringify($product-found, :pretty(True)), "\n");
# product found: {
#     "code": "bubble-gum",
#     "price": 233
# }

print("# using JavaScript-like Array.find() function \"array-find-v2\"\n");

$product-found = array-find-v2(sub ($product, |args) { ($product{"code"} === $product-to-find) }, $products);
print("product found: ", json-stringify($product-found, :pretty(True)), "\n");
# product found: {
#     "code": "bubble-gum",
#     "price": 233
# }

print("# using JavaScript-like Array.find() function \"array-find-v3\"\n");

$product-found = array-find-v3(sub ($product, |args) { ($product{"code"} === $product-to-find) }, $products);
print("product found: ", json-stringify($product-found, :pretty(True)), "\n");
# product found: {
#     "code": "bubble-gum",
#     "price": 233
# }

print("# using JavaScript-like Array.find() function \"array-find-v4\"\n");

$product-found = array-find-v4(sub ($product, |args) { ($product{"code"} === $product-to-find) }, $products);
print("product found: ", json-stringify($product-found, :pretty(True)), "\n");
# product found: {
#     "code": "bubble-gum",
#     "price": 233
# }

print("# using Raku Array.find() built-in method/function \"first\"\n");

$product-found = $products.first({ ($_{"code"} === $product-to-find) });
print("product found: ", json-stringify($product-found, :pretty(True)), "\n");
# product found: {
#     "code": "bubble-gum",
#     "price": 233
# }

$product-found = $products.first({ ($^product{"code"} === $product-to-find) });
print("product found: ", json-stringify($product-found, :pretty(True)), "\n");
# product found: {
#     "code": "bubble-gum",
#     "price": 233
# }
