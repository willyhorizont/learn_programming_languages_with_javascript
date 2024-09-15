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
1. variable can store dynamic data type and dynamic value, variable can inferred data type from value, value of variable can be reassign with different data type or has option to make variable can store dynamic data type and dynamic value
```javascript
let something = "foo";
console.log(`something: ${something}`);
something = 123;
console.log(`something: ${something}`);
something = true;
console.log(`something: ${something}`);
something = null;
console.log(`something: ${something}`);
something = [1, 2, 3];
console.log(`something: ${something}`);
something = { "foo": "bar" };
console.log(`something: ${something}`);
```
```go
type Any interface{}
```
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
2. it is possible to access and modify variables defined outside of the current scope within nested functions, so it is possible to have closure too
```javascript
function getModifiedIndentLevel() {
    let indentLevel = 0;
    function changeIndentLevel() {
        indentLevel += 1;
        if (indentLevel < 5) changeIndentLevel();
        return indentLevel;
    }
    return changeIndentLevel();
}
console.log(`getModifiedIndentLevel(): ${getModifiedIndentLevel()}`);
function createNewGame(initialCredit) {
    let currentCredit = initialCredit;
    console.log(`initial credit: ${initialCredit}`);
    return function () {
        currentCredit -= 1;
        if (currentCredit === 0) {
            console.log("not enough credits");
            return;
        }
        console.log(`playing game, ${currentCredit} credit(s) remaining`);
    };
}
const playGame = createNewGame(3);
playGame();
playGame();
playGame();
```
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
3. object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure can store dynamic data type and dynamic value
```javascript
const myObject = {
    "my_string": "foo",
    "my_number": 123,
    "my_bool": true,
    "my_null": null,
    "my_array": [1, 2, 3],
    "my_object": {
        "foo": "bar"
    }
};
console.log(`myObject: ${myObject}`);
```
>>>
my %my-object-v1 = (
    "my_string" => "foo",
    "my_number" => 123,
    "my_bool" => True,
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
    "my_bool" => True,
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
    "my_bool" => True,
    "my_null" => Nil,
    "my_array" => (1, 2, 3),
    "my_object" => %(
        "foo" => "bar"
    )
);
print("my-object-v3: {json-stringify($my-object-v3, :pretty(True))}", "\n");

#`<<<
4. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
```javascript
const myArray = ["foo", 123, true, null, [1, 2, 3], { "foo": "bar" }];
console.log(`myArray: ${myArray}`);
```
>>>
my $my-array-v1 = ["foo", 123, True, Nil, (1, 2, 3), %("foo" => "bar")];
print("my-array-v2 : {json-stringify($my-array-v1 , :pretty(True))}", "\n");
my @my-array-v2 = ("foo", 123, True, Nil, (1, 2, 3), %("foo" => "bar"));
print("my-array-v1 : {json-stringify(@my-array-v2 , :pretty(True))}", "\n");
my $my-array-v3 = ("foo", 123, True, Nil, (1, 2, 3), %("foo" => "bar"));
print("my-array-v1 : {json-stringify($my-array-v3 , :pretty(True))}", "\n");

#`<<<
5. support passing functions as arguments to other functions
```javascript
function sayHello(callbackFunction) {
    console.log("hello");
    callbackFunction();
}
function sayHowAreYou() {
    console.log("how are you?");
}
sayHello(sayHowAreYou);
sayHello(function () {
    console.log("how are you?");
});
```
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
6. support returning functions as values from other functions
```javascript
function multiply(a) {
    return function (b) {
        return (a * b);
    };
}
const multiplyBy2 = multiply(2);
const multiplyBy2Result = multiplyBy2(10);
console.log(`multiplyBy2Result: ${multiplyBy2Result}`);
```
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
7. support assigning functions to variables
```javascript
const getRectangleAreaV1 = function (rectangleWidth, rectangleLength) {
    return (rectangleWidth * rectangleLength);
};
console.log(`getRectangleAreaV1(7, 5): ${getRectangleAreaV1(7, 5)}`);
const getRectangleAreaV2 = (rectangleWidth, rectangleLength) => {
    return (rectangleWidth * rectangleLength);
};
console.log(`getRectangleAreaV2(7, 5): ${getRectangleAreaV2(7, 5)}`);
const getRectangleAreaV3 = (rectangleWidth, rectangleLength) => (rectangleWidth * rectangleLength);
console.log(`getRectangleAreaV3(7, 5): ${getRectangleAreaV3(7, 5)}`);
```
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
8. support storing functions in data structures like array/list/slice/ordered-list-data-structure or object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure
```javascript
const myArray2 = [
    function (a, b) {
        return (a * b);
    },
    "foo",
    123,
    true,
    null,
    [1, 2, 3],
    { "foo": "bar" }
];
console.log(`myArray2[0](7, 5): ${myArray2[0](7, 5)}`);
const myObject2 = {
    "my_function": function (a, b) {
        return (a * b);
    },
    "my_string": "foo",
    "my_number": 123,
    "my_bool": true,
    "my_null": null,
    "my_array": [1, 2, 3],
    "my_object": {
        "foo": "bar"
    }
};
console.log(`myObject2["my_function"](7, 5): ${myObject2["my_function"](7, 5)}`);
```
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
    "my_bool" => True,
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
    "my_bool" => True,
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
    "my_bool" => True,
    "my_null" => Nil,
    "my_array" => (1, 2, 3),
    "my_object" => %(
        "foo" => "bar"
    )
);
print("myObject2[\"my_function\"](7, 5): ", %my-object2-v3{"my_function"}(7, 5), "\n");
