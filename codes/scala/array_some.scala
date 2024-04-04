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

def arraySomeV1(callbackFunction: (Any, Int, Array[Any]) => Boolean, anArray: Array[Any]): Boolean = {
    // JavaScript-like Array.some() function
    var isConditionMatch = false
    for ((arrayItem, arrayItemIndex) <- anArray.asInstanceOf[Array[Any]].zipWithIndex) {
        isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == true) return isConditionMatch
    }
    return isConditionMatch
}

def arraySomeV2(callbackFunction: (Any, Int, Array[Any]) => Boolean, anArray: Array[Any]): Boolean = {
    // JavaScript-like Array.some() function
    for ((arrayItem, arrayItemIndex) <- anArray.asInstanceOf[Array[Any]].zipWithIndex) {
        val isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == true) return true
    }
    return false
}

def arraySomeV3(callbackFunction: (Any, Int, Array[Any]) => Boolean, anArray: Array[Any]): Boolean = {
    // JavaScript-like Array.some() function
    for ((arrayItem, arrayItemIndex) <- anArray.asInstanceOf[Array[Any]].zipWithIndex) {
        if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) return true
    }
    return false
}

println("\n// JavaScript-like Array.some() in Scala Array")

val numbers = MyArray(12, 34, 27, 23, 65, 93, 36, 87, 4, 254)
println(s"numbers: ${jsonStringify(numbers)}")

var isAnyNumberLessThan500: Any = null
var isAnyNumberMoreThan500: Any = null

println("// using JavaScript-like Array.some() function \"arraySomeV1\"")

isAnyNumberLessThan500 = arraySomeV1(((number: Any, _: Int, _: Array[Any]) => (number.asInstanceOf[Int] < 500): Boolean), numbers)
println(s"is any number < 500: ${isAnyNumberLessThan500}")
// is any number < 500: true

isAnyNumberMoreThan500 = arraySomeV1(((number: Any, _: Int, _: Array[Any]) => (number.asInstanceOf[Int] > 500): Boolean), numbers)
println(s"is any number > 500: ${isAnyNumberMoreThan500}")
// is any number > 500: false

println("// using JavaScript-like Array.some() function \"arraySomeV2\"")

isAnyNumberLessThan500 = arraySomeV2(((number: Any, _: Int, _: Array[Any]) => (number.asInstanceOf[Int] < 500): Boolean), numbers)
println(s"is any number < 500: ${isAnyNumberLessThan500}")
// is any number < 500: true

isAnyNumberMoreThan500 = arraySomeV2(((number: Any, _: Int, _: Array[Any]) => (number.asInstanceOf[Int] > 500): Boolean), numbers)
println(s"is any number > 500: ${isAnyNumberMoreThan500}")
// is any number > 500: false

println("// using JavaScript-like Array.some() function \"arraySomeV3\"")

isAnyNumberLessThan500 = arraySomeV3(((number: Any, _: Int, _: Array[Any]) => (number.asInstanceOf[Int] < 500): Boolean), numbers)
println(s"is any number < 500: ${isAnyNumberLessThan500}")
// is any number < 500: true

isAnyNumberMoreThan500 = arraySomeV3(((number: Any, _: Int, _: Array[Any]) => (number.asInstanceOf[Int] > 500): Boolean), numbers)
println(s"is any number > 500: ${isAnyNumberMoreThan500}")
// is any number > 500: false

println("// using Scala Array.some() built-in method \"Array.exists()\"")

isAnyNumberLessThan500 = numbers.exists(((number: Any) => (number.asInstanceOf[Int] < 500): Boolean))
println(s"is any number < 500: ${isAnyNumberLessThan500}")
// is any number < 500: true

isAnyNumberMoreThan500 = numbers.exists(((number: Any) => (number.asInstanceOf[Int] > 500): Boolean))
println(s"is any number > 500: ${isAnyNumberMoreThan500}")
// is any number > 500: false

println("\n// JavaScript-like Array.some() in Scala Array of Maps")

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

var isAnyProductPriceLessThan500: Any = null
var isAnyProductPriceMoreThan500: Any = null

println("// using JavaScript-like Array.some() function \"arraySomeV1\"")

isAnyProductPriceLessThan500 = arraySomeV1(((product: Any, _: Int, _: Array[Any]) => (product.asInstanceOf[Map[String, Any]]("price").asInstanceOf[Int] < 500): Boolean), products)
println(s"is any product price < 500: ${isAnyProductPriceLessThan500}")
// is any product price < 500: true

isAnyProductPriceMoreThan500 = arraySomeV1(((product: Any, _: Int, _: Array[Any]) => (product.asInstanceOf[Map[String, Any]]("price").asInstanceOf[Int] > 500): Boolean), products)
println(s"is any product price > 500: ${isAnyProductPriceMoreThan500}")
// is any product price > 500: false

println("// using JavaScript-like Array.some() function \"arraySomeV2\"")

isAnyProductPriceLessThan500 = arraySomeV2(((product: Any, _: Int, _: Array[Any]) => (product.asInstanceOf[Map[String, Any]]("price").asInstanceOf[Int] < 500): Boolean), products)
println(s"is any product price < 500: ${isAnyProductPriceLessThan500}")
// is any product price < 500: true

isAnyProductPriceMoreThan500 = arraySomeV2(((product: Any, _: Int, _: Array[Any]) => (product.asInstanceOf[Map[String, Any]]("price").asInstanceOf[Int] > 500): Boolean), products)
println(s"is any product price > 500: ${isAnyProductPriceMoreThan500}")
// is any product price > 500: false

println("// using JavaScript-like Array.some() function \"arraySomeV3\"")

isAnyProductPriceLessThan500 = arraySomeV3(((product: Any, _: Int, _: Array[Any]) => (product.asInstanceOf[Map[String, Any]]("price").asInstanceOf[Int] < 500): Boolean), products)
println(s"is any product price < 500: ${isAnyProductPriceLessThan500}")
// is any product price < 500: true

isAnyProductPriceMoreThan500 = arraySomeV3(((product: Any, _: Int, _: Array[Any]) => (product.asInstanceOf[Map[String, Any]]("price").asInstanceOf[Int] > 500): Boolean), products)
println(s"is any product price > 500: ${isAnyProductPriceMoreThan500}")
// is any product price > 500: false

println("// using Scala Array.some() built-in method \"Array.exists()\"")

isAnyProductPriceLessThan500 = products.exists(((product: Any) => (product.asInstanceOf[Map[String, Any]]("price").asInstanceOf[Int] < 500): Boolean))
println(s"is any product price < 500: ${isAnyProductPriceLessThan500}")
// is any product price < 500: true

isAnyProductPriceMoreThan500 = products.exists(((product: Any) => (product.asInstanceOf[Map[String, Any]]("price").asInstanceOf[Int] > 500): Boolean))
println(s"is any product price > 500: ${isAnyProductPriceMoreThan500}")
// is any product price > 500: false
