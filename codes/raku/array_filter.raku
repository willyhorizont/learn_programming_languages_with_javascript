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

sub array-filter-v1($callback-function, $an-array) {
    # JavaScript-like Array.filter() function
    my $data-filtered = ();
    for ($an-array.kv) -> $array-item-index, $array-item {
        my $is-condition-match = $callback-function($array-item, $array-item-index, $an-array);
        $data-filtered.push($array-item) if ($is-condition-match);
    }
    return $data-filtered;
}

sub array-filter-v2($callback-function, $an-array) {
    # JavaScript-like Array.filter() function
    my $data-filtered = ();
    for ($an-array.kv) -> $array-item-index, $array-item {
        $data-filtered.push($array-item) if ($callback-function($array-item, $array-item-index, $an-array));
    }
    return $data-filtered;
}

print("\n# JavaScript-like Array.filter() in Raku List", "\n");

my $numbers = (12, 34, 27, 23, 65, 93, 36, 87, 4, 254);
print("numbers: ", json-stringify($numbers), "\n");

my $numbers-even;
my $numbers-odd;

print("# using JavaScript-like Array.filter() function \"array-filter-v1\"\n");

$numbers-even = array-filter-v1(sub ($number, |args) { (($number % 2) === 0) }, $numbers);
print("even numbers only: ", json-stringify($numbers-even), "\n");
# even numbers only: [12, 34, 36, 4, 254]

$numbers-odd = array-filter-v1(sub ($number, |args) { (($number % 2) !== 0) }, $numbers);
print("odd numbers only: ", json-stringify($numbers-odd), "\n");
# odd numbers only: [27, 23, 65, 93, 87]

print("# using JavaScript-like Array.filter() function \"array-filter-v2\"\n");

$numbers-even = array-filter-v2(sub ($number, |args) { (($number % 2) === 0) }, $numbers);
print("even numbers only: ", json-stringify($numbers-even), "\n");
# even numbers only: [12, 34, 36, 4, 254]

$numbers-odd = array-filter-v2(sub ($number, |args) { (($number % 2) !== 0) }, $numbers);
print("odd numbers only: ", json-stringify($numbers-odd), "\n");
# odd numbers only: [27, 23, 65, 93, 87]

print("# using Raku Array.filter() built-in method/function \"grep\"\n");

$numbers-even = $numbers.grep({ (($_ % 2) === 0) });
print("even numbers only: ", json-stringify($numbers-even), "\n");
# even numbers only: [12, 34, 36, 4, 254]

$numbers-odd = $numbers.grep({ (($_ % 2) !== 0) });
print("odd numbers only: ", json-stringify($numbers-odd), "\n");
# odd numbers only: [27, 23, 65, 93, 87]

$numbers-even = $numbers.grep({ (($^number % 2) === 0) });
print("even numbers only: ", json-stringify($numbers-even), "\n");
# even numbers only: [12, 34, 36, 4, 254]

$numbers-odd = $numbers.grep({ (($^number % 2) !== 0) });
print("odd numbers only: ", json-stringify($numbers-odd), "\n");
# odd numbers only: [27, 23, 65, 93, 87]

print("\n# JavaScript-like Array.filter() in Raku List of Hashes", "\n");

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

my $products-below100;
my $products-above100;

print("# using JavaScript-like Array.filter() function \"array-filter-v1\"\n");

$products-below100 = array-filter-v1(sub ($product, |args) { ($product{"price"} <= 100) }, $products);
print("products with price <= 100 only: ", json-stringify($products-below100, :pretty(True)), "\n");
# products with price <= 100 only: [
#     {
#         "code": "potato-chips",
#         "price": 5
#     }
# ]

$products-above100 = array-filter-v1(sub ($product, |args) { ($product{"price"} > 100) }, $products);
print("products with price > 100 only: ", json-stringify($products-above100, :pretty(True)), "\n");
# products with price > 100 only: [
#     {
#         "code": "pasta",
#         "price": 321
#     },
#     {
#         "code": "bubble-gum",
#         "price": 233
#     },
#     {
#         "code": "towel",
#         "price": 499
#     }
# ]

print("# using JavaScript-like Array.filter() function \"array-filter-v2\"\n");

$products-below100 = array-filter-v2(sub ($product, |args) { ($product{"price"} <= 100) }, $products);
print("products with price <= 100 only: ", json-stringify($products-below100, :pretty(True)), "\n");
# products with price <= 100 only: [
#     {
#         "code": "potato-chips",
#         "price": 5
#     }
# ]

$products-above100 = array-filter-v2(sub ($product, |args) { ($product{"price"} > 100) }, $products);
print("products with price > 100 only: ", json-stringify($products-above100, :pretty(True)), "\n");
# products with price > 100 only: [
#     {
#         "code": "pasta",
#         "price": 321
#     },
#     {
#         "code": "bubble-gum",
#         "price": 233
#     },
#     {
#         "code": "towel",
#         "price": 499
#     }
# ]

print("# using Raku Array.filter() built-in method/function \"grep\"\n");

$products-below100 = $products.grep({ ($_{"price"} <= 100) });
print("products with price <= 100 only: ", json-stringify($products-below100, :pretty(True)), "\n");
# products with price <= 100 only: [
#     {
#         "code": "potato-chips",
#         "price": 5
#     }
# ]

$products-above100 = $products.grep({ ($_{"price"} > 100) });
print("products with price > 100 only: ", json-stringify($products-above100, :pretty(True)), "\n");
# products with price > 100 only: [
#     {
#         "code": "pasta",
#         "price": 321
#     },
#     {
#         "code": "bubble-gum",
#         "price": 233
#     },
#     {
#         "code": "towel",
#         "price": 499
#     }
# ]

$products-below100 = $products.grep({ ($^product{"price"} <= 100) });
print("products with price <= 100 only: ", json-stringify($products-below100, :pretty(True)), "\n");
# products with price <= 100 only: [
#     {
#         "code": "potato-chips",
#         "price": 5
#     }
# ]

$products-above100 = $products.grep({ ($^product{"price"} > 100) });
print("products with price > 100 only: ", json-stringify($products-above100, :pretty(True)), "\n");
# products with price > 100 only: [
#     {
#         "code": "pasta",
#         "price": 321
#     },
#     {
#         "code": "bubble-gum",
#         "price": 233
#     },
#     {
#         "code": "towel",
#         "price": 499
#     }
# ]
