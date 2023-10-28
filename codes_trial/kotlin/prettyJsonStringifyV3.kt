// Compile and run the application command:
// kotlinc prettyJsonStringifyV3.kt -include-runtime -d prettyJsonStringifyV3.jar && kotlin prettyJsonStringifyV3.jar

fun main() {
    fun prettyJsonStringifyV3(jsonStringified: String): String {
        val indentSize = 4
        val result = StringBuilder()
        var indentLevel = 0

        for (charIndex in 0 until jsonStringified.length) {
            val char = jsonStringified[charIndex]
            if (char == '{' || char == '[') {
                if (result.isNotEmpty() && result.last() != '\n') {
                    result.append("\n")
                }
                result.append(" ".repeat(indentLevel))
                result.append(char)
                indentLevel += indentSize
                result.append("\n" + " ".repeat(indentLevel))
                continue
            }
            if (char == '}' || char == ']') {
                result.append("\n")
                indentLevel -= indentSize
                result.append(" ".repeat(indentLevel))
                result.append(char)
                continue
            }
            if (char == '=') {
                result.append(": ")
                continue
            }
            if (char == ',') {
                result.append(char + "\n" + " ".repeat(indentLevel-1))
                continue
            }
            result.append(char)
        }

        return result.toString()
    }

    val products = mutableListOf(
        mutableMapOf<String, Any>(
            "code" to "pasta",
            "price" to 321
        ),
        mutableMapOf<String, Any>(
            "code" to "bubble_gum",
            "price" to 233
        ),
        mutableMapOf<String, Any>(
            "code" to "potato_chips",
            "price" to 5
        ),
        mutableMapOf<String, Any>(
            "code" to "towel",
            "price" to 499
        )
    )
    val productsStringified = products.joinToString(separator = ", ", prefix = "[", postfix = "]") // [{code=pasta, price=321}, {code=bubble_gum, price=233}, {code=potato_chips, price=5}, {code=towel, price=499}]
    println("productsStringified:\n$productsStringified")
    val productsStringifiedPrettyPrinted = prettyJsonStringifyV3(productsStringified)
    println("productsStringifiedPrettyPrinted:\n$productsStringifiedPrettyPrinted")
}
