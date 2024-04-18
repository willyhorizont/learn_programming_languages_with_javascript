use JSON::Fast;

sub json-stringify-v1($anything) {
    my $json-string = to-json($anything, :pretty(False));
    $json-string ~~ s:g/\,/\, /;
    $json-string ~~ s:g/\:/\: /;
    return $json-string;
}

my &pretty-json-stringify-v1 = -> $anything { to-json($anything, :pretty(True), :spacing(4)) };

my $pretty-json-stringify-v2 = -> $anything { to-json($anything, :pretty(True), :spacing(4)) };

my $pretty-json-stringify-v3 = sub ($anything) { to-json($anything, :pretty(True), :spacing(4)) };

sub pretty-json-stringify-v4($anything) { to-json($anything, :pretty(True), :spacing(4)) }

sub json-stringify-v2($anything, Bool :$pretty = False) {
    use JSON::Fast;
    return to-json($anything, :pretty(True), :spacing(4)) if ($pretty === True);
    my $json-string = to-json($anything, :pretty(False));
    $json-string ~~ s:g/\,/\, /;
    $json-string ~~ s:g/\:/\: /;
    return $json-string;
}

my $something;
$something = (1, 2, 3);
print("something: ", json-stringify-v1($something), "\n");
print("something: ", json-stringify-v2($something, :pretty(True)), "\n");
print("something: ", json-stringify-v2($something, :pretty(False)), "\n");
print("something: ", &pretty-json-stringify-v1($something), "\n");
print("something: ", $pretty-json-stringify-v2($something), "\n");
print("something: ", pretty-json-stringify-v4($something), "\n");
$something = {"foo" => "bar"};
print("something: ", json-stringify-v1($something), "\n");
print("something: ", json-stringify-v2($something, :pretty(True)), "\n");
print("something: ", json-stringify-v2($something, :pretty(False)), "\n");
print("something: ", &pretty-json-stringify-v1($something), "\n");
print("something: ", $pretty-json-stringify-v2($something), "\n");
print("something: ", pretty-json-stringify-v4($something), "\n");

sub json-stringify-v3($anything, Bool :$pretty = False) {
    use JSON::Fast;
    return to-json($anything, :pretty(True), :spacing(4)) if ($pretty === True);
    my $json-string = to-json($anything, :pretty(False));
    $json-string ~~ s:g/\,/\, /;
    $json-string ~~ s:g/\:/\: /;
    return $json-string;
}

sub json-stringify-v4($anything, Bool :$pretty = False, Str :$indent = " " x 4) {
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
