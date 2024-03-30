print("\n# JavaScript-like Optional Chaining Operator (?.) in Raku", "\n");

sub json-stringify($anything, Bool :$pretty = False) {
    use JSON::Fast;
    return to-json($anything, :pretty(True), :spacing(4)) if ($pretty === True);
    my $json-string = to-json($anything, :pretty(False));
    $json-string ~~ s:g/\,/\, /;
    $json-string ~~ s:g/\:/\: /;
    return $json-string;;
}

# There's no JavaScript-like Optional Chaining Operator (?.) in Raku.
# But, we don't need that in Raku.

constant $JSON_OBJECT = %(
    "foo" => %(
        "bar" => "baz"
    ),
    "fruits" => ["apple", "mango", "banana"]
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
