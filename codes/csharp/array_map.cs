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

        Dictionary<string, dynamic> SpreadSyntaxObject(params dynamic[] Parameters) {
            dynamic NewObject = new Dictionary<string, dynamic>();
            int ParameterIndex = 0;
            foreach (dynamic Parameter in Parameters) {
                if (Parameter is Dictionary<string, dynamic>) {
                    int IterationIndex = 0;
                    foreach (KeyValuePair<string, dynamic> ObjectEntry in (Dictionary<string, dynamic>)Parameter) {
                        string ObjectKey = ObjectEntry.Key;
                        dynamic ObjectValue = ObjectEntry.Value;
                        NewObject[Convert.ToString(ObjectKey)] = ObjectValue;
                        IterationIndex += 1;
                    }
                    continue;
                }
                if (Parameter is List<dynamic>) {
                    int ArrayItemIndex = 0;
                    foreach (dynamic ArrayItem in (List<dynamic>)Parameter) {
                        NewObject.Add(Convert.ToString(ArrayItemIndex), ArrayItem);
                        ArrayItemIndex += 1;
                    }
                    continue;
                }
                ParameterIndex += 1;
            }
            return NewObject;
        }

        List<dynamic> ArrayMapV1(Func<dynamic, dynamic, List<dynamic>, dynamic> CallbackFunction, List<dynamic> AnArray) {
            // JavaScript-like Array.map() function
            List<dynamic> NewArray = new List<dynamic>();
            int ArrayItemIndex = 0;
            foreach (dynamic ArrayItem in AnArray) {
                dynamic NewArrayItem = CallbackFunction(ArrayItem, ArrayItemIndex, AnArray);
                NewArray.Add(NewArrayItem);
                ArrayItemIndex += 1;
            }
            return NewArray;
        }

        List<dynamic> ArrayMapV2(Func<dynamic, dynamic, List<dynamic>, dynamic> CallbackFunction, List<dynamic> AnArray) {
            // JavaScript-like Array.map() function
            List<dynamic> NewArray = new List<dynamic>();
            int ArrayItemIndex = 0;
            foreach (dynamic ArrayItem in AnArray) {
                NewArray.Add(CallbackFunction(ArrayItem, ArrayItemIndex, AnArray));
                ArrayItemIndex += 1;
            }
            return NewArray;
        }

        Console.WriteLine("\n// JavaScript-like Array.map() in C# List");

        dynamic Numbers = new List<dynamic>() {12, 34, 27, 23, 65, 93, 36, 87, 4, 254};
        Console.WriteLine($"Numbers: {PrettyArrayOfPrimitives(Numbers)}");

        dynamic NumbersLabeled;

        Console.WriteLine("// using JavaScript-like Array.map() function \"ArrayMapV1\"");

        NumbersLabeled = ArrayMapV1((Func<dynamic, dynamic, List<dynamic>, dynamic>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => new Dictionary<string, dynamic>() {{Convert.ToString(Number), (((Number % 2) == 0) ? "even" : "odd")}}), Numbers);
        Console.WriteLine($"labeled numbers: {PrettyJsonStringify(NumbersLabeled)}");
        // labeled numbers: [
        //     {
        //         "12": "even"
        //     },
        //     {
        //         "34": "even"
        //     },
        //     {
        //         "27": "odd"
        //     },
        //     {
        //         "23": "odd"
        //     },
        //     {
        //         "65": "odd"
        //     },
        //     {
        //         "93": "odd"
        //     },
        //     {
        //         "36": "even"
        //     },
        //     {
        //         "87": "odd"
        //     },
        //     {
        //         "4": "even"
        //     },
        //     {
        //         "254": "even"
        //     }
        // ]

        Console.WriteLine("// using JavaScript-like Array.map() function \"ArrayMapV2\"");

        NumbersLabeled = ArrayMapV2((Func<dynamic, dynamic, List<dynamic>, dynamic>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => new Dictionary<string, dynamic>() {{Convert.ToString(Number), (((Number % 2) == 0) ? "even" : "odd")}}), Numbers);
        Console.WriteLine($"labeled numbers: {PrettyJsonStringify(NumbersLabeled)}");
        // labeled numbers: [
        //     {
        //         "12": "even"
        //     },
        //     {
        //         "34": "even"
        //     },
        //     {
        //         "27": "odd"
        //     },
        //     {
        //         "23": "odd"
        //     },
        //     {
        //         "65": "odd"
        //     },
        //     {
        //         "93": "odd"
        //     },
        //     {
        //         "36": "even"
        //     },
        //     {
        //         "87": "odd"
        //     },
        //     {
        //         "4": "even"
        //     },
        //     {
        //         "254": "even"
        //     }
        // ]

        Console.WriteLine("// using C# Array.map() built-in method \"IEnumerable.Select().ToList()\"");

        NumbersLabeled = ((IEnumerable<dynamic>)Numbers).Select((Func<dynamic, dynamic>)((dynamic Number) => new Dictionary<string, dynamic>() {{Convert.ToString(Number), (((Number % 2) == 0) ? "even" : "odd")}})).ToList();
        Console.WriteLine($"labeled numbers: {PrettyJsonStringify(NumbersLabeled)}");
        // labeled numbers: [
        //     {
        //         "12": "even"
        //     },
        //     {
        //         "34": "even"
        //     },
        //     {
        //         "27": "odd"
        //     },
        //     {
        //         "23": "odd"
        //     },
        //     {
        //         "65": "odd"
        //     },
        //     {
        //         "93": "odd"
        //     },
        //     {
        //         "36": "even"
        //     },
        //     {
        //         "87": "odd"
        //     },
        //     {
        //         "4": "even"
        //     },
        //     {
        //         "254": "even"
        //     }
        // ]

        Console.WriteLine("\n// JavaScript-like Array.map() in C# List of Dictionaries");

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

        dynamic ProductsLabeled;

        Console.WriteLine("// using JavaScript-like Array.map() function \"ArrayMapV1\"");

        ProductsLabeled = ArrayMapV1((Func<dynamic, dynamic, List<dynamic>, dynamic>)((dynamic Product, dynamic ArrayItemIndex, List<dynamic> AnArray) => SpreadSyntaxObject(Product, new Dictionary<string, dynamic>() {{"label", ((Product["price"] > 100) ? "expensive" : "cheap")}})), Products);
        Console.WriteLine($"labeled products: {PrettyJsonStringify(ProductsLabeled)}");
        // labeled products: [
        //     {
        //         "code": "pasta",
        //         "price": 321,
        //         "label": "expensive"
        //     },
        //     {
        //         "code": "bubble_gum",
        //         "price": 233,
        //         "label": "expensive"
        //     },
        //     {
        //         "code": "potato_chips",
        //         "price": 5,
        //         "label": "cheap"
        //     },
        //     {
        //         "code": "towel",
        //         "price": 499,
        //         "label": "expensive"
        //     }
        // ]

        Console.WriteLine("// using JavaScript-like Array.map() function \"ArrayMapV2\"");

        ProductsLabeled = ArrayMapV2((Func<dynamic, dynamic, List<dynamic>, dynamic>)((dynamic Product, dynamic ArrayItemIndex, List<dynamic> AnArray) => SpreadSyntaxObject(Product, new Dictionary<string, dynamic>() {{"label", ((Product["price"] > 100) ? "expensive" : "cheap")}})), Products);
        Console.WriteLine($"labeled products: {PrettyJsonStringify(ProductsLabeled)}");
        // labeled products: [
        //     {
        //         "code": "pasta",
        //         "price": 321,
        //         "label": "expensive"
        //     },
        //     {
        //         "code": "bubble_gum",
        //         "price": 233,
        //         "label": "expensive"
        //     },
        //     {
        //         "code": "potato_chips",
        //         "price": 5,
        //         "label": "cheap"
        //     },
        //     {
        //         "code": "towel",
        //         "price": 499,
        //         "label": "expensive"
        //     }
        // ]

        Console.WriteLine("// using C# Array.map() built-in method \"IEnumerable.Select().ToList()\"");

        ProductsLabeled = ((IEnumerable<dynamic>)Products).Select((Func<dynamic, dynamic>)((dynamic Product) => SpreadSyntaxObject(Product, new Dictionary<string, dynamic>() {{"label", ((Product["price"] > 100) ? "expensive" : "cheap")}}))).ToList();
        Console.WriteLine($"labeled products: {PrettyJsonStringify(ProductsLabeled)}");
        // labeled products: [
        //     {
        //         "code": "pasta",
        //         "price": 321,
        //         "label": "expensive"
        //     },
        //     {
        //         "code": "bubble_gum",
        //         "price": 233,
        //         "label": "expensive"
        //     },
        //     {
        //         "code": "potato_chips",
        //         "price": 5,
        //         "label": "cheap"
        //     },
        //     {
        //         "code": "towel",
        //         "price": 499,
        //         "label": "expensive"
        //     }
        // ]
    }
}
