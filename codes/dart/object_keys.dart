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

	print("\n// JavaScript-like Object.keys() in Dart Map");

    final friend = <String, dynamic>{
        "name": "Alisa",
        "country": "Finland",
        "age": 25,
    };
    print("friend: ${jsonStringify(friend, pretty: true)}");

	print("friend keys: ${jsonStringify(friend.keys.toList())}");
	// friend keys: ["name", "country", "age"]
}
