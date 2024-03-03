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

	dynamic arrayMapV1(dynamic callbackFunction, dynamic anArray) {
		// JavaScript-like Array.map() function
		dynamic newArray = <dynamic>[];
		for (final entryItem in anArray.asMap().entries) {
			final arrayItemIndex = entryItem.key;
			final arrayItem = entryItem.value;
			dynamic newArrayItem = callbackFunction(arrayItem, arrayItemIndex, anArray);
            newArray.add(newArrayItem);
		}
		return newArray;
	}

	dynamic arrayMapV2(dynamic callbackFunction, dynamic anArray) {
		// JavaScript-like Array.map() function
		dynamic newArray = <dynamic>[];
		for (final entryItem in anArray.asMap().entries) {
			final arrayItemIndex = entryItem.key;
			final arrayItem = entryItem.value;
            newArray.add(callbackFunction(arrayItem, arrayItemIndex, anArray));
		}
		return newArray;
	}

    print("\n// JavaScript-like Array.map() in Dart List<dynamic> (List)");

	final numbers = <dynamic>[12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
	print("numbers: ${prettyArrayOfPrimitives(numbers)}");

	dynamic numbersLabeled;

	print("// using JavaScript-like Array.map() function \"arrayMapV1\"");

	numbersLabeled = arrayMapV1((dynamic number, dynamic _, dynamic __) => (<String, dynamic>{ number.toString(): (((number % 2) == 0) ? "even" : "odd") }), numbers);
    print("labeled numbers: ${prettyJsonStringify(numbersLabeled)}");
    // labeled numbers: [
	//     {
	//         "12": "even"
	//     },
	//     {
	//         "34": "even"
	//     },
	//     {
	//         "27": "odd"
	//     },
	//     {
	//         "23": "odd"
	//     },
	//     {
	//         "65": "odd"
	//     },
	//     {
	//         "93": "odd"
	//     },
	//     {
	//         "36": "even"
	//     },
	//     {
	//         "87": "odd"
	//     },
	//     {
	//         "4": "even"
	//     },
	//     {
	//         "254": "even"
	//     }
	// ]

	print("// using JavaScript-like Array.map() function \"arrayMapV2\"");

	numbersLabeled = arrayMapV2((dynamic number, dynamic _, dynamic __) => (<String, dynamic>{ number.toString(): (((number % 2) == 0) ? "even" : "odd") }), numbers);
    print("labeled numbers: ${prettyJsonStringify(numbersLabeled)}");
    // labeled numbers: [
	//     {
	//         "12": "even"
	//     },
	//     {
	//         "34": "even"
	//     },
	//     {
	//         "27": "odd"
	//     },
	//     {
	//         "23": "odd"
	//     },
	//     {
	//         "65": "odd"
	//     },
	//     {
	//         "93": "odd"
	//     },
	//     {
	//         "36": "even"
	//     },
	//     {
	//         "87": "odd"
	//     },
	//     {
	//         "4": "even"
	//     },
	//     {
	//         "254": "even"
	//     }
	// ]

	print("// using Dart Array.map() built-in method \"Array.map().toList()\"");

	numbersLabeled = numbers.map((dynamic number) => (<String, dynamic>{ number.toString(): (((number % 2) == 0) ? "even" : "odd") })).toList();
    print("labeled numbers: ${prettyJsonStringify(numbersLabeled)}");
    // labeled numbers: [
	//     {
	//         "12": "even"
	//     },
	//     {
	//         "34": "even"
	//     },
	//     {
	//         "27": "odd"
	//     },
	//     {
	//         "23": "odd"
	//     },
	//     {
	//         "65": "odd"
	//     },
	//     {
	//         "93": "odd"
	//     },
	//     {
	//         "36": "even"
	//     },
	//     {
	//         "87": "odd"
	//     },
	//     {
	//         "4": "even"
	//     },
	//     {
	//         "254": "even"
	//     }
	// ]

	print("\n// JavaScript-like Array.map() in Dart List<Map<String, dynamic>> (List of Maps)");

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

	dynamic productsLabeled;

	print("// using JavaScript-like Array.map() function \"arrayMapV1\"");

	productsLabeled = arrayMapV1((dynamic product, dynamic _, dynamic __) => (<String, dynamic>{ ...product, "label": ((product["price"] > 100) ? "expensive" : "cheap")}), products);
    print("labeled products: ${prettyJsonStringify(productsLabeled)}");
	// labeled products: [
	//     {
	//         "code": "pasta",
	//         "price": 321,
	//         "label": "expensive"
	//     },
	//     {
	//         "code": "bubble_gum",
	//         "price": 233,
	//         "label": "expensive"
	//     },
	//     {
	//         "code": "potato_chips",
	//         "price": 5,
	//         "label": "cheap"
	//     },
	//     {
	//         "code": "towel",
	//         "price": 499,
	//         "label": "expensive"
	//     }
	// ]

	print("// using JavaScript-like Array.map() function \"arrayMapV2\"");

	productsLabeled = arrayMapV2((dynamic product, dynamic _, dynamic __) => (<String, dynamic>{ ...product, "label": ((product["price"] > 100) ? "expensive" : "cheap")}), products);
    print("labeled products: ${prettyJsonStringify(productsLabeled)}");
	// labeled products: [
	//     {
	//         "code": "pasta",
	//         "price": 321,
	//         "label": "expensive"
	//     },
	//     {
	//         "code": "bubble_gum",
	//         "price": 233,
	//         "label": "expensive"
	//     },
	//     {
	//         "code": "potato_chips",
	//         "price": 5,
	//         "label": "cheap"
	//     },
	//     {
	//         "code": "towel",
	//         "price": 499,
	//         "label": "expensive"
	//     }
	// ]

	print("// using Dart Array.map() built-in method \"Array.map().toList()\"");

	productsLabeled = products.map((dynamic product) => (<String, dynamic>{ ...product, "label": ((product["price"] > 100) ? "expensive" : "cheap")})).toList();
    print("labeled products: ${prettyJsonStringify(productsLabeled)}");
	// labeled products: [
	//     {
	//         "code": "pasta",
	//         "price": 321,
	//         "label": "expensive"
	//     },
	//     {
	//         "code": "bubble_gum",
	//         "price": 233,
	//         "label": "expensive"
	//     },
	//     {
	//         "code": "potato_chips",
	//         "price": 5,
	//         "label": "cheap"
	//     },
	//     {
	//         "code": "towel",
	//         "price": 499,
	//         "label": "expensive"
	//     }
	// ]
}
