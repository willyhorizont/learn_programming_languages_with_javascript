import "dart:convert";

void main() {
	dynamic prettyJsonStringify(dynamic anything) {
		final jsonEncoder = new JsonEncoder.withIndent("    ");
		return jsonEncoder.convert(anything);
	}

	// in Dart, JavaScript-like Object is called Map

    final friend = <String, dynamic>{
		"name": "Alisa",
		"country": "Finland",
		"age": 25,
	};
	print("friend: ${prettyJsonStringify(friend)}");

	print('friend, get country: ${friend["country"]}');
	// friend, get country: Finland

	// iterate over and get each key-value pair
	friend.entries.forEach((dynamic objectEntry) {
		final objectKey = objectEntry.key;
		final objectValue = objectEntry.value;
		print("friend, foreach loop, key: ${objectKey}, value: ${objectValue}");
	});
	// friend, foreach loop, key: name, value: Alisa
	// friend, foreach loop, key: country, value: Finland
	// friend, foreach loop, key: age, value: 25

	// iterate over and get each key-value pair
	friend.forEach((dynamic objectKey, dynamic objectValue) => print("friend, foreach loop, key: ${objectKey}, value: ${objectValue}"));
	// friend, foreach loop, key: name, value: Alisa
	// friend, foreach loop, key: country, value: Finland
	// friend, foreach loop, key: age, value: 25

	// iterate over and get each key-value pair and iteration/entry index
	friend.entries.toList().asMap().forEach((dynamic entryIndex, dynamic entryItem) {
		final objectKey = entryItem.key;
		final objectValue = entryItem.value;
		print("friend, foreach loop, iteration/entry index: ${entryIndex}, key: ${objectKey}, value: ${objectValue}");
	});
	// friend, foreach loop, iteration/entry index: 0, key: name, value: Alisa
	// friend, foreach loop, iteration/entry index: 1, key: country, value: Finland
	// friend, foreach loop, iteration/entry index: 2, key: age, value: 25

	// iterate over and get each key-value pair and iteration/entry index
	for (final entryItem in friend.entries.toList().asMap().entries) {
		final entryIndex = entryItem.key;
		final objectKey = entryItem.value.key;
		final objectValue = entryItem.value.value;

		print("friend, foreach loop, iteration/entry index: ${entryIndex}, key: ${objectKey}, value: ${objectValue}");
	}
	// friend, foreach loop, iteration/entry index: 0, key: name, value: Alisa
	// friend, foreach loop, iteration/entry index: 1, key: country, value: Finland
	// friend, foreach loop, iteration/entry index: 2, key: age, value: 25
}
