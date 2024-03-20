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

	dynamic arrayReduce(dynamic callbackFunction, dynamic anArray, dynamic initialValue) {
		// JavaScript-like Array.reduce() function
		dynamic result = initialValue;
		for (final entryItem in anArray.asMap().entries) {
			final arrayItemIndex = entryItem.key;
			final arrayItem = entryItem.value;
			result = callbackFunction(result, arrayItem, arrayItemIndex, anArray);
		}
		return result;
	}

    print("\n// JavaScript-like Array.reduce() in Dart List");

	final numbers = <dynamic>[36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3];
	print("numbers: ${prettyArrayOfPrimitives(numbers)}");

	dynamic numbersTotal;

	print("// using JavaScript-like Array.reduce() function \"arrayReduce\"");

	numbersTotal = arrayReduce((dynamic currentResult, dynamic currentNumber, dynamic _, dynamic __) => (currentResult + currentNumber), numbers, 0);
    print("total number: ${prettyJsonStringify(numbersTotal)}");
	// total number: 41.2

	print("// using Dart Array.reduce() built-in method \"Array.fold()\"");

	numbersTotal = numbers.fold(0, (dynamic currentResult, dynamic currentNumber) => (currentResult + currentNumber));
    print("total number: ${prettyJsonStringify(numbersTotal)}");
	// total number: 41.2

	print("\n// JavaScript-like Array.reduce() in Dart List of Maps");

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

	dynamic productsGrouped;

	print("// using JavaScript-like Array.reduce() function \"arrayReduce\"");

	productsGrouped = arrayReduce((dynamic currentResult, dynamic currentProduct, dynamic _, dynamic __) => ((currentProduct["price"] > 100) ? <String, dynamic>{...currentResult, "expensive": <dynamic>[...currentResult["expensive"], currentProduct] } : <String, dynamic>{ ...currentResult, "cheap": <dynamic>[...currentResult["cheap"], currentProduct] }), products, <String, dynamic>{ "expensive": <dynamic>[], "cheap": <dynamic>[] });
    print("grouped products: ${prettyJsonStringify(productsGrouped)}");
	// grouped products: {
	// 	"expensive": [
	// 		{
	// 			"code": "pasta",
	// 			"price": 321
	// 		},
	// 		{
	// 			"code": "bubble_gum",
	// 			"price": 233
	// 		},
	// 		{
	// 			"code": "towel",
	// 			"price": 499
	// 		}
	// 	],
	// 	"cheap": [
	// 		{
	// 			"code": "potato_chips",
	// 			"price": 5
	// 		}
	// 	]
	// }

	print("// using Dart Array.reduce() built-in method \"Array.fold()\"");

	productsGrouped = products.fold(<String, dynamic>{ "expensive": <dynamic>[], "cheap": <dynamic>[] }, (dynamic currentResult, dynamic currentProduct) => ((currentProduct["price"] > 100) ? <String, dynamic>{...currentResult, "expensive": <dynamic>[...currentResult["expensive"], currentProduct] } : <String, dynamic>{ ...currentResult, "cheap": <dynamic>[...currentResult["cheap"], currentProduct] }));
    print("grouped products: ${prettyJsonStringify(productsGrouped)}");
	// grouped products: {
	// 	"expensive": [
	// 		{
	// 			"code": "pasta",
	// 			"price": 321
	// 		},
	// 		{
	// 			"code": "bubble_gum",
	// 			"price": 233
	// 		},
	// 		{
	// 			"code": "towel",
	// 			"price": 499
	// 		}
	// 	],
	// 	"cheap": [
	// 		{
	// 			"code": "potato_chips",
	// 			"price": 5
	// 		}
	// 	]
	// }
}
