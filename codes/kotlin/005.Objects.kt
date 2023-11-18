@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST")
// to compile and run the code:
// kotlinc 1.Objects.kt -include-runtime -d 1.Objects.jar && kotlin 1.Objects.jar

fun main() {
    val friend = mutableMapOf<String, Any?>(
        "name" to "Alisa",
        "country" to "Finland",
        "age" to 25
    )

    println("friend, get country: ${friend["country"]}")
    // friend, get country: Finland

    // iterate over and get each key-value pair
    friend.forEach { (objectKey, objectValue) -> println("friend, foreach loop, key: ${objectKey}, value: ${objectValue}") }
    // fruits, for loop, key: 0, value: apple
	// fruits, for loop, key: 1, value: mango
	// fruits, for loop, key: 2, value: orange

    // iterate over and get each key-value pair
    for ((objectKey, objectValue) in friend) {
        println("friend, for loop, key: ${objectKey}, value: ${objectValue}")
    }
    // fruits, for loop, key: 0, value: apple
	// fruits, for loop, key: 1, value: mango
	// fruits, for loop, key: 2, value: orange

    // iterate over and get each key-value pair and iteration/entry index
    friend.entries.forEachIndexed { iterationIndex, entryItem ->
        val objectKey = entryItem.key
        val objectValue = entryItem.value
        println("friend, foreach loop, index: ${iterationIndex}, key: ${objectKey}, value: ${objectValue}")
    }
    // friend, foreach loop, index: 0, key: name, value: Alisa
    // friend, foreach loop, index: 1, key: country, value: Finland
    // friend, foreach loop, index: 2, key: age, value: 25
}
