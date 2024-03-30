sub json-stringify($anything, Bool :$pretty = False) {
    use JSON::Fast;
    return to-json($anything, :pretty(True), :spacing(4)) if ($pretty === True);
    my $json-string = to-json($anything, :pretty(False));
    $json-string ~~ s:g/\,/\, /;
    $json-string ~~ s:g/\:/\: /;
    return $json-string;;
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

my $my-friends = ["Alisa", "Trivia"];
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
