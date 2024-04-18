print("\n# JavaScript-like Optional Chaining Operator (?.) in Raku", "\n");

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

# There's no JavaScript-like Optional Chaining Operator (?.) in Raku.
# But, we don't need that in Raku.

constant $JSON_OBJECT = %(
    "foo" => %(
        "bar" => "baz"
    ),
    "fruits" => ("apple", "mango", "banana")
);
print("JSON_OBJECT: ", json-stringify($JSON_OBJECT, :pretty(True)), "\n");

print("JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: ", json-stringify($JSON_OBJECT{"foo"}{"bar"}), "\n");
# JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: "baz"

print("JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: ", json-stringify($JSON_OBJECT{"foo"}{"baz"}), "\n");
# JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: null

print("JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: ", json-stringify($JSON_OBJECT{"fruits"}[2]), "\n");
# JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: "banana"

print("JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: ", json-stringify($JSON_OBJECT{"fruits"}[5]), "\n");
# JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: null

my \JSON_OBJECT = %(
    "foo" => %(
        "bar" => "baz"
    ),
    "fruits" => ["apple", "mango", "banana"]
);
print("JSON_OBJECT: ", json-stringify(JSON_OBJECT, :pretty(True)), "\n");

print("JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: ", json-stringify(JSON_OBJECT{"foo"}{"bar"}), "\n");
# JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: "baz"

print("JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: ", json-stringify(JSON_OBJECT{"foo"}{"baz"}), "\n");
# JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: null

print("JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: ", json-stringify(JSON_OBJECT{"fruits"}[2]), "\n");
# JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: "banana"

print("JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: ", json-stringify(JSON_OBJECT{"fruits"}[5]), "\n");
# JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: null
