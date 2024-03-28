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

        dynamic ArrayFindV1(Func<dynamic, dynamic, List<dynamic>, bool> CallbackFunction, List<dynamic> AnArray) {
            // JavaScript-like Array.find() function
            dynamic DataFound = null;
            int ArrayItemIndex = 0;
            foreach (dynamic ArrayItem in AnArray) {
                bool IsConditionMatch = (bool)CallbackFunction(ArrayItem, ArrayItemIndex, AnArray);
                if (IsConditionMatch == true) {
                    DataFound = ArrayItem;
                    break;
                }
                ArrayItemIndex += 1;
            }
            return DataFound;
        }

        dynamic ArrayFindV2(Func<dynamic, dynamic, List<dynamic>, bool> CallbackFunction, List<dynamic> AnArray) {
            // JavaScript-like Array.find() function
            dynamic DataFound = null;
            int ArrayItemIndex = 0;
            foreach (dynamic ArrayItem in AnArray) {
                if ((bool)CallbackFunction(ArrayItem, ArrayItemIndex, AnArray) == true) {
                    DataFound = ArrayItem;
                    break;
                }
                ArrayItemIndex += 1;
            }
            return DataFound;
        }

        dynamic ArrayFindV3(Func<dynamic, dynamic, List<dynamic>, bool> CallbackFunction, List<dynamic> AnArray) {
            // JavaScript-like Array.find() function
            int ArrayItemIndex = 0;
            foreach (dynamic ArrayItem in AnArray) {
                bool IsConditionMatch = (bool)CallbackFunction(ArrayItem, ArrayItemIndex, AnArray);
                if (IsConditionMatch == true) {
                    return ArrayItem;
                }
                ArrayItemIndex += 1;
            }
            return null;
        }

        dynamic ArrayFindV4(Func<dynamic, dynamic, List<dynamic>, bool> CallbackFunction, List<dynamic> AnArray) {
            // JavaScript-like Array.find() function
            int ArrayItemIndex = 0;
            foreach (dynamic ArrayItem in AnArray) {
                if ((bool)CallbackFunction(ArrayItem, ArrayItemIndex, AnArray) == true) {
                    return ArrayItem;
                }
                ArrayItemIndex += 1;
            }
            return null;
        }

        Console.WriteLine("\n// JavaScript-like Array.find() in C# List");

        dynamic Numbers = new List<dynamic>() {12, 34, 27, 23, 65, 93, 36, 87, 4, 254};
        Console.WriteLine($"Numbers: {PrettyArrayOfPrimitives(Numbers)}");

        dynamic EvenNumberFound;
        dynamic OddNumberFound;

        Console.WriteLine("// using JavaScript-like Array.find() function \"ArrayFindV1\"");

        EvenNumberFound = ArrayFindV1((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => ((Number % 2) == 0)), Numbers);
        Console.WriteLine($"even number found: {EvenNumberFound}");
        // even number found: 12

        OddNumberFound = ArrayFindV1((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => ((Number % 2) != 0)), Numbers);
        Console.WriteLine($"odd number found: {OddNumberFound}");
        // odd number found: 27

        Console.WriteLine("// using JavaScript-like Array.find() function \"ArrayFindV2\"");

        EvenNumberFound = ArrayFindV2((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => ((Number % 2) == 0)), Numbers);
        Console.WriteLine($"even number found: {EvenNumberFound}");
        // even number found: 12

        OddNumberFound = ArrayFindV2((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => ((Number % 2) != 0)), Numbers);
        Console.WriteLine($"odd number found: {OddNumberFound}");
        // odd number found: 27

        Console.WriteLine("// using JavaScript-like Array.find() function \"ArrayFindV3\"");

        EvenNumberFound = ArrayFindV3((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => ((Number % 2) == 0)), Numbers);
        Console.WriteLine($"even number found: {EvenNumberFound}");
        // even number found: 12

        OddNumberFound = ArrayFindV3((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => ((Number % 2) != 0)), Numbers);
        Console.WriteLine($"odd number found: {OddNumberFound}");
        // odd number found: 27

        Console.WriteLine("// using JavaScript-like Array.find() function \"ArrayFindV4\"");

        EvenNumberFound = ArrayFindV4((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => ((Number % 2) == 0)), Numbers);
        Console.WriteLine($"even number found: {EvenNumberFound}");
        // even number found: 12

        OddNumberFound = ArrayFindV4((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => ((Number % 2) != 0)), Numbers);
        Console.WriteLine($"odd number found: {OddNumberFound}");
        // odd number found: 27

        Console.WriteLine("// using C# Array.find() built-in method \"IEnumerable.FirstOrDefault\"");

        EvenNumberFound = ((IEnumerable<dynamic>)Numbers).FirstOrDefault((Func<dynamic, bool>)((dynamic Number) => ((Number % 2) == 0)));
        Console.WriteLine($"even number found: {EvenNumberFound}");
        // even number found: 12

        OddNumberFound = ((IEnumerable<dynamic>)Numbers).FirstOrDefault((Func<dynamic, bool>)((dynamic Number) => ((Number % 2) != 0)));
        Console.WriteLine($"odd number found: {OddNumberFound}");
        // odd number found: 27

        Console.WriteLine("\n// JavaScript-like Array.find() in C# List of Dictionaries");

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

        dynamic ProductToFind = "bubble_gum";
        Console.WriteLine($"product to find: {PrettyJsonStringify(ProductToFind)}");

        dynamic ProductFound;

        Console.WriteLine("// using JavaScript-like Array.find() function \"ArrayFindV1\"");

        ProductFound = ArrayFindV1((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Product, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Product["code"] == ProductToFind)), Products);
        Console.WriteLine($"product found: {PrettyJsonStringify(ProductFound)}");
        // product found: {
        //     "code": "bubble_gum",
        //     "price": 233
        // }

        Console.WriteLine("// using JavaScript-like Array.find() function \"ArrayFindV2\"");

        ProductFound = ArrayFindV2((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Product, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Product["code"] == ProductToFind)), Products);
        Console.WriteLine($"product found: {PrettyJsonStringify(ProductFound)}");
        // product found: {
        //     "code": "bubble_gum",
        //     "price": 233
        // }

        Console.WriteLine("// using JavaScript-like Array.find() function \"ArrayFindV3\"");

        ProductFound = ArrayFindV3((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Product, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Product["code"] == ProductToFind)), Products);
        Console.WriteLine($"product found: {PrettyJsonStringify(ProductFound)}");
        // product found: {
        //     "code": "bubble_gum",
        //     "price": 233
        // }

        Console.WriteLine("// using JavaScript-like Array.find() function \"ArrayFindV4\"");

        ProductFound = ArrayFindV4((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Product, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Product["code"] == ProductToFind)), Products);
        Console.WriteLine($"product found: {PrettyJsonStringify(ProductFound)}");
        // product found: {
        //     "code": "bubble_gum",
        //     "price": 233
        // }

        Console.WriteLine("// using C# Array.find() built-in method \"IEnumerable.FirstOrDefault\"");

        ProductFound = ((IEnumerable<dynamic>)Products).FirstOrDefault((Func<dynamic, bool>)((dynamic Product) => (Product["code"] == ProductToFind)));
        Console.WriteLine($"product found: {PrettyJsonStringify(ProductFound)}");
        // product found: {
        //     "code": "bubble_gum",
        //     "price": 233
        // }
    }
}
