import scala.collection.mutable

def MyObject(objectEntries: (String, Any)*): mutable.Map[String, Any] = (if (objectEntries.isEmpty) mutable.Map.empty[String, Any] else mutable.Map(objectEntries: _*))

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
        if (anythingInner.isInstanceOf[mutable.Map[_, _]]) {
            if (anythingInner.asInstanceOf[mutable.Map[String, Any]].size == 0) return "{}"
            indentLevel += 1
            var result: String = (if (pretty == true) s"{\n${indentInner * indentLevel}" else "{")
            for (((objectKey, objectValue), objectEntryIndex) <- anythingInner.asInstanceOf[mutable.Map[String, Any]].toArray[Any].zipWithIndex) {
                result += s"\"${objectKey}\": ${jsonStringifyInner(objectValue, indentInner)}"
                if ((objectEntryIndex + 1) != anythingInner.asInstanceOf[mutable.Map[String, Any]].size) result += (if (pretty == true) s",\n${indentInner * indentLevel}" else ", ")
            }
            indentLevel -= 1
            result += (if (pretty == true) s"\n${indentInner * indentLevel}}" else "}")
            return result
        }
        return "null"
    }
    return jsonStringifyInner(anything, indent)
}

def arrayEveryV1(callbackFunction: (Any, Int, Array[Any]) => Boolean, anArray: Array[Any]): Boolean = {
    // JavaScript-like Array.every() function
    var isConditionMatch = false
    for ((arrayItem, arrayItemIndex) <- anArray.asInstanceOf[Array[Any]].zipWithIndex) {
        isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == false) return isConditionMatch
    }
    return isConditionMatch
}

def arrayEveryV2(callbackFunction: (Any, Int, Array[Any]) => Boolean, anArray: Array[Any]): Boolean = {
    // JavaScript-like Array.every() function
    for ((arrayItem, arrayItemIndex) <- anArray.asInstanceOf[Array[Any]].zipWithIndex) {
        val isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == false) return false
    }
    return true
}

def arrayEveryV3(callbackFunction: (Any, Int, Array[Any]) => Boolean, anArray: Array[Any]): Boolean = {
    // JavaScript-like Array.every() function
    for ((arrayItem, arrayItemIndex) <- anArray.asInstanceOf[Array[Any]].zipWithIndex) {
        if (callbackFunction(arrayItem, arrayItemIndex, anArray) == false) return false
    }
    return true
}

println("\n// JavaScript-like Array.every() in Scala Array")

val numbers = MyArray(12, 34, 27, 23, 65, 93, 36, 87, 4, 254)
println(s"numbers: ${jsonStringify(numbers)}")

var isAllNumberLessThan500: Any = null
var isAllNumberMoreThan500: Any = null

println("// using JavaScript-like Array.every() function \"arrayEveryV1\"")

isAllNumberLessThan500 = arrayEveryV1(((number: Any, _: Int, _: Array[Any]) => (number.asInstanceOf[Int] < 500): Boolean), numbers)
println(s"is all number < 500: ${isAllNumberLessThan500}")
// is all number < 500: true

isAllNumberMoreThan500 = arrayEveryV1(((number: Any, _: Int, _: Array[Any]) => (number.asInstanceOf[Int] > 500): Boolean), numbers)
println(s"is all number > 500: ${isAllNumberMoreThan500}")
// is all number > 500: false

println("// using JavaScript-like Array.every() function \"arrayEveryV2\"")

isAllNumberLessThan500 = arrayEveryV2(((number: Any, _: Int, _: Array[Any]) => (number.asInstanceOf[Int] < 500): Boolean), numbers)
println(s"is all number < 500: ${isAllNumberLessThan500}")
// is all number < 500: true

isAllNumberMoreThan500 = arrayEveryV2(((number: Any, _: Int, _: Array[Any]) => (number.asInstanceOf[Int] > 500): Boolean), numbers)
println(s"is all number > 500: ${isAllNumberMoreThan500}")
// is all number > 500: false

println("// using JavaScript-like Array.every() function \"arrayEveryV3\"")

isAllNumberLessThan500 = arrayEveryV3(((number: Any, _: Int, _: Array[Any]) => (number.asInstanceOf[Int] < 500): Boolean), numbers)
println(s"is all number < 500: ${isAllNumberLessThan500}")
// is all number < 500: true

isAllNumberMoreThan500 = arrayEveryV3(((number: Any, _: Int, _: Array[Any]) => (number.asInstanceOf[Int] > 500): Boolean), numbers)
println(s"is all number > 500: ${isAllNumberMoreThan500}")
// is all number > 500: false

println("// using Scala Array.every() built-in method \"Array.forall()\"")

isAllNumberLessThan500 = numbers.forall(((number: Any) => (number.asInstanceOf[Int] < 500): Boolean))
println(s"is all number < 500: ${isAllNumberLessThan500}")
// is all number < 500: true

isAllNumberMoreThan500 = numbers.forall(((number: Any) => (number.asInstanceOf[Int] > 500): Boolean))
println(s"is all number > 500: ${isAllNumberMoreThan500}")
// is all number > 500: false

println("\n// JavaScript-like Array.every() in Scala Array of Maps")

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

var isAllProductPriceLessThan500: Any = null
var isAllProductPriceMoreThan500: Any = null

println("// using JavaScript-like Array.every() function \"arrayEveryV1\"")

isAllProductPriceLessThan500 = arrayEveryV1(((product: Any, _: Int, _: Array[Any]) => (product.asInstanceOf[mutable.Map[String, Any]]("price").asInstanceOf[Int] < 500): Boolean), products)
println(s"is all product price < 500: ${isAllProductPriceLessThan500}")
// is all product price < 500: true

isAllProductPriceMoreThan500 = arrayEveryV1(((product: Any, _: Int, _: Array[Any]) => (product.asInstanceOf[mutable.Map[String, Any]]("price").asInstanceOf[Int] > 500): Boolean), products)
println(s"is all product price > 500: ${isAllProductPriceMoreThan500}")
// is all product price > 500: false

println("// using JavaScript-like Array.every() function \"arrayEveryV2\"")

isAllProductPriceLessThan500 = arrayEveryV2(((product: Any, _: Int, _: Array[Any]) => (product.asInstanceOf[mutable.Map[String, Any]]("price").asInstanceOf[Int] < 500): Boolean), products)
println(s"is all product price < 500: ${isAllProductPriceLessThan500}")
// is all product price < 500: true

isAllProductPriceMoreThan500 = arrayEveryV2(((product: Any, _: Int, _: Array[Any]) => (product.asInstanceOf[mutable.Map[String, Any]]("price").asInstanceOf[Int] > 500): Boolean), products)
println(s"is all product price > 500: ${isAllProductPriceMoreThan500}")
// is all product price > 500: false

println("// using JavaScript-like Array.every() function \"arrayEveryV3\"")

isAllProductPriceLessThan500 = arrayEveryV3(((product: Any, _: Int, _: Array[Any]) => (product.asInstanceOf[mutable.Map[String, Any]]("price").asInstanceOf[Int] < 500): Boolean), products)
println(s"is all product price < 500: ${isAllProductPriceLessThan500}")
// is all product price < 500: true

isAllProductPriceMoreThan500 = arrayEveryV3(((product: Any, _: Int, _: Array[Any]) => (product.asInstanceOf[mutable.Map[String, Any]]("price").asInstanceOf[Int] > 500): Boolean), products)
println(s"is all product price > 500: ${isAllProductPriceMoreThan500}")
// is all product price > 500: false

println("// using Scala Array.every() built-in method \"Array.forall()\"")

isAllProductPriceLessThan500 = products.forall(((product: Any) => (product.asInstanceOf[mutable.Map[String, Any]]("price").asInstanceOf[Int] < 500): Boolean))
println(s"is all product price < 500: ${isAllProductPriceLessThan500}")
// is all product price < 500: true

isAllProductPriceMoreThan500 = products.forall(((product: Any) => (product.asInstanceOf[mutable.Map[String, Any]]("price").asInstanceOf[Int] > 500): Boolean))
println(s"is all product price > 500: ${isAllProductPriceMoreThan500}")
// is all product price > 500: false
