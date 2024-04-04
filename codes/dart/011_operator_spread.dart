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

    dynamic arrayToObject(dynamic anArray) {
        final newObject = <String, dynamic>{};
        for (final objectEntry in anArray.asMap().entries) {
            newObject[objectEntry.key.toString()] = objectEntry.value;
        }
        return newObject;
    }

    print("\n// JavaScript-like Spread Syntax (...) in Dart");

    final fruits = <dynamic>["Mango", "Melon", "Banana"];
    print("fruits: ${jsonStringify(fruits)}");

    final vegetables = <dynamic>["Carrot", "Tomato"];
    print("vegetables: ${jsonStringify(vegetables)}");

    final countryCapitalsInAsia = <String, dynamic>{
        "Thailand": "Bangkok",
        "China": "Beijing",
        "Japan": "Tokyo",
    };
    print("countryCapitalsInAsia: ${jsonStringify(countryCapitalsInAsia, pretty: true)}");

    final countryCapitalsInEurope = <String, dynamic>{
        "France": "Paris",
        "England": "London"
    };
    print("countryCapitalsInEurope: ${jsonStringify(countryCapitalsInEurope, pretty: true)}");

    print("\n// [...array1, ...array2]:\n");

    final combination1 = <dynamic>[...fruits, ...vegetables];
    print("combination1: ${jsonStringify(combination1, pretty: true)}");
    // combination1: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     "Carrot",
    //     "Tomato"
    // ]

    final combination2 = <dynamic>[...fruits, ...<dynamic>["Cucumber", "Cabbage"]];
    print("combination2: ${jsonStringify(combination2, pretty: true)}");
    // combination2: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     "Cucumber",
    //     "Cabbage"
    // ]

    print("\n// { ...object1, ...object2 }:\n");

    final combination3 = <String, dynamic>{ ...countryCapitalsInAsia, ...countryCapitalsInEurope };
    print("combination3: ${jsonStringify(combination3, pretty: true)}");
    // combination3: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "France": "Paris",
    //     "England": "London"
    // }

    final combination4 = <String, dynamic>{ ...countryCapitalsInAsia, ...<String, dynamic>{ "Germany": "Berlin", "Italy": "Rome" } };
    print("combination4: ${jsonStringify(combination4, pretty: true)}");
    // combination4: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "Germany": "Berlin",
    //     "Italy": "Rome"
    // }

    print("\n// [...array1, array2] || [...array1, newArrayItem1, newArrayItem2]:\n");

    final combination5 = <dynamic>[...fruits, vegetables];
    print("combination5: ${jsonStringify(combination5, pretty: true)}");
    // combination5: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     [
    //         "Carrot",
    //         "Tomato"
    //     ]
    // ]

    final combination6 = <dynamic>[...fruits, <dynamic>["Cucumber", "Cabbage"]];
    print("combination6: ${jsonStringify(combination6, pretty: true)}");
    // combination6: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     [
    //         "Cucumber",
    //         "Cabbage"
    //     ]
    // ]

    print("\n// [...array1, object1] || [...array1, newArrayItem1, newArrayItem2]:\n");

    final combination7 = <dynamic>[...fruits, countryCapitalsInAsia];
    print("combination7: ${jsonStringify(combination7, pretty: true)}");
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
    print("combination8: ${jsonStringify(combination8, pretty: true)}");
    // combination8: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     {
    //         "Germany": "Berlin",
    //         "Italy": "Rome"
    //     }
    // ]

    print("\n// { ...object1, object2 } || { ...object1, objectKey: objectValue }:\n");

    final combination9 = <String, dynamic>{ ...countryCapitalsInAsia, "countryCapitalsInEurope": countryCapitalsInEurope };
    print("combination9: ${jsonStringify(combination9, pretty: true)}");
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
    print("combination10: ${jsonStringify(combination10, pretty: true)}");
    // combination10: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "countryCapitalsInEurope": {
    //         "Germany": "Berlin",
    //         "Italy": "Rome"
    //     }
    // }

    print("\n// { ...object1, array2 } || { ...object1, objectKey: objectValue }:\n");

    final combination11 = <String, dynamic>{ ...countryCapitalsInAsia, "vegetables": vegetables };
    print("combination11: ${jsonStringify(combination11, pretty: true)}");
    // combination11: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "vegetables": [
    //         "Carrot",
    //         "Tomato"
    //     ]
    // }

    final combination12 = <String, dynamic>{ ...countryCapitalsInAsia, "vegetables": <dynamic>["Cucumber", "Cabbage"] };
    print("combination12: ${jsonStringify(combination12, pretty: true)}");
    // combination12: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "vegetables": [
    //         "Cucumber",
    //         "Cabbage"
    //     ]
    // }

    print("\n// { ...object1, ...array2 }:\n");

    final combination13 = <String, dynamic>{ ...countryCapitalsInAsia, ...arrayToObject(vegetables) };
    print("combination13: ${jsonStringify(combination13, pretty: true)}");
    // combination13: {
    //    "Thailand" : "Bangkok",
    //    "China" : "Beijing",
    //    "Japan" : "Tokyo",
    //    "0" : "Carrot",
    //    "1" : "Tomato"
    // }

    final combination14 = <String, dynamic>{ ...countryCapitalsInAsia, ...arrayToObject(<dynamic>["Cucumber", "Cabbage"]) };
    print("combination14: ${jsonStringify(combination14, pretty: true)}");
    // combination14: {
    //    "Thailand" : "Bangkok",
    //    "China" : "Beijing",
    //    "Japan" : "Tokyo",
    //    "0" : "Cucumber",
    //    "1" : "Cabbage"
    // }

    // print("\n// [...array1, ...object1]: // this combination throw an error in JavaScript\n");
    
    // this combination throw an error in JavaScript
    // final combinationErrorInJavascript1 = <dynamic>[...fruits, ...countryCapitalsInAsia.values];
    // print("combinationErrorInJavascript1: ${jsonStringify(combinationErrorInJavascript1, pretty: true)}");

    // this combination throw an error in JavaScript
    // final combinationErrorInJavascript2 = <dynamic>[...fruits, ...{ "Germany": "Berlin", "Italy": "Rome" }.values];
    // print("combinationErrorInJavascript2: ${jsonStringify(combinationErrorInJavascript2, pretty: true)}");
}
