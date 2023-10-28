// Compile and run the application command:
// kotlinc prettyJsonStringifyV1.kt -include-runtime -d prettyJsonStringifyV1.jar && kotlin prettyJsonStringifyV1.jar

fun prettyJsonStringifyV1(json: String): String {
    val indentSize = 4
    val result = StringBuilder()
    var indentLevel = 0
    var insideString = false

    json.forEach { char ->
        when (char) {
            '{', '[' -> {
                result.appendLine(char)
                indentLevel += indentSize
                result.append(" ".repeat(indentLevel))
            }
            '}', ']' -> {
                result.appendLine()
                indentLevel -= indentSize
                result.append(" ".repeat(indentLevel))
                result.append(char)
            }
            ',' -> {
                result.append(char)
                if (!insideString) {
                    result.appendLine()
                    result.append(" ".repeat(indentLevel))
                }
            }
            '\u0022' -> {
                result.append(char)
                insideString = !insideString
            }
            else -> result.append(char)
        }
    }

    return result.toString()
}

fun main() {
    val myJsonString = "[{code=pasta, price=321}, {code=bubble_gum, price=233}, {code=potato_chips, price=5}, {code=towel, price=499}]"
    val prettyJson = prettyJsonStringifyV1(myJsonString)
    println(prettyJson)
}
