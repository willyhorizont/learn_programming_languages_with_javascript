void main() {
    print("\n// FizzBuzz(n) in Dart");

    dynamic fizzbuzzV1(int stopNumber) {
        if (stopNumber < 1) throw Exception("Argument should be > 0");
        dynamic result = "";
        dynamic number = 1;
        while (true) {
            if (result == "") {
                result = "${number}";
                if (number >= stopNumber) break;
                number += 1;
                continue;
            }
            if (((number % 3) == 0) && ((number % 5) == 0)) {
                result = "${result}, FizzBuzz";
                if (number >= stopNumber) break;
                number += 1;
                continue;
            }
            if ((number % 3) == 0) {
                result = "${result}, Fizz";
                if (number >= stopNumber) break;
                number += 1;
                continue;
            }
            if ((number % 5) == 0) {
                result = "${result}, Buzz";
                if (number >= stopNumber) break;
                number += 1;
                continue;
            }
            result = "${result}, ${number}";
            if (number >= stopNumber) break;
            number += 1;
        }
        return result;
    }

    dynamic fizzbuzzV2(int stopNumber) {
        if (stopNumber < 1) throw Exception("Argument should be > 0");
        dynamic result = "";
        dynamic number = 1;
        while (number <= stopNumber) {
            if (result == "") {
                result = "${number}";
                number += 1;
                continue;
            }
            if (((number % 3) == 0) && ((number % 5) == 0)) {
                result = "${result}, FizzBuzz";
                number += 1;
                continue;
            }
            if ((number % 3) == 0) {
                result = "${result}, Fizz";
                number += 1;
                continue;
            }
            if ((number % 5) == 0) {
                result = "${result}, Buzz";
                number += 1;
                continue;
            }
            result = "${result}, ${number}";
            number += 1;
        }
        return result;
    }

    dynamic fizzbuzzV3(int stopNumber) {
        if (stopNumber < 1) throw Exception("Argument should be > 0");
        dynamic result = "";
        dynamic number = 1;
        while (true) {
            if (result == "") {
                result = "${number}";
            } else if (((number % 3) == 0) && ((number % 5) == 0)) {
                result = "${result}, FizzBuzz";
            } else if ((number % 3) == 0) {
                result = "${result}, Fizz";
            } else if ((number % 5) == 0) {
                result = "${result}, Buzz";
            } else {
                result = "${result}, ${number}";
            }
            if (number >= stopNumber) break;
            number += 1;
        }
        return result;
    }

    dynamic fizzbuzzV4(int stopNumber) {
        if (stopNumber < 1) throw Exception("Argument should be > 0");
        dynamic result = "";
        dynamic number = 1;
        while (number <= stopNumber) {
            if (result == "") {
                result = "${number}";
            } else if (((number % 3) == 0) && ((number % 5) == 0)) {
                result = "${result}, FizzBuzz";
            } else if ((number % 3) == 0) {
                result = "${result}, Fizz";
            } else if ((number % 5) == 0) {
                result = "${result}, Buzz";
            } else {
                result = "${result}, ${number}";
            }
            number += 1;
        }
        return result;
    }

    dynamic fizzbuzzV5(int stopNumber) {
        if (stopNumber < 1) throw Exception("Argument should be > 0");
        dynamic result = "";
        dynamic number = 1;
        while (true) {
            result = ((result == "")
                ? "${number}"
                : ((((number % 3) == 0) && ((number % 5) == 0))
                    ? "${result}, FizzBuzz"
                    : (((number % 3) == 0)
                        ? "${result}, Fizz"
                        : (((number % 5) == 0)
                            ? "${result}, Buzz"
                            : "${result}, ${number}"
                        )
                    )
                )
            );
            if (number >= stopNumber) break;
            number += 1;
        }
        return result;
    }

    dynamic fizzbuzzV6(int stopNumber) {
        if (stopNumber < 1) throw Exception("Argument should be > 0");
        dynamic result = "";
        dynamic number = 1;
        while (number <= stopNumber) {
            result = ((result == "")
                ? "${number}"
                : ((((number % 3) == 0) && ((number % 5) == 0))
                    ? "${result}, FizzBuzz"
                    : (((number % 3) == 0)
                        ? "${result}, Fizz"
                        : (((number % 5) == 0)
                            ? "${result}, Buzz"
                            : "${result}, ${number}"
                        )
                    )
                )
            );
            number += 1;
        }
        return result;
    }

    dynamic fizzbuzzV7(int stopNumber) {
        if (stopNumber < 1) throw Exception("Argument should be > 0");
        dynamic result = "";
        dynamic number = 1;
        while (true) {
            result = ((result == "") ? "${number}" : ((((number % 3) == 0) && ((number % 5) == 0)) ? "${result}, FizzBuzz" : (((number % 3) == 0) ? "${result}, Fizz" : (((number % 5) == 0) ? "${result}, Buzz" : "${result}, ${number}"))));
            if (number >= stopNumber) break;
            number += 1;
        }
        return result;
    }

    dynamic fizzbuzzV8(int stopNumber) {
        if (stopNumber < 1) throw Exception("Argument should be > 0");
        dynamic result = "";
        dynamic number = 1;
        while (number <= stopNumber) {
            result = ((result == "") ? "${number}" : ((((number % 3) == 0) && ((number % 5) == 0)) ? "${result}, FizzBuzz" : (((number % 3) == 0) ? "${result}, Fizz" : (((number % 5) == 0) ? "${result}, Buzz" : "${result}, ${number}"))));
            number += 1;
        }
        return result;
    }

    dynamic fizzbuzzV9(int stopNumber) {
        if (stopNumber < 1) throw Exception("Argument should be > 0");
        dynamic result = "";
        for (dynamic number = 1; number <= stopNumber; number += 1) {
            if (result == "") {
                result = "${number}";
                continue;
            }
            if (((number % 3) == 0) && ((number % 5) == 0)) {
                result = "${result}, FizzBuzz";
                continue;
            }
            if ((number % 3) == 0) {
                result = "${result}, Fizz";
                continue;
            }
            if ((number % 5) == 0) {
                result = "${result}, Buzz";
                continue;
            }
            result = "${result}, ${number}";
        }
        return result;
    }

    dynamic fizzbuzzV10(int stopNumber) {
        if (stopNumber < 1) throw Exception("Argument should be > 0");
        dynamic result = "";
        for (dynamic number = 1; number <= stopNumber; number += 1) {
            if (result == "") {
                result = "${number}";
            } else if (((number % 3) == 0) && ((number % 5) == 0)) {
                result = "${result}, FizzBuzz";
            } else if ((number % 3) == 0) {
                result = "${result}, Fizz";
            } else if ((number % 5) == 0) {
                result = "${result}, Buzz";
            } else {
                result = "${result}, ${number}";
            }
        }
        return result;
    }

    dynamic fizzbuzzV11(int stopNumber) {
        if (stopNumber < 1) throw Exception("Argument should be > 0");
        dynamic result = "";
        for (dynamic number = 1; number <= stopNumber; number += 1) {
            result = ((result == "")
                ? "${number}"
                : ((((number % 3) == 0) && ((number % 5) == 0))
                    ? "${result}, FizzBuzz"
                    : (((number % 3) == 0)
                        ? "${result}, Fizz"
                        : (((number % 5) == 0)
                            ? "${result}, Buzz"
                            : "${result}, ${number}"
                        )
                    )
                )
            );
        }
        return result;
    }

    dynamic fizzbuzzV12(int stopNumber) {
        if (stopNumber < 1) throw Exception("Argument should be > 0");
        dynamic result = "";
        for (dynamic number = 1; number <= stopNumber; number += 1) {
            result = ((result == "") ? "${number}" : ((((number % 3) == 0) && ((number % 5) == 0)) ? "${result}, FizzBuzz" : (((number % 3) == 0) ? "${result}, Fizz" : (((number % 5) == 0) ? "${result}, Buzz" : "${result}, ${number}"))));
        }
        return result;
    }

    dynamic fizzbuzzV13(int stopNumber) {
        if (stopNumber < 1) throw Exception("Argument should be > 0");
        return Iterable.generate(stopNumber, (i) => i + 1).fold("", (dynamic currentResult, dynamic currentNumber) => ((currentResult == "") ? "${currentNumber}" : ((((currentNumber % 3) == 0) && ((currentNumber % 5) == 0)) ? "${currentResult}, FizzBuzz" : (((currentNumber % 3) == 0) ? "${currentResult}, Fizz" : (((currentNumber % 5) == 0) ? "${currentResult}, Buzz" : "${currentResult}, ${currentNumber}")))));
    }

    dynamic fizzbuzzV14(int stopNumber) {
        if (stopNumber < 1) throw Exception("Argument should be > 0");
        return List.generate(stopNumber, (i) => i + 1).fold("", (dynamic currentResult, dynamic currentNumber) => ((currentResult == "") ? "${currentNumber}" : ((((currentNumber % 3) == 0) && ((currentNumber % 5) == 0)) ? "${currentResult}, FizzBuzz" : (((currentNumber % 3) == 0) ? "${currentResult}, Fizz" : (((currentNumber % 5) == 0) ? "${currentResult}, Buzz" : "${currentResult}, ${currentNumber}")))));
    }

    print('// using fizzbuzz function "fizzbuzzV1"');
    print('FizzBuzz(36): ${fizzbuzzV1(36)}');
    // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

    print('// using fizzbuzz function "fizzbuzzV2"');
    print('FizzBuzz(36): ${fizzbuzzV2(36)}');
    // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

    print('// using fizzbuzz function "fizzbuzzV3"');
    print('FizzBuzz(36): ${fizzbuzzV3(36)}');
    // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

    print('// using fizzbuzz function "fizzbuzzV4"');
    print('FizzBuzz(36): ${fizzbuzzV4(36)}');
    // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

    print('// using fizzbuzz function "fizzbuzzV5"');
    print('FizzBuzz(36): ${fizzbuzzV5(36)}');
    // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

    print('// using fizzbuzz function "fizzbuzzV6"');
    print('FizzBuzz(36): ${fizzbuzzV6(36)}');
    // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

    print('// using fizzbuzz function "fizzbuzzV7"');
    print('FizzBuzz(36): ${fizzbuzzV7(36)}');
    // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

    print('// using fizzbuzz function "fizzbuzzV8"');
    print('FizzBuzz(36): ${fizzbuzzV8(36)}');
    // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

    print('// using fizzbuzz function "fizzbuzzV9"');
    print('FizzBuzz(36): ${fizzbuzzV9(36)}');
    // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

    print('// using fizzbuzz function "fizzbuzzV10"');
    print('FizzBuzz(36): ${fizzbuzzV10(36)}');
    // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

    print('// using fizzbuzz function "fizzbuzzV11"');
    print('FizzBuzz(36): ${fizzbuzzV11(36)}');
    // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

    print('// using fizzbuzz function "fizzbuzzV12"');
    print('FizzBuzz(36): ${fizzbuzzV12(36)}');
    // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

    print('// using fizzbuzz function "fizzbuzzV13"');
    print('FizzBuzz(36): ${fizzbuzzV13(36)}');
    // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

    print('// using fizzbuzz function "fizzbuzzV14"');
    print('FizzBuzz(36): ${fizzbuzzV14(36)}');
    // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz
}
