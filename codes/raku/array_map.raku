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

sub array-map-v1($callback-function, $an-array) {
    # JavaScript-like Array.map() function
    my $new-array = ();
    for ($an-array.kv) -> $array-item-index, $array-item {
        my $new-array-item = $callback-function($array-item, $array-item-index, $an-array);
        $new-array = (|$new-array, $new-array-item);
    }
    return $new-array;
}

sub array-map-v2($callback-function, $an-array) {
    # JavaScript-like Array.map() function
    my $new-array = ();
    for ($an-array.kv) -> $array-item-index, $array-item {
        $new-array = (|$new-array, $callback-function($array-item, $array-item-index, $an-array));
    }
    return $new-array;
}

print("\n# JavaScript-like Array.map() in Raku List", "\n");

my $numbers = (12, 34, 27, 23, 65, 93, 36, 87, 4, 254);
print("numbers: ", json-stringify($numbers), "\n");

my $numbers-labeled;

print("# using JavaScript-like Array.map() function \"array-map-v1\"\n");

$numbers-labeled = array-map-v1(sub ($number, |args) { %("{$number}" => ((($number % 2) === 0) ?? "even" !! "odd")) }, $numbers);
print("labeled numbers ", json-stringify($numbers-labeled, :pretty(True)), "\n");
# labeled numbers: [
#     {
#         "12": "even"
#     },
#     {
#         "34": "even"
#     },
#     {
#         "27": "odd"
#     },
#     {
#         "23": "odd"
#     },
#     {
#         "65": "odd"
#     },
#     {
#         "93": "odd"
#     },
#     {
#         "36": "even"
#     },
#     {
#         "87": "odd"
#     },
#     {
#         "4": "even"
#     },
#     {
#         "254": "even"
#     }
# ]

print("# using JavaScript-like Array.map() function \"array-map-v2\"\n");

$numbers-labeled = array-map-v2(sub ($number, |args) { %("{$number}" => ((($number % 2) === 0) ?? "even" !! "odd")) }, $numbers);
print("labeled numbers ", json-stringify($numbers-labeled, :pretty(True)), "\n");
# labeled numbers: [
#     {
#         "12": "even"
#     },
#     {
#         "34": "even"
#     },
#     {
#         "27": "odd"
#     },
#     {
#         "23": "odd"
#     },
#     {
#         "65": "odd"
#     },
#     {
#         "93": "odd"
#     },
#     {
#         "36": "even"
#     },
#     {
#         "87": "odd"
#     },
#     {
#         "4": "even"
#     },
#     {
#         "254": "even"
#     }
# ]

print("# using Raku Array.map() built-in method/function \"map\"\n");

$numbers-labeled = $numbers.map({ %($_.Str => ((($_ % 2) === 0) ?? "even" !! "odd")) });
print("labeled numbers ", json-stringify($numbers-labeled, :pretty(True)), "\n");
# labeled numbers: [
#     {
#         "12": "even"
#     },
#     {
#         "34": "even"
#     },
#     {
#         "27": "odd"
#     },
#     {
#         "23": "odd"
#     },
#     {
#         "65": "odd"
#     },
#     {
#         "93": "odd"
#     },
#     {
#         "36": "even"
#     },
#     {
#         "87": "odd"
#     },
#     {
#         "4": "even"
#     },
#     {
#         "254": "even"
#     }
# ]

$numbers-labeled = $numbers.map({ %($^number.Str => ((($^number % 2) === 0) ?? "even" !! "odd")) });
print("labeled numbers ", json-stringify($numbers-labeled, :pretty(True)), "\n");
# labeled numbers: [
#     {
#         "12": "even"
#     },
#     {
#         "34": "even"
#     },
#     {
#         "27": "odd"
#     },
#     {
#         "23": "odd"
#     },
#     {
#         "65": "odd"
#     },
#     {
#         "93": "odd"
#     },
#     {
#         "36": "even"
#     },
#     {
#         "87": "odd"
#     },
#     {
#         "4": "even"
#     },
#     {
#         "254": "even"
#     }
# ]

print("\n# JavaScript-like Array.map() in Raku List of Hashes", "\n");

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

my $products-labeled;

print("# using JavaScript-like Array.map() function \"array-map-v1\"\n");

$products-labeled = array-map-v1(sub ($product, |args) { %(|$product, "label" => (($product{"price"} > 100) ?? "expensive" !! "cheap")) }, $products);
print("labeled products: ", json-stringify($products-labeled, :pretty(True)), "\n");
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble-gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato-chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]

print("# using JavaScript-like Array.map() function \"array-map-v2\"\n");

$products-labeled = array-map-v2(sub ($product, |args) { %(|$product, "label" => (($product{"price"} > 100) ?? "expensive" !! "cheap")) }, $products);
print("labeled products: ", json-stringify($products-labeled, :pretty(True)), "\n");
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble-gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato-chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]

print("# using Raku Array.map() built-in method/function \"map\"\n");

$products-labeled = $products.map({ %(|$_, "label" => (($_{"price"} > 100) ?? "expensive" !! "cheap")) });
print("labeled products: ", json-stringify($products-labeled, :pretty(True)), "\n");
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble-gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato-chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]

$products-labeled = $products.map({ %(|$^product, "label" => (($^product{"price"} > 100) ?? "expensive" !! "cheap")) });
print("labeled products: ", json-stringify($products-labeled, :pretty(True)), "\n");
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble-gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato-chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]
