using System; // Console, Func<>, Action<>, Action
using System.Linq; // Enumerable

class Program {
    static void Main(string[] Args) {
        // while loop

        int i1 = 1;
        while (true) {
            if (i1 == 2) {
                if (i1 >= 5) break;
                i1 += 1;
                continue;
            }
            Console.WriteLine($"while loop v1, i1 is {i1}");
            if (i1 >= 5) break;
            i1 += 1;
        }

        int i2 = 1;
        while (i2 <= 5) {
            if (i2 == 2) {
                i2 += 1;
                continue;
            }
            Console.WriteLine($"while loop v2, i2 is {i2}");
            i2 += 1;
        }

        // for loop

        for (int i3 = 1; i3 <= 10; i3 += 1) {
            if (i3 > 5) break;
            if (i3 == 2) continue;
            Console.WriteLine($"for loop, i3 is {i3}");
        }

        // forEach loop

        foreach (int i4 in Enumerable.Range(1, 10)) {
            if (i4 > 5) break;
            if (i4 == 2) continue;
            Console.WriteLine($"forEach loop ascending, i4 is {i4}");
        }

        foreach (int i5 in Enumerable.Range(1, 10).Reverse().ToList()) {
            if (i5 <= 5) break;
            if (i5 == 9) continue;
            Console.WriteLine($"forEach loop descending, i5 is {i5}");
        }
    }
}
