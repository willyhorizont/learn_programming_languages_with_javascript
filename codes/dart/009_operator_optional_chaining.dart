import "dart:convert";

void main() {
    print("\n// JavaScript-like Optional Chaining Operator (?.) in Dart");

    // There's no JavaScript-like Optional Chaining Operator (?.) in Dart.
    // But, we can create our own function to mimic it in Dart.

    dynamic prettyJsonStringify(dynamic anything) {
        final jsonEncoder = new JsonEncoder.withIndent("    ");
        return jsonEncoder.convert(anything);
    }

    dynamic optionalChainingV1(dynamic anything, List<dynamic> objectPropertiesArray) {
        // JavaScript-like Optional Chaining Operator (?.) function
        if (((anything is! Map<String, dynamic>) && (anything is! List<dynamic>)) || (objectPropertiesArray.length == 0)) {
            return anything;
        }
        return objectPropertiesArray.fold(null, (dynamic currentResult, dynamic currentItem) {
            if ((currentResult == null) && (anything is Map<String, dynamic>) && (currentItem is String)) {
                return anything[currentItem.toString()];
            }
            if ((currentResult == null) && (anything is List<dynamic>) && (currentItem is num) && (currentItem.toInt() >= 0) && (anything.length > currentItem.toInt())) {
                return anything[currentItem.toInt()];
            }
            if ((currentResult is Map<String, dynamic>) && (currentItem is String)) {
                return currentResult[currentItem.toString()];
            }
            if ((currentResult is List<dynamic>) && (currentItem is num) && (currentItem.toInt() >= 0) && (currentResult.length > currentItem.toInt())) {
                return currentResult[currentItem.toInt()];
            }
            return null;
        });
    }

    // JavaScript-like Optional Chaining Operator (?.) function
    final optionalChainingV2 = (dynamic anything, List<dynamic> objectPropertiesArray) => ((((anything is! Map<String, dynamic>) && (anything is! List<dynamic>)) || (objectPropertiesArray.length == 0)) ? anything : objectPropertiesArray.fold(null, (dynamic currentResult, dynamic currentItem) => (((currentResult == null) && (anything is Map<String, dynamic>) && (currentItem is String)) ? anything[currentItem.toString()] : (((currentResult == null) && (anything is List<dynamic>) && (currentItem is num) && (currentItem.toInt() >= 0) && (anything.length > currentItem.toInt())) ? anything[currentItem.toInt()] : (((currentResult is Map<String, dynamic>) && (currentItem is String)) ? currentResult[currentItem.toString()] : (((currentResult is List<dynamic>) && (currentItem is num) && (currentItem.toInt() >= 0) && (currentItem.toInt() < currentResult.length)) ? currentResult[currentItem.toInt()] : null))))));

    final JSON_OBJECT = <String, dynamic>{
        "foo":  <String, dynamic>{
            "bar": "baz",
        },
        "fruits": <dynamic>["apple", "mango", "banana"]
    };
    print("JSON_OBJECT: ${prettyJsonStringify(JSON_OBJECT)}");

    print('# using JavaScript-like Optional Chaining Operator (?.) function "optionalChainingV1"');

    print("JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: ${optionalChainingV1(JSON_OBJECT, ["foo", "bar"])}");
    // JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: baz

    print("JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: ${optionalChainingV1(JSON_OBJECT, ["foo", "baz"])}");
    // JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: null

    print("JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: ${optionalChainingV1(JSON_OBJECT, ["fruits", 2])}");
    // JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: banana

    print("JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: ${optionalChainingV1(JSON_OBJECT, ["fruits", 5])}");
    // JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: null

    print('# using JavaScript-like Optional Chaining Operator (?.) function "optionalChainingV2"');

    print("JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: ${optionalChainingV2(JSON_OBJECT, ["foo", "bar"])}");
    // JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: baz

    print("JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: ${optionalChainingV2(JSON_OBJECT, ["foo", "baz"])}");
    // JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: null

    print("JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: ${optionalChainingV2(JSON_OBJECT, ["fruits", 2])}");
    // JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: banana

    print("JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: ${optionalChainingV2(JSON_OBJECT, ["fruits", 5])}");
    // JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: null
}
