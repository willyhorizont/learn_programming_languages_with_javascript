@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST", "USELESS_CAST")

fun main() {
    fun prettyArrayOfPrimitives(anArrayOfPrimitives: MutableList<Any?>): String {
        var result = "["
        for ((arrayItemIndex, arrayItem) in anArrayOfPrimitives.withIndex()) {
            if (((arrayItem is String) == false) && ((arrayItem is Number) == false) && ((arrayItem is Boolean) == false) && (arrayItem != null)) continue
            if (arrayItem is String) result += "\"${arrayItem}\""
            if ((arrayItem is Number) || (arrayItem is Boolean) || (arrayItem == null)) result += "${arrayItem}"
            if ((arrayItemIndex + 1) != anArrayOfPrimitives.size) result += ", "
        }
        result += "]"
        return result
    }

    fun arrayReduce(callbackFunction: (Any?, Any?, Int, MutableList<Any?>) -> Any?, anArray: MutableList<Any?>, initialValue: Any?): Any? {
        // JavaScript-like Array.reduce() function
        var result = initialValue
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            result = callbackFunction(result, arrayItem, arrayItemIndex, anArray)
        }
        return result
    }

    println("\n// JavaScript-like Array.reduce() in Kotlin MutableList")
    
    val numbers = mutableListOf<Any?>(36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3)
    println("numbers: ${prettyArrayOfPrimitives(numbers)}")

    var numbersTotal: Any?

    println("// using JavaScript-like Array.reduce() function \"arrayReduce\"")

    numbersTotal = arrayReduce({ currentResult: Any?, currentNumber: Any?, _: Int, _: MutableList<Any?> -> 
        when {
            currentResult is Number && currentNumber is Number -> (currentResult.toDouble() + currentNumber.toDouble())
            else -> currentResult
        }
    }, numbers, 0.0)
    println("total number: ${numbersTotal}")
    // total number: 41.2
}
