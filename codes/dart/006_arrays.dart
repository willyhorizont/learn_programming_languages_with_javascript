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

	fruits.asMap().forEach((dynamic arrayItemIndex, dynamic arrayItem) => print("fruits, foreach loop, index: ${arrayItemIndex}, value: ${arrayItem}"));
	// fruits, foreach loop, index: 0, value: apple
	// fruits, foreach loop, index: 1, value: mango
	// fruits, foreach loop, index: 2, value: orange

	for (final entryItem in fruits.asMap().entries) {
		final arrayItemIndex = entryItem.key;
		final arrayItem = entryItem.value;
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
		arrayItem.entries.toList().asMap().forEach((dynamic entryIndex, dynamic entryItem) {
			final objectKey = entryItem.key;
			final objectValue = entryItem.value;
			print("products, foreach loop, array item index: ${arrayItemIndex}, iteration/entry index: ${entryIndex}, key: ${objectKey}, value: ${objectValue}");
		});
	});
	// products, foreach loop, array item index: 0, iteration/entry index: 0, key: id, value: P1
	// products, foreach loop, array item index: 0, iteration/entry index: 1, key: name, value: bubble gum
	// products, foreach loop, array item index: 1, iteration/entry index: 0, key: id, value: P2
	// products, foreach loop, array item index: 1, iteration/entry index: 1, key: name, value: potato chips

	for (final entryItem in products.asMap().entries) {
		final arrayItemIndex = entryItem.key;
		final arrayItem = entryItem.value;
		arrayItem.entries.toList().asMap().forEach((dynamic entryIndex, dynamic entryItem2) {
			final objectKey = entryItem2.key;
			final objectValue = entryItem2.value;
			print("products, for loop, array item index: ${arrayItemIndex}, iteration/entry index: ${entryIndex}, key: ${objectKey}, value: ${objectValue}");
		});
	}
	// products, for loop, array item index: 0, iteration/entry index: 0, key: id, value: P1
	// products, for loop, array item index: 0, iteration/entry index: 1, key: name, value: bubble gum
	// products, for loop, array item index: 1, iteration/entry index: 0, key: id, value: P2
	// products, for loop, array item index: 1, iteration/entry index: 1, key: name, value: potato chips

	products.asMap().forEach((dynamic arrayItemIndex, dynamic arrayItem) {
		for (final entryItem in arrayItem.entries.toList().asMap().entries) {
			final entryIndex = entryItem.key;
			final objectKey = entryItem.value.key;
			final objectValue = entryItem.value.value;

			print("products, foreach loop, array item index: ${arrayItemIndex}, iteration/entry index: ${entryIndex}, key: ${objectKey}, value: ${objectValue}");
		}
	});
	// products, foreach loop, array item index: 0, iteration/entry index: 0, key: id, value: P1
	// products, foreach loop, array item index: 0, iteration/entry index: 1, key: name, value: bubble gum
	// products, foreach loop, array item index: 1, iteration/entry index: 0, key: id, value: P2
	// products, foreach loop, array item index: 1, iteration/entry index: 1, key: name, value: potato chips

	for (final entryItem in products.asMap().entries) {
		final arrayItemIndex = entryItem.key;
		final arrayItem = entryItem.value;
		for (final entryItem2 in arrayItem.entries.toList().asMap().entries) {
			final entryIndex = entryItem2.key;
			final objectKey = entryItem2.value.key;
			final objectValue = entryItem2.value.value;

			print("products, for loop, array item index: ${arrayItemIndex}, iteration/entry index: ${entryIndex}, key: ${objectKey}, value: ${objectValue}");
		}
	}
	// products, for loop, array item index: 0, iteration/entry index: 0, key: id, value: P1
	// products, for loop, array item index: 0, iteration/entry index: 1, key: name, value: bubble gum
	// products, for loop, array item index: 1, iteration/entry index: 0, key: id, value: P2
	// products, for loop, array item index: 1, iteration/entry index: 1, key: name, value: potato chips
}
