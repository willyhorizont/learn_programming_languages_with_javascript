import scala.collection.mutable

def createNewObject(objectEntry: (String, Any)*): Any = (if (objectEntry.isEmpty == true) mutable.Map.empty[String, Any] else mutable.Map(objectEntry: _*))

def isLikeJsArray(anything: Any): Any = {
    if (anything.isInstanceOf[mutable.ArrayBuffer[_]] == true) return true
    return false
}

def getType(anything: Any): Any = {
    // if (isLikeJsArray(anything) == true) return "Array"
    return anything.getClass.getName
}

val isNumeric = ((anything: Any) => (if (anything.isInstanceOf[Byte] || anything.isInstanceOf[Int] || anything.isInstanceOf[Long] || anything.isInstanceOf[Short] || anything.isInstanceOf[Double] || anything.isInstanceOf[Float] || anything.isInstanceOf[BigInt] || anything.isInstanceOf[BigDecimal]) true else false): Boolean)

def jsonStringify(anything: Any = null, pretty: Boolean = false, indent: String = "    "): String = {
    var indentLevel: Int = 0
    def jsonStringifyInner(anythingInner: Any, indentInner: String): String = {
        if (anythingInner == null) return "null"
        if (anythingInner.isInstanceOf[String]) return s"\"${anythingInner}\""
        if (isNumeric(anythingInner) || anythingInner.isInstanceOf[Boolean]) return s"${anythingInner}"
        if (anythingInner.isInstanceOf[mutable.ArrayBuffer[_]]) {
            if (anythingInner.asInstanceOf[mutable.ArrayBuffer[Any]].length == 0) return "[]"
            indentLevel += 1
            var result: String = (if (pretty == true) s"[\n${indentInner * indentLevel}" else "[")
            for ((arrayItem, arrayItemIndex) <- anythingInner.asInstanceOf[mutable.ArrayBuffer[Any]].zipWithIndex) {
                result += jsonStringifyInner(arrayItem, indentInner)
                if ((arrayItemIndex + 1) != anythingInner.asInstanceOf[mutable.ArrayBuffer[Any]].length) result += (if (pretty == true) s",\n${indentInner * indentLevel}" else ", ")
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

// in Scala, JavaScript-like Array is called ArrayBuffer

val fruits: Any = mutable.ArrayBuffer[Any]("apple", "mango", "orange")
println("fruits: " + jsonStringify(fruits))

println(s"isLikeJsArray(fruits): ${isLikeJsArray(fruits)}")

println(s"getType(fruits): ${getType(fruits)}")

println(s"fruits, length: ${fruits.asInstanceOf[mutable.ArrayBuffer[Any]].length}")
// fruits, length: 3

println(s"fruits, get mango: ${fruits.asInstanceOf[mutable.ArrayBuffer[Any]](2)}")
// fruits, get mango: mango

println(s"fruits, first element: ${fruits.asInstanceOf[mutable.ArrayBuffer[Any]](0)}")
// fruits, first element: apple

println(s"fruits, first element: ${fruits.asInstanceOf[mutable.ArrayBuffer[Any]].head}")
// fruits, first element: apple

println(s"fruits, last element: ${fruits.asInstanceOf[mutable.ArrayBuffer[Any]](fruits.asInstanceOf[mutable.ArrayBuffer[Any]].length - 1)}")
// fruits, last element: orange

println(s"fruits, last element: ${fruits.asInstanceOf[mutable.ArrayBuffer[Any]].last}")
// fruits, last element: orange

fruits.asInstanceOf[mutable.ArrayBuffer[Any]].zipWithIndex.foreach((objectEntry: Any) => {
    val arrayItem: Any = objectEntry.asInstanceOf[Tuple2[Any, Int]]._1
    val arrayItemIndex: Any = objectEntry.asInstanceOf[Tuple2[Any, Int]]._2
    println(s"fruits, for loop, index: ${arrayItemIndex}, value: ${arrayItem}")
})
// fruits, forEach loop, index: 0, value: apple
// fruits, forEach loop, index: 1, value: mango
// fruits, forEach loop, index: 2, value: orange

fruits.asInstanceOf[mutable.ArrayBuffer[Any]].zipWithIndex.foreach((objectEntry: Tuple2[Any, Int]) => {
    val (arrayItem, arrayItemIndex): (Any, Int) = (objectEntry._1, objectEntry._2)
    println(s"fruits, for loop, index: ${arrayItemIndex}, value: ${arrayItem}")
})
// fruits, forEach loop, index: 0, value: apple
// fruits, forEach loop, index: 1, value: mango
// fruits, forEach loop, index: 2, value: orange

fruits.asInstanceOf[mutable.ArrayBuffer[Any]].zipWithIndex.foreach { case (arrayItem, arrayItemIndex) => println(s"fruits, for loop, index: ${arrayItemIndex}, value: ${arrayItem}") }
// fruits, forEach loop, index: 0, value: apple
// fruits, forEach loop, index: 1, value: mango
// fruits, forEach loop, index: 2, value: orange

fruits.asInstanceOf[mutable.ArrayBuffer[Any]].zipWithIndex.foreach(new Function1[Tuple2[Any, Int], Unit] {
    def apply(objectEntry: Tuple2[Any, Int]): Unit = {
        val (arrayItem, arrayItemIndex): (Any, Int) = (objectEntry._1, objectEntry._2)
        println(s"fruits, for loop, index: ${arrayItemIndex}, value: ${arrayItem}")
    }
})
// fruits, forEach loop, index: 0, value: apple
// fruits, forEach loop, index: 1, value: mango
// fruits, forEach loop, index: 2, value: orange

// (the best way)
for ((arrayItem, arrayItemIndex) <- fruits.asInstanceOf[mutable.ArrayBuffer[Any]].zipWithIndex) {
    println(s"fruits, for loop, index: ${arrayItemIndex}, value: ${arrayItem}")
}
// fruits, forEach loop, index: 0, value: apple
// fruits, forEach loop, index: 1, value: mango
// fruits, forEach loop, index: 2, value: orange
