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

// in Scala, JavaScript-like Array is called Array

val fruits = MyArray("apple", "mango", "orange")
println("fruits: " + jsonStringify(fruits))

println(s"fruits, length: ${fruits.asInstanceOf[Array[Any]].length}")
// fruits, length: 3

println(s"fruits, get mango: ${fruits.asInstanceOf[Array[Any]](2)}")
// fruits, get mango: mango

println(s"fruits, first element: ${fruits.asInstanceOf[Array[Any]](0)}")
// fruits, first element: apple

println(s"fruits, first element: ${fruits.asInstanceOf[Array[Any]].head}")
// fruits, first element: apple

println(s"fruits, last element: ${fruits.asInstanceOf[Array[Any]](fruits.asInstanceOf[Array[Any]].length - 1)}")
// fruits, last element: orange

println(s"fruits, last element: ${fruits.asInstanceOf[Array[Any]].last}")
// fruits, last element: orange

fruits.asInstanceOf[Array[Any]].zipWithIndex.foreach((objectEntry: Tuple2[Any, Int]) => { println(s"fruits, for loop, index: ${objectEntry._2}, value: ${objectEntry._1}") })
// fruits, forEach loop, index: 0, value: apple
// fruits, forEach loop, index: 1, value: mango
// fruits, forEach loop, index: 2, value: orange

fruits.asInstanceOf[Array[Any]].zipWithIndex.foreach((objectEntry: Tuple2[Any, Int]) => {
    val (arrayItem, arrayItemIndex): (Any, Int) = (objectEntry._1, objectEntry._2)
    println(s"fruits, for loop, index: ${arrayItemIndex}, value: ${arrayItem}")
})
// fruits, forEach loop, index: 0, value: apple
// fruits, forEach loop, index: 1, value: mango
// fruits, forEach loop, index: 2, value: orange

fruits.asInstanceOf[Array[Any]].zipWithIndex.foreach { case (arrayItem, arrayItemIndex) => println(s"fruits, for loop, index: ${arrayItemIndex}, value: ${arrayItem}") }
// fruits, forEach loop, index: 0, value: apple
// fruits, forEach loop, index: 1, value: mango
// fruits, forEach loop, index: 2, value: orange

fruits.asInstanceOf[Array[Any]].zipWithIndex.foreach(new Function1[Tuple2[Any, Int], Unit] {
    def apply(objectEntry: Tuple2[Any, Int]): Unit = {
        val (arrayItem, arrayItemIndex): (Any, Int) = (objectEntry._1, objectEntry._2)
        println(s"fruits, for loop, index: ${arrayItemIndex}, value: ${arrayItem}")
    }
})
// fruits, forEach loop, index: 0, value: apple
// fruits, forEach loop, index: 1, value: mango
// fruits, forEach loop, index: 2, value: orange

// (the best way)
for ((arrayItem, arrayItemIndex) <- fruits.asInstanceOf[Array[Any]].zipWithIndex) {
    println(s"fruits, for loop, index: ${arrayItemIndex}, value: ${arrayItem}")
}
// fruits, forEach loop, index: 0, value: apple
// fruits, forEach loop, index: 1, value: mango
// fruits, forEach loop, index: 2, value: orange

// in Scala, JavaScript-like Array of Objects is called Array of Maps

val products = MyArray(
    MyObject(
        "id" -> "P1",
        "name" -> "bubble gum"
    ),
    MyObject(
        "id" -> "P2",
        "name" -> "potato chips"
    )
)
println("products: " + jsonStringify(products, pretty = true))

for ((arrayItem, arrayItemIndex) <- products.asInstanceOf[Array[Any]].zipWithIndex) {
    for (((objectKey, objectValue), objectEntryIndex) <- arrayItem.asInstanceOf[Map[String, Any]].toArray[Any].zipWithIndex) {
        println(s"products, forEach loop, array item index: ${arrayItemIndex}, object iteration/entry index: ${objectEntryIndex}, key: ${objectKey}, value: ${objectValue}")
    }
}
// products, forEach loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
// products, forEach loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
// products, forEach loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
// products, forEach loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips
