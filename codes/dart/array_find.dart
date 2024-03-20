import "dart:convert";

void main() {
	dynamic prettyArrayOfPrimitives(dynamic anything) {
		final jsonEncoder = new JsonEncoder();
		return jsonEncoder.convert(anything).split(',').join(', ');
	}

	dynamic prettyJsonStringify(dynamic anything) {
		final jsonEncoder = new JsonEncoder.withIndent("    ");
		return jsonEncoder.convert(anything);
	}

	dynamic arrayFindV1(dynamic callbackFunction, dynamic anArray) {
		// JavaScript-like Array.find() function
		dynamic dataFound = null;
		for (final entryItem in anArray.asMap().entries) {
			final arrayItemIndex = entryItem.key;
			final arrayItem = entryItem.value;
			dynamic isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray);
            if (isConditionMatch == true) {
				dataFound = arrayItem;
				break;
			}
		}
		return dataFound;
	}

	dynamic arrayFindV2(dynamic callbackFunction, dynamic anArray) {
		// JavaScript-like Array.find() function
		dynamic dataFound = null;
		for (final entryItem in anArray.asMap().entries) {
			final arrayItemIndex = entryItem.key;
			final arrayItem = entryItem.value;
            if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) {
				dataFound = arrayItem;
				break;
			}
		}
		return dataFound;
	}

	dynamic arrayFindV3(dynamic callbackFunction, dynamic anArray) {
		// JavaScript-like Array.find() function
		for (final entryItem in anArray.asMap().entries) {
			final arrayItemIndex = entryItem.key;
			final arrayItem = entryItem.value;
			dynamic isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray);
            if (isConditionMatch == true) return arrayItem;
		}
		return null;
	}

	dynamic arrayFindV4(dynamic callbackFunction, dynamic anArray) {
		// JavaScript-like Array.find() function
		for (final entryItem in anArray.asMap().entries) {
			final arrayItemIndex = entryItem.key;
			final arrayItem = entryItem.value;
            if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) return arrayItem;
		}
		return null;
	}

    print("\n// JavaScript-like Array.find() in Dart List");

	final numbers = <dynamic>[12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
	print("numbers: ${prettyArrayOfPrimitives(numbers)}");

	dynamic evenNumberFound;
	dynamic oddNumberFound;

	print("// using JavaScript-like Array.find() function \"arrayFindV1\"");

	evenNumberFound = arrayFindV1((dynamic number, dynamic _, dynamic __) => ((number % 2) == 0), numbers);
    print("even number found: ${evenNumberFound}");
    // even number found: 12

	oddNumberFound = arrayFindV1((dynamic number, dynamic _, dynamic __) => ((number % 2) != 0), numbers);
    print("odd number found: ${oddNumberFound}");
    // odd number found: 27

	print("// using JavaScript-like Array.find() function \"arrayFindV2\"");

	evenNumberFound = arrayFindV2((dynamic number, dynamic _, dynamic __) => ((number % 2) == 0), numbers);
    print("even number found: ${evenNumberFound}");
    // even number found: 12

	oddNumberFound = arrayFindV2((dynamic number, dynamic _, dynamic __) => ((number % 2) != 0), numbers);
    print("odd number found: ${oddNumberFound}");
    // odd number found: 27

	print("// using JavaScript-like Array.find() function \"arrayFindV3\"");

	evenNumberFound = arrayFindV3((dynamic number, dynamic _, dynamic __) => ((number % 2) == 0), numbers);
    print("even number found: ${evenNumberFound}");
    // even number found: 12

	oddNumberFound = arrayFindV3((dynamic number, dynamic _, dynamic __) => ((number % 2) != 0), numbers);
    print("odd number found: ${oddNumberFound}");
    // odd number found: 27

	print("// using JavaScript-like Array.find() function \"arrayFindV4\"");

	evenNumberFound = arrayFindV4((dynamic number, dynamic _, dynamic __) => ((number % 2) == 0), numbers);
    print("even number found: ${evenNumberFound}");
    // even number found: 12

	oddNumberFound = arrayFindV4((dynamic number, dynamic _, dynamic __) => ((number % 2) != 0), numbers);
    print("odd number found: ${oddNumberFound}");
    // odd number found: 27

	print("// using Dart Array.find() built-in method \"Array.firstWhere()\"");

	evenNumberFound = numbers.firstWhere((dynamic number) => ((number % 2) == 0));
    print("even number found: ${evenNumberFound}");
    // even number found: 12

	oddNumberFound = numbers.firstWhere((dynamic number) => ((number % 2) != 0));
    print("odd number found: ${oddNumberFound}");
    // odd number found: 27

	print("\n// JavaScript-like Array.find() in Dart List of Maps");

	final products = <dynamic>[
		<String, dynamic>{
			"code": "pasta",
			"price": 321
		},
		<String, dynamic>{
			"code": "bubble_gum",
			"price": 233
		},
		<String, dynamic>{
			"code": "potato_chips",
			"price": 5
		},
		<String, dynamic>{
			"code": "towel",
			"price": 499
		}
	];
	print("products: ${prettyJsonStringify(products)}");

	final productToFind = "bubble_gum";
    print("product to find: ${productToFind}");

	dynamic productFound;

	print("// using JavaScript-like Array.find() function \"arrayFindV1\"");

	productFound = arrayFindV1((dynamic product, dynamic _, dynamic __) => (product["code"] == productToFind), products);
    print("product found index: ${prettyJsonStringify(productFound)}");
	// product found: {
	//     "code":"bubble_gum",
	//     "price": 233
	// }

	print("// using JavaScript-like Array.find() function \"arrayFindV2\"");

	productFound = arrayFindV2((dynamic product, dynamic _, dynamic __) => (product["code"] == productToFind), products);
    print("product found index: ${prettyJsonStringify(productFound)}");
	// product found: {
	//     "code":"bubble_gum",
	//     "price": 233
	// }

	print("// using JavaScript-like Array.find() function \"arrayFindV3\"");

	productFound = arrayFindV3((dynamic product, dynamic _, dynamic __) => (product["code"] == productToFind), products);
    print("product found index: ${prettyJsonStringify(productFound)}");
	// product found: {
	//     "code":"bubble_gum",
	//     "price": 233
	// }

	print("// using JavaScript-like Array.find() function \"arrayFindV4\"");

	productFound = arrayFindV4((dynamic product, dynamic _, dynamic __) => (product["code"] == productToFind), products);
    print("product found index: ${prettyJsonStringify(productFound)}");
	// product found: {
	//     "code":"bubble_gum",
	//     "price": 233
	// }

	print("// using Dart Array.find() built-in method \"Array.firstWhere()\"");

	productFound = products.firstWhere((dynamic product) => (product["code"] == productToFind));
    print("product found index: ${prettyJsonStringify(productFound)}");
	// product found: {
	//     "code":"bubble_gum",
	//     "price": 233
	// }
}
