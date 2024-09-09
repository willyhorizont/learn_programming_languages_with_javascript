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

# There's no JavaScript-like Object.entries() in Raku.
# But, we can create our own function to mimic it in Raku.

sub object-entries($an-object) {
    # JavaScript-like Array.map() function
    my $new-array = ();
    for ($an-object.pairs.kv) -> $object-entry-index, $object-entry {
        my $object-key = $object-entry.key;
        my $object-value = $object-entry.value;
        $new-array = (|$new-array, ($object-key, $object-value));
    }
    return $new-array;
}

print("\n# JavaScript-like Object.entries() in Raku Hash", "\n");

my %friend1 = (
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
);
print("friend1: ", json-stringify(%friend1, :pretty(True)), "\n");

print("# using JavaScript-like Object.entries() function \"object-entries\"\n");

print("friend1 entries: ", json-stringify(object-entries(%friend1)), "\n");
# friend entries: [["name", "Alisa"], ["country", "Finland"], ["age", 25]]

my $friend2 = {
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
};
print("friend2: ", json-stringify($friend2, :pretty(True)), "\n");

print("# using JavaScript-like Object.entries() function \"object-entries\"\n");

print("friend2 entries: ", json-stringify(object-entries($friend2)), "\n");
# friend entries: [["name", "Alisa"], ["country", "Finland"], ["age", 25]]

my $friend3 = %(
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
);
print("friend3: ", json-stringify($friend3, :pretty(True)), "\n");

print("# using JavaScript-like Object.entries() function \"object-entries\"\n");

print("friend3 entries: ", json-stringify(object-entries($friend3)), "\n");
# friend entries: [["name", "Alisa"], ["country", "Finland"], ["age", 25]]
