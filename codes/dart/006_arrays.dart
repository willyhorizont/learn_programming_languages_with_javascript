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

    // in Dart, JavaScript-like Array is called List

    final fruits = <dynamic>["apple", "mango", "orange"];
    print("fruits: ${prettyArrayOfPrimitives(fruits)}");

    print("fruits, length: ${fruits.length}");
    // fruits, length: 3

    print("fruits, get mango: ${fruits[1]}");
    // fruits, get mango: mango

    print("fruits, first element: ${fruits[0]}");
    // fruits, first element: apple

    print("fruits, first element: ${fruits.first}");
    // fruits, first element: apple

    print("fruits, last element: ${fruits[fruits.length - 1]}");
    // fruits, last element: orange

    print("fruits, last element: ${fruits.last}");
    // fruits, last element: orange

    fruits.asMap().forEach((dynamic arrayItemIndex, dynamic arrayItem) => print("fruits, forEach loop, index: ${arrayItemIndex}, value: ${arrayItem}"));
    // fruits, forEach loop, index: 0, value: apple
    // fruits, forEach loop, index: 1, value: mango
    // fruits, forEach loop, index: 2, value: orange

    for (final objectEntry in fruits.asMap().entries) {
        final arrayItemIndex = objectEntry.key;
        final arrayItem = objectEntry.value;
        print("fruits, for loop, index: ${arrayItemIndex}, value: ${arrayItem}");
    }
    // fruits, for loop, index: 0, value: apple
    // fruits, for loop, index: 1, value: mango
    // fruits, for loop, index: 2, value: orange

    // in Dart, JavaScript-like Array of Objects is called List of Maps

    final products = <dynamic>[
        <String, dynamic>{
            "id": "P1",
            "name": "bubble gum"
        },
        <String, dynamic>{
            "id": "P2",
            "name": "potato chips"
        }
    ];
    print("products: ${prettyJsonStringify(products)}");

    products.asMap().forEach((dynamic arrayItemIndex, dynamic arrayItem) {
        arrayItem.entries.toList().asMap().forEach((dynamic objectEntryIndex, dynamic objectEntry) {
            final objectKey = objectEntry.key;
            final objectValue = objectEntry.value;
            print("products, forEach loop, array item index: ${arrayItemIndex}, object iteration/entry index: ${objectEntryIndex}, key: ${objectKey}, value: ${objectValue}");
        });
    });
    // products, forEach loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
    // products, forEach loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
    // products, forEach loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
    // products, forEach loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips

    for (final objectEntry in products.asMap().entries) {
        final arrayItemIndex = objectEntry.key;
        final arrayItem = objectEntry.value;
        arrayItem.entries.toList().asMap().forEach((dynamic objectEntryIndex, dynamic objectEntry) {
            final objectKey = objectEntry.key;
            final objectValue = objectEntry.value;
            print("products, for loop, array item index: ${arrayItemIndex}, object iteration/entry index: ${objectEntryIndex}, key: ${objectKey}, value: ${objectValue}");
        });
    }
    // products, for loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
    // products, for loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
    // products, for loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
    // products, for loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips

    products.asMap().forEach((dynamic arrayItemIndex, dynamic arrayItem) {
        for (final objectEntry in arrayItem.entries.toList().asMap().entries) {
            final objectEntryIndex = objectEntry.key;
            final objectKey = objectEntry.value.key;
            final objectValue = objectEntry.value.value;

            print("products, forEach loop, array item index: ${arrayItemIndex}, object iteration/entry index: ${objectEntryIndex}, key: ${objectKey}, value: ${objectValue}");
        }
    });
    // products, forEach loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
    // products, forEach loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
    // products, forEach loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
    // products, forEach loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips

    for (final objectEntry in products.asMap().entries) {
        final arrayItemIndex = objectEntry.key;
        final arrayItem = objectEntry.value;
        for (final objectEntry in arrayItem.entries.toList().asMap().entries) {
            final objectEntryIndex = objectEntry.key;
            final objectKey = objectEntry.value.key;
            final objectValue = objectEntry.value.value;

            print("products, for loop, array item index: ${arrayItemIndex}, object iteration/entry index: ${objectEntryIndex}, key: ${objectKey}, value: ${objectValue}");
        }
    }
    // products, for loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
    // products, for loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
    // products, for loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
    // products, for loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips
}
