using System; // Console, Func<>, Action<>, Action

class Program {
    static void Main(string[] Args) {
        Console.WriteLine("\n// Factorial(n) in C#");

        dynamic FactorialV1(int Number) {
            if (Number < 0) throw new InvalidOperationException("Argument should be >= 0");
            if (Number == 0) return 1;
            dynamic Result = 1;
            int I = Number;
            while (true) {
                Result *= I;
                if (I <= 1) break;
                I -= 1;
            }
            return Result;
        }

        dynamic FactorialV2(int Number) {
            if (Number < 0) throw new InvalidOperationException("Argument should be >= 0");
            if (Number == 0) return 1;
            dynamic Result = 1;
            int I = Number;
            while (I >= 1) {
                Result *= I;
                I -= 1;
            }
            return Result;
        }

        dynamic FactorialV3(int Number) {
            if (Number < 0) throw new InvalidOperationException("Argument should be >= 0");
            if (Number == 0) return 1;
            dynamic Result = 1;
            for (int I = Number; I >= 1; I -= 1) {
                Result *= I;
            }
            return Result;
        }

        dynamic FactorialV4(int Number) {
            if (Number < 0) throw new InvalidOperationException("Argument should be >= 0");
            if (Number == 0) return 1;
            return (Number * FactorialV4(Number - 1));
        }

        Console.WriteLine("// using factorial function \"FactorialV1\"");
        Console.WriteLine($"Factorial(5): {FactorialV1(5)}");
        // Factorial(5): 120

        Console.WriteLine("// using factorial function \"FactorialV2\"");
        Console.WriteLine($"Factorial(5): {FactorialV2(5)}");
        // Factorial(5): 120

        Console.WriteLine("// using factorial function \"FactorialV3\"");
        Console.WriteLine($"Factorial(5): {FactorialV3(5)}");
        // Factorial(5): 120

        Console.WriteLine("// using factorial function \"FactorialV4\"");
        Console.WriteLine($"Factorial(5): {FactorialV4(5)}");
        // Factorial(5): 120
    }
}
