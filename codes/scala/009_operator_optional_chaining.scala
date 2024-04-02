println("\n// JavaScript-like Optional Chaining Operator (?.) in Scala")

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

val JSON_OBJECT: Any = MyObject(
    "foo" -> MyObject(
        "bar" -> "baz"
    ),
    "fruits" -> MyArray("apple", "mango", "banana")
)
println(s"JSON_OBJECT: ${jsonStringify(JSON_OBJECT, pretty = true)}")

println(s"JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: ${JSON_OBJECT.asInstanceOf[Map[String, Any]].getOrElse("foo", null).asInstanceOf[Map[String, Any]].getOrElse("bar", null)}")
// JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: baz

println(s"JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: ${JSON_OBJECT.asInstanceOf[Map[String, Any]].getOrElse("foo", null).asInstanceOf[Map[String, Any]].getOrElse("baz", null)}")
// JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: null

println(s"JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: ${JSON_OBJECT.asInstanceOf[Map[String, Any]].getOrElse("fruits", null).asInstanceOf[Array[Any]].lift(2).getOrElse(null)}")
// JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: banana

println(s"JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: ${JSON_OBJECT.asInstanceOf[Map[String, Any]].getOrElse("fruits", null).asInstanceOf[Array[Any]].lift(5).getOrElse(null)}")
// JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: null

println(s"JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: ${JSON_OBJECT.asInstanceOf[Map[String, Any]].getOrElse("foo", null).asInstanceOf[Map[String, Any]].applyOrElse("bar", ((_: String) => null))}")
// JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: baz

println(s"JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: ${JSON_OBJECT.asInstanceOf[Map[String, Any]].getOrElse("foo", null).asInstanceOf[Map[String, Any]].applyOrElse("baz", ((_: String) => null))}")
// JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: null

println(s"JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: ${JSON_OBJECT.asInstanceOf[Map[String, Any]].getOrElse("fruits", null).asInstanceOf[Array[Any]].applyOrElse(2, ((_: Int) => null))}")
// JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: banana

println(s"JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: ${JSON_OBJECT.asInstanceOf[Map[String, Any]].getOrElse("fruits", null).asInstanceOf[Array[Any]].applyOrElse(5, ((_: Int) => null))}")
// JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: null
