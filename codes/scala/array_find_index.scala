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

def arrayFindIndexV1(callbackFunction: (Any, Int, Array[Any]) => Boolean, anArray: Array[Any]): Int = {
    // JavaScript-like Array.findIndex() function
    for ((arrayItem, arrayItemIndex) <- anArray.asInstanceOf[Array[Any]].zipWithIndex) {
        val isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == true) return arrayItemIndex
    }
    return -1
}

def arrayFindIndexV2(callbackFunction: (Any, Int, Array[Any]) => Boolean, anArray: Array[Any]): Int = {
    // JavaScript-like Array.findIndex() function
    for ((arrayItem, arrayItemIndex) <- anArray.asInstanceOf[Array[Any]].zipWithIndex) {
        if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) return arrayItemIndex
    }
    return -1
}

println("\n// JavaScript-like Array.findIndex() in Scala Array")

val numbers = MyArray(12, 34, 27, 23, 65, 93, 36, 87, 4, 254)
println(s"numbers: ${jsonStringify(numbers)}")

val numberToFind = 27
println(s"number to find: ${numberToFind}")

var numberFoundIndex: Any = null

println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV1\"")

numberFoundIndex = arrayFindIndexV1(((number: Any, _: Int, _: Array[Any]) => (number.asInstanceOf[Int] == numberToFind): Boolean), numbers)
println(s"number found index: ${numberFoundIndex}")
// number found index: 2

println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV2\"")

numberFoundIndex = arrayFindIndexV2(((number: Any, _: Int, _: Array[Any]) => (number.asInstanceOf[Int] == numberToFind): Boolean), numbers)
println(s"number found index: ${numberFoundIndex}")
// number found index: 2

println("// using Scala Array.findIndex() built-in method \"Array.indexWhere()\"")

numberFoundIndex = numbers.indexWhere(((number: Any) => (number.asInstanceOf[Int] == numberToFind): Boolean))
println(s"number found index: ${numberFoundIndex}")
// number found index: 2

println("\n// JavaScript-like Array.findIndex() in Scala Array of Maps")

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

val productToFind = "pasta"
println(s"product to find: ${jsonStringify(productToFind)}")

var productFoundIndex: Any = null

println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV1\"")

productFoundIndex = arrayFindIndexV1(((product: Any, _: Int, _: Array[Any]) => (product.asInstanceOf[Map[String, Any]]("code").asInstanceOf[String] == productToFind): Boolean), products)
println(s"product found index: ${productFoundIndex}")
// product found index: 0

println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV2\"")

productFoundIndex = arrayFindIndexV2(((product: Any, _: Int, _: Array[Any]) => (product.asInstanceOf[Map[String, Any]]("code").asInstanceOf[String] == productToFind): Boolean), products)
println(s"product found index: ${productFoundIndex}")
// product found index: 0

println("// using Scala Array.findIndex() built-in method \"Array.indexWhere()\"")

productFoundIndex = products.indexWhere(((product: Any) => (product.asInstanceOf[Map[String, Any]]("code").asInstanceOf[String] == productToFind): Boolean))
println(s"product found index: ${productFoundIndex}")
// product found index: 0
