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

	dynamic arraySomeV1(dynamic callbackFunction, dynamic anArray) {
		// JavaScript-like Array.some() function
		dynamic isConditionMatch = false;
		for (final entryItem in anArray.asMap().entries) {
			final arrayItemIndex = entryItem.key;
			final arrayItem = entryItem.value;
			isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray);
            if (isConditionMatch == true) break;
		}
		return isConditionMatch;
	}

	dynamic arraySomeV2(dynamic callbackFunction, dynamic anArray) {
		// JavaScript-like Array.some() function
		dynamic isConditionMatch = false;
		for (final entryItem in anArray.asMap().entries) {
			final arrayItemIndex = entryItem.key;
			final arrayItem = entryItem.value;
			isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray);
            if (isConditionMatch == true) return isConditionMatch;
		}
		return isConditionMatch;
	}

	dynamic arraySomeV3(dynamic callbackFunction, dynamic anArray) {
		// JavaScript-like Array.some() function
		for (final entryItem in anArray.asMap().entries) {
			final arrayItemIndex = entryItem.key;
			final arrayItem = entryItem.value;
			dynamic isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray);
            if (isConditionMatch == true) return true;
		}
		return false;
	}

	dynamic arraySomeV4(dynamic callbackFunction, dynamic anArray) {
		// JavaScript-like Array.some() function
		for (final entryItem in anArray.asMap().entries) {
			final arrayItemIndex = entryItem.key;
			final arrayItem = entryItem.value;
            if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) return true;
		}
		return false;
	}

	print("\n// JavaScript-like Array.some() in Dart List<dynamic> (List)");

	final numbers = <dynamic>[12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
	print("numbers: ${prettyArrayOfPrimitives(numbers)}");

	dynamic isAnyNumberLessThan500;
	dynamic isAnyNumberMoreThan500;

	print("// using JavaScript-like Array.some() function \"arraySomeV1\"");

	isAnyNumberLessThan500 = arraySomeV1((dynamic number, dynamic _, dynamic __) => (number < 500), numbers);
    print("is any number < 500: ${isAnyNumberLessThan500}");
    // is any number < 500: true

    isAnyNumberMoreThan500 = arraySomeV1((dynamic number, dynamic _, dynamic __) => (number > 500), numbers);
    print("is any number > 500: ${isAnyNumberMoreThan500}");
    // is any number > 500: false

	print("// using JavaScript-like Array.some() function \"arraySomeV2\"");

	isAnyNumberLessThan500 = arraySomeV2((dynamic number, dynamic _, dynamic __) => (number < 500), numbers);
    print("is any number < 500: ${isAnyNumberLessThan500}");
    // is any number < 500: true

    isAnyNumberMoreThan500 = arraySomeV2((dynamic number, dynamic _, dynamic __) => (number > 500), numbers);
    print("is any number > 500: ${isAnyNumberMoreThan500}");
    // is any number > 500: false

	print("// using JavaScript-like Array.some() function \"arraySomeV3\"");

	isAnyNumberLessThan500 = arraySomeV3((dynamic number, dynamic _, dynamic __) => (number < 500), numbers);
    print("is any number < 500: ${isAnyNumberLessThan500}");
    // is any number < 500: true

    isAnyNumberMoreThan500 = arraySomeV3((dynamic number, dynamic _, dynamic __) => (number > 500), numbers);
    print("is any number > 500: ${isAnyNumberMoreThan500}");
    // is any number > 500: false

	print("// using JavaScript-like Array.some() function \"arraySomeV4\"");

	isAnyNumberLessThan500 = arraySomeV4((dynamic number, dynamic _, dynamic __) => (number < 500), numbers);
    print("is any number < 500: ${isAnyNumberLessThan500}");
    // is any number < 500: true

    isAnyNumberMoreThan500 = arraySomeV4((dynamic number, dynamic _, dynamic __) => (number > 500), numbers);
    print("is any number > 500: ${isAnyNumberMoreThan500}");
    // is any number > 500: false

	print("// using Dart Array.some() built-in method \"Array.any()\"");

	isAnyNumberLessThan500 = numbers.any((dynamic number) => (number < 500));
    print("is any number < 500: ${isAnyNumberLessThan500}");
    // is any number < 500: true

    isAnyNumberMoreThan500 = numbers.any((dynamic number) => (number > 500));
    print("is any number > 500: ${isAnyNumberMoreThan500}");
    // is any number > 500: false

	print("\n// JavaScript-like Array.some() in Dart List<Map<String, dynamic>> (List of Maps)");

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

	dynamic isAnyProductPriceLessThan500;
	dynamic isAnyProductPriceMoreThan500;

	print("// using JavaScript-like Array.some() function \"arraySomeV1\"");

	isAnyProductPriceLessThan500 = arraySomeV1((dynamic product, dynamic _, dynamic __) => (product["price"] < 500), products);
    print("is any product price < 500: ${isAnyProductPriceLessThan500}");
    // is any product price < 500: true

    isAnyProductPriceMoreThan500 = arraySomeV1((dynamic product, dynamic _, dynamic __) => (product["price"] > 500), products);
    print("is any product price > 500: ${isAnyProductPriceMoreThan500}");
    // is any product price > 500: false

	print("// using JavaScript-like Array.some() function \"arraySomeV2\"");

	isAnyProductPriceLessThan500 = arraySomeV2((dynamic product, dynamic _, dynamic __) => (product["price"] < 500), products);
    print("is any product price < 500: ${isAnyProductPriceLessThan500}");
    // is any product price < 500: true

    isAnyProductPriceMoreThan500 = arraySomeV2((dynamic product, dynamic _, dynamic __) => (product["price"] > 500), products);
    print("is any product price > 500: ${isAnyProductPriceMoreThan500}");
    // is any product price > 500: false

	print("// using JavaScript-like Array.some() function \"arraySomeV3\"");

	isAnyProductPriceLessThan500 = arraySomeV3((dynamic product, dynamic _, dynamic __) => (product["price"] < 500), products);
    print("is any product price < 500: ${isAnyProductPriceLessThan500}");
    // is any product price < 500: true

    isAnyProductPriceMoreThan500 = arraySomeV3((dynamic product, dynamic _, dynamic __) => (product["price"] > 500), products);
    print("is any product price > 500: ${isAnyProductPriceMoreThan500}");
    // is any product price > 500: false

	print("// using JavaScript-like Array.some() function \"arraySomeV4\"");

	isAnyProductPriceLessThan500 = arraySomeV4((dynamic product, dynamic _, dynamic __) => (product["price"] < 500), products);
    print("is any product price < 500: ${isAnyProductPriceLessThan500}");
    // is any product price < 500: true

    isAnyProductPriceMoreThan500 = arraySomeV4((dynamic product, dynamic _, dynamic __) => (product["price"] > 500), products);
    print("is any product price > 500: ${isAnyProductPriceMoreThan500}");
    // is any product price > 500: false

	print("// using Dart Array.some() built-in method \"Array.any()\"");

	isAnyProductPriceLessThan500 = products.any((dynamic product) => (product["price"] < 500));
    print("is any product price < 500: ${isAnyProductPriceLessThan500}");
    // is any product price < 500: true

    isAnyProductPriceMoreThan500 = products.any((dynamic product) => (product["price"] > 500));
    print("is any product price > 500: ${isAnyProductPriceMoreThan500}");
    // is any product price > 500: false
}
