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
                if ((IsNumeric(AnythingInner) == true) || AnythingInner is bool) {
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

        dynamic OptionalChainingV2(dynamic Anything, params dynamic[] ObjectPropertiesArray) {
            // JavaScript-like Optional Chaining Operator (?.) function
            return ((((Anything is Dictionary<string, dynamic>) == false) && ((Anything is List<dynamic>) == false) || (ObjectPropertiesArray.Length == 0))
                ? Anything
                : (ObjectPropertiesArray.Aggregate(null, (Func<dynamic, dynamic, dynamic>)((dynamic CurrentResult, dynamic CurrentItem) => (((CurrentResult == null) && (Anything is Dictionary<string, dynamic>) && (CurrentItem is string))
                    ? (Anything.ContainsKey(CurrentItem) ? Anything[CurrentItem] : null)
                    : (((CurrentResult == null) && (Anything is List<dynamic>) && (IsNumeric(CurrentItem) == true) && (CurrentItem >= 0) && (Anything.Count > CurrentItem)) 
                        ? Anything[CurrentItem]
                        : (((CurrentResult is Dictionary<string, dynamic>) && (CurrentItem is string))
                            ? (CurrentResult.ContainsKey(CurrentItem) ? CurrentResult[CurrentItem] : null)
                            : (((CurrentResult is List<dynamic>) && (IsNumeric(CurrentItem) == true) && (CurrentItem >= 0) && (CurrentResult.Count > CurrentItem))
                                ? CurrentResult[CurrentItem]
                                : null
                            )
                        )
                    )
                ))))
            );
        }

        Console.WriteLine("\n// JavaScript-like Nullish Coalescing Operator (??) in C#");

        dynamic JSON_OBJECT = new Dictionary<string, dynamic>() {
            {"foo", new Dictionary<string, dynamic>() {
                {"bar", "baz"}
            }},
            {"fruits", new List<dynamic>() {"apple", "mango", "banana"}}
        };
        Console.WriteLine($"JSON_OBJECT: {PrettyJsonStringify(JSON_OBJECT)}");

        Console.WriteLine($"(JSON_OBJECT?.foo?.bar ?? 'not found') or (JSON_OBJECT?.['foo']?.['bar'] ?? 'not found'): {PrettyJsonStringify(OptionalChainingV2(JSON_OBJECT, "foo", "bar") ?? "not found")}");
        // (JSON_OBJECT?.foo?.bar ?? 'not found') or (JSON_OBJECT?.['foo']?.['bar'] ?? 'not found'): "baz"

        Console.WriteLine($"(JSON_OBJECT?.foo?.baz ?? 'not found') or (JSON_OBJECT?.['foo']?.['baz'] ?? 'not found'): {PrettyJsonStringify(OptionalChainingV2(JSON_OBJECT, "foo", "baz") ?? "not found")}");
        // (JSON_OBJECT?.foo?.baz ?? 'not found') or (JSON_OBJECT?.['foo']?.['baz'] ?? 'not found'): "not found"

        Console.WriteLine($"(JSON_OBJECT?.fruits?.[2] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[2] ?? 'not found'): {PrettyJsonStringify(OptionalChainingV2(JSON_OBJECT, "fruits", 2) ?? "not found")}");
        // (JSON_OBJECT?.fruits?.[2] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[2] ?? 'not found'): "banana"

        Console.WriteLine($"(JSON_OBJECT?.fruits?.[5] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[5] ?? 'not found'): {PrettyJsonStringify(OptionalChainingV2(JSON_OBJECT, "fruits", 5) ?? "not found")}");
        // (JSON_OBJECT?.fruits?.[5] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[5] ?? 'not found'): "not found"
    }
}
