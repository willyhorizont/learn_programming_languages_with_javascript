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

        List<dynamic> SpreadSyntaxArray(params dynamic[] Parameters) {
            dynamic NewArray = new List<dynamic>();
            int ParameterIndex = 0;
            foreach (dynamic Parameter in Parameters) {
                if (Parameter is Dictionary<string, dynamic>) {
                    if (Parameter.Count == 1) {
                        int IterationIndex = 0;
                        foreach (KeyValuePair<string, dynamic> ObjectEntry in (Dictionary<string, dynamic>)Parameter) {
                            string ObjectKey = ObjectEntry.Key;
                            dynamic ObjectValue = ObjectEntry.Value;
                            NewArray.Add(ObjectValue);
                            IterationIndex += 1;
                        }
                        continue;
                    }
                    NewArray.Add(Parameter);
                    continue;
                }
                if (Parameter is List<dynamic>) {
                    int ArrayItemIndex = 0;
                    foreach (dynamic ArrayItem in (List<dynamic>)Parameter) {
                        NewArray.Add(ArrayItem);
                        ArrayItemIndex += 1;
                    }
                    continue;
                }
                ParameterIndex += 1;
            }
            return NewArray;
        }

        Console.WriteLine("\n// JavaScript-like Spread Syntax (...) in C#");

        // There's no JavaScript-like Spread Syntax (...) in C#.
        // But, we can create our own function to mimic it in C#.

        dynamic Fruits = new List<dynamic>() {"Mango", "Melon", "Banana"};
        Console.WriteLine($"Fruits: {PrettyArrayOfPrimitives(Fruits)}");

        dynamic Vegetables = new List<dynamic>() {"Carrot", "Tomato"};
        Console.WriteLine($"Vegetables: {PrettyArrayOfPrimitives(Vegetables)}");

        dynamic CountryCapitalsInAsia = new Dictionary<string, dynamic>() {
            {"Thailand", "Bangkok"},
            {"China", "Beijing"},
            {"Japan", "Tokyo"}
        };
        Console.WriteLine($"CountryCapitalsInAsia: {PrettyJsonStringify(CountryCapitalsInAsia)}");

        dynamic CountryCapitalsInEurope = new Dictionary<string, dynamic>() {
            {"France", "Paris"},
            {"England", "London"}
        };
        Console.WriteLine($"CountryCapitalsInEurope: {PrettyJsonStringify(CountryCapitalsInEurope)}");

        Console.WriteLine("\n// [...array1, ...array2]:\n");

        dynamic Combination1 = SpreadSyntaxArray(Fruits, Vegetables);
        Console.WriteLine($"Combination1: {PrettyJsonStringify(Combination1)}");
        // Combination1: [
        //     "Mango",
        //     "Melon",
        //     "Banana",
        //     "Carrot",
        //     "Tomato"
        // ]

        dynamic Combination2 = SpreadSyntaxArray(Fruits, new List<dynamic>() {"Cucumber", "Cabbage"});
        Console.WriteLine($"Combination2: {PrettyJsonStringify(Combination2)}");
        // Combination2: [
        //     "Mango",
        //     "Melon",
        //     "Banana",
        //     "Cucumber",
        //     "Cabbage"
        // ]

        Console.WriteLine("\n// { ...object1, ...object2 }:\n");

        dynamic Combination3 = SpreadSyntaxObject(CountryCapitalsInAsia, CountryCapitalsInEurope);
        Console.WriteLine($"Combination3: {PrettyJsonStringify(Combination3)}");
        // Combination3: {
        //     "Thailand": "Bangkok",
        //     "China": "Beijing",
        //     "Japan": "Tokyo",
        //     "France": "Paris",
        //     "England": "London"
        // }

        dynamic Combination4 = SpreadSyntaxObject(CountryCapitalsInAsia, new Dictionary<string, dynamic>() {{"Germany", "Berlin"}, {"Italy", "Rome"}});
        Console.WriteLine($"Combination4: {PrettyJsonStringify(Combination4)}");
        // Combination4: {
        //     "Thailand": "Bangkok",
        //     "China": "Beijing",
        //     "Japan": "Tokyo",
        //     "Germany": "Berlin",
        //     "Italy": "Rome"
        // }

        Console.WriteLine("\n// [...array1, array2]:\n");

        dynamic Combination5 = SpreadSyntaxArray(Fruits, new Dictionary<string, dynamic>() {{"Vegetables", Vegetables}});
        Console.WriteLine($"Combination5: {PrettyJsonStringify(Combination5)}");
        // Combination5: [
        //     "Mango",
        //     "Melon",
        //     "Banana",
        //     [
        //         "Carrot",
        //         "Tomato"
        //     ]
        // ]

        dynamic Combination6 = SpreadSyntaxArray(Fruits, new Dictionary<string, dynamic>() {{"Vegetables", new List<dynamic>() {"Cucumber", "Cabbage"}}});
        Console.WriteLine($"Combination6: {PrettyJsonStringify(Combination6)}");
        // Combination6: [
        //     "Mango",
        //     "Melon",
        //     "Banana",
        //     [
        //         "Cucumber",
        //         "Cabbage"
        //     ]
        // ]

        Console.WriteLine("\n// [...array1, object1]:\n");

        dynamic Combination7 = SpreadSyntaxArray(Fruits, new Dictionary<string, dynamic>() {{"CountryCapitalsInAsia", CountryCapitalsInAsia}});
        Console.WriteLine($"Combination7: {PrettyJsonStringify(Combination7)}");
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

        dynamic Combination8 = SpreadSyntaxArray(Fruits, new Dictionary<string, dynamic>() {{"CountryCapitalsInEurope", new Dictionary<string, dynamic>() {{"Germany", "Berlin"}, {"Italy", "Rome"}}}});
        Console.WriteLine($"Combination8: {PrettyJsonStringify(Combination8)}");
        // Combination8: [
        //     "Mango",
        //     "Melon",
        //     "Banana",
        //     {
        //         "Germany": "Berlin",
        //         "Italy": "Rome"
        //     }
        // ]

        Console.WriteLine("\n// { ...object1, object2 }:\n");

        dynamic Combination9 = SpreadSyntaxObject(CountryCapitalsInAsia, new Dictionary<string, dynamic>() {{"CountryCapitalsInEurope", CountryCapitalsInEurope}});
        Console.WriteLine($"Combination9: {PrettyJsonStringify(Combination9)}");
        // Combination9: {
        //     "Thailand": "Bangkok",
        //     "China": "Beijing",
        //     "Japan": "Tokyo",
        //     "CountryCapitalsInEurope": {
        //         "France": "Paris",
        //         "England": "London"
        //     }
        // }

        dynamic Combination10 = SpreadSyntaxObject(CountryCapitalsInAsia, new Dictionary<string, dynamic>() {{"CountryCapitalsInEurope", new Dictionary<string, dynamic>() {{"Germany", "Berlin"}, {"Italy", "Rome"}}}});
        Console.WriteLine($"Combination10: {PrettyJsonStringify(Combination10)}");
        // Combination10: {
        //     "Thailand": "Bangkok",
        //     "China": "Beijing",
        //     "Japan": "Tokyo",
        //     "CountryCapitalsInEurope": {
        //         "Germany": "Berlin",
        //         "Italy": "Rome"
        //     }
        // }

        Console.WriteLine("\n// { ...object1, array2 }:\n");

        dynamic Combination11 = SpreadSyntaxObject(CountryCapitalsInAsia, new Dictionary<string, dynamic>() {{"Vegetables", Vegetables}});
        Console.WriteLine($"Combination11: {PrettyJsonStringify(Combination11)}");
        // Combination11: {
        //     "Thailand": "Bangkok",
        //     "China": "Beijing",
        //     "Japan": "Tokyo",
        //     "Vegetables": [
        //         "Carrot",
        //         "Tomato"
        //     ]
        // }

        dynamic Combination12 = SpreadSyntaxObject(CountryCapitalsInAsia, new Dictionary<string, dynamic>() {{"Vegetables", new List<dynamic>() {"Cucumber", "Cabbage"}}});
        Console.WriteLine($"Combination12: {PrettyJsonStringify(Combination12)}");
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

        dynamic Combination13 = SpreadSyntaxObject(CountryCapitalsInAsia, Vegetables);
        Console.WriteLine($"Combination13: {PrettyJsonStringify(Combination13)}");
        // Combination13: {
        //     "Thailand": "Bangkok",
        //     "China": "Beijing",
        //     "Japan": "Tokyo",
        //     "0": "Carrot",
        //     "1": "Tomato"
        // }

        dynamic Combination14 = SpreadSyntaxObject(CountryCapitalsInAsia, new List<dynamic>() {"Cucumber", "Cabbage"});
        Console.WriteLine($"Combination14: {PrettyJsonStringify(Combination14)}");
        // Combination14: {
        //     "Thailand": "Bangkok",
        //     "China": "Beijing",
        //     "Japan": "Tokyo",
        //     "0": "Cucumber",
        //     "1": "Cabbage"
        // }

        // Console.WriteLine("\n// [...array1, ...object1]: // this combination throw an error in JavaScript\n");

        // this combination throw an error in JavaScript
        // dynamic CombinationErrorInJavascript1 = SpreadSyntaxArray(Fruits, CountryCapitalsInAsia);
        // Console.WriteLine($"CombinationErrorInJavascript1: {PrettyJsonStringify(CombinationErrorInJavascript1)}");

        // this combination throw an error in JavaScript
        // dynamic CombinationErrorInJavascript2 = SpreadSyntaxArray(Fruits, new Dictionary<string, dynamic>() {{"Germany", "Berlin"}, {"Italy", "Rome"}});
        // Console.WriteLine($"CombinationErrorInJavascript2: {PrettyJsonStringify(CombinationErrorInJavascript2)}");
    }
}
