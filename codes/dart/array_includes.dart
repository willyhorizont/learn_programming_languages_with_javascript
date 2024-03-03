import "dart:convert";

void main() {
    dynamic prettyArrayOfPrimitives(dynamic anything) {
		final jsonEncoder = new JsonEncoder();
		return jsonEncoder.convert(anything).split(',').join(', ');
	}

	print("\n// JavaScript-like Array.includes() in Dart");

	final myFriends = <dynamic>["Alisa", "Trivia"];
	print("myFriends: ${prettyArrayOfPrimitives(myFriends)}");

	dynamic name;
	dynamic isMyFriend;

	print("// using Dart Array.includes() built-in method \"Array.contains()\"");

	name = "Alisa";
    print("name: \"${name}\"");
    isMyFriend = myFriends.contains(name);
    print("is my friends includes \"${name}\": ${isMyFriend}");
    // is my friends includes "Alisa": true

    name = "Trivia";
    print("name: \"${name}\"");
    isMyFriend = myFriends.contains(name);
    print("is my friends includes \"${name}\": ${isMyFriend}");
    // is my friends includes "Trivia": true

    name = "Tony";
    print("name: \"${name}\"");
    isMyFriend = myFriends.contains(name);
    print("is my friends includes \"${name}\": ${isMyFriend}");
    // is my friends includes "Tony": false

    name = "Ezekiel";
    print("name: \"${name}\"");
    isMyFriend = myFriends.contains(name);
    print("is my friends includes \"${name}\": ${isMyFriend}");
    // is my friends includes "Ezekiel": false
}
