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

        dynamic  ArrayFindIndexV1(Func<dynamic, dynamic, List<dynamic>, bool> CallbackFunction, List<dynamic> AnArray) {
            // JavaScript-like Array.findIndex() function
            dynamic DataFoundIndex = -1;
            int ArrayItemIndex = 0;
            foreach (dynamic ArrayItem in AnArray) {
                bool IsConditionMatch = (bool)CallbackFunction(ArrayItem, ArrayItemIndex, AnArray);
                if (IsConditionMatch == true) {
                    DataFoundIndex = ArrayItemIndex;
                    break;
                }
                ArrayItemIndex += 1;
            }
            return DataFoundIndex;
        }

        dynamic  ArrayFindIndexV2(Func<dynamic, dynamic, List<dynamic>, bool> CallbackFunction, List<dynamic> AnArray) {
            // JavaScript-like Array.findIndex() function
            dynamic DataFoundIndex = -1;
            int ArrayItemIndex = 0;
            foreach (dynamic ArrayItem in AnArray) {
                if ((bool)CallbackFunction(ArrayItem, ArrayItemIndex, AnArray) == true) {
                    DataFoundIndex = ArrayItemIndex;
                    break;
                }
                ArrayItemIndex += 1;
            }
            return DataFoundIndex;
        }

        dynamic  ArrayFindIndexV3(Func<dynamic, dynamic, List<dynamic>, bool> CallbackFunction, List<dynamic> AnArray) {
            // JavaScript-like Array.findIndex() function
            int ArrayItemIndex = 0;
            foreach (dynamic ArrayItem in AnArray) {
                bool IsConditionMatch = (bool)CallbackFunction(ArrayItem, ArrayItemIndex, AnArray);
                if (IsConditionMatch == true) {
                    return ArrayItemIndex;
                }
                ArrayItemIndex += 1;
            }
            return -1;
        }

        dynamic  ArrayFindIndexV4(Func<dynamic, dynamic, List<dynamic>, bool> CallbackFunction, List<dynamic> AnArray) {
            // JavaScript-like Array.findIndex() function
            int ArrayItemIndex = 0;
            foreach (dynamic ArrayItem in AnArray) {
                if ((bool)CallbackFunction(ArrayItem, ArrayItemIndex, AnArray) == true) {
                    return ArrayItemIndex;
                }
                ArrayItemIndex += 1;
            }
            return -1;
        }

        Console.WriteLine("\n// JavaScript-like Array.findIndex() in C# List");

        dynamic Numbers = new List<dynamic>() {12, 34, 27, 23, 65, 93, 36, 87, 4, 254};
        Console.WriteLine($"Numbers: {JsonStringify(Numbers)}");

        dynamic NumberToFind = 27;
        Console.WriteLine($"number to find: {NumberToFind}");

        dynamic NumberFoundIndex;

        Console.WriteLine("// using JavaScript-like Array.findIndex() function \"ArrayFindIndexV1\"");

        NumberFoundIndex = ArrayFindIndexV1((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Number == NumberToFind)), Numbers);
        Console.WriteLine($"number found index: {NumberFoundIndex}");
        // number found index: 2

        Console.WriteLine("// using JavaScript-like Array.findIndex() function \"ArrayFindIndexV2\"");

        NumberFoundIndex = ArrayFindIndexV2((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Number == NumberToFind)), Numbers);
        Console.WriteLine($"number found index: {NumberFoundIndex}");
        // number found index: 2

        Console.WriteLine("// using JavaScript-like Array.findIndex() function \"ArrayFindIndexV3\"");

        NumberFoundIndex = ArrayFindIndexV3((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Number == NumberToFind)), Numbers);
        Console.WriteLine($"number found index: {NumberFoundIndex}");
        // number found index: 2

        Console.WriteLine("// using JavaScript-like Array.findIndex() function \"ArrayFindIndexV4\"");

        NumberFoundIndex = ArrayFindIndexV4((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Number == NumberToFind)), Numbers);
        Console.WriteLine($"number found index: {NumberFoundIndex}");
        // number found index: 2

        Console.WriteLine("// using C# Array.findIndex() built-in method \"List.FindIndex()\"");

        NumberFoundIndex = Numbers.FindIndex((Predicate<dynamic>)((dynamic Number) => (Number == NumberToFind)));
        Console.WriteLine($"number found index: {NumberFoundIndex}");
        // number found index: 2

        Console.WriteLine("\n// JavaScript-like Array.findIndex() in C# List of Dictionaries");

        dynamic Products = new List<dynamic>() {
            new Dictionary<string, dynamic>() {
                {"code", "pasta"},
                {"price", 321}
            },
            new Dictionary<string, dynamic>() {
                {"code", "bubble_gum"},
                {"price", 233}
            },
            new Dictionary<string, dynamic>() {
                {"code", "potato_chips"},
                {"price", 5}
            },
            new Dictionary<string, dynamic>() {
                {"code", "towel"},
                {"price", 499}
            },
        };
        Console.WriteLine($"Products: {JsonStringify(Products, Pretty: true)}");

        dynamic ProductToFind = "pasta";
        Console.WriteLine($"product to find: {JsonStringify(ProductToFind)}");

        dynamic ProductFoundIndex;

        Console.WriteLine("// using JavaScript-like Array.findIndex() function \"ArrayFindIndexV1\"");

        ProductFoundIndex = ArrayFindIndexV1((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Product, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Product["code"] == ProductToFind)), Products);
        Console.WriteLine($"product found index: {ProductFoundIndex}");
        // product found index: 0

        Console.WriteLine("// using JavaScript-like Array.findIndex() function \"ArrayFindIndexV2\"");

        ProductFoundIndex = ArrayFindIndexV2((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Product, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Product["code"] == ProductToFind)), Products);
        Console.WriteLine($"product found index: {ProductFoundIndex}");
        // product found index: 0

        Console.WriteLine("// using JavaScript-like Array.findIndex() function \"ArrayFindIndexV3\"");

        ProductFoundIndex = ArrayFindIndexV3((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Product, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Product["code"] == ProductToFind)), Products);
        Console.WriteLine($"product found index: {ProductFoundIndex}");
        // product found index: 0

        Console.WriteLine("// using JavaScript-like Array.findIndex() function \"ArrayFindIndexV4\"");

        ProductFoundIndex = ArrayFindIndexV4((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Product, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Product["code"] == ProductToFind)), Products);
        Console.WriteLine($"product found index: {ProductFoundIndex}");
        // product found index: 0

        Console.WriteLine("// using C# Array.findIndex() built-in method \"List.FindIndex()\"");

        ProductFoundIndex = Products.FindIndex((Predicate<dynamic>)((dynamic Product) => (Product["code"] == ProductToFind)));
        Console.WriteLine($"product found index: {ProductFoundIndex}");
        // product found index: 0
    }
}
