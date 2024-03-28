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

        string PrettyArrayOfPrimitives(List<dynamic> AnArrayOfPrimitives) {
            string Result = "[";
            int ArrayItemIndex = 0;
            foreach (dynamic ArrayItem in AnArrayOfPrimitives) {
                if (((ArrayItem is string) == false) && (IsNumeric(ArrayItem) == false) && ((ArrayItem is bool) == false) && (ArrayItem != null)) continue;
                if (ArrayItem is string) Result += $"\"{ArrayItem}\"";
                if (IsNumeric(ArrayItem) == true) Result += ArrayItem.ToString().Replace(",", ".");
                if (ArrayItem is bool) Result += $"{ArrayItem.ToLower()}";
                if (ArrayItem == null) Result += "null";
                if ((ArrayItemIndex + 1) != AnArrayOfPrimitives.Count) Result += ", ";
                ArrayItemIndex += 1;
            }
            Result += "]";
            return Result;
        }

        bool ArrayEveryV1(Func<dynamic, dynamic, List<dynamic>, bool> CallbackFunction, List<dynamic> AnArray) {
            // JavaScript-like Array.every() function
            bool IsConditionMatch = false;
            int ArrayItemIndex = 0;
            foreach (dynamic ArrayItem in AnArray) {
                IsConditionMatch = (bool)CallbackFunction(ArrayItem, ArrayItemIndex, AnArray);
                if (IsConditionMatch == false) break;
                ArrayItemIndex += 1;
            }
            return IsConditionMatch;
        }

        bool ArrayEveryV2(Func<dynamic, dynamic, List<dynamic>, bool> CallbackFunction, List<dynamic> AnArray) {
            // JavaScript-like Array.every() function
            bool IsConditionMatch = false;
            int ArrayItemIndex = 0;
            foreach (dynamic ArrayItem in AnArray) {
                IsConditionMatch = (bool)CallbackFunction(ArrayItem, ArrayItemIndex, AnArray);
                if (IsConditionMatch == false) return IsConditionMatch;
                ArrayItemIndex += 1;
            }
            return IsConditionMatch;
        }

        bool ArrayEveryV3(Func<dynamic, dynamic, List<dynamic>, bool> CallbackFunction, List<dynamic> AnArray) {
            // JavaScript-like Array.every() function
            int ArrayItemIndex = 0;
            foreach (dynamic ArrayItem in AnArray) {
                bool IsConditionMatch = (bool)CallbackFunction(ArrayItem, ArrayItemIndex, AnArray);
                if (IsConditionMatch == false) return false;
                ArrayItemIndex += 1;
            }
            return true;
        }

        bool ArrayEveryV4(Func<dynamic, dynamic, List<dynamic>, bool> CallbackFunction, List<dynamic> AnArray) {
            // JavaScript-like Array.every() function
            int ArrayItemIndex = 0;
            foreach (dynamic ArrayItem in AnArray) {
                if ((bool)CallbackFunction(ArrayItem, ArrayItemIndex, AnArray) == false) return false;
                ArrayItemIndex += 1;
            }
            return true;
        }

        Console.WriteLine("\n// JavaScript-like Array.every() in C# List");

        dynamic Numbers = new List<dynamic>() {12, 34, 27, 23, 65, 93, 36, 87, 4, 254};
        Console.WriteLine($"Numbers: {PrettyArrayOfPrimitives(Numbers)}");

        dynamic IsAllNumberLessThan500;
        dynamic IsAllNumberMoreThan500;

        Console.WriteLine("// using JavaScript-like Array.every() function \"ArrayEveryV1\"");

        IsAllNumberLessThan500 = ArrayEveryV1((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Number < 500)), Numbers);
        Console.WriteLine($"is all number < 500: {IsAllNumberLessThan500}");
        // is all number < 500: True

        IsAllNumberMoreThan500 = ArrayEveryV1((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Number > 500)), Numbers);
        Console.WriteLine($"is all number > 500: {IsAllNumberMoreThan500}");
        // is all number > 500: False

        Console.WriteLine("// using JavaScript-like Array.every() function \"ArrayEveryV2\"");

        IsAllNumberLessThan500 = ArrayEveryV2((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Number < 500)), Numbers);
        Console.WriteLine($"is all number < 500: {IsAllNumberLessThan500}");
        // is all number < 500: True

        IsAllNumberMoreThan500 = ArrayEveryV2((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Number > 500)), Numbers);
        Console.WriteLine($"is all number > 500: {IsAllNumberMoreThan500}");
        // is all number > 500: False

        Console.WriteLine("// using JavaScript-like Array.every() function \"ArrayEveryV3\"");

        IsAllNumberLessThan500 = ArrayEveryV3((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Number < 500)), Numbers);
        Console.WriteLine($"is all number < 500: {IsAllNumberLessThan500}");
        // is all number < 500: True

        IsAllNumberMoreThan500 = ArrayEveryV3((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Number > 500)), Numbers);
        Console.WriteLine($"is all number > 500: {IsAllNumberMoreThan500}");
        // is all number > 500: False

        Console.WriteLine("// using JavaScript-like Array.every() function \"ArrayEveryV4\"");

        IsAllNumberLessThan500 = ArrayEveryV4((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Number < 500)), Numbers);
        Console.WriteLine($"is all number < 500: {IsAllNumberLessThan500}");
        // is all number < 500: True

        IsAllNumberMoreThan500 = ArrayEveryV4((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Number > 500)), Numbers);
        Console.WriteLine($"is all number > 500: {IsAllNumberMoreThan500}");
        // is all number > 500: False

        Console.WriteLine("// using C# Array.every() built-in method \"IEnumerable.All()\"");

        IsAllNumberLessThan500 = ((IEnumerable<dynamic>)Numbers).All((Func<dynamic, bool>)((dynamic Number) => (Number < 500)));
        Console.WriteLine($"is all number < 500: {IsAllNumberLessThan500}");
        // is all number < 500: True

        IsAllNumberMoreThan500 = ((IEnumerable<dynamic>)Numbers).All((Func<dynamic, bool>)((dynamic Number) => (Number > 500)));
        Console.WriteLine($"is all number > 500: {IsAllNumberMoreThan500}");
        // is all number > 500: False

        Console.WriteLine("\n// JavaScript-like Array.every() in C# List of Dictionaries");

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
        Console.WriteLine($"Products: {PrettyJsonStringify(Products)}");

        dynamic IsAllProductPriceLessThan500;
        dynamic IsAllProductPriceMoreThan500;

        Console.WriteLine("// using JavaScript-like Array.every() function \"ArrayEveryV1\"");

        IsAllProductPriceLessThan500 = ArrayEveryV1((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Product, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Product["price"] < 500)), Products);
        Console.WriteLine($"is all product price < 500: {IsAllProductPriceLessThan500}");
        // is all product price < 500: True

        IsAllProductPriceMoreThan500 = ArrayEveryV1((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Product, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Product["price"] > 500)), Products);
        Console.WriteLine($"is all product price > 500: {IsAllProductPriceMoreThan500}");
        // is all product price > 500: False

        Console.WriteLine("// using JavaScript-like Array.every() function \"ArrayEveryV2\"");

        IsAllProductPriceLessThan500 = ArrayEveryV2((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Product, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Product["price"] < 500)), Products);
        Console.WriteLine($"is all product price < 500: {IsAllProductPriceLessThan500}");
        // is all product price < 500: True

        IsAllProductPriceMoreThan500 = ArrayEveryV2((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Product, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Product["price"] > 500)), Products);
        Console.WriteLine($"is all product price > 500: {IsAllProductPriceMoreThan500}");
        // is all product price > 500: False

        Console.WriteLine("// using JavaScript-like Array.every() function \"ArrayEveryV3\"");

        IsAllProductPriceLessThan500 = ArrayEveryV3((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Product, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Product["price"] < 500)), Products);
        Console.WriteLine($"is all product price < 500: {IsAllProductPriceLessThan500}");
        // is all product price < 500: True

        IsAllProductPriceMoreThan500 = ArrayEveryV3((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Product, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Product["price"] > 500)), Products);
        Console.WriteLine($"is all product price > 500: {IsAllProductPriceMoreThan500}");
        // is all product price > 500: False

        Console.WriteLine("// using JavaScript-like Array.every() function \"ArrayEveryV4\"");

        IsAllProductPriceLessThan500 = ArrayEveryV4((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Product, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Product["price"] < 500)), Products);
        Console.WriteLine($"is all product price < 500: {IsAllProductPriceLessThan500}");
        // is all product price < 500: True

        IsAllProductPriceMoreThan500 = ArrayEveryV4((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Product, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Product["price"] > 500)), Products);
        Console.WriteLine($"is all product price > 500: {IsAllProductPriceMoreThan500}");
        // is all product price > 500: False

        Console.WriteLine("// using C# Array.every() built-in method \"IEnumerable.All()\"");

        IsAllProductPriceLessThan500 = ((IEnumerable<dynamic>)Products).All((Func<dynamic, bool>)((dynamic Product) => (Product["price"] < 500)));
        Console.WriteLine($"is all product price < 500: {IsAllProductPriceLessThan500}");
        // is all product price < 500: True

        IsAllProductPriceMoreThan500 = ((IEnumerable<dynamic>)Products).All((Func<dynamic, bool>)((dynamic Product) => (Product["price"] > 500)));
        Console.WriteLine($"is all product price > 500: {IsAllProductPriceMoreThan500}");
        // is all product price > 500: False
    }
}
