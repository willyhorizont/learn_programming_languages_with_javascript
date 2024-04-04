def MyObject(objectEntries: (String, Any)*): Map[String, Any] = (if (objectEntries.isEmpty) Map.empty[String, Any] else objectEntries.toMap[String, Any])
def MyArray(arrayItems: Any*): Array[Any] = (if (arrayItems.isEmpty) Array.empty[Any] else arrayItems.toArray[Any])
val isNumeric = ((anything: Any) => (if (anything.isInstanceOf[Byte] || anything.isInstanceOf[Int] || anything.isInstanceOf[Long] || anything.isInstanceOf[Short] || anything.isInstanceOf[Double] || anything.isInstanceOf[Float] || anything.isInstanceOf[BigInt] || anything.isInstanceOf[BigDecimal]) true else false): Boolean)
def jsonStringify(anything: Any = null, pretty: Boolean = false, indent: String = "    "): String = {
    var indentLevel: Int = 0
    def jsonStringifyInner(anythingInner: Any, indentInner: String): String = {
        if (anythingInner == null) return "null"
        if (anythingInner.isInstanceOf[String]) return s"\"${anythingInner}\""
        if (isNumeric(anythingInner) || anythingInner.isInstanceOf[Boolean]) return s"${anythingInner}"
        if (anythingInner.isInstanceOf[Array[_]]) {
            if (anythingInner.asInstanceOf[Array[Any]].length == 0) return "[]"
            indentLevel += 1
            var result: String = (if (pretty == true) s"[\n${indentInner * indentLevel}" else "[")
            for ((arrayItem, arrayItemIndex) <- anythingInner.asInstanceOf[Array[Any]].zipWithIndex) {
                result += jsonStringifyInner(arrayItem, indentInner)
                if ((arrayItemIndex + 1) != anythingInner.asInstanceOf[Array[Any]].length) result += (if (pretty == true) s",\n${indentInner * indentLevel}" else ", ")
            }
            indentLevel -= 1
            result += (if (pretty == true) s"\n${indentInner * indentLevel}]" else "]")
            return result
        }
        if (anythingInner.isInstanceOf[Map[_, _]]) {
            if (anythingInner.asInstanceOf[Map[String, Any]].size == 0) return "{}"
            indentLevel += 1
            var result: String = (if (pretty == true) s"{\n${indentInner * indentLevel}" else "{")
            for (((objectKey, objectValue), objectEntryIndex) <- anythingInner.asInstanceOf[Map[String, Any]].toArray[Any].zipWithIndex) {
                result += s"\"${objectKey}\": ${jsonStringifyInner(objectValue, indentInner)}"
                if ((objectEntryIndex + 1) != anythingInner.asInstanceOf[Map[String, Any]].size) result += (if (pretty == true) s",\n${indentInner * indentLevel}" else ", ")
            }
            indentLevel -= 1
            result += (if (pretty == true) s"\n${indentInner * indentLevel}}" else "}")
            return result
        }
        return "null"
    }
    return jsonStringifyInner(anything, indent)
}

def arrayFindV1(callbackFunction: (Any, Int, Array[Any]) => Boolean, anArray: Array[Any]): Any = {
    // JavaScript-like Array.find() function
    for ((arrayItem, arrayItemIndex) <- anArray.asInstanceOf[Array[Any]].zipWithIndex) {
        val isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == true) return arrayItem
    }
    return null
}

def arrayFindV2(callbackFunction: (Any, Int, Array[Any]) => Boolean, anArray: Array[Any]): Any = {
    // JavaScript-like Array.find() function
    for ((arrayItem, arrayItemIndex) <- anArray.asInstanceOf[Array[Any]].zipWithIndex) {
        if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) return arrayItem
    }
    return null
}

println("\n// JavaScript-like Array.find() in Scala Array")

val numbers = MyArray(12, 34, 27, 23, 65, 93, 36, 87, 4, 254)
println(s"numbers: ${jsonStringify(numbers)}")

var evenNumberFound: Any = null
var oddNumberFound: Any = null

println("// using JavaScript-like Array.find() function \"arrayFindV1\"")

evenNumberFound = arrayFindV1(((number: Any, _: Int, _: Array[Any]) => ((number.asInstanceOf[Int] % 2) == 0): Boolean), numbers)
println(s"even number found: ${evenNumberFound}")
// even number found: 12

oddNumberFound = arrayFindV1(((number: Any, _: Int, _: Array[Any]) => ((number.asInstanceOf[Int] % 2) != 0): Boolean), numbers)
println(s"odd number found: ${oddNumberFound}")
// odd number found: 27

println("// using JavaScript-like Array.find() function \"arrayFindV2\"")

evenNumberFound = arrayFindV2(((number: Any, _: Int, _: Array[Any]) => ((number.asInstanceOf[Int] % 2) == 0): Boolean), numbers)
println(s"even number found: ${evenNumberFound}")
// even number found: 12

oddNumberFound = arrayFindV2(((number: Any, _: Int, _: Array[Any]) => ((number.asInstanceOf[Int] % 2) != 0): Boolean), numbers)
println(s"odd number found: ${oddNumberFound}")
// odd number found: 27

println("// using Scala Array.find() built-in method \"Array.find().getOrElse(null)\"")

evenNumberFound = numbers.find(((number: Any) => ((number.asInstanceOf[Int] % 2) == 0): Boolean)).getOrElse(null)
println(s"even number found: ${evenNumberFound}")
// even number found: 12

oddNumberFound = numbers.find(((number: Any) => ((number.asInstanceOf[Int] % 2) != 0): Boolean)).getOrElse(null)
println(s"odd number found: ${oddNumberFound}")
// odd number found: 27

println("\n// JavaScript-like Array.find() in Scala Array of Maps")

val products = MyArray(
    MyObject(
        "code" -> "pasta",
        "price" -> 321
    ),
    MyObject(
        "code" -> "bubble_gum",
        "price" -> 233
    ),
    MyObject(
        "code" -> "potato_chips",
        "price" -> 5
    ),
    MyObject(
        "code" -> "towel",
        "price" -> 499
    ),
)
println(s"products: ${jsonStringify(products, pretty = true)}")

val productToFind = "bubble_gum"
println(s"product to find: ${jsonStringify(productToFind)}")

var productFound: Any = null

println("// using JavaScript-like Array.find() function \"arrayFindV1\"")

productFound = arrayFindV1(((product: Any, _: Int, _: Array[Any]) => (product.asInstanceOf[Map[String, Any]]("code").asInstanceOf[String] == productToFind): Boolean), products)
println(s"product found: ${jsonStringify(productFound, pretty = true)}")
// product found: {
//     "code":"bubble_gum",
//     "price": 233
// }

println("// using JavaScript-like Array.find() function \"arrayFindV2\"")

productFound = arrayFindV2(((product: Any, _: Int, _: Array[Any]) => (product.asInstanceOf[Map[String, Any]]("code").asInstanceOf[String] == productToFind): Boolean), products)
println(s"product found: ${jsonStringify(productFound, pretty = true)}")
// product found: {
//     "code":"bubble_gum",
//     "price": 233
// }

println("// using Scala Array.find() built-in method \"Array.find().getOrElse(null)\"")

productFound = products.find(((product: Any) => (product.asInstanceOf[Map[String, Any]]("code").asInstanceOf[String] == productToFind): Boolean)).getOrElse(null)
println(s"product found: ${jsonStringify(productFound, pretty = true)}")
// product found: {
//     "code":"bubble_gum",
//     "price": 233
// }
