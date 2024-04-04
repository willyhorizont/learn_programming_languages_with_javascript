@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST", "USELESS_CAST")

fun main() {
    fun jsonStringify(anything: Any? = null, pretty: Boolean = false, indent: String = "    "): String {
        var indentLevel = 0
        fun jsonStringifyInner(anythingInner: Any?, indentInner: String): String {
            if (anythingInner == null) return "null"
            if (anythingInner is String) return "\"${anythingInner}\""
            if (anythingInner is Number || anythingInner is Boolean) return "${anythingInner}"
            if (anythingInner is MutableList<*>) {
                if (anythingInner.size == 0) return "[]"
                indentLevel += 1
                var result = (if (pretty == true) "[\n${indentInner.repeat(indentLevel)}" else "[")
                for ((arrayItemIndex, arrayItem) in anythingInner.withIndex()) {
                    result += jsonStringifyInner(arrayItem, indentInner)
                    if ((arrayItemIndex + 1) != anythingInner.size) result += (if (pretty == true) ",\n${indentInner.repeat(indentLevel)}" else ", ")
                }
                indentLevel -= 1
                result += (if (pretty == true) "\n${indentInner.repeat(indentLevel)}]" else "]")
                return result
            }
            if (anythingInner is MutableMap<*, *>) {
                if (anythingInner.entries.size == 0) return "{}"
                indentLevel += 1
                var result = (if (pretty == true) "{\n${indentInner.repeat(indentLevel)}" else "{")
                anythingInner.entries.forEachIndexed { objectEntryIndex, objectEntry ->
                    val objectKey = objectEntry.key
                    val objectValue = objectEntry.value
                    result += "\"${objectKey}\": ${jsonStringifyInner(objectValue, indentInner)}"
                    if ((objectEntryIndex + 1) != anythingInner.entries.size) result += (if (pretty == true) ",\n${indentInner.repeat(indentLevel)}" else ", ")
                }
                indentLevel -= 1
                result += (if (pretty == true) "\n${indentInner.repeat(indentLevel)}}" else "}")
                return result
            }
            return "null"
        }
        return jsonStringifyInner(anything, indent)
    }

    println("\n// JavaScript-like Spread Syntax (...) in Kotlin")

    // There's no JavaScript-like Spread Syntax (...) in Kotlin.
    // But, we can create our own function to mimic it in Kotlin.

    fun spreadObject(vararg parameters: Any?): MutableMap<String, Any?> {
        val newObject = mutableMapOf<String, Any?>()
        for ((parameterIndex, parameter) in parameters.withIndex()) {
            if (parameter is MutableMap<*, *>) {
                for ((objectKey, objectValue) in parameter as MutableMap<String, Any?>) {
                    newObject[objectKey.toString()] = objectValue
                }
                continue
            }
            if (parameter is MutableList<*>) {
                for ((arrayItemIndex, arrayItem) in (parameter as MutableList<Any?>).withIndex()) {
                    newObject[arrayItemIndex.toString()] = arrayItem
                }
                continue
            }
        }
        return newObject
    }

    fun spreadArray(vararg parameters: Any?): MutableList<Any?> {
        val newArray = mutableListOf<Any?>()
        for ((parameterIndex, parameter) in parameters.withIndex()) {
            if (parameter is MutableMap<*, *>) {
                if ((parameter as MutableMap<String, Any?>).size == 1) {
                    for ((objectKey, objectValue) in (parameter as MutableMap<String, Any?>)) {
                        newArray.add(objectValue)
                    }
                    continue
                }
                newArray.add(parameter)
                continue
            }
            if (parameter is MutableList<*>) {
                for ((arrayItemIndex, arrayItem) in (parameter as MutableList<Any?>).withIndex()) {
                    newArray.add(arrayItem)
                }
                continue
            }
        }
        return newArray
    }

    val fruits = mutableListOf<Any?>("Mango", "Melon", "Banana")
    println("fruits: ${jsonStringify(fruits)}")
    
    val vegetables = mutableListOf<Any?>("Carrot", "Tomato")
    println("vegetables: ${jsonStringify(vegetables)}")

    val countryCapitalsInAsia = mutableMapOf<String, Any?>(
        "Thailand" to "Bangkok",
        "China" to "Beijing",
        "Japan" to "Tokyo"
    )
    println("countryCapitalsInAsia: ${jsonStringify(countryCapitalsInAsia, pretty = true)}")
    
    val countryCapitalsInEurope = mutableMapOf<String, Any?>(
        "France" to "Paris",
        "England" to "London"
    )
    println("countryCapitalsInEurope: ${jsonStringify(countryCapitalsInEurope, pretty = true)}")

    println("\n// [...array1, ...array2]:\n")

    val combination1 = spreadArray(fruits, vegetables)
    println("combination1: ${jsonStringify(combination1, pretty = true)}")
    // combination1: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     "Carrot",
    //     "Tomato"
    // ]

    val combination2 = spreadArray(fruits, mutableListOf<Any?>("Cucumber", "Cabbage"))
    println("combination2: ${jsonStringify(combination2, pretty = true)}")
    // combination2: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     "Cucumber",
    //     "Cabbage"
    // ]

    println("\n// { ...object1, ...object2 }:\n")

    val combination3 = spreadObject(countryCapitalsInAsia, countryCapitalsInEurope)
    println("combination3: ${jsonStringify(combination3, pretty = true)}")
    // combination3: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "France": "Paris",
    //     "England": "London"
    // }

    val combination4 = spreadObject(countryCapitalsInAsia, mutableMapOf<String, Any?>("Germany" to "Berlin", "Italy" to "Rome"))
    println("combination4: ${jsonStringify(combination4, pretty = true)}")
    // combination4: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "Germany": "Berlin",
    //     "Italy": "Rome"
    // }

    println("\n// [...array1, array2] || [...array1, newArrayItem1, newArrayItem2]:\n")

    val combination5 = spreadArray(fruits, mutableMapOf<String, Any?>("vegetables" to vegetables))
    println("combination5: ${jsonStringify(combination5, pretty = true)}")
    // combination5: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     [
    //         "Carrot",
    //         "Tomato"
    //     ]
    // ]

    val combination6 = spreadArray(fruits, mutableMapOf<String, Any?>("vegetables" to mutableListOf<Any?>("Cucumber", "Cabbage")))
    println("combination6: ${jsonStringify(combination6, pretty = true)}")
    // combination6: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     [
    //         "Cucumber",
    //         "Cabbage"
    //     ]
    // ]

    println("\n// [...array1, object1] || [...array1, newArrayItem1, newArrayItem2]:\n")

    val combination7 = spreadArray(fruits, mutableMapOf<String, Any?>("countryCapitalsInAsia" to countryCapitalsInAsia))
    println("combination7: ${jsonStringify(combination7, pretty = true)}")
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

    val combination8 = spreadArray(fruits, mutableMapOf<String, Any?>("countryCapitalsInEurope" to mutableMapOf<String, Any?>("Germany" to "Berlin", "Italy" to "Rome")))
    println("combination8: ${jsonStringify(combination8, pretty = true)}")
    // combination8: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     {
    //         "Germany": "Berlin",
    //         "Italy": "Rome"
    //     }
    // ]

    println("\n// { ...object1, object2 } || { ...object1, objectKey: objectValue }:\n")

    val combination9 = spreadObject(countryCapitalsInAsia, mutableMapOf<String, Any?>("countryCapitalsInEurope" to countryCapitalsInEurope))
    println("combination9: ${jsonStringify(combination9, pretty = true)}")
    // combination9: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "countryCapitalsInEurope": {
    //         "France": "Paris",
    //         "England": "London"
    //     }
    // }

    val combination10 = spreadObject(countryCapitalsInAsia, mutableMapOf<String, Any?>("countryCapitalsInEurope" to mutableMapOf<String, Any?>("Germany" to "Berlin", "Italy" to "Rome")))
    println("combination10: ${jsonStringify(combination10, pretty = true)}")
    // combination10: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "countryCapitalsInEurope": {
    //         "Germany": "Berlin",
    //         "Italy": "Rome"
    //     }
    // }

    println("\n// { ...object1, array2 } || { ...object1, objectKey: objectValue }:\n")

    val combination11 = spreadObject(countryCapitalsInAsia, mutableMapOf<String, Any?>("vegetables" to vegetables))
    println("combination11: ${jsonStringify(combination11, pretty = true)}")
    // combination11: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "vegetables": [
    //         "Carrot",
    //         "Tomato"
    //     ]
    // }

    val combination12 = spreadObject(countryCapitalsInAsia, mutableMapOf<String, Any?>("vegetables" to mutableListOf<Any?>("Cucumber", "Cabbage")))
    println("combination12: ${jsonStringify(combination12, pretty = true)}")
    // combination12: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "vegetables": [
    //         "Cucumber",
    //         "Cabbage"
    //     ]
    // }

    println("\n// { ...object1, ...array2 }:\n")

    val combination13 = spreadObject(countryCapitalsInAsia, vegetables)
    println("combination13: ${jsonStringify(combination13, pretty = true)}")
    // combination13: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "0": "Carrot",
    //     "1": "Tomato"
    // }

    val combination14 = spreadObject(countryCapitalsInAsia, mutableListOf<Any?>("Cucumber", "Cabbage"))
    println("combination14: ${jsonStringify(combination14, pretty = true)}")
    // combination14: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "0": "Cucumber",
    //     "1": "Cabbage"
    // }

    // println("\n// [...array1, ...object1]: // this combination throw an error in JavaScript\n")

    // this combination throw an error in JavaScript
    // val combinationErrorInJavascript1 = spreadArray(fruits, countryCapitalsInAsia)
    // println("combinationErrorInJavascript1: ${jsonStringify(combinationErrorInJavascript1, pretty = true)}")

    // this combination throw an error in JavaScript
    // val combinationErrorInJavascript2 = spreadArray(fruits, mutableMapOf<String, Any?>("Germany" to "Berlin", "Italy" to "Rome"))
    // println("combinationErrorInJavascript2: ${jsonStringify(combinationErrorInJavascript2, pretty = true)}")
}
