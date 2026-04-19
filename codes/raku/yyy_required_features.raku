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

#`<<<
x. variable can store dynamic data type and dynamic value, variable can inferred data type from value, value of variable can be reassign with different data type or has option to make variable can store dynamic data type and dynamic value
>>>
my $something = "foo";
print("something: {json-stringify($something, :pretty(True))}", "\n");
$something = 123;
print("something: {json-stringify($something, :pretty(True))}", "\n");
$something = True;
print("something: {json-stringify($something, :pretty(True))}", "\n");
$something = Nil;
print("something: {json-stringify($something, :pretty(True))}", "\n");
$something = (1, 2, 3);
print("something: {json-stringify($something, :pretty(True))}", "\n");
$something = %("foo" => "bar");
print("something: {json-stringify($something, :pretty(True))}", "\n");

#`<<<
x. it is possible to access and modify variables defined outside of the current scope within nested functions, so it is possible to have closure too
>>>
sub get-modified-indent-level() {
    my $indent-level = 0;
    sub change-indent-level() {
        $indent-level += 1;
        change-indent-level() if ($indent-level < 5);
        return $indent-level;
    }
    return change-indent-level();
}
print("get-modified-indent-level(): {get-modified-indent-level()}", "\n");
sub create-new-game($initial-credit) {
    my $current-credit = $initial-credit;
    print("initial credit: {$initial-credit}", "\n");
    return sub {
        $current-credit -= 1;
        if ($current-credit === 0) {
            print("not enough credits", "\n");
            return;
        }
        print("playing game, {$current-credit} credit(s) remaining", "\n");
    }
}
my $play-game = create-new-game(3);
$play-game();
$play-game();
$play-game();

#`<<<
x. object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure can store dynamic data type and dynamic value
>>>
my %my-object-v1 = (
    "my_string" => "foo",
    "my_number" => 123,
    "my_boolean" => True,
    "my_null" => Nil,
    "my_array" => (1, 2, 3),
    "my_object" => %(
        "foo" => "bar"
    )
);
print("my-object-v1: {json-stringify(%my-object-v1, :pretty(True))}", "\n");
my $my-object-v2 = {
    "my_string" => "foo",
    "my_number" => 123,
    "my_boolean" => True,
    "my_null" => Nil,
    "my_array" => (1, 2, 3),
    "my_object" => %(
        "foo" => "bar"
    )
};
print("my-object-v2: {json-stringify($my-object-v2, :pretty(True))}", "\n");
my $my-object-v3 = %(
    "my_string" => "foo",
    "my_number" => 123,
    "my_boolean" => True,
    "my_null" => Nil,
    "my_array" => (1, 2, 3),
    "my_object" => %(
        "foo" => "bar"
    )
);
print("my-object-v3: {json-stringify($my-object-v3, :pretty(True))}", "\n");

#`<<<
x. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
>>>
my $my-array-v1 = ["foo", 123, True, Nil, (1, 2, 3), %("foo" => "bar")];
print("my-array-v2 : {json-stringify($my-array-v1 , :pretty(True))}", "\n");
my @my-array-v2 = ("foo", 123, True, Nil, (1, 2, 3), %("foo" => "bar"));
print("my-array-v1 : {json-stringify(@my-array-v2 , :pretty(True))}", "\n");
my $my-array-v3 = ("foo", 123, True, Nil, (1, 2, 3), %("foo" => "bar"));
print("my-array-v1 : {json-stringify($my-array-v3 , :pretty(True))}", "\n");

#`<<<
x. support passing functions as arguments to other functions
>>>
sub say-hello-v1($callback-function) {
    print("hello", "\n");
    $callback-function();
}
sub say-hello-v2(&callback-function) {
    print("hello", "\n");
    &callback-function();
}
sub say-how-are-you() {
    print("how are you?", "\n");
}
say-hello-v1(&say-how-are-you);
say-hello-v2(&say-how-are-you);
say-hello-v1(sub () {
    print("how are you?", "\n");
});
say-hello-v2(sub () {
    print("how are you?", "\n");
});

#`<<<
x. support returning functions as values from other functions
>>>
sub multiply($a) {
    return sub ($b) {
        return ($a * $b);
    };
}
my $multiplyBy2 = multiply(2);
my $multiplyBy2Result = $multiplyBy2(10);
print("multiplyBy2Result: {$multiplyBy2Result}", "\n");

#`<<<
x. support assigning functions to variables
>>>
my $get-rectangle-area-v1 = sub ($rectangle-width, $rectangle-length) {
    return ($rectangle-width * $rectangle-length);
};
print("get-rectangle-area-v1(7, 5): {$get-rectangle-area-v1(7, 5)}", "\n");
my $get-rectangle-area-v2 = sub ($rectangle-width, $rectangle-length) { ($rectangle-width * $rectangle-length) };
print("get-rectangle-area-v2(7, 5): {$get-rectangle-area-v2(7, 5)}", "\n");
my &get-rectangle-area-v3 = sub ($rectangle-width, $rectangle-length) {
    return ($rectangle-width * $rectangle-length);
};
print("get-rectangle-area-v3(7, 5): {&get-rectangle-area-v3(7, 5)}", "\n");
my &get-rectangle-area-v4 = sub ($rectangle-width, $rectangle-length) { ($rectangle-width * $rectangle-length) };
print("get-rectangle-area-v4(7, 5): {&get-rectangle-area-v4(7, 5)}", "\n");
my $get-rectangle-area-v5 = -> $rectangle-width, $rectangle-length { ($rectangle-width * $rectangle-length) };
print("get-rectangle-area-v5(7, 5): {$get-rectangle-area-v5(7, 5)}", "\n");
my &get-rectangle-area-v6 = -> $rectangle-width, $rectangle-length { ($rectangle-width * $rectangle-length) };
print("get-rectangle-area-v6(7, 5): {&get-rectangle-area-v6(7, 5)}", "\n");

#`<<<
x. support storing functions in data structures like object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure or array/list/slice/ordered-list-data-structure
>>>
my @my-array2-v1 = (
    sub ($a, $b) {
        return ($a * $b);
    },
    "foo",
    123,
    True,
    Nil,
    (1, 2, 3),
    %("foo" => "bar")
);
print("myArray2[0](7, 5): {@my-array2-v1[0](7, 5)}", "\n");
my $my-array2-v2 = [
    sub ($a, $b) {
        return ($a * $b);
    },
    "foo",
    123,
    True,
    Nil,
    (1, 2, 3),
    %("foo" => "bar")
];
print("myArray2[0](7, 5): {$my-array2-v2[0](7, 5)}", "\n");
my %my-object2-v1 = (
    "my_function" => sub ($a, $b) {
        return ($a * $b);
    },
    "my_string" => "foo",
    "my_number" => 123,
    "my_boolean" => True,
    "my_null" => Nil,
    "my_array" => (1, 2, 3),
    "my_object" => %(
        "foo" => "bar"
    )
);
print("myObject2[\"my_function\"](7, 5): ", %my-object2-v1{"my_function"}(7, 5), "\n");
my $my-object2-v2 = {
    "my_function" => sub ($a, $b) {
        return ($a * $b);
    },
    "my_string" => "foo",
    "my_number" => 123,
    "my_boolean" => True,
    "my_null" => Nil,
    "my_array" => (1, 2, 3),
    "my_object" => %(
        "foo" => "bar"
    )
};
print("myObject2[\"my_function\"](7, 5): ", $my-object2-v2{"my_function"}(7, 5), "\n");
my %my-object2-v3 = %(
    "my_function" => sub ($a, $b) {
        return ($a * $b);
    },
    "my_string" => "foo",
    "my_number" => 123,
    "my_boolean" => True,
    "my_null" => Nil,
    "my_array" => (1, 2, 3),
    "my_object" => %(
        "foo" => "bar"
    )
);
print("myObject2[\"my_function\"](7, 5): ", %my-object2-v3{"my_function"}(7, 5), "\n");
