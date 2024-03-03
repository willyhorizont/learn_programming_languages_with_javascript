import "dart:convert";

void main() {
	dynamic prettyJsonStringify(dynamic anything) {
		final jsonEncoder = new JsonEncoder.withIndent("    ");
		return jsonEncoder.convert(anything);
	}

	// JavaScript-like Optional Chaining Operator (?.) function
	final optionalChainingV2 = (dynamic anything, List<dynamic> objectPropertiesArray) => ((((anything is! Map<String, dynamic>) && (anything is! List<dynamic>)) || (objectPropertiesArray.length == 0)) ? anything : objectPropertiesArray.fold(null, (dynamic currentResult, dynamic currentItem) => (((currentResult == null) && (anything is Map<String, dynamic>) && (currentItem is String)) ? anything[currentItem.toString()] : (((currentResult == null) && (anything is List<dynamic>) && (currentItem is num)) ? anything[currentItem.toInt()] : (((currentResult is Map<String, dynamic>) && (currentItem is String)) ? currentResult[currentItem.toString()] : (((currentResult is List<dynamic>) && (currentItem is num) && (currentItem.toInt() >= 0) && (currentItem.toInt() < currentResult.length)) ? currentResult[currentItem.toInt()] : null))))));

    print("\n// JavaScript-like Nullish Coalescing Operator (??) in Dart");

	final JSON_OBJECT = <String, dynamic>{
		"foo":  <String, dynamic>{
			"bar": "baz",
		},
		"fruits": <dynamic>["apple", "mango", "banana"]
	};
	print("JSON_OBJECT: ${prettyJsonStringify(JSON_OBJECT)}");

	print('# using JavaScript-like Optional Chaining Operator (?.) function "optionalChainingV2"');

	print("JSON_OBJECT?.foo?.bar ?? \"not found\": ${optionalChainingV2(JSON_OBJECT, ["foo", "bar"]) ?? "not found"}");
	// JSON_OBJECT?.foo?.bar ?? "not found": baz

	print("JSON_OBJECT?.foo?.baz ?? \"not found\": ${optionalChainingV2(JSON_OBJECT, ["foo", "baz"]) ?? "not found"}");
	// JSON_OBJECT?.foo?.baz ?? "not found": "not found"

	print("JSON_OBJECT?.fruits?.[2] ?? \"not found\": ${optionalChainingV2(JSON_OBJECT, ["fruits", 2]) ?? "not found"}");
	// JSON_OBJECT?.fruits?.[2] ?? "not found": banana

	print("JSON_OBJECT?.fruits?.[5] ?? \"not found\": ${optionalChainingV2(JSON_OBJECT, ["fruits", 5]) ?? "not found"}");
	// JSON_OBJECT?.fruits?.[5] ?? "not found": "not found"
}
