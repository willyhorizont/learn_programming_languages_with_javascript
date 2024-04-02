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
val toDouble = ((anything: Any) => (if (anything.isInstanceOf[Byte]) anything.asInstanceOf[Byte].toDouble else (if (anything.isInstanceOf[Int]) anything.asInstanceOf[Int].toDouble else (if (anything.isInstanceOf[Long]) anything.asInstanceOf[Long].toDouble else (if (anything.isInstanceOf[Short]) anything.asInstanceOf[Short].toDouble else (if (anything.isInstanceOf[Double]) anything.asInstanceOf[Double].toDouble else (if (anything.isInstanceOf[Float]) anything.asInstanceOf[Float].toDouble else (if (anything.isInstanceOf[BigInt]) anything.asInstanceOf[BigInt].toDouble else (if (anything.isInstanceOf[BigDecimal]) anything.asInstanceOf[BigDecimal].toDouble else 0.0)))))))): Double)

def arrayReduce(callbackFunction: (Any, Any, Int, Array[Any]) => Any, anArray: Array[Any], initialValue: Any): Any = {
    // JavaScript-like Array.reduce() function
    var result = initialValue
    for ((arrayItem, arrayItemIndex) <- anArray.asInstanceOf[Array[Any]].zipWithIndex) {
        result = callbackFunction(result, arrayItem, arrayItemIndex, anArray)
    }
    return result
}

println("\n// JavaScript-like Array.reduce() in Scala Array")

val numbers = MyArray(36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3)
println(s"numbers: ${jsonStringify(numbers)}")

var numbersTotal: Any = null

println("// using JavaScript-like Array.reduce() function \"arrayReduce\"")

numbersTotal = arrayReduce(((currentResult: Any, currentNumber: Any, _: Int, _: Array[Any]) => (toDouble(currentResult) + toDouble(currentNumber)): Any), numbers, 0.0)
println(s"total number: ${numbersTotal}")
// total number: 41.2

println("// using Scala Array.reduce() built-in method \"Array.reduce()\"")

numbersTotal = (MyArray((0.0).asInstanceOf[Any]) ++ numbers).reduce(((currentResult: Any, currentNumber: Any) => (toDouble(currentResult) + toDouble(currentNumber)): Any))
println(s"total number: ${numbersTotal}")
// total number: 41.2

println("// using Scala Array.reduce() built-in method \"Array.fold()()\"")

numbersTotal = numbers.fold((0.0).asInstanceOf[Any])(((currentResult: Any, currentNumber: Any) => (toDouble(currentResult) + toDouble(currentNumber)): Any))
println(s"total number: ${numbersTotal}")
// total number: 41.2

println("// using Scala Array.reduce() built-in method \"Array.foldLeft()()\"")

numbersTotal = numbers.foldLeft((0.0).asInstanceOf[Any])(((currentResult: Any, currentNumber: Any) => (toDouble(currentResult) + toDouble(currentNumber)): Any))
println(s"total number: ${numbersTotal}")
// total number: 41.2

println("\n// JavaScript-like Array.reduce() in Scala Array of Maps")

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

var productsGrouped: Any = null

println("// using JavaScript-like Array.reduce() function \"arrayReduce\"")

productsGrouped = arrayReduce(((currentResult: Any, currentProduct: Any, _: Int, _: Array[Any]) => (if (currentProduct.asInstanceOf[Map[String, Any]]("price").asInstanceOf[Int] > 100) ((MyObject() ++ currentResult.asInstanceOf[Map[String, Any]]) + ("expensive" -> ((MyArray() ++ currentResult.asInstanceOf[Map[String, Any]]("expensive").asInstanceOf[Array[Any]]) :+ currentProduct))) else ((MyObject() ++ currentResult.asInstanceOf[Map[String, Any]]) + ("cheap" -> ((MyArray() ++ currentResult.asInstanceOf[Map[String, Any]]("cheap").asInstanceOf[Array[Any]]) :+ currentProduct)))): Any), products, MyObject("expensive" -> MyArray(), "cheap" -> MyArray()))
println(s"grouped products: ${jsonStringify(productsGrouped, pretty = true)}")
// grouped products: {
//     "expensive": [
//         {
//             "code": "pasta",
//             "price": 321
//         },
//         {
//             "code": "bubble_gum",
//             "price": 233
//         },
//         {
//             "code": "towel",
//             "price": 499
//         }
//     ],
//     "cheap": [
//         {
//             "code": "potato_chips",
//             "price": 5
//         }
//     ]
// }

println("// using Scala Array.reduce() built-in method \"Array.reduce()\"")

productsGrouped = (MyArray(MyObject("expensive" -> MyArray(), "cheap" -> MyArray())) ++ products).reduce(((currentResult: Any, currentProduct: Any) => (if (currentProduct.asInstanceOf[Map[String, Any]]("price").asInstanceOf[Int] > 100) ((MyObject() ++ currentResult.asInstanceOf[Map[String, Any]]) + ("expensive" -> ((MyArray() ++ currentResult.asInstanceOf[Map[String, Any]]("expensive").asInstanceOf[Array[Any]]) :+ currentProduct))) else ((MyObject() ++ currentResult.asInstanceOf[Map[String, Any]]) + ("cheap" -> ((MyArray() ++ currentResult.asInstanceOf[Map[String, Any]]("cheap").asInstanceOf[Array[Any]]) :+ currentProduct)))): Any))
println(s"grouped products: ${jsonStringify(productsGrouped, pretty = true)}")
// grouped products: {
//     "expensive": [
//         {
//             "code": "pasta",
//             "price": 321
//         },
//         {
//             "code": "bubble_gum",
//             "price": 233
//         },
//         {
//             "code": "towel",
//             "price": 499
//         }
//     ],
//     "cheap": [
//         {
//             "code": "potato_chips",
//             "price": 5
//         }
//     ]
// }

println("// using Scala Array.reduce() built-in method \"Array.fold()()\"")

productsGrouped = products.fold(MyObject("expensive" -> MyArray(), "cheap" -> MyArray()).asInstanceOf[Any])(((currentResult: Any, currentProduct: Any) => (if (currentProduct.asInstanceOf[Map[String, Any]]("price").asInstanceOf[Int] > 100) ((MyObject() ++ currentResult.asInstanceOf[Map[String, Any]]) + ("expensive" -> ((MyArray() ++ currentResult.asInstanceOf[Map[String, Any]]("expensive").asInstanceOf[Array[Any]]) :+ currentProduct))) else ((MyObject() ++ currentResult.asInstanceOf[Map[String, Any]]) + ("cheap" -> ((MyArray() ++ currentResult.asInstanceOf[Map[String, Any]]("cheap").asInstanceOf[Array[Any]]) :+ currentProduct)))): Any))
println(s"grouped products: ${jsonStringify(productsGrouped, pretty = true)}")
// grouped products: {
//     "expensive": [
//         {
//             "code": "pasta",
//             "price": 321
//         },
//         {
//             "code": "bubble_gum",
//             "price": 233
//         },
//         {
//             "code": "towel",
//             "price": 499
//         }
//     ],
//     "cheap": [
//         {
//             "code": "potato_chips",
//             "price": 5
//         }
//     ]
// }

println("// using Scala Array.reduce() built-in method \"Array.foldLeft()()\"")

productsGrouped = products.foldLeft(MyObject("expensive" -> MyArray(), "cheap" -> MyArray()).asInstanceOf[Any])(((currentResult: Any, currentProduct: Any) => (if (currentProduct.asInstanceOf[Map[String, Any]]("price").asInstanceOf[Int] > 100) ((MyObject() ++ currentResult.asInstanceOf[Map[String, Any]]) + ("expensive" -> ((MyArray() ++ currentResult.asInstanceOf[Map[String, Any]]("expensive").asInstanceOf[Array[Any]]) :+ currentProduct))) else ((MyObject() ++ currentResult.asInstanceOf[Map[String, Any]]) + ("cheap" -> ((MyArray() ++ currentResult.asInstanceOf[Map[String, Any]]("cheap").asInstanceOf[Array[Any]]) :+ currentProduct)))): Any))
println(s"grouped products: ${jsonStringify(productsGrouped, pretty = true)}")
// grouped products: {
//     "expensive": [
//         {
//             "code": "pasta",
//             "price": 321
//         },
//         {
//             "code": "bubble_gum",
//             "price": 233
//         },
//         {
//             "code": "towel",
//             "price": 499
//         }
//     ],
//     "cheap": [
//         {
//             "code": "potato_chips",
//             "price": 5
//         }
//     ]
// }
