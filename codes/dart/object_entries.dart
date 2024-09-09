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

	// There's no JavaScript-like Object.entries() in Dart.
    // But, we can create our own function to mimic it in Dart.

	dynamic objectEntries(dynamic anObject) {
        // JavaScript-like Object.entries() function
        dynamic newArray = <dynamic>[];
		anObject.entries.toList().asMap().forEach((dynamic objectEntryIndex, dynamic objectEntry) {
			final objectKey = objectEntry.key;
			final objectValue = objectEntry.value;
			newArray.add(<dynamic>[objectKey, objectValue]);
		});
        return newArray;
    }

	print("\n// JavaScript-like Object.entries() in Dart Map");

    final friend = <String, dynamic>{
        "name": "Alisa",
        "country": "Finland",
        "age": 25,
    };
    print("friend: ${jsonStringify(friend, pretty: true)}");

	print("// using JavaScript-like Object.entries() function \"objectEntries\"");

	print("friend entries: ${jsonStringify(objectEntries(friend))}");
	// friend entries: [["name", "Alisa"], ["country", "Finland"], ["age", 25]]
}
