def MyObject(objectEntries: (String, Any)*): Map[String, Any] = (if (objectEntries.isEmpty) Map.empty[String, Any] else objectEntries.toMap[String, Any])
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

// in Scala, JavaScript-like Object is called Map

val friend = MyObject(
    "name" -> "Alisa",
    "country" -> "Finland",
    "age" -> 25
)
println(s"friend: ${jsonStringify(friend, pretty = true)}")

println(s"friend, get country: ${friend.asInstanceOf[Map[String, Any]]("country")}")
// friend, get country: Finland

println(s"friend, get total object keys: ${friend.asInstanceOf[Map[String, Any]].size}")
// friend, get total object keys: 3

// iterate over and get each key-value pair
friend.asInstanceOf[Map[String, Any]].foreach((objectEntry: Tuple2[String, Any]) => { println(s"friend, forEach loop, key: ${objectEntry._1}, value: ${objectEntry._2}") })
// fruits, forEach loop, key: name, value: Alisa
// fruits, forEach loop, key: country, value: Finland
// fruits, forEach loop, key: age, value: 25

// iterate over and get each key-value pair
friend.asInstanceOf[Map[String, Any]].foreach((objectEntry: Tuple2[String, Any]) => {
    val (objectKey, objectValue): (String, Any) = (objectEntry._1, objectEntry._2)
    println(s"friend, forEach loop, key: ${objectKey}, value: ${objectValue}")
})
// fruits, forEach loop, key: name, value: Alisa
// fruits, forEach loop, key: country, value: Finland
// fruits, forEach loop, key: age, value: 25

// iterate over and get each key-value pair
friend.asInstanceOf[Map[String, Any]].foreach { case (objectKey, objectValue) => println(s"friend, forEach loop, key: ${objectKey}, value: ${objectValue}") }
// fruits, forEach loop, key: name, value: Alisa
// fruits, forEach loop, key: country, value: Finland
// fruits, forEach loop, key: age, value: 25

// iterate over and get each key-value pair
friend.asInstanceOf[Map[String, Any]].foreach(new Function1[Tuple2[String, Any], Unit] {
    def apply(objectEntry: Tuple2[String, Any]): Unit = {
        val (objectKey, objectValue): (String, Any) = (objectEntry._1, objectEntry._2)
        println(s"friend, forEach loop, key: ${objectKey}, value: ${objectValue}")
    }
})
// fruits, forEach loop, key: name, value: Alisa
// fruits, forEach loop, key: country, value: Finland
// fruits, forEach loop, key: age, value: 25

// iterate over and get each key-value pair
for ((objectKey, objectValue) <- friend.asInstanceOf[Map[String, Any]]) {
    println(s"friend, forEach loop, key: ${objectKey}, value: ${objectValue}")
}
// fruits, forEach loop, key: name, value: Alisa
// fruits, forEach loop, key: country, value: Finland
// fruits, forEach loop, key: age, value: 25

// iterate over and get each key-value pair and object iteration/entry index (the best way)
for (((objectKey, objectValue), objectEntryIndex) <- friend.asInstanceOf[Map[String, Any]].toArray[Any].zipWithIndex) {
    println(s"friend, forEach loop, object iteration/entry index: ${objectEntryIndex}, key: ${objectKey}, value: ${objectValue}")
}
// friend, forEach loop, object iteration/entry index: 0, key: name, value: Alisa
// friend, forEach loop, object iteration/entry index: 1, key: country, value: Finland
// friend, forEach loop, object iteration/entry index: 2, key: age, value: 25
