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

    dynamic arrayFindIndexV1(dynamic callbackFunction, dynamic anArray) {
        // JavaScript-like Array.findIndex() function
        dynamic dataFoundIndex = -1;
        for (final entryItem in anArray.asMap().entries) {
            final arrayItemIndex = entryItem.key;
            final arrayItem = entryItem.value;
            dynamic isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray);
            if (isConditionMatch == true) {
                dataFoundIndex = arrayItemIndex;
                break;
            }
        }
        return dataFoundIndex;
    }

    dynamic arrayFindIndexV2(dynamic callbackFunction, dynamic anArray) {
        // JavaScript-like Array.findIndex() function
        dynamic dataFoundIndex = -1;
        for (final entryItem in anArray.asMap().entries) {
            final arrayItemIndex = entryItem.key;
            final arrayItem = entryItem.value;
            if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) {
                dataFoundIndex = arrayItemIndex;
                break;
            }
        }
        return dataFoundIndex;
    }

    dynamic arrayFindIndexV3(dynamic callbackFunction, dynamic anArray) {
        // JavaScript-like Array.findIndex() function
        for (final entryItem in anArray.asMap().entries) {
            final arrayItemIndex = entryItem.key;
            final arrayItem = entryItem.value;
            dynamic isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray);
            if (isConditionMatch == true) return arrayItemIndex;
        }
        return -1;
    }

    dynamic arrayFindIndexV4(dynamic callbackFunction, dynamic anArray) {
        // JavaScript-like Array.findIndex() function
        for (final entryItem in anArray.asMap().entries) {
            final arrayItemIndex = entryItem.key;
            final arrayItem = entryItem.value;
            if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) return arrayItemIndex;
        }
        return -1;
    }

    print("\n// JavaScript-like Array.findIndex() in Dart List");

    final numbers = <dynamic>[12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
    print("numbers: ${prettyArrayOfPrimitives(numbers)}");

    final numberToFind = 27;
    print("number to find: ${numberToFind}");

    dynamic numberFoundIndex;

    print("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV1\"");

    numberFoundIndex = arrayFindIndexV1((dynamic number, dynamic _, dynamic __) => (number == numberToFind), numbers);
    print("number found index: ${numberFoundIndex}");
    // number found index: 2

    print("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV2\"");

    numberFoundIndex = arrayFindIndexV2((dynamic number, dynamic _, dynamic __) => (number == numberToFind), numbers);
    print("number found index: ${numberFoundIndex}");
    // number found index: 2

    print("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV3\"");

    numberFoundIndex = arrayFindIndexV3((dynamic number, dynamic _, dynamic __) => (number == numberToFind), numbers);
    print("number found index: ${numberFoundIndex}");
    // number found index: 2

    print("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV4\"");

    numberFoundIndex = arrayFindIndexV4((dynamic number, dynamic _, dynamic __) => (number == numberToFind), numbers);
    print("number found index: ${numberFoundIndex}");
    // number found index: 2

    print("// using Dart Array.findIndex() built-in method \"Array.indexWhere()\"");

    numberFoundIndex = numbers.indexWhere((dynamic number) => (number == numberToFind));
    print("number found index: ${numberFoundIndex}");
    // number found index: 2

    print("\n// JavaScript-like Array.findIndex() in Dart List of Maps");

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

    final productToFind = "pasta";
    print("product to find: ${productToFind}");

    dynamic productFoundIndex;

    print("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV1\"");

    productFoundIndex = arrayFindIndexV1((dynamic product, dynamic _, dynamic __) => (product["code"] == productToFind), products);
    print("product found index: ${productFoundIndex}");
    // product found index: 0

    print("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV2\"");

    productFoundIndex = arrayFindIndexV2((dynamic product, dynamic _, dynamic __) => (product["code"] == productToFind), products);
    print("product found index: ${productFoundIndex}");
    // product found index: 0

    print("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV3\"");

    productFoundIndex = arrayFindIndexV3((dynamic product, dynamic _, dynamic __) => (product["code"] == productToFind), products);
    print("product found index: ${productFoundIndex}");
    // product found index: 0

    print("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV4\"");

    productFoundIndex = arrayFindIndexV4((dynamic product, dynamic _, dynamic __) => (product["code"] == productToFind), products);
    print("product found index: ${productFoundIndex}");
    // product found index: 0

    print("// using Dart Array.findIndex() built-in method \"Array.indexWhere()\"");

    productFoundIndex = products.indexWhere((dynamic product) => (product["code"] == productToFind));
    print("product found index: ${productFoundIndex}");
    // product found index: 0
}
