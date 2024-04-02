def MyObject(objectEntries: (String, Any)*): Map[String, Any] = (if (objectEntries.isEmpty) Map.empty[String, Any] else objectEntries.toMap[String, Any])
def MyArray(arrayItems: Any*): Array[Any] = (if (arrayItems.isEmpty) Array.empty[Any] else arrayItems.toArray[Any])
val isNumeric = ((anything: Any) => (if (anything.isInstanceOf[Byte] || anything.isInstanceOf[Int] || anything.isInstanceOf[Long] || anything.isInstanceOf[Short] || anything.isInstanceOf[Double] || anything.isInstanceOf[Float] || anything.isInstanceOf[BigInt] || anything.isInstanceOf[BigDecimal]) true else false): Boolean)
def jsonStringify(anything: Any = null, indent: String = "    ", pretty: Boolean = false): String = {
    var indentLevel: Int = 0
    def jsonStringifyInner(anythingInner: Any, indentInner: String, prettyInner: Boolean): String = {
        if (anythingInner == null) return "null"
        if (anythingInner.isInstanceOf[String]) return s"\"${anythingInner}\""
        if (isNumeric(anythingInner) || anythingInner.isInstanceOf[Boolean]) return s"${anythingInner}"
        if (anythingInner.isInstanceOf[Array[_]]) {
            if (anythingInner.asInstanceOf[Array[Any]].length == 0) return "[]"
            indentLevel += 1
            var result: String = s"[${if (pretty == true) s"\n${indentInner * indentLevel}" else ""}"
            for ((arrayItem, arrayItemIndex) <- anythingInner.asInstanceOf[Array[Any]].zipWithIndex) {
                result += jsonStringifyInner(arrayItem, indentInner, prettyInner)
                if ((arrayItemIndex + 1) != anythingInner.asInstanceOf[Array[Any]].length) result += s",${if (pretty == false) " " else ""}${if (pretty == true) s"\n${indentInner * indentLevel}" else ""}"
            }
            indentLevel -= 1
            result += s"${if (pretty == true) s"\n${indentInner * indentLevel}" else ""}]"
            return result
        }
        if (anythingInner.isInstanceOf[Map[_, _]]) {
            if (anythingInner.asInstanceOf[Map[String, Any]].size == 0) return "{}"
            indentLevel += 1
            var result: String = s"{${if (pretty == true) s"\n${indentInner * indentLevel}" else ""}"
            for (((objectKey, objectValue), objectEntryIndex) <- anythingInner.asInstanceOf[Map[String, Any]].toArray[Any].zipWithIndex) {
                result += s"\"${objectKey}\": ${jsonStringifyInner(objectValue, indentInner, prettyInner)}"
                if ((objectEntryIndex + 1) != anythingInner.asInstanceOf[Map[String, Any]].size) result += s",${if (pretty == false) " " else ""}${if (pretty == true) s"\n${indentInner * indentLevel}" else ""}"
            }
            indentLevel -= 1
            result += s"${if (pretty == true) s"\n${indentInner * indentLevel}" else ""}}"
            return result
        }
        return "null"
    }
    jsonStringifyInner(anything, indent, pretty)
}

println("\n// JavaScript-like Spread Syntax (...) in Scala")

// There's no JavaScript-like Spread Syntax (...) in Scala.
// But, we can create our own function to mimic it in Scala.

val arrayToObject = new Function1[Array[Any], Map[String, Any]] {
    def apply(anArray: Array[Any]): Map[String, Any] = {
        var newObject = MyObject()
        for ((arrayItem, arrayItemIndex) <- anArray.asInstanceOf[Array[Any]].zipWithIndex) {
            newObject = (newObject + (arrayItemIndex.toString -> arrayItem))
        }
        return newObject: Map[String, Any]
    }
}

val fruits = MyArray("Mango", "Melon", "Banana")
println(s"fruits: ${jsonStringify(fruits)}")

val vegetables = MyArray("Carrot", "Tomato")
println(s"vegetables: ${jsonStringify(vegetables)}")

val countryCapitalsInAsia = MyObject(
    "Thailand" -> "Bangkok",
    "China" -> "Beijing",
    "Japan" -> "Tokyo"
)
println(s"countryCapitalsInAsia: ${jsonStringify(countryCapitalsInAsia, pretty = true)}")

val countryCapitalsInEurope = MyObject(
    "France" -> "Paris",
    "England" -> "London"
)
println(s"countryCapitalsInEurope: ${jsonStringify(countryCapitalsInEurope, pretty = true)}")

println("\n// [...array1, ...array2]:\n")

val combination1 = ((MyArray() ++ fruits) ++ vegetables)
println(s"combination1: ${jsonStringify(combination1, pretty = true)}")
// combination1: [
//     "Mango",
//     "Melon",
//     "Banana",
//     "Carrot",
//     "Tomato"
// ]

val combination2 = ((MyArray() ++ fruits) ++ MyArray("Cucumber", "Cabbage"))
println(s"combination2: ${jsonStringify(combination2, pretty = true)}")
// combination2: [
//     "Mango",
//     "Melon",
//     "Banana",
//     "Cucumber",
//     "Cabbage"
// ]

println("\n// { ...object1, ...object2 }:\n")

val combination3 = ((MyObject() ++ countryCapitalsInAsia) ++ countryCapitalsInEurope)
println(s"combination3: ${jsonStringify(combination3, pretty = true)}")
// combination3: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "France": "Paris",
//     "England": "London"
// }

val combination4 = ((MyObject() ++ countryCapitalsInAsia) ++ MyObject("Germany" -> "Berlin", "Italy" -> "Rome"))
println(s"combination4: ${jsonStringify(combination4, pretty = true)}")
// combination4: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "Germany": "Berlin",
//     "Italy": "Rome"
// }

println("\n// [...array1, array2] || [...array1, newArrayItem1, newArrayItem2]:\n")

val combination5 = ((MyArray() ++ fruits) :+ vegetables)
println(s"combination5: ${jsonStringify(combination5, pretty = true)}")
// combination5: [
//     "Mango",
//     "Melon",
//     "Banana",
//     [
//         "Carrot",
//         "Tomato"
//     ]
// ]

val combination6 = ((MyArray() ++ fruits) :+ MyArray("Cucumber", "Cabbage"))
println(s"combination6: ${jsonStringify(combination6, pretty = true)}")
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

val combination7 = ((MyArray() ++ fruits) :+ countryCapitalsInAsia)
println(s"combination7: ${jsonStringify(combination7, pretty = true)}")
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

val combination8 = ((MyArray() ++ fruits) :+ MyObject("Germany" -> "Berlin", "Italy" -> "Rome"))
println(s"combination8: ${jsonStringify(combination8, pretty = true)}")
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

val combination9 = ((MyObject() ++ countryCapitalsInAsia) + ("countryCapitalsInEurope" -> countryCapitalsInEurope))
println(s"combination9: ${jsonStringify(combination9, pretty = true)}")
// combination9: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "countryCapitalsInEurope": {
//         "France": "Paris",
//         "England": "London"
//     }
// }

val combination10 = ((MyObject() ++ countryCapitalsInAsia) + ("countryCapitalsInEurope" -> MyObject("Germany" -> "Berlin", "Italy" -> "Rome")))
println(s"combination10: ${jsonStringify(combination10, pretty = true)}")
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

val combination11 = ((MyObject() ++ countryCapitalsInAsia) + ("vegetables" -> vegetables))
println(s"combination11: ${jsonStringify(combination11, pretty = true)}")
// combination11: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "vegetables": [
//         "Carrot",
//         "Tomato"
//     ]
// }

val combination12 = ((MyObject() ++ countryCapitalsInAsia) + ("vegetables" -> MyArray("Cucumber", "Cabbage")))
println(s"combination12: ${jsonStringify(combination12, pretty = true)}")
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

val combination13 = ((MyObject() ++ countryCapitalsInAsia) ++ arrayToObject(vegetables))
println(s"combination13: ${jsonStringify(combination13, pretty = true)}")
// combination13: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "0": "Carrot",
//     "1": "Tomato"
// }

val combination14 = ((MyObject() ++ countryCapitalsInAsia) ++ arrayToObject(MyArray("Cucumber", "Cabbage")))
println(s"combination14: ${jsonStringify(combination14, pretty = true)}")
// combination14: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "0": "Cucumber",
//     "1": "Cabbage"
// }

// println("\n// [...array1, ...object1]: // this combination throw an error in JavaScript\n")

// this combination throw an error in JavaScript
// val combinationErrorInJavascript1 = ((MyArray() ++ fruits) :+ countryCapitalsInAsia)
// println(s"combinationErrorInJavascript1: ${jsonStringify(combinationErrorInJavascript1, pretty = true)}")

// this combination throw an error in JavaScript
// val combinationErrorInJavascript2 = ((MyArray() ++ fruits) :+ MyObject("Germany" -> "Berlin", "Italy" -> "Rome"))
// println(s"combinationErrorInJavascript2: ${jsonStringify(combinationErrorInJavascript2, pretty = true)}")
