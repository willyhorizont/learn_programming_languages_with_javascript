using System;
using System.Linq;
using System.Collections.Generic;

class Program {
    static void Main(string[] args) {
        Func<dynamic, bool> IsNumericV1 = (dynamic Anything) => (Anything is sbyte || Anything is byte || Anything is short || Anything is ushort || Anything is int || Anything is uint || Anything is long || Anything is ulong || Anything is float || Anything is double || Anything is decimal);
        Func<dynamic, bool> IsNumericV2 = (dynamic Anything) => double.TryParse(Anything?.ToString(), out double _);
        Func<dynamic, string> PrettyJsonStringify = (dynamic Anything) => {
            string Indent = "    ";
            int IndentLevel = 0;
            Func<dynamic, string> PrettyJsonStringifyInner = null;
            PrettyJsonStringifyInner = (dynamic AnythingInner) => {
                if (AnythingInner == null) {
                    return "undefined";
                }
                if (AnythingInner is string && (string)AnythingInner == "null") {
                    return "null";
                }
                if (AnythingInner is string && (string)AnythingInner == "undefined") {
                    return "undefined";
                }
                if (AnythingInner is string) {
                    return "\"" + (string)AnythingInner + "\"";
                }
                if (IsNumericV1(AnythingInner) || AnythingInner is bool) {
                    return AnythingInner.ToString();
                }
                if (AnythingInner is dynamic[]) {
                    IndentLevel += 1;
                    string Result = "[" + Environment.NewLine + string.Concat(Enumerable.Repeat(Indent, IndentLevel));
                    int ArrayItemIndex = 0;
                    foreach (dynamic ArrayItem in (dynamic[])AnythingInner) {
                        Result += PrettyJsonStringifyInner(ArrayItem);
                        if ((ArrayItemIndex + 1) != ((dynamic[])AnythingInner).Length) {
                            Result += "," + Environment.NewLine + string.Concat(Enumerable.Repeat(Indent, IndentLevel));
                        }
                        ArrayItemIndex += 1;
                    }
                    IndentLevel -= 1;
                    Result += Environment.NewLine + string.Concat(Enumerable.Repeat(Indent, IndentLevel)) + "]";
                    return Result;
                }
                if (AnythingInner is Dictionary<string, dynamic>) {
                    IndentLevel += 1;
                    string Result = "{" + Environment.NewLine + string.Concat(Enumerable.Repeat(Indent, IndentLevel));
                    int IterationIndex = 0;
                    foreach (KeyValuePair<string, dynamic> objectEntry in (Dictionary<string, dynamic>)AnythingInner) {
                        string ObjectKey = objectEntry.Key;
                        dynamic ObjectValue = objectEntry.Value;
                        Result += "\"" + ObjectKey + "\": " + PrettyJsonStringifyInner(ObjectValue);
                        if ((IterationIndex + 1) != ((Dictionary<string, dynamic>)AnythingInner).Count) {
                            Result += "," + Environment.NewLine + string.Concat(Enumerable.Repeat(Indent, IndentLevel));
                        }
                        IterationIndex += 1;
                    }
                    IndentLevel -= 1;
                    Result += Environment.NewLine + string.Concat(Enumerable.Repeat(Indent, IndentLevel)) + "}";
                    return Result;
                }
                return "undefined";
            };
            return PrettyJsonStringifyInner(Anything);
        };
        /*
        1. variable can store dynamic data type and dynamic value, variable can inferred data type from value, value of variable can be reassign with different data type
        ```javascript
        let something = 123;
        console.log("something: ", something);
        something = "foo";
        console.log("something: ", something);
        something = true;
        console.log("something: ", something);
        something = null;
        console.log("something: ", something);
        something = [1, 2, 3];
        console.log("something: ", something);
        something = { "foo": "bar" };
        console.log("something: ", something);
        ```
        */
        dynamic Something = 123;
        Console.WriteLine("Something: " + PrettyJsonStringify(Something));
        Something = "foo";
        Console.WriteLine("Something: " + PrettyJsonStringify(Something));
        Something = true;
        Console.WriteLine("Something: " + PrettyJsonStringify(Something));
        Something = null;
        Console.WriteLine("Something: " + PrettyJsonStringify(Something));
        Something = new dynamic[] { 1, 2, 3 };
        Console.WriteLine("Something: " + PrettyJsonStringify(Something));
        Something = new Dictionary<string, dynamic>() { { "foo", "bar" } };
        Console.WriteLine("Something: " + PrettyJsonStringify(Something));

        /*
        3. object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure can store dynamic data type and dynamic value
        ```javascript
        const myObject = {
            "my_string": "foo",
            "my_number": 123,
            "my_bool": true,
            "my_null": null,
            "my_object": {
                "foo": "bar"
            },
            "my_array": [1, 2, 3],
        }
        ```
        */
        dynamic MyObject = new Dictionary<string, dynamic>() {
            {"my_string", "foo"},
            {"my_number", 123},
            {"my_bool", true},
            {"my_null", null},
            {"my_object", new Dictionary<string, dynamic>() { { "foo", "bar" } }},
            {"my_array", new dynamic[] { 1, 2, 3 }}
        };
        Console.WriteLine("MyObject: " + PrettyJsonStringify(MyObject));

        /*
        4. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
        ```javascript
        const myArray = ["foo", 123, true, null, [1, 2, 3], { "foo": "bar" }];
        console.log("myArray: ", myArray);
        ```
        */
        dynamic MyArray = new dynamic[] { "foo", 123, true, null, new dynamic[] { 1, 2, 3 }, new Dictionary<string, dynamic>() { { "foo", "bar" } } };
        Console.WriteLine("MyArray: " + PrettyJsonStringify(MyArray));

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
        Action<Action> SayHello = (CallbackFunction) => {
            Console.WriteLine("hello");
            CallbackFunction();
        };
        Action SayHowAreYou = () => {
            Console.WriteLine("how are you?");
        };
        SayHello(SayHowAreYou);
        SayHello((Action)(() => {
            Console.WriteLine("how are you?");
        }));

        /*
        6. support returning functions as values from other functions
        ```javascript
        function multiply(a) {
            return function (b) {
                return a * b;
            };
        }
        const multiplyBy2 = multiply(2);
        const multiplyBy2Result = multiplyBy2(10); // 20
        console.log("multiplyBy2Result: ", multiplyBy2Result);
        ```
        */
        Func<int, Func<int, int>> Multiply = (a) => {
            return (b) => {
                return a * b;
            };
        };
        Func<int, int> MultiplyBy2 = Multiply(2);
        int MultiplyBy2Result = MultiplyBy2(10); // 20
        Console.WriteLine("MultiplyBy2Result: " + MultiplyBy2Result);

        /*
        7. support assigning functions to variables
        ```javascript
        const getRectangleArea = function (rectangleWidth, rectangleLength) {
            return rectangleWidth * rectangleLength;
        };
        console.log("getRectangleArea(7, 5): ", getRectangleArea(7, 5));;
        ```
        */
        Func<int, int, int> GetRectangleArea = (RectangleWidth, RectangleLength) => {
            return RectangleWidth * RectangleLength;
        };
        Console.WriteLine("GetRectangleArea(7, 5): " + GetRectangleArea(7, 5));

        /*
        8. support storing functions in data structures like array/list/slice/ordered-list-data-structure or object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure
        ```javascript
        const myArray2 = [
            function (rectangleWidth, rectangleLength) {
                return rectangleWidth * rectangleLength;
            },
            "foo",
            123,
            true,
            null
            [1, 2, 3],
            { "foo": "bar" },
        ];
        console.log("myArray2[0](7, 5): ", myArray2[0](7, 5));

        const myObject2 = {
            "my_function": function (a, b) {
                return a * b;
            },
            "my_string": "foo",
            "my_number": 123,
            "my_bool": true,
            "my_null": null,
            "my_object": {
                "foo": "bar"
            },
            "my_array": [1, 2, 3],
        }
        console.log("myObject2.my_function(7, 5): ", myObject2.my_function(7, 5));
        ```
        */
        dynamic MyArray2 = new dynamic[] {
            (Func<int, int, int>)((a, b) => {
                return a * b;
            }),
            "foo",
            123,
            true,
            null,
            new dynamic[] { 1, 2, 3 },
            new Dictionary<string, dynamic>() { { "foo", "bar" } }
        };
        Console.WriteLine("MyArray2[0](7, 5): " + MyArray2[0](7, 5));

        dynamic MyObject2 = new Dictionary<string, dynamic>() {
            {"my_function", (Func<int, int, int>)((a, b) => {
                return a * b;
            })},
            {"my_string", "foo"},
            {"my_number", 123},
            {"my_bool", true},
            {"my_null", null},
            {"my_object", new Dictionary<string, dynamic>() { { "foo", "bar" } }},
            {"my_array", new dynamic[] { 1, 2, 3 }}
        };
        Console.WriteLine("myObject2.my_function(7, 5): " + MyObject2["my_function"](7, 5));
    }
}
