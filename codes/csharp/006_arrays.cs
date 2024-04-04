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

        int ArrayItemIndex = 0;

        // in C#, JavaScript-like Array is called List

        dynamic Fruits = new List<dynamic>() {"apple", "mango", "orange"};
        Console.WriteLine($"Fruits: {JsonStringify(Fruits)}");

        Console.WriteLine($"Fruits, length: {Fruits.Count}");
        // Fruits, length: 3

        Console.WriteLine($"Fruits, get mango: {Fruits[1]}");
        // Fruits, get mango: mango

        Console.WriteLine($"Fruits, first element: {Fruits[0]}");
        // Fruits, first element: apple

        Console.WriteLine($"Fruits, last element: {Fruits[Fruits.Count - 1]}");
        // Fruits, last element: orange

        foreach (dynamic ArrayItem in (List<dynamic>)Fruits) {
            Console.WriteLine($"Fruits, forEach loop, index: {ArrayItemIndex}, value: {ArrayItem}");
            ArrayItemIndex += 1;
        }
        // Fruits, forEach loop, index: 0, value: apple
        // Fruits, forEach loop, index: 1, value: mango
        // Fruits, forEach loop, index: 2, value: orange

        // in C#, JavaScript-like Array of Objects is called List of Dictionaries

        dynamic Products = new List<dynamic>() {
            new Dictionary<string, dynamic>() {
                {"id", "P1"},
                {"name", "bubble gum"}
            },
            new Dictionary<string, dynamic>() {
                {"id", "P2"},
                {"name", "potato chips"}
            }
        };
        Console.WriteLine($"Products: {JsonStringify(Products, Pretty: true)}");

        foreach (dynamic ArrayItem in (List<dynamic>)Products) {
            int ObjectIterationIndex = 0;
            foreach (KeyValuePair<string, dynamic> ObjectEntry in (Dictionary<string, dynamic>)ArrayItem) {
                string ObjectKey = ObjectEntry.Key;
                dynamic ObjectValue = ObjectEntry.Value;
                Console.WriteLine($"Products, forEach loop, array item index: {ArrayItemIndex}, object iteration/entry index: {ObjectIterationIndex}, key: {ObjectKey}, value: {ObjectValue}");
                ObjectIterationIndex += 1;
            }
            ArrayItemIndex += 1;
        }
        // Products, forEach loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
        // Products, forEach loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
        // Products, forEach loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
        // Products, forEach loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips
    }
}
