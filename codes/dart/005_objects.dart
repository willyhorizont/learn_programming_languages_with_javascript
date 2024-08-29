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

    // in Dart, JavaScript-like Object is called Map

	// Create using Map.fromEntries()
	// final friend = Map<String, dynamic>.fromEntries([
	// 	   MapEntry("name", "Alisa"),
	// 	   MapEntry("country", "Finland"),
	//     MapEntry("age", 25),
	// ]);

	// Create using Map.of()
	// final friend = Map<String, dynamic>.of({
	// 	  "name": "Alisa",
	// 	  "country": "Finland",
	//    "age": 25,
	// });

	// Create using Map Literal (the best way)
    final friend = <String, dynamic>{
        "name": "Alisa",
        "country": "Finland",
        "age": 25,
    };
    print("friend: ${jsonStringify(friend, pretty: true)}");

    print('friend, get total object keys: ${friend.length}');
    // friend, get total object keys: 3

    print('friend, get country: ${friend["country"]}');
    // friend, get country: Finland

	// iterate over and get each key-value pair
    friend.entries.forEach((dynamic objectEntry) {
        final objectKey = objectEntry.key;
        final objectValue = objectEntry.value;
        print("friend, forEach loop, key: ${objectKey}, value: ${objectValue}");
    });
    // friend, forEach loop, key: name, value: Alisa
    // friend, forEach loop, key: country, value: Finland
    // friend, forEach loop, key: age, value: 25

    // iterate over and get each key-value pair
    friend.forEach((dynamic objectKey, dynamic objectValue) => print("friend, forEach loop, key: ${objectKey}, value: ${objectValue}"));
    // friend, forEach loop, key: name, value: Alisa
    // friend, forEach loop, key: country, value: Finland
    // friend, forEach loop, key: age, value: 25

    // iterate over and get each key-value pair and object iteration/entry index
    friend.entries.toList().asMap().forEach((dynamic objectEntryIndex, dynamic objectEntry) {
        final objectKey = objectEntry.key;
        final objectValue = objectEntry.value;
        print("friend, forEach loop, object iteration/entry index: ${objectEntryIndex}, key: ${objectKey}, value: ${objectValue}");
    });
    // friend, forEach loop, object iteration/entry index: 0, key: name, value: Alisa
    // friend, forEach loop, object iteration/entry index: 1, key: country, value: Finland
    // friend, forEach loop, object iteration/entry index: 2, key: age, value: 25

    // iterate over and get each key-value pair and object iteration/entry index
    for (final objectEntry in friend.entries.toList().asMap().entries) {
        final objectEntryIndex = objectEntry.key;
        final objectKey = objectEntry.value.key;
        final objectValue = objectEntry.value.value;

        print("friend, forEach loop, object iteration/entry index: ${objectEntryIndex}, key: ${objectKey}, value: ${objectValue}");
    }
    // friend, forEach loop, object iteration/entry index: 0, key: name, value: Alisa
    // friend, forEach loop, object iteration/entry index: 1, key: country, value: Finland
    // friend, forEach loop, object iteration/entry index: 2, key: age, value: 25

	friend["age"] = 27;
	print("friend: ${jsonStringify(friend, pretty: true)}");

	friend["gender"] = "Female";
	print("friend: ${jsonStringify(friend, pretty: true)}");

	friend.remove("country");
	print("friend: ${jsonStringify(friend, pretty: true)}");

	// Computed property names: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Object_initializer#computed_property_names
	final deliveryResponseKeyMessage = "message";
	final deliveryResponse = <String, dynamic>{
        deliveryResponseKeyMessage: "ok"
    };
    print("deliveryResponse: ${jsonStringify(deliveryResponse, pretty: true)}");
	final deliveryResponseKeyStatus = "status";
  	deliveryResponse[deliveryResponseKeyStatus] = 200;
    print("deliveryResponse: ${jsonStringify(deliveryResponse, pretty: true)}");
}
