print("\n# JavaScript-like Nullish Coalescing Operator (??) in Raku", "\n");

sub json-stringify($anything, Bool :$pretty = False) {
    use JSON::Fast;
    return to-json($anything, :pretty(True), :spacing(4)) if ($pretty === True);
    my $json-string = to-json($anything, :pretty(False));
    $json-string ~~ s:g/\,/\, /;
    $json-string ~~ s:g/\:/\: /;
    return $json-string;;
}

# In Raku, JavaScript-like Nullish Coalescing Operator (??) is called "defined-or" Operator (//).

constant $JSON_OBJECT = %(
    "foo" => %(
        "bar" => "baz"
    ),
    "fruits" => ["apple", "mango", "banana"]
);
print("JSON_OBJECT: ", json-stringify($JSON_OBJECT, :pretty(True)), "\n");

print("(JSON_OBJECT?.foo?.bar ?? 'not found') or (JSON_OBJECT?.['foo']?.['bar'] ?? 'not found'): ", json-stringify($JSON_OBJECT{"foo"}{"bar"} // "not found"), "\n");
# (JSON_OBJECT?.foo?.bar ?? 'not found') or (JSON_OBJECT?.['foo']?.['bar'] ?? 'not found'): "baz"
print("(JSON_OBJECT?.foo?.baz ?? 'not found') or (JSON_OBJECT?.['foo']?.['baz'] ?? 'not found'): ", json-stringify($JSON_OBJECT{"foo"}{"baz"} // "not found"), "\n");
# (JSON_OBJECT?.foo?.baz ?? 'not found') or (JSON_OBJECT?.['foo']?.['baz'] ?? 'not found'): "not found"

print("(JSON_OBJECT?.fruits?.[2] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[2] ?? 'not found'): ", json-stringify($JSON_OBJECT{"fruits"}[2] // "not found"), "\n");
# (JSON_OBJECT?.fruits?.[2] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[2] ?? 'not found'): "banana"
print("(JSON_OBJECT?.fruits?.[5] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[5] ?? 'not found'): ", json-stringify($JSON_OBJECT{"fruits"}[5] // "not found"), "\n");
# (JSON_OBJECT?.fruits?.[5] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[5] ?? 'not found'): "not found"

my \JSON_OBJECT = %(
    "foo" => %(
        "bar" => "baz"
    ),
    "fruits" => ["apple", "mango", "banana"]
);
print("JSON_OBJECT: ", json-stringify(JSON_OBJECT, :pretty(True)), "\n");

print("(JSON_OBJECT?.foo?.bar ?? 'not found') or (JSON_OBJECT?.['foo']?.['bar'] ?? 'not found'): ", json-stringify(JSON_OBJECT{"foo"}{"bar"} // "not found"), "\n");
# (JSON_OBJECT?.foo?.bar ?? 'not found') or (JSON_OBJECT?.['foo']?.['bar'] ?? 'not found'): "baz"
print("(JSON_OBJECT?.foo?.baz ?? 'not found') or (JSON_OBJECT?.['foo']?.['baz'] ?? 'not found'): ", json-stringify(JSON_OBJECT{"foo"}{"baz"} // "not found"), "\n");
# (JSON_OBJECT?.foo?.baz ?? 'not found') or (JSON_OBJECT?.['foo']?.['baz'] ?? 'not found'): "not found"

print("(JSON_OBJECT?.fruits?.[2] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[2] ?? 'not found'): ", json-stringify(JSON_OBJECT{"fruits"}[2] // "not found"), "\n");
# (JSON_OBJECT?.fruits?.[2] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[2] ?? 'not found'): "banana"
print("(JSON_OBJECT?.fruits?.[5] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[5] ?? 'not found'): ", json-stringify(JSON_OBJECT{"fruits"}[5] // "not found"), "\n");
# (JSON_OBJECT?.fruits?.[5] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[5] ?? 'not found'): "not found"
