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

        Dictionary<string, dynamic> SpreadObject(params dynamic[] Arguments) {
            dynamic NewObject = new Dictionary<string, dynamic>();
            int ArgumentIndex = 0;
            foreach (dynamic Argument in Arguments) {
                if (Argument is Dictionary<string, dynamic>) {
                    int ObjectIterationIndex = 0;
                    foreach (KeyValuePair<string, dynamic> ObjectEntry in (Dictionary<string, dynamic>)Argument) {
                        string ObjectKey = ObjectEntry.Key;
                        dynamic ObjectValue = ObjectEntry.Value;
                        NewObject[Convert.ToString(ObjectKey)] = ObjectValue;
                        ObjectIterationIndex += 1;
                    }
                    continue;
                }
                if (Argument is List<dynamic>) {
                    int ArrayItemIndex = 0;
                    foreach (dynamic ArrayItem in (List<dynamic>)Argument) {
                        NewObject.Add(Convert.ToString(ArrayItemIndex), ArrayItem);
                        ArrayItemIndex += 1;
                    }
                    continue;
                }
                ArgumentIndex += 1;
            }
            return NewObject;
        }

        List<dynamic> SpreadArray(params dynamic[] Arguments) {
            dynamic NewArray = new List<dynamic>();
            int ArgumentIndex = 0;
            foreach (dynamic Argument in Arguments) {
                if (Argument is Dictionary<string, dynamic>) {
                    if (Argument.Count == 1) {
                        int ObjectIterationIndex = 0;
                        foreach (KeyValuePair<string, dynamic> ObjectEntry in (Dictionary<string, dynamic>)Argument) {
                            string ObjectKey = ObjectEntry.Key;
                            dynamic ObjectValue = ObjectEntry.Value;
                            NewArray.Add(ObjectValue);
                            ObjectIterationIndex += 1;
                        }
                        continue;
                    }
                    NewArray.Add(Argument);
                    continue;
                }
                if (Argument is List<dynamic>) {
                    int ArrayItemIndex = 0;
                    foreach (dynamic ArrayItem in (List<dynamic>)Argument) {
                        NewArray.Add(ArrayItem);
                        ArrayItemIndex += 1;
                    }
                    continue;
                }
                ArgumentIndex += 1;
            }
            return NewArray;
        }

        dynamic ArrayReduce(Func<dynamic, dynamic, dynamic, List<dynamic>, dynamic> CallbackFunction, List<dynamic> AnArray, dynamic InitialValue) {
            // JavaScript-like Array.reduce() function
            dynamic Result = InitialValue;
            int ArrayItemIndex = 0;
            foreach (dynamic ArrayItem in AnArray) {
                Result = CallbackFunction(Result, ArrayItem, ArrayItemIndex, AnArray);
                ArrayItemIndex += 1;
            }
            return Result;
        }

        Console.WriteLine("\n// JavaScript-like Array.reduce() in C# List");

        dynamic Numbers = new List<dynamic>() {36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3};
        Console.WriteLine($"Numbers: {JsonStringify(Numbers)}");

        dynamic NumbersTotal;

        Console.WriteLine("// using JavaScript-like Array.reduce() function \"ArrayReduce\"");

        NumbersTotal = ArrayReduce((Func<dynamic, dynamic, dynamic, List<dynamic>, dynamic>)((dynamic CurrentResult, dynamic CurrentNumber, dynamic ArrayItemIndex, List<dynamic> AnArray) => (CurrentResult + CurrentNumber)), Numbers, 0);
        Console.WriteLine($"total number: {JsonStringify(NumbersTotal)}");
        // total number: 41.2

        Console.WriteLine("// using C# Array.reduce() built-in method \"IEnumerable.Aggregate()\"");

        // ((IEnumerable<dynamic>)Numbers) == (Numbers as IEnumerable<dynamic>)
        NumbersTotal = ((IEnumerable<dynamic>)Numbers).Aggregate(0, (Func<dynamic, dynamic, dynamic>)((dynamic CurrentResult, dynamic CurrentNumber) => (CurrentResult + CurrentNumber)));
        Console.WriteLine($"total number: {JsonStringify(NumbersTotal)}");
        // total number: 41.2

        Console.WriteLine("\n// JavaScript-like Array.reduce() in C# List of Dictionaries");

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

        dynamic ProductsGrouped;

        Console.WriteLine("// using JavaScript-like Array.reduce() function \"ArrayReduce\"");

        ProductsGrouped = ArrayReduce((Func<dynamic, dynamic, dynamic, List<dynamic>, dynamic>)((dynamic CurrentResult, dynamic CurrentProduct, dynamic ArrayItemIndex, List<dynamic> AnArray) => ((CurrentProduct["price"] > 100) ? SpreadObject(CurrentResult, new Dictionary<string, dynamic>() {{"expensive", SpreadArray(CurrentResult["expensive"], new Dictionary<string, dynamic>() {{"CurrentProduct", CurrentProduct}})}}) : SpreadObject(CurrentResult, new Dictionary<string, dynamic>() {{"cheap", SpreadArray(CurrentResult["cheap"], new Dictionary<string, dynamic>() {{"CurrentProduct", CurrentProduct}})}}))), Products, new Dictionary<string, dynamic>() {{"expensive", new List<dynamic>()}, {"cheap", new List<dynamic>()}});
        Console.WriteLine($"grouped products: {JsonStringify(ProductsGrouped, Pretty: true)}");
        // grouped products: {
        //     "expensive": [
        //         {
        //             "code": "pasta",
        //             "price": 321
        //         },
        //         {
        //             "code": "bubble_gum",
        //             "price": 233
        //         },
        //         {
        //             "code": "towel",
        //             "price": 499
        //         }
        //     ],
        //     "cheap": [
        //         {
        //             "code": "potato_chips",
        //             "price": 5
        //         }
        //     ]
        // }

        Console.WriteLine("// using C# Array.reduce() built-in method \"IEnumerable.Aggregate()\"");

        // ((IEnumerable<dynamic>)Products) == (Products as IEnumerable<dynamic>)
        ProductsGrouped = ((IEnumerable<dynamic>)Products).Aggregate(new Dictionary<string, dynamic>() {{"expensive", new List<dynamic>()}, {"cheap", new List<dynamic>()}}, (Func<dynamic, dynamic, dynamic>)((dynamic CurrentResult, dynamic CurrentProduct) => ((CurrentProduct["price"] > 100) ? SpreadObject(CurrentResult, new Dictionary<string, dynamic>() {{"expensive", SpreadArray(CurrentResult["expensive"], new Dictionary<string, dynamic>() {{"CurrentProduct", CurrentProduct}})}}) : SpreadObject(CurrentResult, new Dictionary<string, dynamic>() {{"cheap", SpreadArray(CurrentResult["cheap"], new Dictionary<string, dynamic>() {{"CurrentProduct", CurrentProduct}})}}))));
        Console.WriteLine($"grouped products: {JsonStringify(ProductsGrouped, Pretty: true)}");
        // grouped products: {
        //     "expensive": [
        //         {
        //             "code": "pasta",
        //             "price": 321
        //         },
        //         {
        //             "code": "bubble_gum",
        //             "price": 233
        //         },
        //         {
        //             "code": "towel",
        //             "price": 499
        //         }
        //     ],
        //     "cheap": [
        //         {
        //             "code": "potato_chips",
        //             "price": 5
        //         }
        //     ]
        // }
    }
}
