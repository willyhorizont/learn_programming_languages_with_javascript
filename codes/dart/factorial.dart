void main() {
    print("\n// Factorial(n) in Dart");

	dynamic factorialV1(num number) {
		if ((number > 1) == false) return 1;
        dynamic result = 1;
        dynamic i = number;
        while (true) {
            result *= i;
            i -= 1;
            if (i <= 0) break;
        }
        return result;
	}

	dynamic factorialV2(num number) {
		if ((number > 1) == false) return 1;
        dynamic result = 1;
        dynamic i = number;
        while (i >= 1) {
            result *= i;
            i -= 1;
        }
        return result;
	}

	dynamic factorialV3(num number) {
		if ((number > 1) == false) return 1;
        dynamic result = 1;
        for (dynamic i = number; i >= 1; i -= 1) {
			result *= i;
		}
        return result;
	}

	print('// using factorial function "factorialV1"');
	print("Factorial(5): ${factorialV1(5)}");
	// Factorial(5): 120

	print('// using factorial function "factorialV2"');
	print("Factorial(5): ${factorialV2(5)}");
	// Factorial(5): 120

	print('// using factorial function "factorialV3"');
	print("Factorial(5): ${factorialV3(5)}");
	// Factorial(5): 120
}
