using System; // Console, Func<>, Action<>, Action
using System.Linq; // Enumerable

class Program {
    static void Main(string[] Args) {
        dynamic IsNumeric = (Func<dynamic, bool>)((dynamic Anything) => (Anything is sbyte || Anything is byte || Anything is short || Anything is ushort || Anything is int || Anything is uint || Anything is long || Anything is ulong || Anything is float || Anything is double || Anything is decimal));

        Console.WriteLine("\n// FizzBuzz(n) in C#");

        dynamic FizzBuzzV1(int StopNumber) {
            if (StopNumber < 1) throw new InvalidOperationException("Argument should be > 0");
            dynamic Result = "";
            int Number = 1;
            while (true) {
                if (Result == "") {
                    Result = $"{Number}";
                    if (Number >= StopNumber) break;
                    Number += 1;
                    continue;
                }
                if (((Number % 3) == 0) && ((Number % 5) == 0)) {
                    Result = $"{Result}, FizzBuzz";
                    if (Number >= StopNumber) break;
                    Number += 1;
                    continue;
                }
                if ((Number % 3) == 0) {
                    Result = $"{Result}, Fizz";
                    if (Number >= StopNumber) break;
                    Number += 1;
                    continue;
                }
                if ((Number % 5) == 0) {
                    Result = $"{Result}, Buzz";
                    if (Number >= StopNumber) break;
                    Number += 1;
                    continue;
                }
                Result = $"{Result}, {Number}";
                if (Number >= StopNumber) break;
                Number += 1;
            }
            return Result;
        }

        dynamic FizzBuzzV2(int StopNumber) {
            if (StopNumber < 1) throw new InvalidOperationException("Argument should be > 0");
            dynamic Result = "";
            int Number = 1;
            while (Number <= StopNumber) {
                if (Result == "") {
                    Result = $"{Number}";
                    Number += 1;
                    continue;
                }
                if (((Number % 3) == 0) && ((Number % 5) == 0)) {
                    Result = $"{Result}, FizzBuzz";
                    Number += 1;
                    continue;
                }
                if ((Number % 3) == 0) {
                    Result = $"{Result}, Fizz";
                    Number += 1;
                    continue;
                }
                if ((Number % 5) == 0) {
                    Result = $"{Result}, Buzz";
                    Number += 1;
                    continue;
                }
                Result = $"{Result}, {Number}";
                Number += 1;
            }
            return Result;
        }

        dynamic FizzBuzzV3(int StopNumber) {
            if (StopNumber < 1) throw new InvalidOperationException("Argument should be > 0");
            dynamic Result = "";
            int Number = 1;
            while (true) {
                if (Result == "") {
                    Result = $"{Number}";
                } else if (((Number % 3) == 0) && ((Number % 5) == 0)) {
                    Result = $"{Result}, FizzBuzz";
                } else if ((Number % 3) == 0) {
                    Result = $"{Result}, Fizz";
                } else if ((Number % 5) == 0) {
                    Result = $"{Result}, Buzz";
                } else {
                    Result = $"{Result}, {Number}";
                }
                if (Number >= StopNumber) break;
                Number += 1;
            }
            return Result;
        }

        dynamic FizzBuzzV4(int StopNumber) {
            if (StopNumber < 1) throw new InvalidOperationException("Argument should be > 0");
            dynamic Result = "";
            int Number = 1;
            while (Number <= StopNumber) {
                if (Result == "") {
                    Result = $"{Number}";
                } else if (((Number % 3) == 0) && ((Number % 5) == 0)) {
                    Result = $"{Result}, FizzBuzz";
                } else if ((Number % 3) == 0) {
                    Result = $"{Result}, Fizz";
                } else if ((Number % 5) == 0) {
                    Result = $"{Result}, Buzz";
                } else {
                    Result = $"{Result}, {Number}";
                }
                Number += 1;
            }
            return Result;
        }

        dynamic FizzBuzzV5(int StopNumber) {
            if (StopNumber < 1) throw new InvalidOperationException("Argument should be > 0");
            dynamic Result = "";
            int Number = 1;
            while (true) {
                Result = ((Result == "")
                    ? $"{Number}"
                    : ((((Number % 3) == 0) && ((Number % 5) == 0))
                        ? $"{Result}, FizzBuzz"
                        : (((Number % 3) == 0)
                            ? $"{Result}, Fizz"
                            : (((Number % 5) == 0)
                                ? $"{Result}, Buzz"
                                : $"{Result}, {Number}"
                            )
                        )
                    )
                );
                if (Number >= StopNumber) break;
                Number += 1;
            }
            return Result;
        }

        dynamic FizzBuzzV6(int StopNumber) {
            if (StopNumber < 1) throw new InvalidOperationException("Argument should be > 0");
            dynamic Result = "";
            int Number = 1;
            while (Number <= StopNumber) {
                Result = ((Result == "")
                    ? $"{Number}"
                    : ((((Number % 3) == 0) && ((Number % 5) == 0))
                        ? $"{Result}, FizzBuzz"
                        : (((Number % 3) == 0)
                            ? $"{Result}, Fizz"
                            : (((Number % 5) == 0)
                                ? $"{Result}, Buzz"
                                : $"{Result}, {Number}"
                            )
                        )
                    )
                );
                Number += 1;
            }
            return Result;
        }

        dynamic FizzBuzzV7(int StopNumber) {
            if (StopNumber < 1) throw new InvalidOperationException("Argument should be > 0");
            dynamic Result = "";
            int Number = 1;
            while (true) {
                Result = ((Result == "") ? $"{Number}" : ((((Number % 3) == 0) && ((Number % 5) == 0)) ? $"{Result}, FizzBuzz" : (((Number % 3) == 0) ? $"{Result}, Fizz" : (((Number % 5) == 0) ? $"{Result}, Buzz" : $"{Result}, {Number}"))));
                if (Number >= StopNumber) break;
                Number += 1;
            }
            return Result;
        }

        dynamic FizzBuzzV8(int StopNumber) {
            if (StopNumber < 1) throw new InvalidOperationException("Argument should be > 0");
            dynamic Result = "";
            int Number = 1;
            while (Number <= StopNumber) {
                Result = ((Result == "") ? $"{Number}" : ((((Number % 3) == 0) && ((Number % 5) == 0)) ? $"{Result}, FizzBuzz" : (((Number % 3) == 0) ? $"{Result}, Fizz" : (((Number % 5) == 0) ? $"{Result}, Buzz" : $"{Result}, {Number}"))));
                Number += 1;
            }
            return Result;
        }

        dynamic FizzBuzzV9(int StopNumber) {
            if (StopNumber < 1) throw new InvalidOperationException("Argument should be > 0");
            dynamic Result = "";
            for (int Number = 1; Number <= StopNumber; Number += 1) {
                if (Result == "") {
                    Result = $"{Number}";
                    continue;
                }
                if (((Number % 3) == 0) && ((Number % 5) == 0)) {
                    Result = $"{Result}, FizzBuzz";
                    continue;
                }
                if ((Number % 3) == 0) {
                    Result = $"{Result}, Fizz";
                    continue;
                }
                if ((Number % 5) == 0) {
                    Result = $"{Result}, Buzz";
                    continue;
                }
                Result = $"{Result}, {Number}";
            }
            return Result;
        }

        dynamic FizzBuzzV10(int StopNumber) {
            if (StopNumber < 1) throw new InvalidOperationException("Argument should be > 0");
            dynamic Result = "";
            for (int Number = 1; Number <= StopNumber; Number += 1) {
                if (Result == "") {
                    Result = $"{Number}";
                } else if (((Number % 3) == 0) && ((Number % 5) == 0)) {
                    Result = $"{Result}, FizzBuzz";
                } else if ((Number % 3) == 0) {
                    Result = $"{Result}, Fizz";
                } else if ((Number % 5) == 0) {
                    Result = $"{Result}, Buzz";
                } else {
                    Result = $"{Result}, {Number}";
                }
            }
            return Result;
        }

        dynamic FizzBuzzV11(int StopNumber) {
            if (StopNumber < 1) throw new InvalidOperationException("Argument should be > 0");
            dynamic Result = "";
            for (int Number = 1; Number <= StopNumber; Number += 1) {
                Result = ((Result == "")
                    ? $"{Number}"
                    : ((((Number % 3) == 0) && ((Number % 5) == 0))
                        ? $"{Result}, FizzBuzz"
                        : (((Number % 3) == 0)
                            ? $"{Result}, Fizz"
                            : (((Number % 5) == 0)
                                ? $"{Result}, Buzz"
                                : $"{Result}, {Number}"
                            )
                        )
                    )
                );
            }
            return Result;
        }

        dynamic FizzBuzzV12(int StopNumber) {
            if (StopNumber < 1) throw new InvalidOperationException("Argument should be > 0");
            dynamic Result = "";
            for (int Number = 1; Number <= StopNumber; Number += 1) {
                Result = ((Result == "") ? $"{Number}" : ((((Number % 3) == 0) && ((Number % 5) == 0)) ? $"{Result}, FizzBuzz" : (((Number % 3) == 0) ? $"{Result}, Fizz" : (((Number % 5) == 0) ? $"{Result}, Buzz" : $"{Result}, {Number}"))));
            }
            return Result;
        }

        dynamic FizzBuzzV13(int StopNumber) {
            if (StopNumber < 1) throw new InvalidOperationException("Argument should be > 0");
            return Enumerable.Range(1, StopNumber).Aggregate("", (Func<dynamic, int, dynamic>)((dynamic CurrentResult, int CurrentNumber) => ((CurrentResult == "") ? $"{CurrentNumber}" : ((((CurrentNumber % 3) == 0) && ((CurrentNumber % 5) == 0)) ? $"{CurrentResult}, FizzBuzz" : (((CurrentNumber % 3) == 0) ? $"{CurrentResult}, Fizz" : (((CurrentNumber % 5) == 0) ? $"{CurrentResult}, Buzz" : $"{CurrentResult}, {CurrentNumber}"))))));
        }

        Console.WriteLine("// using fizzbuzz function \"FizzBuzzV1\"");
        Console.WriteLine($"FizzBuzz(36): {FizzBuzzV1(36)}");
        // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

        Console.WriteLine("// using fizzbuzz function \"FizzBuzzV2\"");
        Console.WriteLine($"FizzBuzz(36): {FizzBuzzV2(36)}");
        // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

        Console.WriteLine("// using fizzbuzz function \"FizzBuzzV3\"");
        Console.WriteLine($"FizzBuzz(36): {FizzBuzzV3(36)}");
        // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

        Console.WriteLine("// using fizzbuzz function \"FizzBuzzV4\"");
        Console.WriteLine($"FizzBuzz(36): {FizzBuzzV4(36)}");
        // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

        Console.WriteLine("// using fizzbuzz function \"FizzBuzzV5\"");
        Console.WriteLine($"FizzBuzz(36): {FizzBuzzV5(36)}");
        // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

        Console.WriteLine("// using fizzbuzz function \"FizzBuzzV6\"");
        Console.WriteLine($"FizzBuzz(36): {FizzBuzzV6(36)}");
        // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

        Console.WriteLine("// using fizzbuzz function \"FizzBuzzV7\"");
        Console.WriteLine($"FizzBuzz(36): {FizzBuzzV7(36)}");
        // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

        Console.WriteLine("// using fizzbuzz function \"FizzBuzzV8\"");
        Console.WriteLine($"FizzBuzz(36): {FizzBuzzV8(36)}");
        // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

        Console.WriteLine("// using fizzbuzz function \"FizzBuzzV9\"");
        Console.WriteLine($"FizzBuzz(36): {FizzBuzzV9(36)}");
        // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

        Console.WriteLine("// using fizzbuzz function \"FizzBuzzV10\"");
        Console.WriteLine($"FizzBuzz(36): {FizzBuzzV10(36)}");
        // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

        Console.WriteLine("// using fizzbuzz function \"FizzBuzzV11\"");
        Console.WriteLine($"FizzBuzz(36): {FizzBuzzV11(36)}");
        // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

        Console.WriteLine("// using fizzbuzz function \"FizzBuzzV12\"");
        Console.WriteLine($"FizzBuzz(36): {FizzBuzzV12(36)}");
        // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

        Console.WriteLine("// using fizzbuzz function \"FizzBuzzV13\"");
        Console.WriteLine($"FizzBuzz(36): {FizzBuzzV13(36)}");
        // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz
    }
}
