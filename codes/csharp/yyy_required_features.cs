using System; // Console, Func<>, Action<>, Action
using System.Linq; // Enumerable
using System.Collections.Generic; // Dictionary<>, List<>, KeyValuePair<>, IEnumerable<>

class Program {
    static void Main(string[] Args) {
        dynamic IsNumeric = (Func<dynamic, bool>)((dynamic Anything) => (Anything is sbyte || Anything is byte || Anything is short || Anything is ushort || Anything is int || Anything is uint || Anything is long || Anything is ulong || Anything is float || Anything is double || Anything is decimal));

        string JsonStringify(dynamic Anything, bool Pretty = false, string Indent = "    ") {
            int IndentLevel = 0;
            string JsonStringifyInner(dynamic AnythingInner, string IndentInner) {
                if (AnythingInner == null) return "null";
                if (AnythingInner is string) return "\"" + (string)AnythingInner + "\"";
                if ((IsNumeric(AnythingInner) == true) || AnythingInner is bool) return AnythingInner.ToString().Replace(",", ".");
                if (AnythingInner is List<dynamic>) {
                    IndentLevel += 1;
                    string Result = ((Pretty == true) ? ("[" + Environment.NewLine + string.Concat(Enumerable.Repeat(IndentInner, IndentLevel))) : "[");
                    int ArrayItemIndex = 0;
                    foreach (dynamic ArrayItem in (List<dynamic>)AnythingInner) {
                        Result += JsonStringifyInner(ArrayItem, IndentInner);
                        if ((ArrayItemIndex + 1) != ((List<dynamic>)AnythingInner).Count) Result += ((Pretty == true) ? ("," + Environment.NewLine + string.Concat(Enumerable.Repeat(IndentInner, IndentLevel))) : ", ");
                        ArrayItemIndex += 1;
                    }
                    IndentLevel -= 1;
                    Result += ((Pretty == true) ? (Environment.NewLine + string.Concat(Enumerable.Repeat(IndentInner, IndentLevel)) + "]") : "]");
                    return Result;
                }
                if (AnythingInner is Dictionary<string, dynamic>) {
                    IndentLevel += 1;
                    string Result = ((Pretty == true) ? ("{" + Environment.NewLine + string.Concat(Enumerable.Repeat(IndentInner, IndentLevel))) : "{");
                    int ObjectIterationIndex = 0;
                    foreach (KeyValuePair<string, dynamic> ObjectEntry in (Dictionary<string, dynamic>)AnythingInner) {
                        string ObjectKey = ObjectEntry.Key;
                        dynamic ObjectValue = ObjectEntry.Value;
                        Result += "\"" + ObjectKey + "\": " + JsonStringifyInner(ObjectValue, IndentInner);
                        if ((ObjectIterationIndex + 1) != ((Dictionary<string, dynamic>)AnythingInner).Count) Result += ((Pretty == true) ? ("," + Environment.NewLine + string.Concat(Enumerable.Repeat(IndentInner, IndentLevel))) : ", ");
                        ObjectIterationIndex += 1;
                    }
                    IndentLevel -= 1;
                    Result += ((Pretty == true) ? (Environment.NewLine + string.Concat(Enumerable.Repeat(IndentInner, IndentLevel)) + "}") : "}");
                    return Result;
                }
                return "null";
            };
            return JsonStringifyInner(Anything, Indent);
        }

        /*
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
        */
        dynamic Something = "foo";
        Console.WriteLine("Something: " + JsonStringify(Something, Pretty: true));
        Something = 123;
        Console.WriteLine("Something: " + JsonStringify(Something, Pretty: true));
        Something = true;
        Console.WriteLine("Something: " + JsonStringify(Something, Pretty: true));
        Something = null;
        Console.WriteLine("Something: " + JsonStringify(Something, Pretty: true));
        Something = new List<dynamic>() {1, 2, 3};
        Console.WriteLine("Something: " + JsonStringify(Something, Pretty: true));
        Something = new Dictionary<string, dynamic>() {{"foo", "bar"}};
        Console.WriteLine("Something: " + JsonStringify(Something, Pretty: true));

        /*
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
        */
        dynamic GetModifiedIndentLevel = (Func<dynamic>)(() => {
            int IndentLevel = 0;
            dynamic ChangeIndentLevel = null;
            ChangeIndentLevel = (Func<dynamic>)(() => {
                IndentLevel += 1;
                if (IndentLevel < 5) {
                    ChangeIndentLevel();
                }
                return IndentLevel;
            });
            return ChangeIndentLevel();
        });
        Console.WriteLine("GetModifiedIndentLevel(): " + GetModifiedIndentLevel());
        dynamic CreateNewGame = (Func<dynamic, Action>)((dynamic InitialCredit) => {
            int CurrentCredit = InitialCredit;
            Console.WriteLine("initial credit: " + InitialCredit);
            return () => {
                CurrentCredit -= 1;
                if (CurrentCredit == 0) {
                    Console.WriteLine("not enough credits");
                    return;
                }
                Console.WriteLine($"playing game, {CurrentCredit} credit(s) remaining");
            };
        });
        dynamic PlayGame = CreateNewGame(3);
        PlayGame();
        PlayGame();
        PlayGame();

        /*
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
        */
        dynamic MyObject = new Dictionary<string, dynamic>() {
            {"my_string", "foo"},
            {"my_number", 123},
            {"my_bool", true},
            {"my_null", null},
            {"my_array", new List<dynamic>() {1, 2, 3}},
            {"my_object", new Dictionary<string, dynamic>() {
                { "foo", "bar" }
            }}
        };
        Console.WriteLine("MyObject: " + JsonStringify(MyObject, Pretty: true));

        /*
4. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
```javascript
const myArray = ["foo", 123, true, null, [1, 2, 3], { "foo": "bar" }];
console.log(`myArray: ${myArray}`);
```
        */
        dynamic MyArray = new List<dynamic>() {"foo", 123, true, null, new List<dynamic>() {1, 2, 3}, new Dictionary<string, dynamic>() {{"foo", "bar"}}};
        Console.WriteLine("MyArray: " + JsonStringify(MyArray, Pretty: true));

        /*
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
        */
        void SayHello(Action CallbackFunction) {
            Console.WriteLine("hello");
            CallbackFunction();
        }
        void SayHowAreYou() {
            Console.WriteLine("how are you?");
        }
        SayHello(SayHowAreYou);
        SayHello((Action)(() => {
            Console.WriteLine("how are you?");
        }));

        /*
6. support returning functions as values from other functions
```javascript
function multiply(a) {
    return function (b) {
        return (a * b);
    };
}
const multiplyBy2 = multiply(2);
const multiplyBy2Result = multiplyBy2(10);
console.log(`multiplyBy2(10): ${multiplyBy2Result}`);
```
        */
        dynamic Multiply = (Func<dynamic, Func<dynamic, dynamic>>)((dynamic A) => {
            return (Func<dynamic, dynamic>)((dynamic B) => {
                return (A * B);
            });
        });
        dynamic MultiplyBy2 = (Func<dynamic, dynamic>)Multiply(2);
        dynamic MultiplyBy2Result = MultiplyBy2(10);
        Console.WriteLine("MultiplyBy2Result: " + MultiplyBy2Result);

        /*
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
        */
        dynamic GetRectangleAreaV1 = (Func<dynamic, dynamic, dynamic>)((dynamic RectangleWidth, dynamic RectangleLength) => {
            return (RectangleWidth * RectangleLength);
        });
        Console.WriteLine("GetRectangleAreaV1(7, 5): " + GetRectangleAreaV1(7, 5));
        dynamic GetRectangleAreaV2 = (Func<dynamic, dynamic, dynamic>)((dynamic RectangleWidth, dynamic RectangleLength) => (RectangleWidth * RectangleLength));
        Console.WriteLine("GetRectangleAreaV2(7, 5): " + GetRectangleAreaV2(7, 5));

        /*
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
        */
        dynamic MyArray2 = new List<dynamic>() {
            (Func<dynamic, dynamic, dynamic>)((dynamic A, dynamic B) => {
                return (A * B);
            }),
            "foo",
            123,
            true,
            null,
            new List<dynamic>() {1, 2, 3},
            new Dictionary<string, dynamic>() {{"foo", "bar"}}
        };
        Console.WriteLine("myArray2[0](7, 5): " + MyArray2[0](7, 5));
        dynamic MyObject2 = new Dictionary<string, dynamic>() {
            {"my_function", (Func<dynamic, dynamic, dynamic>)((dynamic A, dynamic B) => {
                return (A * B);
            })},
            {"my_string", "foo"},
            {"my_number", 123},
            {"my_bool", true},
            {"my_null", null},
            {"my_array", new List<dynamic>() {1, 2, 3}},
            {"my_object", new Dictionary<string, dynamic>() {
                { "foo", "bar" }
            }}
        };
        Console.WriteLine("myObject2[\"my_function\"](7, 5): " + MyObject2["my_function"](7, 5));
    }
}
