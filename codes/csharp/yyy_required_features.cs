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
x. variable can store dynamic data type and dynamic value, variable can inferred data type from value, value of variable can be reassign with different data type or has option to make variable can store dynamic data type and dynamic value
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
x. it is possible to access and modify variables defined outside of the current scope within nested functions, so it is possible to have closure too
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
x. object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure can store dynamic data type and dynamic value
        */
        dynamic MyObject = new Dictionary<string, dynamic>() {
            {"my_string", "foo"},
            {"my_number", 123},
            {"my_boolean", true},
            {"my_null", null},
            {"my_array", new List<dynamic>() {1, 2, 3}},
            {"my_object", new Dictionary<string, dynamic>() {
                { "foo", "bar" }
            }}
        };
        Console.WriteLine("MyObject: " + JsonStringify(MyObject, Pretty: true));

        /*
x. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
        */
        dynamic MyArray = new List<dynamic>() {"foo", 123, true, null, new List<dynamic>() {1, 2, 3}, new Dictionary<string, dynamic>() {{"foo", "bar"}}};
        Console.WriteLine("MyArray: " + JsonStringify(MyArray, Pretty: true));

        /*
x. support passing functions as arguments to other functions
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
x. support returning functions as values from other functions
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
x. support assigning functions to variables
        */
        dynamic GetRectangleAreaV1 = (Func<dynamic, dynamic, dynamic>)((dynamic RectangleWidth, dynamic RectangleLength) => {
            return (RectangleWidth * RectangleLength);
        });
        Console.WriteLine("GetRectangleAreaV1(7, 5): " + GetRectangleAreaV1(7, 5));
        dynamic GetRectangleAreaV2 = (Func<dynamic, dynamic, dynamic>)((dynamic RectangleWidth, dynamic RectangleLength) => (RectangleWidth * RectangleLength));
        Console.WriteLine("GetRectangleAreaV2(7, 5): " + GetRectangleAreaV2(7, 5));

        /*
x. support storing functions in data structures like object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure or array/list/slice/ordered-list-data-structure
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
            {"my_boolean", true},
            {"my_null", null},
            {"my_array", new List<dynamic>() {1, 2, 3}},
            {"my_object", new Dictionary<string, dynamic>() {
                { "foo", "bar" }
            }}
        };
        Console.WriteLine("myObject2[\"my_function\"](7, 5): " + MyObject2["my_function"](7, 5));
    }
}
