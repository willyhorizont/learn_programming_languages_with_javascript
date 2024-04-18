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

# There's no JavaScript-like Array.includes() in Raku.
# But, we can create our own function to mimic it in Raku.

sub array-includes-v1($search-element, $an-array) {
    # JavaScript-like Array.includes() function
    my $is-element-found = False;
    for ($an-array.kv) -> $array-item-index, $array-item {
        if ($array-item === $search-element) {
            $is-element-found = True;
            last;
        }
    }
    return $is-element-found;
}

sub array-includes-v2($search-element, $an-array) {
    # JavaScript-like Array.includes() function
    for ($an-array.kv) -> $array-item-index, $array-item {
        return True if ($array-item === $search-element);
    }
    return False;
}

print("\n# JavaScript-like Array.includes() in Raku", "\n");

my $my-friends = ("Alisa", "Trivia");
print("my friends: ", json-stringify($my-friends), "\n");

my $name;
my $is-my-friend;

print("# using JavaScript-like Array.includes() function \"array-includes-v1\"\n");

$name = "Alisa";
print("name: \"{$name}\"\n");
$is-my-friend = array-includes-v1($name, $my-friends);
print("is my friends includes \"{$name}\": ", json-stringify($is-my-friend), "\n");
# is my friends includes "Alisa": true

$name = "Trivia";
print("name: \"{$name}\"\n");
$is-my-friend = array-includes-v1($name, $my-friends);
print("is my friends includes \"{$name}\": ", json-stringify($is-my-friend), "\n");
# is my friends includes "Trivia": true

$name = "Tony";
print("name: \"{$name}\"\n");
$is-my-friend = array-includes-v1($name, $my-friends);
print("is my friends includes \"{$name}\": ", json-stringify($is-my-friend), "\n");
# is my friends includes "Tony": false

$name = "Ezekiel";
print("name: \"{$name}\"\n");
$is-my-friend = array-includes-v1($name, $my-friends);
print("is my friends includes \"{$name}\": ", json-stringify($is-my-friend), "\n");
# is my friends includes "Ezekiel": false

print("# using JavaScript-like Array.includes() function \"array-includes-v2\"\n");

$name = "Alisa";
print("name: \"{$name}\"\n");
$is-my-friend = array-includes-v2($name, $my-friends);
print("is my friends includes \"{$name}\": ", json-stringify($is-my-friend), "\n");
# is my friends includes "Alisa": true

$name = "Trivia";
print("name: \"{$name}\"\n");
$is-my-friend = array-includes-v2($name, $my-friends);
print("is my friends includes \"{$name}\": ", json-stringify($is-my-friend), "\n");
# is my friends includes "Trivia": true

$name = "Tony";
print("name: \"{$name}\"\n");
$is-my-friend = array-includes-v2($name, $my-friends);
print("is my friends includes \"{$name}\": ", json-stringify($is-my-friend), "\n");
# is my friends includes "Tony": false

$name = "Ezekiel";
print("name: \"{$name}\"\n");
$is-my-friend = array-includes-v2($name, $my-friends);
print("is my friends includes \"{$name}\": ", json-stringify($is-my-friend), "\n");
# is my friends includes "Ezekiel": false
