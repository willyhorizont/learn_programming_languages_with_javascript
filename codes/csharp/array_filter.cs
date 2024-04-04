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

        List<dynamic> ArrayFilterV1(Func<dynamic, dynamic, List<dynamic>, bool> CallbackFunction, List<dynamic> AnArray) {
            // JavaScript-like Array.filter() function
            List<dynamic> DataFiltered = new List<dynamic>();
            int ArrayItemIndex = 0;
            foreach (dynamic ArrayItem in AnArray) {
                bool IsConditionMatch = (bool)CallbackFunction(ArrayItem, ArrayItemIndex, AnArray);
                if (IsConditionMatch == true) DataFiltered.Add(ArrayItem);
                ArrayItemIndex += 1;
            }
            return DataFiltered;
        }

        List<dynamic> ArrayFilterV2(Func<dynamic, dynamic, List<dynamic>, bool> CallbackFunction, List<dynamic> AnArray) {
            // JavaScript-like Array.filter() function
            List<dynamic> DataFiltered = new List<dynamic>();
            int ArrayItemIndex = 0;
            foreach (dynamic ArrayItem in AnArray) {
                if ((bool)CallbackFunction(ArrayItem, ArrayItemIndex, AnArray) == true) DataFiltered.Add(ArrayItem);
                ArrayItemIndex += 1;
            }
            return DataFiltered;
        }

        Console.WriteLine("\n// JavaScript-like Array.filter() in C# List");

        dynamic Numbers = new List<dynamic>() {12, 34, 27, 23, 65, 93, 36, 87, 4, 254};
        Console.WriteLine($"Numbers: {JsonStringify(Numbers)}");

        dynamic NumbersEven;
        dynamic NumbersOdd;

        Console.WriteLine("// using JavaScript-like Array.filter() function \"ArrayFilterV1\"");

        NumbersEven = ArrayFilterV1((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => ((Number % 2) == 0)), Numbers);
        Console.WriteLine($"even numbers only: {JsonStringify(NumbersEven)}");
        // even numbers only: [12, 34, 36, 4, 254]

        NumbersOdd = ArrayFilterV1((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => ((Number % 2) != 0)), Numbers);
        Console.WriteLine($"odd numbers only: {JsonStringify(NumbersOdd)}");
        // odd numbers only: [27, 23, 65, 93, 87]

        Console.WriteLine("// using JavaScript-like Array.filter() function \"ArrayFilterV2\"");

        NumbersEven = ArrayFilterV2((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => ((Number % 2) == 0)), Numbers);
        Console.WriteLine($"even numbers only: {JsonStringify(NumbersEven)}");
        // even numbers only: [12, 34, 36, 4, 254]

        NumbersOdd = ArrayFilterV2((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Number, dynamic ArrayItemIndex, List<dynamic> AnArray) => ((Number % 2) != 0)), Numbers);
        Console.WriteLine($"odd numbers only: {JsonStringify(NumbersOdd)}");
        // odd numbers only: [27, 23, 65, 93, 87]

        Console.WriteLine("// using C# Array.filter() built-in method \"IEnumerable.Where().ToList()\"");

        NumbersEven = ((IEnumerable<dynamic>)Numbers).Where((Func<dynamic, bool>)((dynamic Number) => ((Number % 2) == 0))).ToList();
        Console.WriteLine($"even numbers only: {JsonStringify(NumbersEven)}");
        // even numbers only: [12, 34, 36, 4, 254]

        NumbersOdd = ((IEnumerable<dynamic>)Numbers).Where((Func<dynamic, bool>)((dynamic Number) => ((Number % 2) != 0))).ToList();
        Console.WriteLine($"odd numbers only: {JsonStringify(NumbersOdd)}");
        // odd numbers only: [27, 23, 65, 93, 87]

        Console.WriteLine("\n// JavaScript-like Array.filter() in C# List of Dictionaries");

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

        dynamic ProductsBelow100;
        dynamic ProductsAbove100;

        Console.WriteLine("// using JavaScript-like Array.filter() function \"ArrayFilterV1\"");

        ProductsBelow100 = ArrayFilterV1((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Product, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Product["price"] <= 100)), Products);
        Console.WriteLine($"products with price <= 100 only: {JsonStringify(ProductsBelow100, Pretty: true)}");
        // products with price <= 100 only: [
        //     {
        //         "code": "potato_chips",
        //         "price": 5
        //     }
        // ]

        ProductsAbove100 = ArrayFilterV1((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Product, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Product["price"] > 100)), Products);
        Console.WriteLine($"products with price > 100 only: {JsonStringify(ProductsAbove100, Pretty: true)}");
        // products with price > 100 only: [
        //     {
        //         "code": "pasta",
        //         "price": 321
        //     },
        //     {
        //         "code": "bubble_gum",
        //         "price": 233
        //     },
        //     {
        //         "code": "towel",
        //         "price": 499
        //     }
        // ]

        Console.WriteLine("// using JavaScript-like Array.filter() function \"ArrayFilterV2\"");

        ProductsBelow100 = ArrayFilterV2((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Product, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Product["price"] <= 100)), Products);
        Console.WriteLine($"products with price <= 100 only: {JsonStringify(ProductsBelow100, Pretty: true)}");
        // products with price <= 100 only: [
        //     {
        //         "code": "potato_chips",
        //         "price": 5
        //     }
        // ]

        ProductsAbove100 = ArrayFilterV2((Func<dynamic, dynamic, List<dynamic>, bool>)((dynamic Product, dynamic ArrayItemIndex, List<dynamic> AnArray) => (Product["price"] > 100)), Products);
        Console.WriteLine($"products with price > 100 only: {JsonStringify(ProductsAbove100, Pretty: true)}");
        // products with price > 100 only: [
        //     {
        //         "code": "pasta",
        //         "price": 321
        //     },
        //     {
        //         "code": "bubble_gum",
        //         "price": 233
        //     },
        //     {
        //         "code": "towel",
        //         "price": 499
        //     }
        // ]

        Console.WriteLine("// using C# Array.filter() built-in method \"IEnumerable.Where().ToList()\"");

        ProductsBelow100 = ((IEnumerable<dynamic>)Products).Where((Func<dynamic, bool>)((dynamic Product) => (Product["price"] <= 100))).ToList();
        Console.WriteLine($"products with price <= 100 only: {JsonStringify(ProductsBelow100, Pretty: true)}");
        // products with price <= 100 only: [
        //     {
        //         "code": "potato_chips",
        //         "price": 5
        //     }
        // ]

        ProductsAbove100 = ((IEnumerable<dynamic>)Products).Where((Func<dynamic, bool>)((dynamic Product) => (Product["price"] > 100))).ToList();
        Console.WriteLine($"products with price > 100 only: {JsonStringify(ProductsAbove100, Pretty: true)}");
        // products with price > 100 only: [
        //     {
        //         "code": "pasta",
        //         "price": 321
        //     },
        //     {
        //         "code": "bubble_gum",
        //         "price": 233
        //     },
        //     {
        //         "code": "towel",
        //         "price": 499
        //     }
        // ]
    }
}
