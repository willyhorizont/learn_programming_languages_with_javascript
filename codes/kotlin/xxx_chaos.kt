@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST", "USELESS_CAST")

fun main() {
    fun arrayReduce(callbackFunction: (Any?, Any?, Int, MutableList<Any?>) -> Any?, anArray: MutableList<Any?>, initialValue: Any?): Any? {
        // JavaScript-like Array.reduce() function
        var result = initialValue
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            result = callbackFunction(result, arrayItem, arrayItemIndex, anArray)
        }
        return result
    }
    
    val numbers = mutableListOf<Any?>(36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3)

    var numbersTotal: Any?

    numbersTotal = arrayReduce({ currentResult: Any?, currentNumber: Any?, _: Int, _: MutableList<Any?> -> 
        if (currentResult is Number && currentNumber is Number) {
            currentResult.toDouble() + currentNumber.toDouble()
        } else {
            currentResult
        }
    }, numbers, 0.0)
    println("total number: ${numbersTotal}")
    // total number: 41.2

    numbersTotal = arrayReduce({ currentResult: Any?, currentNumber: Any?, _: Int, _: MutableList<Any?> -> 
        when {
            currentResult is Number && currentNumber is Number -> currentResult.toDouble() + currentNumber.toDouble()
            else -> currentResult
        }
    }, numbers, 0.0)
    println("total number: ${numbersTotal}")
    // total number: 41.2
    
    numbersTotal = arrayReduce({ currentResult: Any?, currentNumber: Any?, _: Int, _: MutableList<Any?> -> if (currentResult is Number && currentNumber is Number) currentResult.toDouble() + currentNumber.toDouble() else currentResult }, numbers, 0.0)
    println("total number: ${numbersTotal}")
    // total number: 41.2

    numbersTotal = numbers.fold(0.0) { currentResult: Any?, currentNumber: Any? -> 
        if (currentResult is Number && currentNumber is Number) {
            currentResult.toDouble() + currentNumber.toDouble()
        } else {
            currentResult
        }
    }
    println("total number: ${numbersTotal}")
    // total number: 41.2

    numbersTotal = numbers.fold(0.0) { currentResult: Any?, currentNumber: Any? -> 
        when {
            currentResult is Number && currentNumber is Number -> currentResult.toDouble() + currentNumber.toDouble()
            else -> currentResult // Return currentResult unchanged if types are incompatible
        }
    }
    println("total number: ${numbersTotal}")
    // total number: 41.2

    numbersTotal = numbers.fold(0.0) { currentResult: Any?, currentNumber: Any? -> if (currentResult is Number && currentNumber is Number) currentResult.toDouble() + currentNumber.toDouble() else currentResult }
    println("total number: ${numbersTotal}")
    // total number: 41.2

    println(null)
    println(true)
    println(false)
}
