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

        bool ArraySomeV1(Func<dynamic, dynamic, List<dynamic>, bool> CallbackFunction, List<dynamic> AnArray) {
            // JavaScript-like Array.some() function
            bool IsConditionMatch = false;
            int ArrayItemIndex = 0;
            foreach (dynamic ArrayItem in AnArray) {
                IsConditionMatch = (bool)CallbackFunction(ArrayItem, ArrayItemIndex, AnArray);
                if (IsConditionMatch == true) break;
                ArrayItemIndex += 1;
            }
            return IsConditionMatch;
        }

        bool ArraySomeV2(Func<dynamic, dynamic, List<dynamic>, bool> CallbackFunction, List<dynamic> AnArray) {
            // JavaScript-like Array.some() function
            bool IsConditionMatch = false;
            int ArrayItemIndex = 0;
            foreach (dynamic ArrayItem in AnArray) {
                IsConditionMatch = (bool)CallbackFunction(ArrayItem, ArrayItemIndex, AnArray);
                if (IsConditionMatch == true) return IsConditionMatch;
                ArrayItemIndex += 1;
            }
            return IsConditionMatch;
        }

        bool ArraySomeV3(Func<dynamic, dynamic, List<dynamic>, bool> CallbackFunction, List<dynamic> AnArray) {
            // JavaScript-like Array.some() function
            int ArrayItemIndex = 0;
            foreach (dynamic ArrayItem in AnArray) {
                bool IsConditionMatch = (bool)CallbackFunction(ArrayItem, ArrayItemIndex, AnArray);
                if (IsConditionMatch == true) return true;
                ArrayItemIndex += 1;
            }
            return false;
        }

        bool ArraySomeV4(Func<dynamic, dynamic, List<dynamic>, bool> CallbackFunction, List<dynamic> AnArray) {
            // JavaScript-like Array.some() function
            int ArrayItemIndex = 0;
            foreach (dynamic ArrayItem in AnArray) {
                if ((bool)CallbackFunction(ArrayItem, ArrayItemIndex, AnArray) == true) return true;
                ArrayItemIndex += 1;
            }
            return false;
        }

        Console.WriteLine("\n// JavaScript-like Array.some() in C# List");

        dynamic Numbers = new List<dynamic>() {12, 34, 27, 23, 65, 93, 36, 87, 4, 254};
        Console.WriteLine($"Numbers: {JsonStringify(Numbers)}");

        dynamic IsAnyNumberLessThan500;
        dynamic IsAnyNumberMoreThan500;

        Console.WriteLine("// using JavaScript-like Array.some() function \"ArraySomeV1\"");

        IsAnyNumberLessThan500 = ArraySomeV1((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Number < 500)), Numbers);
        Console.WriteLine($"is any number < 500: {IsAnyNumberLessThan500}");
        // is any number < 500: True

        IsAnyNumberMoreThan500 = ArraySomeV1((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Number > 500)), Numbers);
        Console.WriteLine($"is any number > 500: {IsAnyNumberMoreThan500}");
        // is any number > 500: False

        Console.WriteLine("// using JavaScript-like Array.some() function \"ArraySomeV2\"");

        IsAnyNumberLessThan500 = ArraySomeV2((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Number < 500)), Numbers);
        Console.WriteLine($"is any number < 500: {IsAnyNumberLessThan500}");
        // is any number < 500: True

        IsAnyNumberMoreThan500 = ArraySomeV2((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Number > 500)), Numbers);
        Console.WriteLine($"is any number > 500: {IsAnyNumberMoreThan500}");
        // is any number > 500: False

        Console.WriteLine("// using JavaScript-like Array.some() function \"ArraySomeV3\"");

        IsAnyNumberLessThan500 = ArraySomeV3((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Number < 500)), Numbers);
        Console.WriteLine($"is any number < 500: {IsAnyNumberLessThan500}");
        // is any number < 500: True

        IsAnyNumberMoreThan500 = ArraySomeV3((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Number > 500)), Numbers);
        Console.WriteLine($"is any number > 500: {IsAnyNumberMoreThan500}");
        // is any number > 500: False

        Console.WriteLine("// using JavaScript-like Array.some() function \"ArraySomeV4\"");

        IsAnyNumberLessThan500 = ArraySomeV4((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Number < 500)), Numbers);
        Console.WriteLine($"is any number < 500: {IsAnyNumberLessThan500}");
        // is any number < 500: True

        IsAnyNumberMoreThan500 = ArraySomeV4((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Number > 500)), Numbers);
        Console.WriteLine($"is any number > 500: {IsAnyNumberMoreThan500}");
        // is any number > 500: False

        Console.WriteLine("// using C# Array.some() built-in method \"IEnumerable.Any()\"");

        IsAnyNumberLessThan500 = ((IEnumerable<dynamic>)Numbers).Any((Func<dynamic, bool>)((dynamic Number) => (Number < 500)));
        Console.WriteLine($"is any number < 500: {IsAnyNumberLessThan500}");
        // is any number < 500: True

        IsAnyNumberMoreThan500 = ((IEnumerable<dynamic>)Numbers).Any((Func<dynamic, bool>)((dynamic Number) => (Number > 500)));
        Console.WriteLine($"is any number > 500: {IsAnyNumberMoreThan500}");
        // is any number > 500: False

        Console.WriteLine("\n// JavaScript-like Array.some() in C# List of Dictionaries");

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

        dynamic IsAnyProductPriceLessThan500;
        dynamic IsAnyProductPriceMoreThan500;

        Console.WriteLine("// using JavaScript-like Array.some() function \"ArraySomeV1\"");

        IsAnyProductPriceLessThan500 = ArraySomeV1((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Product, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Product["price"] < 500)), Products);
        Console.WriteLine($"is any product price < 500: {IsAnyProductPriceLessThan500}");
        // is any product price < 500: True

        IsAnyProductPriceMoreThan500 = ArraySomeV1((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Product, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Product["price"] > 500)), Products);
        Console.WriteLine($"is any product price > 500: {IsAnyProductPriceMoreThan500}");
        // is any product price > 500: False

        Console.WriteLine("// using JavaScript-like Array.some() function \"ArraySomeV2\"");

        IsAnyProductPriceLessThan500 = ArraySomeV2((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Product, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Product["price"] < 500)), Products);
        Console.WriteLine($"is any product price < 500: {IsAnyProductPriceLessThan500}");
        // is any product price < 500: True

        IsAnyProductPriceMoreThan500 = ArraySomeV2((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Product, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Product["price"] > 500)), Products);
        Console.WriteLine($"is any product price > 500: {IsAnyProductPriceMoreThan500}");
        // is any product price > 500: False

        Console.WriteLine("// using JavaScript-like Array.some() function \"ArraySomeV3\"");

        IsAnyProductPriceLessThan500 = ArraySomeV3((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Product, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Product["price"] < 500)), Products);
        Console.WriteLine($"is any product price < 500: {IsAnyProductPriceLessThan500}");
        // is any product price < 500: True

        IsAnyProductPriceMoreThan500 = ArraySomeV3((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Product, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Product["price"] > 500)), Products);
        Console.WriteLine($"is any product price > 500: {IsAnyProductPriceMoreThan500}");
        // is any product price > 500: False

        Console.WriteLine("// using JavaScript-like Array.some() function \"ArraySomeV4\"");

        IsAnyProductPriceLessThan500 = ArraySomeV4((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Product, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Product["price"] < 500)), Products);
        Console.WriteLine($"is any product price < 500: {IsAnyProductPriceLessThan500}");
        // is any product price < 500: True

        IsAnyProductPriceMoreThan500 = ArraySomeV4((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Product, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Product["price"] > 500)), Products);
        Console.WriteLine($"is any product price > 500: {IsAnyProductPriceMoreThan500}");
        // is any product price > 500: False

        Console.WriteLine("// using C# Array.some() built-in method \"IEnumerable.Any()\"");

        IsAnyProductPriceLessThan500 = ((IEnumerable<dynamic>)Products).Any((Func<dynamic, bool>)((dynamic Product) => (Product["price"] < 500)));
        Console.WriteLine($"is any product price < 500: {IsAnyProductPriceLessThan500}");
        // is any product price < 500: True

        IsAnyProductPriceMoreThan500 = ((IEnumerable<dynamic>)Products).Any((Func<dynamic, bool>)((dynamic Product) => (Product["price"] > 500)));
        Console.WriteLine($"is any product price > 500: {IsAnyProductPriceMoreThan500}");
        // is any product price > 500: False
    }
}
