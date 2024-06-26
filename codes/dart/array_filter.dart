import "dart:convert";

void main() {
    dynamic jsonStringify(dynamic anything, { bool pretty = false, String indent = "    " }) {
		if (pretty == true) {
			final jsonEncoder = new JsonEncoder.withIndent(indent);
			return jsonEncoder.convert(anything);
		}
		final jsonEncoder = new JsonEncoder();
		return jsonEncoder.convert(anything).split(',').join(', ');
    }

    dynamic arrayFilterV1(dynamic callbackFunction, dynamic anArray) {
        // JavaScript-like Array.filter() function
        dynamic dataFiltered = <dynamic>[];
        for (final objectEntry in anArray.asMap().entries) {
            final arrayItemIndex = objectEntry.key;
            final arrayItem = objectEntry.value;
            dynamic isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray);
            if (isConditionMatch == true) dataFiltered.add(arrayItem);
        }
        return dataFiltered;
    }

    dynamic arrayFilterV2(dynamic callbackFunction, dynamic anArray) {
        // JavaScript-like Array.filter() function
        dynamic dataFiltered = <dynamic>[];
        for (final objectEntry in anArray.asMap().entries) {
            final arrayItemIndex = objectEntry.key;
            final arrayItem = objectEntry.value;
            if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) dataFiltered.add(arrayItem);
        }
        return dataFiltered;
    }

    print("\n// JavaScript-like Array.filter() in Dart List");

    final numbers = <dynamic>[12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
    print("numbers: ${jsonStringify(numbers)}");

    dynamic numbersEven;
    dynamic numbersOdd;

    print("// using JavaScript-like Array.filter() function \"arrayFilterV1\"");

    numbersEven = arrayFilterV1((dynamic number, dynamic _, dynamic __) => ((number % 2) == 0), numbers);
    print("even numbers only: ${jsonStringify(numbersEven)}");
    // even numbers only: [12, 34, 36, 4, 254]

    numbersOdd = arrayFilterV1((dynamic number, dynamic _, dynamic __) => ((number % 2) != 0), numbers);
    print("odd numbers only: ${jsonStringify(numbersOdd)}");
    // odd numbers only: [27, 23, 65, 93, 87]

    print("// using JavaScript-like Array.filter() function \"arrayFilterV2\"");

    numbersEven = arrayFilterV2((dynamic number, dynamic _, dynamic __) => ((number % 2) == 0), numbers);
    print("even numbers only: ${jsonStringify(numbersEven)}");
    // even numbers only: [12, 34, 36, 4, 254]

    numbersOdd = arrayFilterV2((dynamic number, dynamic _, dynamic __) => ((number % 2) != 0), numbers);
    print("odd numbers only: ${jsonStringify(numbersOdd)}");
    // odd numbers only: [27, 23, 65, 93, 87]

    print("// using Dart Array.filter() built-in method \"Array.where().toList()\"");

    numbersEven = numbers.where((dynamic number) => ((number % 2) == 0)).toList();
    print("even numbers only: ${jsonStringify(numbersEven)}");
    // even numbers only: [12, 34, 36, 4, 254]

    numbersOdd = numbers.where((dynamic number) => ((number % 2) != 0)).toList();
    print("odd numbers only: ${jsonStringify(numbersOdd)}");
    // odd numbers only: [27, 23, 65, 93, 87]

    print("\n// JavaScript-like Array.filter() in Dart List of Maps");

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
    print("products: ${jsonStringify(products, pretty: true)}");

    dynamic productsBelow100;
    dynamic productsAbove100;

    print("// using JavaScript-like Array.filter() function \"arrayFilterV1\"");

    productsBelow100 = arrayFilterV1((dynamic product, dynamic _, dynamic __) => (product["price"] <= 100), products);
    print("products with price <= 100 only: ${jsonStringify(productsBelow100, pretty: true)}");
    // products with price <= 100 only: [
    //     {
    //         "code": "potato_chips",
    //         "price": 5
    //     }
    // ]

    productsAbove100 = arrayFilterV1((dynamic product, dynamic _, dynamic __) => (product["price"] > 100), products);
    print("products with price > 100 only: ${jsonStringify(productsAbove100, pretty: true)}");
    // products with price > 100 only: [
    //     {
    //         "code": "pasta",
    //         "price": 321
    //     },
    //     {
    //         "code": "bubble_gum",
    //         "price": 233
    //     },
    //     {
    //         "code": "towel",
    //         "price": 499
    //     }
    // ]

    print("// using JavaScript-like Array.filter() function \"arrayFilterV2\"");

    productsBelow100 = arrayFilterV2((dynamic product, dynamic _, dynamic __) => (product["price"] <= 100), products);
    print("products with price <= 100 only: ${jsonStringify(productsBelow100, pretty: true)}");
    // products with price <= 100 only: [
    //     {
    //         "code": "potato_chips",
    //         "price": 5
    //     }
    // ]

    productsAbove100 = arrayFilterV2((dynamic product, dynamic _, dynamic __) => (product["price"] > 100), products);
    print("products with price > 100 only: ${jsonStringify(productsAbove100, pretty: true)}");
    // products with price > 100 only: [
    //     {
    //         "code": "pasta",
    //         "price": 321
    //     },
    //     {
    //         "code": "bubble_gum",
    //         "price": 233
    //     },
    //     {
    //         "code": "towel",
    //         "price": 499
    //     }
    // ]

    print("// using Dart Array.filter() built-in method \"Array.where().toList()\"");

    productsBelow100 = products.where((dynamic product) => (product["price"] <= 100)).toList();
    print("products with price <= 100 only: ${jsonStringify(productsBelow100, pretty: true)}");
    // products with price <= 100 only: [
    //     {
    //         "code": "potato_chips",
    //         "price": 5
    //     }
    // ]

    productsAbove100 = products.where((dynamic product) => (product["price"] > 100)).toList();
    print("products with price > 100 only: ${jsonStringify(productsAbove100, pretty: true)}");
    // products with price > 100 only: [
    //     {
    //         "code": "pasta",
    //         "price": 321
    //     },
    //     {
    //         "code": "bubble_gum",
    //         "price": 233
    //     },
    //     {
    //         "code": "towel",
    //         "price": 499
    //     }
    // ]
}
