// ignore_for_file: unused_local_variable, unused_element

void main() {
    // ? function statement or function declaration

	dynamic getRectangleAreaV1(dynamic rectangleWidth, dynamic rectangleLength) {
		return (rectangleWidth * rectangleLength);
	}
	// call the function example: getRectangleAreaV1(7, 5)

	dynamic getRectangleAreaV2(dynamic rectangleWidth, dynamic rectangleLength) => (rectangleWidth * rectangleLength);
	// call the function example: getRectangleAreaV2(7, 5)

	// ? function expression

	final getRectangleAreaV3 = (dynamic rectangleWidth, dynamic rectangleLength) {
		return (rectangleWidth * rectangleLength);
	};
	// call the function example: getRectangleAreaV3(7, 5)

	final getRectangleAreaV4 = (dynamic rectangleWidth, dynamic rectangleLength) => (rectangleWidth * rectangleLength);
	// call the function example: getRectangleAreaV4(7, 5)

	// ? anonymous function

	(dynamic rectangleWidth, dynamic rectangleLength) {
		return (rectangleWidth * rectangleLength);
	};
	(dynamic rectangleWidth, dynamic rectangleLength) => (rectangleWidth * rectangleLength);

	// ? Passing functions as arguments to other functions

	dynamic sayHello(dynamic callbackFunction) {
		print("hello");
    	callbackFunction();
	}

	dynamic sayHowAreYou() {
		print("how are you?");
	}

	sayHello(sayHowAreYou);

	sayHello(() {
		print("how are you?");
	});

	sayHello(() => print("how are you?"));

	// ? Assigning functions to variables or storing them in data structures

	final getRectangleAreaV3Copy = (dynamic rectangleWidth, dynamic rectangleLength) {
		return (rectangleWidth * rectangleLength);
	};

	final getRectangleAreaV4Copy = (dynamic rectangleWidth, dynamic rectangleLength) => (rectangleWidth * rectangleLength);

	final myArrayOfGetRectangleAreaFunctions = <dynamic>[
		getRectangleAreaV1,
		(dynamic rectangleWidth, dynamic rectangleLength) {
			return (rectangleWidth * rectangleLength);
		},
		(dynamic rectangleWidth, dynamic rectangleLength) => (rectangleWidth * rectangleLength)
	];
	final getRectangleAreaFunctionResult1 = myArrayOfGetRectangleAreaFunctions[0](7, 5);
	final getRectangleAreaFunctionResult2 = myArrayOfGetRectangleAreaFunctions[1](7, 5);
	final getRectangleAreaFunctionResult3 = myArrayOfGetRectangleAreaFunctions[2](7, 5);

	dynamic exponentiation(dynamic a, dynamic b) {
		return (a ^ b);
	}

	final simpleCalculator = <String, dynamic>{
		"exponentiation": exponentiation,
		"multiplication": (dynamic a, dynamic b) {
			return (a * b);
		},
		"division": (dynamic a, dynamic b) => (a / b)
	};
	final simpleCalculatorResult1 = simpleCalculator["exponentiation"](2, 4);
	final simpleCalculatorResult2 = simpleCalculator["multiplication"](7, 5);
	final simpleCalculatorResult3 = simpleCalculator["division"](81, 9);

	// ? Returning functions as values from other functions

	dynamic multiplyV1(dynamic a) {
		dynamic multiplyBy(dynamic b) {
			return (a * b);
		}
		return multiplyBy;
	}
	final multiplyBy2 = multiplyV1(2);
	final multiplyBy2Result = multiplyBy2(10); // 20

	dynamic multiplyV2(dynamic a) {
		dynamic multiplyBy(dynamic b) => (a * b);
		return multiplyBy;
	}
	final multiplyBy3 = multiplyV2(3);
	final multiplyBy3Result = multiplyBy3(10); // 30

	dynamic multiplyV3(dynamic a) {
		final multiplyBy = (dynamic b) {
			return (a * b);
		};
		return multiplyBy;
	}
	final multiplyBy4 = multiplyV3(4);
	final multiplyBy4Result = multiplyBy4(10); // 40

	dynamic multiplyV4(dynamic a) {
		final multiplyBy = (dynamic b) => (a * b);
		return multiplyBy;
	}
	final multiplyBy5 = multiplyV4(5);
	final multiplyBy5Result = multiplyBy5(10); // 50

	dynamic multiplyV5(dynamic a) {
		return (dynamic b) {
			return (a * b);
		};
	}
	final multiplyBy6 = multiplyV5(6);
	final multiplyBy6Result = multiplyBy6(10); // 60

	dynamic multiplyV6(dynamic a) {
		return (dynamic b) => (a * b);
	}
	final multiplyBy7 = multiplyV6(7);
	final multiplyBy7Result = multiplyBy7(10); // 70

	final multiplyV7 = (dynamic a) {
		dynamic multiplyBy(dynamic b) {
			return (a * b);
		}
		return multiplyBy;
	};
	final multiplyBy8 = multiplyV7(8);
	final multiplyBy8Result = multiplyBy8(10); // 80

	final multiplyV8 = (dynamic a) {
		dynamic multiplyBy(dynamic b) => (a * b);
		return multiplyBy;
	};
	final multiplyBy9 = multiplyV8(9);
	final multiplyBy9Result = multiplyBy9(10); // 90

	final multiplyV9 = (dynamic a) {
		final multiplyBy = (dynamic b) {
			return (a * b);
		};
		return multiplyBy;
	};
	final multiplyBy10 = multiplyV9(10);
	final multiplyBy10Result = multiplyBy10(10); // 100

	final multiplyV10 = (dynamic a) {
		final multiplyBy = (dynamic b) => (a * b);
		return multiplyBy;
	};
	final multiplyBy11 = multiplyV10(11);
	final multiplyBy11Result = multiplyBy11(10); // 110

	final multiplyV11 = (dynamic a) {
		return (dynamic b) {
			return (a * b);
		};
	};
	final multiplyBy12 = multiplyV11(12);
	final multiplyBy12Result = multiplyBy12(10); // 120

	final multiplyV12 = (dynamic a) {
		return (dynamic b) => (a * b);
	};
	final multiplyBy13 = multiplyV12(13);
	final multiplyBy13Result = multiplyBy13(10); // 130

	final multiplyV13 = (dynamic a) => (dynamic b) => (a * b);
	final multiplyBy14 = multiplyV13(14);
	final multiplyBy14Result = multiplyBy14(10); // 140
}
