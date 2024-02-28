using System;
using System.Linq;
using System.Collections.Generic;

class Program {
    static void Main(string[] args) {
        Console.WriteLine("GetRectangleArea(3, 4): " + GetRectangleArea(3));

        Func<dynamic, bool> IsNumericV2 = (dynamic anything) => double.TryParse(anything?.ToString(), out double _);

        dynamic MyArray = new dynamic[] { "foo", 17, true, null, new dynamic[] { 1, 2, 3 }, new Dictionary<string, dynamic>() { { "foo", "bar" } } };

        foreach (dynamic ArrayItem in MyArray) {
            Console.WriteLine(IsNumericV2(ArrayItem));
        }
    }
    static int GetRectangleArea(int RectangleWidth, int RectangleLength) {
        return RectangleWidth * RectangleLength;
    }
    static int GetRectangleArea(int RectangleWidth) {
        return RectangleWidth * 3;
    }
}
