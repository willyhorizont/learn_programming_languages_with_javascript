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

	dynamic arrayToObject(dynamic anArray) {
		final newObject = <String, dynamic>{};
		for (final entryItem in anArray.asMap().entries) {
			newObject[entryItem.key.toString()] = entryItem.value;
		}
		return newObject;
	}

    print("\n// JavaScript-like Spread Syntax (...) in Dart");

	final fruits = <dynamic>["Mango", "Melon", "Banana"];
	print("fruits: ${prettyArrayOfPrimitives(fruits)}");

	final vegetables = <dynamic>["Carrot", "Tomato"];
	print("vegetables: ${prettyArrayOfPrimitives(vegetables)}");

	final countryCapitalsInAsia = <String, dynamic>{
		"Thailand": "Bangkok",
        "China": "Beijing",
        "Japan": "Tokyo",
	};
	print("countryCapitalsInAsia: ${prettyJsonStringify(countryCapitalsInAsia)}");

	final countryCapitalsInEurope = <String, dynamic>{
		"France": "Paris",
        "England": "London"
	};
	print("countryCapitalsInEurope: ${prettyJsonStringify(countryCapitalsInEurope)}");

	print("\n// [...array1, ...array2]:\n");

	final combination1 = <dynamic>[...fruits, ...vegetables];
	print("combination1: ${prettyJsonStringify(combination1)}");
	// combination1: [
	//     "Mango",
	//     "Melon",
	//     "Banana",
	//     "Carrot",
	//     "Tomato"
	// ]

	final combination2 = <dynamic>[...fruits, ...<dynamic>["Cucumber", "Onion"]];
	print("combination2: ${prettyJsonStringify(combination2)}");
	// combination2: [
	//     "Mango",
	//     "Melon",
	//     "Banana",
	//     "Cucumber",
	//     "Onion"
	// ]

	print("\n// { ...object1, ...object2 }:\n");

	final combination3 = <String, dynamic>{ ...countryCapitalsInAsia, ...countryCapitalsInEurope };
	print("combination3: ${prettyJsonStringify(combination3)}");
	// combination3: {
	//     "Thailand": "Bangkok",
	//     "China": "Beijing",
	//     "Japan": "Tokyo",
	//     "France": "Paris",
	//     "England": "London"
	// }

	final combination4 = <String, dynamic>{ ...countryCapitalsInAsia, ...<String, dynamic>{ "Germany": "Berlin", "Italy": "Rome" } };
	print("combination4: ${prettyJsonStringify(combination4)}");
	// combination4: {
	//     "Thailand": "Bangkok",
	//     "China": "Beijing",
	//     "Japan": "Tokyo",
	//     "Germany": "Berlin",
	//     "Italy": "Rome"
	// }

	print("\n// [...array1, array2]:\n");

	final combination5 = <dynamic>[...fruits, vegetables];
	print("combination5: ${prettyJsonStringify(combination5)}");
	// combination5: [
	//     "Mango",
	//     "Melon",
	//     "Banana",
	//     [
	//         "Carrot",
	//         "Tomato"
	//     ]
	// ]

	final combination6 = <dynamic>[...fruits, <dynamic>["Cucumber", "Onion"]];
	print("combination6: ${prettyJsonStringify(combination6)}");
	// combination6: [
	//     "Mango",
	//     "Melon",
	//     "Banana",
	//     [
	//         "Cucumber",
	//         "Onion"
	//     ]
	// ]

	print("\n// [...array1, object1]:\n");

	final combination7 = <dynamic>[...fruits, countryCapitalsInAsia];
	print("combination7: ${prettyJsonStringify(combination7)}");
	// combination7: [
	//     "Mango",
	//     "Melon",
	//     "Banana",
	//     {
	//         "Thailand": "Bangkok",
	//         "China": "Beijing",
	//         "Japan": "Tokyo"
	//     }
	// ]

	final combination8 = <dynamic>[...fruits, <String, dynamic>{ "Germany": "Berlin", "Italy": "Rome" }];
	print("combination8: ${prettyJsonStringify(combination8)}");
	// combination8: [
	//     "Mango",
	//     "Melon",
	//     "Banana",
	//     {
	//         "Germany": "Berlin",
	//         "Italy": "Rome"
	//     }
	// ]

	print("\n// { ...object1, object2 }:\n");

	final combination9 = <String, dynamic>{ ...countryCapitalsInAsia, "countryCapitalsInEurope": countryCapitalsInEurope };
	print("combination9: ${prettyJsonStringify(combination9)}");
	// combination9: {
	//    "Thailand" : "Bangkok",
	//    "China" : "Beijing",
	//    "Japan" : "Tokyo",
	//    "countryCapitalsInEurope" : {
	//       "France" : "Paris",
	//       "England" : "London"
	//    }
	// }

	final combination10 = <String, dynamic>{ ...countryCapitalsInAsia, "countryCapitalsInEurope": <String, dynamic>{ "Germany": "Berlin", "Italy": "Rome" } };
	print("combination10: ${prettyJsonStringify(combination10)}");
	// combination10: {
	//     "Thailand": "Bangkok",
	//     "China": "Beijing",
	//     "Japan": "Tokyo",
	//     "countryCapitalsInEurope": {
	//         "Germany": "Berlin",
	//         "Italy": "Rome"
	//     }
	// }

	print("\n// { ...object1, array2 }:\n");

	final combination11 = <String, dynamic>{ ...countryCapitalsInAsia, "vegetables": vegetables };
	print("combination11: ${prettyJsonStringify(combination11)}");
	// combination11: {
	//     "Thailand": "Bangkok",
	//     "China": "Beijing",
	//     "Japan": "Tokyo",
	//     "vegetables": [
	//         "Carrot",
	//         "Tomato"
	//     ]
	// }

	final combination12 = <String, dynamic>{ ...countryCapitalsInAsia, "vegetables": <dynamic>["Cucumber", "Onion"] };
	print("combination12: ${prettyJsonStringify(combination12)}");
	// combination12: {
	//     "Thailand": "Bangkok",
	//     "China": "Beijing",
	//     "Japan": "Tokyo",
	//     "vegetables": [
	//         "Cucumber",
	//         "Onion"
	//     ]
	// }

	print("\n// { ...object1, ...array2 }:\n");

	final combination13 = <String, dynamic>{ ...countryCapitalsInAsia, ...arrayToObject(vegetables) };
	print("combination13: ${prettyJsonStringify(combination13)}");
	// combination13: {
	//    "Thailand" : "Bangkok",
	//    "China" : "Beijing",
	//    "Japan" : "Tokyo",
	//    "0" : "Carrot",
	//    "1" : "Tomato"
	// }

	final combination14 = <String, dynamic>{ ...countryCapitalsInAsia, ...arrayToObject(<dynamic>["Cucumber", "Onion"]) };
	print("combination14: ${prettyJsonStringify(combination14)}");
	// combination14: {
	//    "Thailand" : "Bangkok",
	//    "China" : "Beijing",
	//    "Japan" : "Tokyo",
	//    "0" : "Cucumber",
	//    "1" : "Onion"
	// }

	// print("\n// [...array1, ...object1]: // this combination throw an error in JavaScript\n");
	
	// this combination throw an error in JavaScript
	// final combinationErrorInJavascript1 = <dynamic>[...fruits, ...countryCapitalsInAsia.values];
	// print("combinationErrorInJavascript1: ${prettyJsonStringify(combinationErrorInJavascript1)}");

	// this combination throw an error in JavaScript
	// final combinationErrorInJavascript2 = <dynamic>[...fruits, ...{ "Germany": "Berlin", "Italy": "Rome" }.values];
	// print("combinationErrorInJavascript2: ${prettyJsonStringify(combinationErrorInJavascript2)}");
}
