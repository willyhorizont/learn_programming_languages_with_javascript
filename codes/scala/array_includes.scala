import scala.collection.mutable

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

// arrayIncludesV1

println("\n// JavaScript-like Array.includes() in Scala")

val myFriends = MyArray("Alisa", "Trivia")
println(s"myFriends: ${jsonStringify(myFriends)}")

var aName: Any = null
var isMyFriend: Any = null

println("// using Scala Array.includes() built-in method \"Array.contains()\"")

aName = "Alisa"
isMyFriend = myFriends.contains(aName)
println(s"is my friends includes \"${aName}\": ${isMyFriend}")
// is my friends includes "Alisa": true

aName = "Trivia"
isMyFriend = myFriends.contains(aName)
println(s"is my friends includes \"${aName}\": ${isMyFriend}")
// is my friends includes "Trivia": true

aName = "Tony"
isMyFriend = myFriends.contains(aName)
println(s"is my friends includes \"${aName}\": ${isMyFriend}")
// is my friends includes "Tony": false

aName = "Ezekiel"
isMyFriend = myFriends.contains(aName)
println(s"is my friends includes \"${aName}\": ${isMyFriend}")
// is my friends includes "Ezekiel": false
