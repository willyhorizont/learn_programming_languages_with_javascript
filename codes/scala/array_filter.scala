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

def arrayFilterV1(callbackFunction: (Any, Int, Array[Any]) => Any, anArray: Array[Any]): Array[Any] = {
    // JavaScript-like Array.filter() function
    var dataFiltered = MyArray()
    for ((arrayItem, arrayItemIndex) <- anArray.asInstanceOf[Array[Any]].zipWithIndex) {
        val isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == true) dataFiltered = (dataFiltered :+ arrayItem)
    }
    return dataFiltered
}

def arrayFilterV2(callbackFunction: (Any, Int, Array[Any]) => Any, anArray: Array[Any]): Array[Any] = {
    // JavaScript-like Array.filter() function
    var dataFiltered = MyArray()
    for ((arrayItem, arrayItemIndex) <- anArray.asInstanceOf[Array[Any]].zipWithIndex) {
        if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) dataFiltered = (dataFiltered :+ arrayItem)
    }
    return dataFiltered
}

println("\n// JavaScript-like Array.filter() in Scala Array")

val numbers = MyArray(12, 34, 27, 23, 65, 93, 36, 87, 4, 254)
println(s"numbers: ${jsonStringify(numbers)}")

var numbersEven: Any = null
var numbersOdd: Any = null

println("// using JavaScript-like Array.filter() function \"arrayFilterV1\"")

numbersEven = arrayFilterV1(((number: Any, _: Int, _: Array[Any]) => ((number.asInstanceOf[Int] % 2) == 0): Boolean), numbers)
println(s"even numbers only: ${jsonStringify(numbersEven)}")
// even numbers only: [12, 34, 36, 4, 254]

numbersOdd = arrayFilterV1(((number: Any, _: Int, _: Array[Any]) => ((number.asInstanceOf[Int] % 2) != 0): Boolean), numbers)
println(s"odd numbers only: ${jsonStringify(numbersOdd)}")
// odd numbers only: [27, 23, 65, 93, 87]

println("// using JavaScript-like Array.filter() function \"arrayFilterV2\"")

numbersEven = arrayFilterV2(((number: Any, _: Int, _: Array[Any]) => ((number.asInstanceOf[Int] % 2) == 0): Boolean), numbers)
println(s"even numbers only: ${jsonStringify(numbersEven)}")
// even numbers only: [12, 34, 36, 4, 254]

numbersOdd = arrayFilterV2(((number: Any, _: Int, _: Array[Any]) => ((number.asInstanceOf[Int] % 2) != 0): Boolean), numbers)
println(s"odd numbers only: ${jsonStringify(numbersOdd)}")
// odd numbers only: [27, 23, 65, 93, 87]

println("// using Scala Array.filter() built-in method \"Array.filter()\"")

numbersEven = numbers.filter(((number: Any) => ((number.asInstanceOf[Int] % 2) == 0): Boolean))
println(s"even numbers only: ${jsonStringify(numbersEven)}")
// even numbers only: [12, 34, 36, 4, 254]

numbersOdd = numbers.filter(((number: Any) => ((number.asInstanceOf[Int] % 2) != 0): Boolean))
println(s"odd numbers only: ${jsonStringify(numbersOdd)}")
// odd numbers only: [27, 23, 65, 93, 87]

println("\n// JavaScript-like Array.filter() in Scala Array of mutable Maps")

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

var productsBelow100: Any = null
var productsAbove100: Any = null

println("// using JavaScript-like Array.filter() function \"arrayFilterV1\"")

productsBelow100 = arrayFilterV1(((product: Any, _: Int, _: Array[Any]) => (product.asInstanceOf[mutable.Map[String, Any]]("price").asInstanceOf[Int] <= 100): Boolean), products)
println(s"products with price <= 100 only: ${jsonStringify(productsBelow100, pretty = true)}")
// products with price <= 100 only: [
//     {
//         "code": "potato_chips",
//         "price": 5
//     }
// ]

productsAbove100 = arrayFilterV1(((product: Any, _: Int, _: Array[Any]) => (product.asInstanceOf[mutable.Map[String, Any]]("price").asInstanceOf[Int] > 100): Boolean), products)
println(s"products with price > 100 only: ${jsonStringify(productsAbove100, pretty = true)}")
// products with price > 100 only: [
//     {
//         "code": "pasta",
//         "price": 321
//     },
//     {
//         "code": "bubble_gum",
//         "price": 233
//     },
//     {
//         "code": "towel",
//         "price": 499
//     }
// ]

println("// using JavaScript-like Array.filter() function \"arrayFilterV2\"")

productsBelow100 = arrayFilterV2(((product: Any, _: Int, _: Array[Any]) => (product.asInstanceOf[mutable.Map[String, Any]]("price").asInstanceOf[Int] <= 100): Boolean), products)
println(s"products with price <= 100 only: ${jsonStringify(productsBelow100, pretty = true)}")
// products with price <= 100 only: [
//     {
//         "code": "potato_chips",
//         "price": 5
//     }
// ]

productsAbove100 = arrayFilterV2(((product: Any, _: Int, _: Array[Any]) => (product.asInstanceOf[mutable.Map[String, Any]]("price").asInstanceOf[Int] > 100): Boolean), products)
println(s"products with price > 100 only: ${jsonStringify(productsAbove100, pretty = true)}")
// products with price > 100 only: [
//     {
//         "code": "pasta",
//         "price": 321
//     },
//     {
//         "code": "bubble_gum",
//         "price": 233
//     },
//     {
//         "code": "towel",
//         "price": 499
//     }
// ]

println("// using Scala Array.filter() built-in method \"Array.filter()\"")

productsBelow100 = products.filter(((product: Any) => (product.asInstanceOf[mutable.Map[String, Any]]("price").asInstanceOf[Int] <= 100): Boolean))
println(s"products with price <= 100 only: ${jsonStringify(productsBelow100, pretty = true)}")
// products with price <= 100 only: [
//     {
//         "code": "potato_chips",
//         "price": 5
//     }
// ]

productsAbove100 = products.filter(((product: Any) => (product.asInstanceOf[mutable.Map[String, Any]]("price").asInstanceOf[Int] > 100): Boolean))
println(s"products with price > 100 only: ${jsonStringify(productsAbove100, pretty = true)}")
// products with price > 100 only: [
//     {
//         "code": "pasta",
//         "price": 321
//     },
//     {
//         "code": "bubble_gum",
//         "price": 233
//     },
//     {
//         "code": "towel",
//         "price": 499
//     }
// ]
