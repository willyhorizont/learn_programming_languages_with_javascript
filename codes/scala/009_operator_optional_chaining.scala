import scala.collection.mutable

println("\n// JavaScript-like Optional Chaining Operator (?.) in Scala")

def MyObject(objectEntry: (String, Any)*): mutable.Map[String, Any] = (if (objectEntry.isEmpty) mutable.Map.empty[String, Any] else mutable.Map(objectEntry: _*))

def MyArray(arrayItem: Any*): Array[Any] = (if (arrayItem.isEmpty) Array.empty[Any] else arrayItem.toArray[Any])

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

val JSON_OBJECT: Any = MyObject(
    "foo" -> MyObject(
        "bar" -> "baz"
    ),
    "fruits" -> MyArray("apple", "mango", "banana")
)
println(s"JSON_OBJECT: ${jsonStringify(JSON_OBJECT, pretty = true)}")

println(s"JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: ${JSON_OBJECT.asInstanceOf[mutable.Map[String, Any]].getOrElse("foo", null).asInstanceOf[mutable.Map[String, Any]].getOrElse("bar", null)}")
// JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: baz

println(s"JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: ${JSON_OBJECT.asInstanceOf[mutable.Map[String, Any]].getOrElse("foo", null).asInstanceOf[mutable.Map[String, Any]].getOrElse("baz", null)}")
// JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: null

println(s"JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: ${JSON_OBJECT.asInstanceOf[mutable.Map[String, Any]].getOrElse("fruits", null).asInstanceOf[Array[Any]].lift(2).getOrElse(null)}")
// JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: banana

println(s"JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: ${JSON_OBJECT.asInstanceOf[mutable.Map[String, Any]].getOrElse("fruits", null).asInstanceOf[Array[Any]].lift(5).getOrElse(null)}")
// JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: null

println(s"JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: ${JSON_OBJECT.asInstanceOf[mutable.Map[String, Any]].getOrElse("foo", null).asInstanceOf[mutable.Map[String, Any]].applyOrElse("bar", ((_: String) => null))}")
// JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: baz

println(s"JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: ${JSON_OBJECT.asInstanceOf[mutable.Map[String, Any]].getOrElse("foo", null).asInstanceOf[mutable.Map[String, Any]].applyOrElse("baz", ((_: String) => null))}")
// JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: null

println(s"JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: ${JSON_OBJECT.asInstanceOf[mutable.Map[String, Any]].getOrElse("fruits", null).asInstanceOf[Array[Any]].applyOrElse(2, ((_: Int) => null))}")
// JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: banana

println(s"JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: ${JSON_OBJECT.asInstanceOf[mutable.Map[String, Any]].getOrElse("fruits", null).asInstanceOf[Array[Any]].applyOrElse(5, ((_: Int) => null))}")
// JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: null
