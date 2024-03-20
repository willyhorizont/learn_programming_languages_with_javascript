using System; // Console, Func<>, Action<>, Action
using System.Linq; // Enumerable
using System.Collections.Generic; // Dictionary<>, List<>, KeyValuePair<>, IEnumerable<>

class Program {
    static void Main(string[] Args) {
        dynamic IsNumeric = (Func<dynamic, bool>)((dynamic Anything) => (Anything is sbyte || Anything is byte || Anything is short || Anything is ushort || Anything is int || Anything is uint || Anything is long || Anything is ulong || Anything is float || Anything is double || Anything is decimal));

        string PrettyJsonStringify(dynamic Anything, string Indent = "    ") {
            int IndentLevel = 0;
            dynamic PrettyJsonStringifyInner = null;
            PrettyJsonStringifyInner = (Func<dynamic, string, string>)((dynamic AnythingInner, string IndentInner) => {
                if (AnythingInner == null) {
                    return "null";
                }
                if (AnythingInner is string) {
                    return "\"" + (string)AnythingInner + "\"";
                }
                if (IsNumeric(AnythingInner) || AnythingInner is bool) {
                    return AnythingInner.ToString().Replace(",", ".");
                }
                if (AnythingInner is List<dynamic>) {
                    IndentLevel += 1;
                    string Result = "[" + Environment.NewLine + string.Concat(Enumerable.Repeat(IndentInner, IndentLevel));
                    int ArrayItemIndex = 0;
                    foreach (dynamic ArrayItem in (List<dynamic>)AnythingInner) {
                        Result += PrettyJsonStringifyInner(ArrayItem, IndentInner);
                        if ((ArrayItemIndex + 1) != ((List<dynamic>)AnythingInner).Count) {
                            Result += "," + Environment.NewLine + string.Concat(Enumerable.Repeat(IndentInner, IndentLevel));
                        }
                        ArrayItemIndex += 1;
                    }
                    IndentLevel -= 1;
                    Result += Environment.NewLine + string.Concat(Enumerable.Repeat(IndentInner, IndentLevel)) + "]";
                    return Result;
                }
                if (AnythingInner is Dictionary<string, dynamic>) {
                    IndentLevel += 1;
                    string Result = "{" + Environment.NewLine + string.Concat(Enumerable.Repeat(IndentInner, IndentLevel));
                    int IterationIndex = 0;
                    foreach (KeyValuePair<string, dynamic> ObjectEntry in (Dictionary<string, dynamic>)AnythingInner) {
                        string ObjectKey = ObjectEntry.Key;
                        dynamic ObjectValue = ObjectEntry.Value;
                        Result += "\"" + ObjectKey + "\": " + PrettyJsonStringifyInner(ObjectValue, IndentInner);
                        if ((IterationIndex + 1) != ((Dictionary<string, dynamic>)AnythingInner).Count) {
                            Result += "," + Environment.NewLine + string.Concat(Enumerable.Repeat(IndentInner, IndentLevel));
                        }
                        IterationIndex += 1;
                    }
                    IndentLevel -= 1;
                    Result += Environment.NewLine + string.Concat(Enumerable.Repeat(IndentInner, IndentLevel)) + "}";
                    return Result;
                }
                return "null";
            });
            return PrettyJsonStringifyInner(Anything, Indent);
        }

        Console.WriteLine("\n// JavaScript-like Optional Chaining Operator (?.) in C#");

        // There's no JavaScript-like Optional Chaining Operator (?.) in C#.
        // But, we can create our own function to mimic it in C#.

        dynamic OptionalChainingV1(dynamic Anything, params dynamic[] ObjectPropertiesArray) {
            // JavaScript-like Optional Chaining Operator (?.) function
            if (((Anything is Dictionary<string, dynamic>) == false) && ((Anything is List<dynamic>) == false) || (ObjectPropertiesArray.Length == 0)) return Anything;
            return ObjectPropertiesArray.Aggregate(null, (Func<dynamic, dynamic, dynamic>)((dynamic CurrentResult, dynamic CurrentItem) => {
                if ((CurrentResult == null) && (Anything is Dictionary<string, dynamic>) && (CurrentItem is string)) return (Anything.ContainsKey(CurrentItem) ? Anything[CurrentItem] : null);
                if ((CurrentResult == null) && (Anything is List<dynamic>) && (CurrentItem is int) && (CurrentItem >= 0) && (Anything.Count > CurrentItem)) return Anything[CurrentItem];
                if ((CurrentResult is Dictionary<string, dynamic>) && (CurrentItem is string)) return (CurrentResult.ContainsKey(CurrentItem) ? CurrentResult[CurrentItem] : null);
                if ((CurrentResult is List<dynamic>) && (CurrentItem is int) && (CurrentItem >= 0) && (CurrentResult.Count > CurrentItem)) return CurrentResult[CurrentItem];
                return null;
            }));
        }

        dynamic OptionalChainingV2(dynamic Anything, params dynamic[] ObjectPropertiesArray) {
            // JavaScript-like Optional Chaining Operator (?.) function
            return ((((Anything is Dictionary<string, dynamic>) == false) && ((Anything is List<dynamic>) == false) || (ObjectPropertiesArray.Length == 0))
                ? Anything
                : (ObjectPropertiesArray.Aggregate(null, (Func<dynamic, dynamic, dynamic>)((dynamic CurrentResult, dynamic CurrentItem) => (((CurrentResult == null) && (Anything is Dictionary<string, dynamic>) && (CurrentItem is string))
                    ? (Anything.ContainsKey(CurrentItem) ? Anything[CurrentItem] : null)
                    : (((CurrentResult == null) && (Anything is List<dynamic>) && (CurrentItem is int) && (CurrentItem >= 0) && (Anything.Count > CurrentItem)) 
                        ? Anything[CurrentItem]
                        : (((CurrentResult is Dictionary<string, dynamic>) && (CurrentItem is string))
                            ? (CurrentResult.ContainsKey(CurrentItem) ? CurrentResult[CurrentItem] : null)
                            : (((CurrentResult is List<dynamic>) && (CurrentItem is int) && (CurrentItem >= 0) && (CurrentResult.Count > CurrentItem))
                                ? CurrentResult[CurrentItem]
                                : null
                            )
                        )
                    )
                ))))
            );
        }

        dynamic JSON_OBJECT = new Dictionary<string, dynamic>() {
            {"foo", new Dictionary<string, dynamic>() {
                {"bar", "baz"}
            }},
            {"fruits", new List<dynamic>() {"apple", "mango", "banana"}}
        };
        Console.WriteLine($"JSON_OBJECT: {PrettyJsonStringify(JSON_OBJECT)}");

        Console.WriteLine("// using JavaScript-like Optional Chaining Operator (?.) function \"OptionalChainingV1\"");

        Console.WriteLine($"JSON_OBJECT?.foo?.bar: {PrettyJsonStringify(OptionalChainingV1(JSON_OBJECT, "foo", "bar"))}");
        // JSON_OBJECT?.foo?.bar: "baz"

        Console.WriteLine($"JSON_OBJECT?.foo?.baz: {PrettyJsonStringify(OptionalChainingV1(JSON_OBJECT, "foo", "baz"))}");
        // JSON_OBJECT?.foo?.baz: null

        Console.WriteLine($"JSON_OBJECT?.fruits?.[2]: {PrettyJsonStringify(OptionalChainingV1(JSON_OBJECT, "fruits", 2))}");
        // JSON_OBJECT?.fruits?.[2]: "banana"

        Console.WriteLine($"JSON_OBJECT?.fruits?.[5]: {PrettyJsonStringify(OptionalChainingV1(JSON_OBJECT, "fruits", 5))}");
        // JSON_OBJECT?.fruits?.[5]: null

        Console.WriteLine("// using JavaScript-like Optional Chaining Operator (?.) function \"OptionalChainingV2\"");

        Console.WriteLine($"JSON_OBJECT?.foo?.bar: {PrettyJsonStringify(OptionalChainingV2(JSON_OBJECT, "foo", "bar"))}");
        // JSON_OBJECT?.foo?.bar: "baz"

        Console.WriteLine($"JSON_OBJECT?.foo?.baz: {PrettyJsonStringify(OptionalChainingV2(JSON_OBJECT, "foo", "baz"))}");
        // JSON_OBJECT?.foo?.baz: null

        Console.WriteLine($"JSON_OBJECT?.fruits?.[2]: {PrettyJsonStringify(OptionalChainingV2(JSON_OBJECT, "fruits", 2))}");
        // JSON_OBJECT?.fruits?.[2]: "banana"

        Console.WriteLine($"JSON_OBJECT?.fruits?.[5]: {PrettyJsonStringify(OptionalChainingV2(JSON_OBJECT, "fruits", 5))}");
        // JSON_OBJECT?.fruits?.[5]: null
    }
}
