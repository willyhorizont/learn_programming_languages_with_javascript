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
}
