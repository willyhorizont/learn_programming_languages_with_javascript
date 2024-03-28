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

    fun prettyJsonStringify(anything: Any? = null, indent: String = "    "): String {
        var indentLevel = 0
        fun prettyJsonStringifyInner(anythingInner: Any?, indentInner: String): String {
            if (anythingInner == null) return "null"
            if (anythingInner is String) return "\"${anythingInner}\""
            if (anythingInner is Number || anythingInner is Boolean) return "${anythingInner}"
            if (anythingInner is MutableList<*>) {
                if (anythingInner.size == 0) return "[]"
                indentLevel += 1
                var result = "[\n${indentInner.repeat(indentLevel)}"
                for ((arrayItemIndex, arrayItem) in anythingInner.withIndex()) {
                    result += prettyJsonStringifyInner(arrayItem, indentInner)
                    if ((arrayItemIndex + 1) != anythingInner.size) result += ",\n${indentInner.repeat(indentLevel)}"
                }
                indentLevel -= 1
                result += "\n${indentInner.repeat(indentLevel)}]"
                return result
            }
            if (anythingInner is MutableMap<*, *>) {
                if (anythingInner.entries.size == 0) return "{}"
                indentLevel += 1
                var result = "{\n${indentInner.repeat(indentLevel)}"
                anythingInner.entries.forEachIndexed { entryIndex, entryItem ->
                    val objectKey = entryItem.key
                    val objectValue = entryItem.value
                    result += "\"${objectKey}\": ${prettyJsonStringifyInner(objectValue, indentInner)}"
                    if ((entryIndex + 1) != anythingInner.entries.size) result += ",\n${indentInner.repeat(indentLevel)}"
                }
                indentLevel -= 1
                result += "\n${indentInner.repeat(indentLevel)}}"
                return result
            }
            return "null"
        }
        return prettyJsonStringifyInner(anything, indent)
    }

    println("\n// JavaScript-like Spread Syntax (...) in Kotlin")

    // There's no JavaScript-like Spread Syntax (...) in Kotlin.
    // But, we can create our own function to mimic it in Kotlin.

    fun spreadSyntaxObject(vararg parameters: Any?): MutableMap<String, Any?> {
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

    fun spreadSyntaxArray(vararg parameters: Any?): MutableList<Any?> {
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
    println("fruits: ${prettyArrayOfPrimitives(fruits)}")
    
    val vegetables = mutableListOf<Any?>("Carrot", "Tomato")
    println("vegetables: ${prettyArrayOfPrimitives(vegetables)}")

    val countryCapitalsInAsia = mutableMapOf<String, Any?>(
        "Thailand" to "Bangkok",
        "China" to "Beijing",
        "Japan" to "Tokyo"
    )
    println("countryCapitalsInAsia: ${prettyJsonStringify(countryCapitalsInAsia)}")
    
    val countryCapitalsInEurope = mutableMapOf<String, Any?>(
        "France" to "Paris",
        "England" to "London"
    )
    println("countryCapitalsInEurope: ${prettyJsonStringify(countryCapitalsInEurope)}")

    println("\n// [...array1, ...array2]:\n")

    val combination1 = spreadSyntaxArray(fruits, vegetables)
    println("combination1: ${prettyJsonStringify(combination1)}")
    // combination1: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     "Carrot",
    //     "Tomato"
    // ]

    val combination2 = spreadSyntaxArray(fruits, mutableListOf<Any?>("Cucumber", "Cabbage"))
    println("combination2: ${prettyJsonStringify(combination2)}")
    // combination2: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     "Cucumber",
    //     "Cabbage"
    // ]

    println("\n// { ...object1, ...object2 }:\n")

    val combination3 = spreadSyntaxObject(countryCapitalsInAsia, countryCapitalsInEurope)
    println("combination3: ${prettyJsonStringify(combination3)}")
    // combination3: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "France": "Paris",
    //     "England": "London"
    // }

    val combination4 = spreadSyntaxObject(countryCapitalsInAsia, mutableMapOf<String, Any?>("Germany" to "Berlin", "Italy" to "Rome"))
    println("combination4: ${prettyJsonStringify(combination4)}")
    // combination4: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "Germany": "Berlin",
    //     "Italy": "Rome"
    // }

    println("\n// [...array1, array2]:\n")

    val combination5 = spreadSyntaxArray(fruits, mutableMapOf<String, Any?>("vegetables" to vegetables))
    println("combination5: ${prettyJsonStringify(combination5)}")
    // combination5: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     [
    //         "Carrot",
    //         "Tomato"
    //     ]
    // ]

    val combination6 = spreadSyntaxArray(fruits, mutableMapOf<String, Any?>("vegetables" to mutableListOf<Any?>("Cucumber", "Cabbage")))
    println("combination6: ${prettyJsonStringify(combination6)}")
    // combination6: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     [
    //         "Cucumber",
    //         "Cabbage"
    //     ]
    // ]

    println("\n// [...array1, object1]:\n")

    val combination7 = spreadSyntaxArray(fruits, mutableMapOf<String, Any?>("countryCapitalsInAsia" to countryCapitalsInAsia))
    println("combination7: ${prettyJsonStringify(combination7)}")
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

    val combination8 = spreadSyntaxArray(fruits, mutableMapOf<String, Any?>("countryCapitalsInEurope" to mutableMapOf<String, Any?>("Germany" to "Berlin", "Italy" to "Rome")))
    println("combination8: ${prettyJsonStringify(combination8)}")
    // combination8: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     {
    //         "Germany": "Berlin",
    //         "Italy": "Rome"
    //     }
    // ]

    println("\n// { ...object1, object2 }:\n")

    val combination9 = spreadSyntaxObject(countryCapitalsInAsia, mutableMapOf<String, Any?>("countryCapitalsInEurope" to countryCapitalsInEurope))
    println("combination9: ${prettyJsonStringify(combination9)}")
    // combination9: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "countryCapitalsInEurope": {
    //         "France": "Paris",
    //         "England": "London"
    //     }
    // }

    val combination10 = spreadSyntaxObject(countryCapitalsInAsia, mutableMapOf<String, Any?>("countryCapitalsInEurope" to mutableMapOf<String, Any?>("Germany" to "Berlin", "Italy" to "Rome")))
    println("combination10: ${prettyJsonStringify(combination10)}")
    // combination10: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "countryCapitalsInEurope": {
    //         "Germany": "Berlin",
    //         "Italy": "Rome"
    //     }
    // }

    println("\n// { ...object1, array2 }:\n")

    val combination11 = spreadSyntaxObject(countryCapitalsInAsia, mutableMapOf<String, Any?>("vegetables" to vegetables))
    println("combination11: ${prettyJsonStringify(combination11)}")
    // combination11: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "vegetables": [
    //         "Carrot",
    //         "Tomato"
    //     ]
    // }

    val combination12 = spreadSyntaxObject(countryCapitalsInAsia, mutableMapOf<String, Any?>("vegetables" to mutableListOf<Any?>("Cucumber", "Cabbage")))
    println("combination12: ${prettyJsonStringify(combination12)}")
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

    val combination13 = spreadSyntaxObject(countryCapitalsInAsia, vegetables)
    println("combination13: ${prettyJsonStringify(combination13)}")
    // combination13: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "0": "Carrot",
    //     "1": "Tomato"
    // }

    val combination14 = spreadSyntaxObject(countryCapitalsInAsia, mutableListOf<Any?>("Cucumber", "Cabbage"))
    println("combination14: ${prettyJsonStringify(combination14)}")
    // combination14: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "0": "Cucumber",
    //     "1": "Cabbage"
    // }

    // println("\n// [...array1, ...object1]: // this combination throw an error in JavaScript\n")

    // this combination throw an error in JavaScript
    // let combinationErrorInJavascript1 = spreadSyntaxArray(fruits, countryCapitalsInAsia)
    // println("combinationErrorInJavascript1: ${prettyJsonStringify(combinationErrorInJavascript1)}")

    // this combination throw an error in JavaScript
    // let combinationErrorInJavascript2 = spreadSyntaxArray(fruits, mutableMapOf<String, Any?>("Germany" to "Berlin", "Italy" to "Rome"))
    // println("combinationErrorInJavascript2: ${prettyJsonStringify(combinationErrorInJavascript2)}")
}
