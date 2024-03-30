sub json-stringify($anything, Bool :$pretty = False) {
    use JSON::Fast;
    return to-json($anything, :pretty(True), :spacing(4)) if ($pretty === True);
    my $json-string = to-json($anything, :pretty(False));
    $json-string ~~ s:g/\,/\, /;
    $json-string ~~ s:g/\:/\: /;
    return $json-string;;
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

my $numbers = [36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3];
print("numbers: ", json-stringify($numbers), "\n");

my $numbers-total;

print("# using JavaScript-like Array.reduce() function \"array-reduce\"\n");

$numbers-total = array-reduce(sub ($current-result, $current-number, |args) { ($current-result + $current-number) }, $numbers, 0);
print("total number: {$numbers-total}", "\n");
# total number: 41.2

print("# using Raku Array.reduce() built-in method \"List.reduce()\"\n");

$numbers-total = [0, |$numbers].reduce({ ($^current-result + $^current-number) });
print("total number: {$numbers-total}", "\n");
# total number: 41.2

print("\n# JavaScript-like Array.reduce() in Raku List of Hashes", "\n");

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

print("# using JavaScript-like Array.reduce() function \"array-reduce\"\n");

my $products-grouped;

$products-grouped = array-reduce(sub ($current-result, $current-product, |args) {
    return %(|$current-result, "expensive" => [|$current-result{"expensive"}, $current-product]) if ($current-product{"price"} > 100);
    return %(|$current-result, "cheap" => [|$current-result{"cheap"}, $current-product]);
}, $products, %("expensive" => [], "cheap" => []));
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

$products-grouped = array-reduce(sub ($current-result, $current-product, |args) { (($current-product{"price"} > 100) ?? %(|$current-result, "expensive" => [|$current-result{"expensive"}, $current-product]) !! %(|$current-result, "cheap" => [|$current-result{"cheap"}, $current-product])) }, $products, %("expensive" => [], "cheap" => []));
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

print("# using Raku Array.reduce() built-in method \"List.reduce()\"\n");

$products-grouped = [%("expensive" => [], "cheap" => []), |$products].reduce({ (($^current-product{"price"} > 100) ?? %(|$^current-result, "expensive" => [|$^current-result{"expensive"}, $^current-product]) !! %(|$^current-result, "cheap" => [|$^current-result{"cheap"}, $^current-product])) });
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
