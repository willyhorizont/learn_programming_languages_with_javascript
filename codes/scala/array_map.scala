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

def arrayMapV1(callbackFunction: (Any, Int, Array[Any]) => Any, anArray: Array[Any]): Array[Any] = {
    // JavaScript-like Array.map() function
    var newArray = MyArray()
    for ((arrayItem, arrayItemIndex) <- anArray.asInstanceOf[Array[Any]].zipWithIndex) {
        val newArrayItem = callbackFunction(arrayItem, arrayItemIndex, anArray)
        newArray = (newArray :+ newArrayItem)
    }
    return newArray
}

def arrayMapV2(callbackFunction: (Any, Int, Array[Any]) => Any, anArray: Array[Any]): Array[Any] = {
    // JavaScript-like Array.map() function
    var newArray = MyArray()
    for ((arrayItem, arrayItemIndex) <- anArray.asInstanceOf[Array[Any]].zipWithIndex) {
        newArray = (newArray :+ callbackFunction(arrayItem, arrayItemIndex, anArray))
    }
    return newArray
}

println("\n// JavaScript-like Array.map() in Scala Array")

val numbers = MyArray(12, 34, 27, 23, 65, 93, 36, 87, 4, 254)
println(s"numbers: ${jsonStringify(numbers)}")

var numbersLabeled: Any = null

println("// using JavaScript-like Array.map() function \"arrayMapV1\"")

numbersLabeled = arrayMapV1(((number: Any, _: Int, _: Array[Any]) => (MyObject(number.asInstanceOf[Int].toString -> (if ((number.asInstanceOf[Int] % 2) == 0) "even" else "odd"))): mutable.Map[String, Any]), numbers)
println(s"labeled numbers: ${jsonStringify(numbersLabeled, pretty = true)}")
// labeled numbers: [
//     {
//         "12": "even"
//     },
//     {
//         "34": "even"
//     },
//     {
//         "27": "odd"
//     },
//     {
//         "23": "odd"
//     },
//     {
//         "65": "odd"
//     },
//     {
//         "93": "odd"
//     },
//     {
//         "36": "even"
//     },
//     {
//         "87": "odd"
//     },
//     {
//         "4": "even"
//     },
//     {
//         "254": "even"
//     }
// ]

println("// using JavaScript-like Array.map() function \"arrayMapV2\"")

numbersLabeled = arrayMapV2(((number: Any, _: Int, _: Array[Any]) => (MyObject(number.asInstanceOf[Int].toString -> (if ((number.asInstanceOf[Int] % 2) == 0) "even" else "odd"))): mutable.Map[String, Any]), numbers)
println(s"labeled numbers: ${jsonStringify(numbersLabeled, pretty = true)}")
// labeled numbers: [
//     {
//         "12": "even"
//     },
//     {
//         "34": "even"
//     },
//     {
//         "27": "odd"
//     },
//     {
//         "23": "odd"
//     },
//     {
//         "65": "odd"
//     },
//     {
//         "93": "odd"
//     },
//     {
//         "36": "even"
//     },
//     {
//         "87": "odd"
//     },
//     {
//         "4": "even"
//     },
//     {
//         "254": "even"
//     }
// ]

println("// using Scala Array.map() built-in method \"Array.map()\"")

numbersLabeled = numbers.map(((number: Any) => (MyObject(number.asInstanceOf[Int].toString -> (if ((number.asInstanceOf[Int] % 2) == 0) "even" else "odd"))): mutable.Map[String, Any]))
println(s"labeled numbers: ${jsonStringify(numbersLabeled, pretty = true)}")
// labeled numbers: [
//     {
//         "12": "even"
//     },
//     {
//         "34": "even"
//     },
//     {
//         "27": "odd"
//     },
//     {
//         "23": "odd"
//     },
//     {
//         "65": "odd"
//     },
//     {
//         "93": "odd"
//     },
//     {
//         "36": "even"
//     },
//     {
//         "87": "odd"
//     },
//     {
//         "4": "even"
//     },
//     {
//         "254": "even"
//     }
// ]

println("\n// JavaScript-like Array.map() in Scala Array of mutable Maps")

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

var productsLabeled: Any = null

println("// using JavaScript-like Array.map() function \"arrayMapV1\"")

productsLabeled = arrayMapV1(((product: Any, _: Int, _: Array[Any]) => ((MyObject() ++ product.asInstanceOf[mutable.Map[String, Any]]) ++ MyObject("label" -> (if (product.asInstanceOf[mutable.Map[String, Any]]("price").asInstanceOf[Int] > 100) "expensive" else "cheap"))): mutable.Map[String, Any]), products)
println(s"labeled products: ${jsonStringify(productsLabeled, pretty = true)}")
// labeled products: [
//     {
//         "code": "pasta",
//         "price": 321,
//         "label": "expensive"
//     },
//     {
//         "code": "bubble_gum",
//         "price": 233,
//         "label": "expensive"
//     },
//     {
//         "code": "potato_chips",
//         "price": 5,
//         "label": "cheap"
//     },
//     {
//         "code": "towel",
//         "price": 499,
//         "label": "expensive"
//     }
// ]

println("// using JavaScript-like Array.map() function \"arrayMapV2\"")

productsLabeled = arrayMapV2(((product: Any, _: Int, _: Array[Any]) => ((MyObject() ++ product.asInstanceOf[mutable.Map[String, Any]]) ++ MyObject("label" -> (if (product.asInstanceOf[mutable.Map[String, Any]]("price").asInstanceOf[Int] > 100) "expensive" else "cheap"))): mutable.Map[String, Any]), products)
println(s"labeled products: ${jsonStringify(productsLabeled, pretty = true)}")
// labeled products: [
//     {
//         "code": "pasta",
//         "price": 321,
//         "label": "expensive"
//     },
//     {
//         "code": "bubble_gum",
//         "price": 233,
//         "label": "expensive"
//     },
//     {
//         "code": "potato_chips",
//         "price": 5,
//         "label": "cheap"
//     },
//     {
//         "code": "towel",
//         "price": 499,
//         "label": "expensive"
//     }
// ]

println("// using Scala Array.map() built-in method \"Array.map()\"")

productsLabeled = products.map(((product: Any) => ((MyObject() ++ product.asInstanceOf[mutable.Map[String, Any]]) ++ MyObject("label" -> (if (product.asInstanceOf[mutable.Map[String, Any]]("price").asInstanceOf[Int] > 100) "expensive" else "cheap"))): mutable.Map[String, Any]))
println(s"labeled products: ${jsonStringify(productsLabeled, pretty = true)}")
// labeled products: [
//     {
//         "code": "pasta",
//         "price": 321,
//         "label": "expensive"
//     },
//     {
//         "code": "bubble_gum",
//         "price": 233,
//         "label": "expensive"
//     },
//     {
//         "code": "potato_chips",
//         "price": 5,
//         "label": "cheap"
//     },
//     {
//         "code": "towel",
//         "price": 499,
//         "label": "expensive"
//     }
// ]
