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

    print("\n// JavaScript-like Array.includes() in Dart");

    final myFriends = <dynamic>["Alisa", "Trivia"];
    print("myFriends: ${jsonStringify(myFriends)}");

    dynamic aName;
    dynamic isMyFriend;

    print("// using Dart Array.includes() built-in method \"Array.contains()\"");

    aName = "Alisa";
    isMyFriend = myFriends.contains(aName);
    print("is my friends includes \"${aName}\": ${isMyFriend}");
    // is my friends includes "Alisa": true

    aName = "Trivia";
    isMyFriend = myFriends.contains(aName);
    print("is my friends includes \"${aName}\": ${isMyFriend}");
    // is my friends includes "Trivia": true

    aName = "Tony";
    isMyFriend = myFriends.contains(aName);
    print("is my friends includes \"${aName}\": ${isMyFriend}");
    // is my friends includes "Tony": false

    aName = "Ezekiel";
    isMyFriend = myFriends.contains(aName);
    print("is my friends includes \"${aName}\": ${isMyFriend}");
    // is my friends includes "Ezekiel": false
}
