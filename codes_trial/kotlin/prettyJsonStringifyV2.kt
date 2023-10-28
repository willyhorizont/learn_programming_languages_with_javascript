// Compile and run the application command:
// kotlinc prettyJsonStringifyV2.kt -include-runtime -d prettyJsonStringifyV2.jar && kotlin prettyJsonStringifyV2.jar

fun prettyJsonStringifyV2(jsonStringified: String): String {
    val indentSize = 4
    val result = StringBuilder()
    var indentLevel = 0
    var insideString = false

    for (char in jsonStringified) {
        if (char == '{' || char == '[') {
            result.appendLine(char)
            indentLevel += indentSize
            result.append(" ".repeat(indentLevel))
            continue
        }
        if (char == '}' || char == ']') {
            result.append("\n")
            indentLevel -= indentSize
            result.append(" ".repeat(indentLevel))
            result.append(char)
            continue
        }
        if (char == ',') {
            result.append(char)
            if (!insideString) {
                result.append("\n")
                result.append(" ".repeat(indentLevel))
                continue
            }
            continue
        }
        if (char == '\u0022') {
            result.append(char)
            insideString = !insideString
            continue
        }
        result.append(char)
    }

    return result.toString()
}

fun main() {
    val myJsonString = "[{code=pasta, price=321}, {code=bubble_gum, price=233}, {code=potato_chips, price=5}, {code=towel, price=499}]"
    val prettyJson = prettyJsonStringifyV2(myJsonString)
    println(prettyJson)
}

// fun main() {
//     val myString = "Hello, World!"
//     for (char in myString) {
//         // Do something with 'char'
//         println(char)
//     }
// }
