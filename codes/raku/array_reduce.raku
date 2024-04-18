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

sub array-reduce($callback-function, $an-array, $initial-value) {
    # JavaScript-like Array.reduce() function
    my $result = $initial-value;
    for ($an-array.kv) -> $array-item-index, $array-item {
        $result = $callback-function($result, $array-item, $array-item-index, $an-array);
    }
    return $result;
}

print("\n# JavaScript-like Array.reduce() in Raku List", "\n");

my $numbers = (36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3);
print("numbers: ", json-stringify($numbers), "\n");

my $numbers-total;

print("# using JavaScript-like Array.reduce() function \"array-reduce\"\n");

$numbers-total = array-reduce(sub ($current-result, $current-number, |args) { ($current-result + $current-number) }, $numbers, 0);
print("total number: {$numbers-total}", "\n");
# total number: 41.2

print("# using Raku Array.reduce() built-in method/function \"reduce\"\n");

$numbers-total = (0, |$numbers).reduce({ ($^a-current-result + $^b-current-number) });
print("total number: {$numbers-total}", "\n");
# total number: 41.2

print("\n# JavaScript-like Array.reduce() in Raku List of Hashes", "\n");

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

print("# using JavaScript-like Array.reduce() function \"array-reduce\"\n");

my $products-grouped;

$products-grouped = array-reduce(sub ($current-result, $current-product, |args) {
    return %(|$current-result, "expensive" => (|$current-result{"expensive"}, $current-product)) if ($current-product{"price"} > 100);
    return %(|$current-result, "cheap" => (|$current-result{"cheap"}, $current-product));
}, $products, %("expensive" => (), "cheap" => ()));
print("grouped products: ", json-stringify($products-grouped, :pretty(True)), "\n");
# grouped products: {
#     "expensive": [
#         {
#             "code": "pasta",
#             "price": 321
#         },
#         {
#             "code": "bubble-gum",
#             "price": 233
#         },
#         {
#             "code": "towel",
#             "price": 499
#         }
#     ],
#     "cheap": [
#         {
#             "code": "potato-chips",
#             "price": 5
#         }
#     ]
# }

$products-grouped = array-reduce(sub ($current-result, $current-product, |args) { (($current-product{"price"} > 100) ?? %(|$current-result, "expensive" => (|$current-result{"expensive"}, $current-product)) !! %(|$current-result, "cheap" => (|$current-result{"cheap"}, $current-product))) }, $products, %("expensive" => (), "cheap" => ()));
print("grouped products: ", json-stringify($products-grouped, :pretty(True)), "\n");
# grouped products: {
#     "expensive": [
#         {
#             "code": "pasta",
#             "price": 321
#         },
#         {
#             "code": "bubble-gum",
#             "price": 233
#         },
#         {
#             "code": "towel",
#             "price": 499
#         }
#     ],
#     "cheap": [
#         {
#             "code": "potato-chips",
#             "price": 5
#         }
#     ]
# }

print("# using Raku Array.reduce() built-in method/function \"reduce\"\n");

$products-grouped = (%("expensive" => (), "cheap" => ()), |$products).reduce({ (($^b-current-product{"price"} > 100) ?? %(|$^a-current-result, "expensive" => (|$^a-current-result{"expensive"}, $^b-current-product)) !! %(|$^a-current-result, "cheap" => (|$^a-current-result{"cheap"}, $^b-current-product))) });
print("grouped products: ", json-stringify($products-grouped, :pretty(True)), "\n");
# grouped products: {
#     "expensive": [
#         {
#             "code": "pasta",
#             "price": 321
#         },
#         {
#             "code": "bubble-gum",
#             "price": 233
#         },
#         {
#             "code": "towel",
#             "price": 499
#         }
#     ],
#     "cheap": [
#         {
#             "code": "potato-chips",
#             "price": 5
#         }
#     ]
# }
