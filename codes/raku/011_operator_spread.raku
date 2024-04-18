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

print("\n# JavaScript-like Spread Syntax (...) in Raku", "\n");

# In Raku, JavaScript-like Spread Syntax (...) is called Slip Operator (|).

my $fruits = ("Mango", "Melon", "Banana");
print("fruits: ", json-stringify($fruits), "\n");

my $vegetables = ("Carrot", "Tomato");
print("vegetables: ", json-stringify($vegetables), "\n");

my $country-capitals-in-asia = %(
    "Thailand" => "Bangkok",
    "China" => "Beijing",
    "Japan" => "Tokyo"
);
print("country-capitals-in-asia: ", json-stringify($country-capitals-in-asia, :pretty(True)), "\n");

my $country-capitals-in-europe = %(
    "France" => "Paris",
    "England" => "London"
);
print("country-capitals-in-europe: ", json-stringify($country-capitals-in-europe, :pretty(True)), "\n");

print("\n# [...array1, ...array2]:\n", "\n");

my $combination1 = (|$fruits, |$vegetables);
print("combination1: ", json-stringify($combination1, :pretty(True)), "\n");
# combination1: [
#     "Mango",
#     "Melon",
#     "Banana",
#     "Carrot",
#     "Tomato"
# ]

my $combination2 = (|$fruits, "Cucumber", "Cabbage");
print("combination2: ", json-stringify($combination2, :pretty(True)), "\n");
# combination2: [
#     "Mango",
#     "Melon",
#     "Banana",
#     "Cucumber",
#     "Cabbage"
# ]

print("\n# \{ ...object1, ...object2 }:\n", "\n");

my $combination3 = %(|$country-capitals-in-asia, |$country-capitals-in-europe);
print("combination3: ", json-stringify($combination3, :pretty(True)), "\n");
# combination3: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "France": "Paris",
#     "England": "London"
# }

my $combination4 = %(|$country-capitals-in-asia, "Germany" => "Berlin", "Italy" => "Rome");
print("combination4: ", json-stringify($combination4, :pretty(True)), "\n");
# combination4: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "Germany": "Berlin",
#     "Italy": "Rome"
# }

print("\n# [...array1, array2] || [...array1, newArrayItem1, newArrayItem2]:\n", "\n");

my $combination5 = (|$fruits, $vegetables);
print("combination5: ", json-stringify($combination5, :pretty(True)), "\n");
# combination5: [
#     "Mango",
#     "Melon",
#     "Banana",
#     [
#         "Carrot",
#         "Tomato"
#     ]
# ]

my $combination6 = (|$fruits, ("Cucumber", "Cabbage"));
print("combination6: ", json-stringify($combination6, :pretty(True)), "\n");
# combination6: [
#     "Mango",
#     "Melon",
#     "Banana",
#     [
#         "Cucumber",
#         "Cabbage"
#     ]
# ]

print("\n# [...array1, object1] || [...array1, newArrayItem1, newArrayItem2]:\n", "\n");

my $combination7 = (|$fruits, $country-capitals-in-asia);
print("combination7: ", json-stringify($combination7, :pretty(True)), "\n");
# combination7: [
#     "Mango",
#     "Melon",
#     "Banana",
#     {
#         "Thailand": "Bangkok",
#         "China": "Beijing",
#         "Japan": "Tokyo"
#     }
# ]

my $combination8 = (|$fruits, %("Germany" => "Berlin", "Italy" => "Rome"));
print("combination8: ", json-stringify($combination8, :pretty(True)), "\n");
# combination8: [
#     "Mango",
#     "Melon",
#     "Banana",
#     {
#         "Germany": "Berlin",
#         "Italy": "Rome"
#     }
# ]

print("\n# \{ ...object1, object2 } || \{ ...object1, objectKey: objectValue }:\n", "\n");

my $combination9 = %(|$country-capitals-in-asia, %("country-capitals-in-europe" => $country-capitals-in-europe));
print("combination9: ", json-stringify($combination9, :pretty(True)), "\n");
# combination9: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "country-capitals-in-europe" : {
#       "France" : "Paris",
#       "England" : "London"
#    }
# }

my $combination10 = %(|$country-capitals-in-asia, %("country-capitals-in-europe" => %("Germany" => "Berlin", "Italy" => "Rome")));
print("combination10: ", json-stringify($combination10, :pretty(True)), "\n");
# combination10: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "country-capitals-in-europe": {
#         "Germany": "Berlin",
#         "Italy": "Rome"
#     }
# }

print("\n# \{ ...object1, array2 } || \{ ...object1, objectKey: objectValue }:\n", "\n");

my $combination11 = %(|$country-capitals-in-asia, %("vegetables" => $vegetables));
print("combination11: ", json-stringify($combination11, :pretty(True)), "\n");
# combination11: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "vegetables": [
#         "Carrot",
#         "Tomato"
#     ]
# }

my $combination12 = %(|$country-capitals-in-asia, %("vegetables" => ("Cucumber", "Cabbage")));
print("combination12: ", json-stringify($combination12, :pretty(True)), "\n");
# combination12: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "vegetables": [
#         "Cucumber",
#         "Cabbage"
#     ]
# }

print("\n# \{ ...object1, ...array2 }:\n", "\n");

my $combination13 = %(|$country-capitals-in-asia, |$vegetables.kv);
print("combination13: ", json-stringify($combination13, :pretty(True)), "\n");
# combination13: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "0" : "Carrot",
#    "1" : "Tomato"
# }

my $combination14 = %(|$country-capitals-in-asia, |("Cucumber", "Cabbage").kv);
print("combination14: ", json-stringify($combination14, :pretty(True)), "\n");
# combination14: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "0" : "Cucumber",
#    "1" : "Cabbage"
# }

# print("\n# [...array1, ...object1]: # this combination throw an error in JavaScript\n", "\n");

# this combination throw an error in JavaScript
# my $combination-error-in-javascript1 = (|$fruits, $country-capitals-in-asia);
# print("combination-error-in-javascript1: ", json-stringify($combination-error-in-javascript1, :pretty(True)), "\n");

# this combination throw an error in JavaScript
# my $combination-error-in-javascript2 = (|$fruits, %("country-capitals-in-europe" => %("Germany" => "Berlin", "Italy" => "Rome")));
# print("combination-error-in-javascript2: ", json-stringify($combination-error-in-javascript2, :pretty(True)), "\n");
