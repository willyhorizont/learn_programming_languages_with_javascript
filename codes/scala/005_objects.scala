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

// in Scala, JavaScript-like Object is called mutable Map

val friend: Any = mutable.Map[String, Any](
    "name" -> "Alisa",
    "country" -> "Finland",
    "age" -> 25
)
println(s"friend: ${jsonStringify(friend, pretty = true)}")

println(s"friend, get total object keys: ${friend.asInstanceOf[mutable.Map[String, Any]].size}")
// friend, get total object keys: 3

println(s"friend, get country: ${friend.asInstanceOf[mutable.Map[String, Any]]("country")}")
// friend, get country: Finland

// iterate over and get each key-value pair
friend.asInstanceOf[mutable.Map[String, Any]].foreach((objectEntry: Tuple2[String, Any]) => { println(s"friend, forEach loop, key: ${objectEntry._1}, value: ${objectEntry._2}") })
// fruits, forEach loop, key: name, value: Alisa
// fruits, forEach loop, key: country, value: Finland
// fruits, forEach loop, key: age, value: 25

// iterate over and get each key-value pair
friend.asInstanceOf[mutable.Map[String, Any]].foreach((objectEntry: Tuple2[String, Any]) => {
    val (objectKey, objectValue): (String, Any) = (objectEntry._1, objectEntry._2)
    println(s"friend, forEach loop, key: ${objectKey}, value: ${objectValue}")
})
// fruits, forEach loop, key: name, value: Alisa
// fruits, forEach loop, key: country, value: Finland
// fruits, forEach loop, key: age, value: 25

// iterate over and get each key-value pair
friend.asInstanceOf[mutable.Map[String, Any]].foreach { case (objectKey, objectValue) => println(s"friend, forEach loop, key: ${objectKey}, value: ${objectValue}") }
// fruits, forEach loop, key: name, value: Alisa
// fruits, forEach loop, key: country, value: Finland
// fruits, forEach loop, key: age, value: 25

// iterate over and get each key-value pair
friend.asInstanceOf[mutable.Map[String, Any]].foreach(new Function1[Tuple2[String, Any], Unit] {
    def apply(objectEntry: Tuple2[String, Any]): Unit = {
        val (objectKey, objectValue): (String, Any) = (objectEntry._1, objectEntry._2)
        println(s"friend, forEach loop, key: ${objectKey}, value: ${objectValue}")
    }
})
// fruits, forEach loop, key: name, value: Alisa
// fruits, forEach loop, key: country, value: Finland
// fruits, forEach loop, key: age, value: 25

// iterate over and get each key-value pair
for ((objectKey, objectValue) <- friend.asInstanceOf[mutable.Map[String, Any]]) {
    println(s"friend, forEach loop, key: ${objectKey}, value: ${objectValue}")
}
// fruits, forEach loop, key: name, value: Alisa
// fruits, forEach loop, key: country, value: Finland
// fruits, forEach loop, key: age, value: 25

// iterate over and get each key-value pair and object iteration/entry index (the best way)
for (((objectKey, objectValue), objectEntryIndex) <- friend.asInstanceOf[mutable.Map[String, Any]].toArray[Any].zipWithIndex) {
    println(s"friend, forEach loop, object iteration/entry index: ${objectEntryIndex}, key: ${objectKey}, value: ${objectValue}")
}
// friend, forEach loop, object iteration/entry index: 0, key: name, value: Alisa
// friend, forEach loop, object iteration/entry index: 1, key: country, value: Finland
// friend, forEach loop, object iteration/entry index: 2, key: age, value: 25

friend.asInstanceOf[mutable.Map[String, Any]]("age") = 27
println(s"friend: ${jsonStringify(friend, pretty = true)}")

friend.asInstanceOf[mutable.Map[String, Any]]("gender") = "Female"
println(s"friend: ${jsonStringify(friend, pretty = true)}")

friend.asInstanceOf[mutable.Map[String, Any]].update("job", "Streamer")
println(s"friend: ${jsonStringify(friend, pretty = true)}")

friend.asInstanceOf[mutable.Map[String, Any]] += ("address" -> "123 Main Street, Anytown, Finland")
println(s"friend: ${jsonStringify(friend, pretty = true)}")

friend.asInstanceOf[mutable.Map[String, Any]] -= "name"
println(s"friend: ${jsonStringify(friend, pretty = true)}")

friend.asInstanceOf[mutable.Map[String, Any]].remove("country")
println(s"friend: ${jsonStringify(friend, pretty = true)}")

// Computed property names: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Object_initializer#computed_property_names
val deliveryResponseKeyMessage: Any = "message"
val deliveryResponse: Any = mutable.Map[String, Any](
    deliveryResponseKeyMessage.asInstanceOf[String] -> "ok".asInstanceOf[Any]
)
println(s"deliveryResponse: ${jsonStringify(deliveryResponse, pretty = true)}")
val deliveryResponseKeyStatus: Any = "status"
deliveryResponse.asInstanceOf[mutable.Map[String, Any]](deliveryResponseKeyStatus.asInstanceOf[String]) = 200
println(s"deliveryResponse: ${jsonStringify(deliveryResponse, pretty = true)}")
