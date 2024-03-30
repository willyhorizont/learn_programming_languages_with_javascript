sub json-stringify($anything, Bool :$pretty = False) {
    use JSON::Fast;
    return to-json($anything, :pretty(True), :spacing(4)) if ($pretty === True);
    my $json-string = to-json($anything, :pretty(False));
    $json-string ~~ s:g/\,/\, /;
    $json-string ~~ s:g/\:/\: /;
    return $json-string;;
}

sub array-find-index-v1($callback-function, $an-array) {
    # JavaScript-like Array.findIndex() function
    my $data-found-index = -1;
    for ($an-array.kv) -> $array-item-index, $array-item {
        my $is-condition-match = $callback-function($array-item, $array-item-index, $an-array);
        if ($is-condition-match) {
            $data-found-index = $array-item-index;
            last;
        }
    }
    return $data-found-index;
}

sub array-find-index-v2($callback-function, $an-array) {
    # JavaScript-like Array.findIndex() function
    my $data-found-index = -1;
    for ($an-array.kv) -> $array-item-index, $array-item {
        if ($callback-function($array-item, $array-item-index, $an-array)) {
            $data-found-index = $array-item-index;
            last;
        }
    }
    return $data-found-index;
}

sub array-find-index-v3($callback-function, $an-array) {
    # JavaScript-like Array.findIndex() function
    for ($an-array.kv) -> $array-item-index, $array-item {
        my $is-condition-match = $callback-function($array-item, $array-item-index, $an-array);
        return $array-item-index if ($is-condition-match);
    }
    return -1;
}

sub array-find-index-v4($callback-function, $an-array) {
    # JavaScript-like Array.findIndex() function
    for ($an-array.kv) -> $array-item-index, $array-item {
        return $array-item-index if ($callback-function($array-item, $array-item-index, $an-array));
    }
    return -1;
}

print("\n# JavaScript-like Array.findIndex() in Raku List", "\n");

my $numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
print("numbers: ", json-stringify($numbers), "\n");

my $number-to-find = 27;
print("number to find: ", $number-to-find, "\n");

my $number-found-index;

print("# using JavaScript-like Array.findIndex() function \"array-find-index-v1\"\n");

$number-found-index = array-find-index-v1(sub ($number, |args) { ($number === $number-to-find) }, $numbers);
print("number found index: ", $number-found-index, "\n");
# number found index: 2

print("# using JavaScript-like Array.findIndex() function \"array-find-index-v2\"\n");

$number-found-index = array-find-index-v2(sub ($number, |args) { ($number === $number-to-find) }, $numbers);
print("number found index: ", $number-found-index, "\n");
# number found index: 2

print("# using JavaScript-like Array.findIndex() function \"array-find-index-v3\"\n");

$number-found-index = array-find-index-v3(sub ($number, |args) { ($number === $number-to-find) }, $numbers);
print("number found index: ", $number-found-index, "\n");
# number found index: 2

print("# using JavaScript-like Array.findIndex() function \"array-find-index-v4\"\n");

$number-found-index = array-find-index-v4(sub ($number, |args) { ($number === $number-to-find) }, $numbers);
print("number found index: ", $number-found-index, "\n");
# number found index: 2

print("# using Raku Array.findIndex() built-in method \"List.first(predicate, :k)\"\n");

$number-found-index = $numbers.first({ $_ === $number-to-find }, :k);
print("number found index: ", $number-found-index, "\n");
# number found index: 2

$number-found-index = $numbers.first({ $^number === $number-to-find }, :k);
print("number found index: ", $number-found-index, "\n");
# number found index: 2

print("\n# JavaScript-like Array.findIndex() in Raku List of Hashes", "\n");

my $products = [
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
];

print("products: ", json-stringify($products, :pretty(True)), "\n");

my $product-to-find = "pasta";
print("product to find: ", json-stringify($product-to-find), "\n");

my $product-found-index;

print("# using JavaScript-like Array.findIndex() function \"array-find-index-v1\"\n");

$product-found-index = array-find-index-v1(sub ($product, |args) { ($product{"code"} === $product-to-find) }, $products);
print("product found index: ", $product-found-index, "\n");
# product found index: 0

print("# using JavaScript-like Array.findIndex() function \"array-find-index-v2\"\n");

$product-found-index = array-find-index-v2(sub ($product, |args) { ($product{"code"} === $product-to-find) }, $products);
print("product found index: ", $product-found-index, "\n");
# product found index: 0

print("# using JavaScript-like Array.findIndex() function \"array-find-index-v3\"\n");

$product-found-index = array-find-index-v3(sub ($product, |args) { ($product{"code"} === $product-to-find) }, $products);
print("product found index: ", $product-found-index, "\n");
# product found index: 0

print("# using JavaScript-like Array.findIndex() function \"array-find-index-v4\"\n");

$product-found-index = array-find-index-v4(sub ($product, |args) { ($product{"code"} === $product-to-find) }, $products);
print("product found index: ", $product-found-index, "\n");
# product found index: 0

print("# using Raku Array.findIndex() built-in method \"List.first(predicate, :k)\"\n");

$product-found-index = $products.first({ $_{"code"} === $product-to-find }, :k);
print("product found index: ", $product-found-index, "\n");
# product found index: 0

$product-found-index = $products.first({ $^product{"code"} === $product-to-find }, :k);
print("product found index: ", $product-found-index, "\n");
# product found index: 0
