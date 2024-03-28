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

    dynamic arrayEveryV1(dynamic callbackFunction, dynamic anArray) {
        // JavaScript-like Array.every() function
        dynamic isConditionMatch = false;
        for (final entryItem in anArray.asMap().entries) {
            final arrayItemIndex = entryItem.key;
            final arrayItem = entryItem.value;
            isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray);
            if (isConditionMatch == false) break;
        }
        return isConditionMatch;
    }

    dynamic arrayEveryV2(dynamic callbackFunction, dynamic anArray) {
        // JavaScript-like Array.every() function
        dynamic isConditionMatch = false;
        for (final entryItem in anArray.asMap().entries) {
            final arrayItemIndex = entryItem.key;
            final arrayItem = entryItem.value;
            isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray);
            if (isConditionMatch == false) return isConditionMatch;
        }
        return isConditionMatch;
    }

    dynamic arrayEveryV3(dynamic callbackFunction, dynamic anArray) {
        // JavaScript-like Array.every() function
        for (final entryItem in anArray.asMap().entries) {
            final arrayItemIndex = entryItem.key;
            final arrayItem = entryItem.value;
            dynamic isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray);
            if (isConditionMatch == false) return false;
        }
        return true;
    }

    dynamic arrayEveryV4(dynamic callbackFunction, dynamic anArray) {
        // JavaScript-like Array.every() function
        for (final entryItem in anArray.asMap().entries) {
            final arrayItemIndex = entryItem.key;
            final arrayItem = entryItem.value;
            if (callbackFunction(arrayItem, arrayItemIndex, anArray) == false) return false;
        }
        return true;
    }

    print("\n// JavaScript-like Array.every() in Dart List");

    final numbers = <dynamic>[12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
    print("numbers: ${prettyArrayOfPrimitives(numbers)}");

    dynamic isAllNumberLessThan500;
    dynamic isAllNumberMoreThan500;

    print("// using JavaScript-like Array.every() function \"arrayEveryV1\"");

    isAllNumberLessThan500 = arrayEveryV1((dynamic number, dynamic _, dynamic __) => (number < 500), numbers);
    print("is all number < 500: ${isAllNumberLessThan500}");
    // is all number < 500: true

    isAllNumberMoreThan500 = arrayEveryV1((dynamic number, dynamic _, dynamic __) => (number > 500), numbers);
    print("is all number > 500: ${isAllNumberMoreThan500}");
    // is all number > 500: false

    print("// using JavaScript-like Array.every() function \"arrayEveryV2\"");

    isAllNumberLessThan500 = arrayEveryV2((dynamic number, dynamic _, dynamic __) => (number < 500), numbers);
    print("is all number < 500: ${isAllNumberLessThan500}");
    // is all number < 500: true

    isAllNumberMoreThan500 = arrayEveryV2((dynamic number, dynamic _, dynamic __) => (number > 500), numbers);
    print("is all number > 500: ${isAllNumberMoreThan500}");
    // is all number > 500: false

    print("// using JavaScript-like Array.every() function \"arrayEveryV3\"");

    isAllNumberLessThan500 = arrayEveryV3((dynamic number, dynamic _, dynamic __) => (number < 500), numbers);
    print("is all number < 500: ${isAllNumberLessThan500}");
    // is all number < 500: true

    isAllNumberMoreThan500 = arrayEveryV3((dynamic number, dynamic _, dynamic __) => (number > 500), numbers);
    print("is all number > 500: ${isAllNumberMoreThan500}");
    // is all number > 500: false

    print("// using JavaScript-like Array.every() function \"arrayEveryV4\"");

    isAllNumberLessThan500 = arrayEveryV4((dynamic number, dynamic _, dynamic __) => (number < 500), numbers);
    print("is all number < 500: ${isAllNumberLessThan500}");
    // is all number < 500: true

    isAllNumberMoreThan500 = arrayEveryV4((dynamic number, dynamic _, dynamic __) => (number > 500), numbers);
    print("is all number > 500: ${isAllNumberMoreThan500}");
    // is all number > 500: false

    print("// using Dart Array.every() built-in method \"Array.every()\"");

    isAllNumberLessThan500 = numbers.every((dynamic number) => (number < 500));
    print("is all number < 500: ${isAllNumberLessThan500}");
    // is all number < 500: true

    isAllNumberMoreThan500 = numbers.every((dynamic number) => (number > 500));
    print("is all number > 500: ${isAllNumberMoreThan500}");
    // is all number > 500: false

    print("\n// JavaScript-like Array.every() in Dart List of Maps");

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

    dynamic isAllProductPriceLessThan500;
    dynamic isAllProductPriceMoreThan500;

    print("// using JavaScript-like Array.every() function \"arrayEveryV1\"");

    isAllProductPriceLessThan500 = arrayEveryV1((dynamic product, dynamic _, dynamic __) => (product["price"] < 500), products);
    print("is all product price < 500: ${isAllProductPriceLessThan500}");
    // is all product price < 500: true

    isAllProductPriceMoreThan500 = arrayEveryV1((dynamic product, dynamic _, dynamic __) => (product["price"] > 500), products);
    print("is all product price > 500: ${isAllProductPriceMoreThan500}");
    // is all product price > 500: false

    print("// using JavaScript-like Array.every() function \"arrayEveryV2\"");

    isAllProductPriceLessThan500 = arrayEveryV2((dynamic product, dynamic _, dynamic __) => (product["price"] < 500), products);
    print("is all product price < 500: ${isAllProductPriceLessThan500}");
    // is all product price < 500: true

    isAllProductPriceMoreThan500 = arrayEveryV2((dynamic product, dynamic _, dynamic __) => (product["price"] > 500), products);
    print("is all product price > 500: ${isAllProductPriceMoreThan500}");
    // is all product price > 500: false

    print("// using JavaScript-like Array.every() function \"arrayEveryV3\"");

    isAllProductPriceLessThan500 = arrayEveryV3((dynamic product, dynamic _, dynamic __) => (product["price"] < 500), products);
    print("is all product price < 500: ${isAllProductPriceLessThan500}");
    // is all product price < 500: true

    isAllProductPriceMoreThan500 = arrayEveryV3((dynamic product, dynamic _, dynamic __) => (product["price"] > 500), products);
    print("is all product price > 500: ${isAllProductPriceMoreThan500}");
    // is all product price > 500: false

    print("// using JavaScript-like Array.every() function \"arrayEveryV4\"");

    isAllProductPriceLessThan500 = arrayEveryV4((dynamic product, dynamic _, dynamic __) => (product["price"] < 500), products);
    print("is all product price < 500: ${isAllProductPriceLessThan500}");
    // is all product price < 500: true

    isAllProductPriceMoreThan500 = arrayEveryV4((dynamic product, dynamic _, dynamic __) => (product["price"] > 500), products);
    print("is all product price > 500: ${isAllProductPriceMoreThan500}");
    // is all product price > 500: false

    print("// using Dart Array.every() built-in method \"Array.every()\"");

    isAllProductPriceLessThan500 = products.every((dynamic product) => (product["price"] < 500));
    print("is all product price < 500: ${isAllProductPriceLessThan500}");
    // is all product price < 500: true

    isAllProductPriceMoreThan500 = products.every((dynamic product) => (product["price"] > 500));
    print("is all product price > 500: ${isAllProductPriceMoreThan500}");
    // is all product price > 500: false
}
