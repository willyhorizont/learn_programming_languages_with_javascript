let toCamelCase = { (aString: String) -> String in aString.split(separator: " ").enumerated().map { (wordIndex: Int, aWord: Substring) -> String in ((wordIndex == 0) ? "\(aWord)" : "\(aWord.first!.uppercased())\(aWord.dropFirst())") }.joined(separator: "") }
print(toCamelCase("this is camel case")) // thisIsCamelCase

let toSnakeCase = { (aString: String) -> String in aString.split(separator: " ").map { (aWord: Substring) -> String in "\(aWord.lowercased())" }.joined(separator: "_") }
print(toSnakeCase("this is snake case")) // this_is_snake_case

let toPascalCase = { (aString: String) -> String in aString.split(separator: " ").map { (aWord: Substring) -> String in "\(aWord.first!.uppercased())\(aWord.dropFirst())" }.joined(separator: "") }
print(toPascalCase("this is pascal case")) // ThisIsPascalCase

let toKebabCase = { (aString: String) -> String in aString.split(separator: " ").map { (aWord: Substring) -> String in "\(aWord.lowercased())" }.joined(separator: "-") }
print(toKebabCase("this is kebab case")) // this-is-kebab-case

let toTitleCase = { (aString: String) -> String in aString.split(separator: " ").map { (aWord: Substring) -> String in "\(aWord.first!.uppercased())\(aWord.dropFirst())" }.joined(separator: " ") }
print(toTitleCase("this is title case")) // This Is Title Case

let toFlatCase = { (aString: String) -> String in aString.split(separator: " ").map { (aWord: Substring) -> String in "\(aWord.lowercased())" }.joined(separator: "") }
print(toFlatCase("this is flat case")) // thisisflatcase

let toUpperFlatCase = { (aString: String) -> String in aString.split(separator: " ").map { (aWord: Substring) -> String in "\(aWord.uppercased())" }.joined(separator: "") }
print(toUpperFlatCase("this is upper flat case")) // THISISUPPERFLATCASE

let toPascalSnakeCase = { (aString: String) -> String in aString.split(separator: " ").map { (aWord: Substring) -> String in "\(aWord.first!.uppercased())\(aWord.dropFirst())" }.joined(separator: "_") }
print(toPascalSnakeCase("this is pascal snake case")) // This_Is_Pascal_Snake_Case

let toConstantCase = { (aString: String) -> String in aString.split(separator: " ").map { (aWord: Substring) -> String in "\(aWord.uppercased())" }.joined(separator: "_") }
print(toConstantCase("this is constant case")) // THIS_IS_CONSTANT_CASE

let toTrainCase = { (aString: String) -> String in aString.split(separator: " ").map { (aWord: Substring) -> String in "\(aWord.first!.uppercased())\(aWord.dropFirst())" }.joined(separator: "-") }
print(toTrainCase("this is train case")) // This-Is-Train-Case

let toCobolCase = { (aString: String) -> String in aString.split(separator: " ").map { (aWord: Substring) -> String in "\(aWord.uppercased())" }.joined(separator: "-") }
print(toCobolCase("this is cobol case")) // THIS-IS-COBOL-CASE
