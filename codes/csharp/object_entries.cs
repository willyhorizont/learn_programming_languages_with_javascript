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

        List<dynamic> ObjectEntries(Dictionary<string, dynamic> AnObject) {
            // JavaScript-like Object.entries() function
            List<dynamic> NewArray = new List<dynamic>();
            foreach (KeyValuePair<string, dynamic> ObjectEntry in (Dictionary<string, dynamic>)AnObject) {
                string ObjectKey = ObjectEntry.Key;
                dynamic ObjectValue = ObjectEntry.Value;
                NewArray.Add(new List<dynamic>() {ObjectKey, ObjectValue});
            }
            return NewArray;
        }

        Console.WriteLine("\n// JavaScript-like Object.entries() in C# Dictionary");

        // There's no JavaScript-like Object.entries() in C#.
        // But, we can create our own function to mimic it in C#.

        dynamic Friend = new Dictionary<string, dynamic>() {
            {"name", "Alisa"},
            {"country", "Finland"},
            {"age", 25}
        };
        Console.WriteLine($"Friend: {JsonStringify(Friend, Pretty: true)}");

        Console.WriteLine("// using JavaScript-like Object.entries() function \"ObjectEntries\"");

        Console.WriteLine($"friend entries: {JsonStringify(ObjectEntries(Friend))}");
        // friend entries: [["name", "Alisa"], ["country", "Finland"], ["age", 25]]
    }
}
