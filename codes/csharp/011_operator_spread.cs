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

        Console.WriteLine("\n// JavaScript-like Spread Syntax (...) in C#");

        // There's no JavaScript-like Spread Syntax (...) in C#.
        // But, we can create our own function to mimic it in C#.

        dynamic Fruits = new List<dynamic>() {"Mango", "Melon", "Banana"};
        Console.WriteLine($"Fruits: {JsonStringify(Fruits)}");

        dynamic Vegetables = new List<dynamic>() {"Carrot", "Tomato"};
        Console.WriteLine($"Vegetables: {JsonStringify(Vegetables)}");

        dynamic CountryCapitalsInAsia = new Dictionary<string, dynamic>() {
            {"Thailand", "Bangkok"},
            {"China", "Beijing"},
            {"Japan", "Tokyo"}
        };
        Console.WriteLine($"CountryCapitalsInAsia: {JsonStringify(CountryCapitalsInAsia, Pretty: true)}");

        dynamic CountryCapitalsInEurope = new Dictionary<string, dynamic>() {
            {"France", "Paris"},
            {"England", "London"}
        };
        Console.WriteLine($"CountryCapitalsInEurope: {JsonStringify(CountryCapitalsInEurope, Pretty: true)}");

        Console.WriteLine("\n// [...array1, ...array2]:\n");

        dynamic Combination1 = SpreadArray(Fruits, Vegetables);
        Console.WriteLine($"Combination1: {JsonStringify(Combination1, Pretty: true)}");
        // Combination1: [
        //     "Mango",
        //     "Melon",
        //     "Banana",
        //     "Carrot",
        //     "Tomato"
        // ]

        dynamic Combination2 = SpreadArray(Fruits, new List<dynamic>() {"Cucumber", "Cabbage"});
        Console.WriteLine($"Combination2: {JsonStringify(Combination2, Pretty: true)}");
        // Combination2: [
        //     "Mango",
        //     "Melon",
        //     "Banana",
        //     "Cucumber",
        //     "Cabbage"
        // ]

        Console.WriteLine("\n// { ...object1, ...object2 }:\n");

        dynamic Combination3 = SpreadObject(CountryCapitalsInAsia, CountryCapitalsInEurope);
        Console.WriteLine($"Combination3: {JsonStringify(Combination3, Pretty: true)}");
        // Combination3: {
        //     "Thailand": "Bangkok",
        //     "China": "Beijing",
        //     "Japan": "Tokyo",
        //     "France": "Paris",
        //     "England": "London"
        // }

        dynamic Combination4 = SpreadObject(CountryCapitalsInAsia, new Dictionary<string, dynamic>() {{"Germany", "Berlin"}, {"Italy", "Rome"}});
        Console.WriteLine($"Combination4: {JsonStringify(Combination4, Pretty: true)}");
        // Combination4: {
        //     "Thailand": "Bangkok",
        //     "China": "Beijing",
        //     "Japan": "Tokyo",
        //     "Germany": "Berlin",
        //     "Italy": "Rome"
        // }

        Console.WriteLine("\n// [...array1, array2] || [...array1, newArrayItem1, newArrayItem2]:\n");

        dynamic Combination5 = SpreadArray(Fruits, new Dictionary<string, dynamic>() {{"Vegetables", Vegetables}});
        Console.WriteLine($"Combination5: {JsonStringify(Combination5, Pretty: true)}");
        // Combination5: [
        //     "Mango",
        //     "Melon",
        //     "Banana",
        //     [
        //         "Carrot",
        //         "Tomato"
        //     ]
        // ]

        dynamic Combination6 = SpreadArray(Fruits, new Dictionary<string, dynamic>() {{"Vegetables", new List<dynamic>() {"Cucumber", "Cabbage"}}});
        Console.WriteLine($"Combination6: {JsonStringify(Combination6, Pretty: true)}");
        // Combination6: [
        //     "Mango",
        //     "Melon",
        //     "Banana",
        //     [
        //         "Cucumber",
        //         "Cabbage"
        //     ]
        // ]

        Console.WriteLine("\n// [...array1, object1] || [...array1, newArrayItem1, newArrayItem2]:\n");

        dynamic Combination7 = SpreadArray(Fruits, new Dictionary<string, dynamic>() {{"CountryCapitalsInAsia", CountryCapitalsInAsia}});
        Console.WriteLine($"Combination7: {JsonStringify(Combination7, Pretty: true)}");
        // Combination7: [
        //     "Mango",
        //     "Melon",
        //     "Banana",
        //     {
        //         "Thailand": "Bangkok",
        //         "China": "Beijing",
        //         "Japan": "Tokyo"
        //     }
        // ]

        dynamic Combination8 = SpreadArray(Fruits, new Dictionary<string, dynamic>() {{"CountryCapitalsInEurope", new Dictionary<string, dynamic>() {{"Germany", "Berlin"}, {"Italy", "Rome"}}}});
        Console.WriteLine($"Combination8: {JsonStringify(Combination8, Pretty: true)}");
        // Combination8: [
        //     "Mango",
        //     "Melon",
        //     "Banana",
        //     {
        //         "Germany": "Berlin",
        //         "Italy": "Rome"
        //     }
        // ]

        Console.WriteLine("\n// { ...object1, object2 } || { ...object1, objectKey: objectValue }:\n");

        dynamic Combination9 = SpreadObject(CountryCapitalsInAsia, new Dictionary<string, dynamic>() {{"CountryCapitalsInEurope", CountryCapitalsInEurope}});
        Console.WriteLine($"Combination9: {JsonStringify(Combination9, Pretty: true)}");
        // Combination9: {
        //     "Thailand": "Bangkok",
        //     "China": "Beijing",
        //     "Japan": "Tokyo",
        //     "CountryCapitalsInEurope": {
        //         "France": "Paris",
        //         "England": "London"
        //     }
        // }

        dynamic Combination10 = SpreadObject(CountryCapitalsInAsia, new Dictionary<string, dynamic>() {{"CountryCapitalsInEurope", new Dictionary<string, dynamic>() {{"Germany", "Berlin"}, {"Italy", "Rome"}}}});
        Console.WriteLine($"Combination10: {JsonStringify(Combination10, Pretty: true)}");
        // Combination10: {
        //     "Thailand": "Bangkok",
        //     "China": "Beijing",
        //     "Japan": "Tokyo",
        //     "CountryCapitalsInEurope": {
        //         "Germany": "Berlin",
        //         "Italy": "Rome"
        //     }
        // }

        Console.WriteLine("\n// { ...object1, array2 } || { ...object1, objectKey: objectValue }:\n");

        dynamic Combination11 = SpreadObject(CountryCapitalsInAsia, new Dictionary<string, dynamic>() {{"Vegetables", Vegetables}});
        Console.WriteLine($"Combination11: {JsonStringify(Combination11, Pretty: true)}");
        // Combination11: {
        //     "Thailand": "Bangkok",
        //     "China": "Beijing",
        //     "Japan": "Tokyo",
        //     "Vegetables": [
        //         "Carrot",
        //         "Tomato"
        //     ]
        // }

        dynamic Combination12 = SpreadObject(CountryCapitalsInAsia, new Dictionary<string, dynamic>() {{"Vegetables", new List<dynamic>() {"Cucumber", "Cabbage"}}});
        Console.WriteLine($"Combination12: {JsonStringify(Combination12, Pretty: true)}");
        // Combination12: {
        //     "Thailand": "Bangkok",
        //     "China": "Beijing",
        //     "Japan": "Tokyo",
        //     "Vegetables": [
        //         "Cucumber",
        //         "Cabbage"
        //     ]
        // }

        Console.WriteLine("\n// { ...object1, ...array2 }:\n");

        dynamic Combination13 = SpreadObject(CountryCapitalsInAsia, Vegetables);
        Console.WriteLine($"Combination13: {JsonStringify(Combination13, Pretty: true)}");
        // Combination13: {
        //     "Thailand": "Bangkok",
        //     "China": "Beijing",
        //     "Japan": "Tokyo",
        //     "0": "Carrot",
        //     "1": "Tomato"
        // }

        dynamic Combination14 = SpreadObject(CountryCapitalsInAsia, new List<dynamic>() {"Cucumber", "Cabbage"});
        Console.WriteLine($"Combination14: {JsonStringify(Combination14, Pretty: true)}");
        // Combination14: {
        //     "Thailand": "Bangkok",
        //     "China": "Beijing",
        //     "Japan": "Tokyo",
        //     "0": "Cucumber",
        //     "1": "Cabbage"
        // }

        // Console.WriteLine("\n// [...array1, ...object1]: // this combination throw an error in JavaScript\n");

        // this combination throw an error in JavaScript
        // dynamic CombinationErrorInJavascript1 = SpreadArray(Fruits, CountryCapitalsInAsia);
        // Console.WriteLine($"CombinationErrorInJavascript1: {JsonStringify(CombinationErrorInJavascript1, Pretty: true)}");

        // this combination throw an error in JavaScript
        // dynamic CombinationErrorInJavascript2 = SpreadArray(Fruits, new Dictionary<string, dynamic>() {{"Germany", "Berlin"}, {"Italy", "Rome"}});
        // Console.WriteLine($"CombinationErrorInJavascript2: {JsonStringify(CombinationErrorInJavascript2, Pretty: true)}");
    }
}
