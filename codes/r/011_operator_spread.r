library(jsonlite)

# There's no JavaScript-like Spread Syntax (...) in R.
# But, we can create our own function to mimic it in R.

prettyJsonStringify <- function(anything) {
    prettyJsonStringWithTrailingNewLine <- prettify(toJSON(anything, pretty = TRUE, auto_unbox = TRUE), indent = 4)
    prettyJsonStringWithoutTrailingNewLine <- gsub("\\n$", "", prettyJsonStringWithTrailingNewLine, perl = TRUE)
    prettyJsonStringWithoutTrailingNewLineAndWithProperNull <- gsub("\\{\\s*\\n\\s*\\}", "null", prettyJsonStringWithoutTrailingNewLine, perl = TRUE)
    return(prettyJsonStringWithoutTrailingNewLineAndWithProperNull)
}

prettyArrayOfPrimitives <- function(anArrayOfPrimitives) {
    result <- "["
    for (arrayItemIndex in seq_along(anArrayOfPrimitives)) {
        arrayItem <- anArrayOfPrimitives[[arrayItemIndex]]
        if ((is.character(arrayItem) == FALSE) && (is.numeric(arrayItem) == FALSE) && (is.logical(arrayItem) == FALSE) && (is.null(arrayItem) == FALSE)) next
        if (is.character(arrayItem) == TRUE) {
            result <- paste(sep = "", result, "\"", arrayItem, "\"")
        }
        if ((is.numeric(arrayItem) == TRUE) || (is.logical(arrayItem) == TRUE)) {
            result <- paste(sep = "", result, arrayItem)
        }
        if (is.null(arrayItem) == TRUE) {
            result <- paste(sep = "", result, "null")
        }
        if (arrayItemIndex != length(anArrayOfPrimitives)) {
            result <- paste(sep = "", result, ", ")
        }
    }
    result <- paste(sep = "", result, "]")
    return(result)
}

getType <- function(anything) {
    if (is.list(anything) == FALSE) return(class(anything))
    if (length(anything) == 0) return("empty_list")
    if (is.null(names(anything)) == TRUE) return("array")
    return("object")
}

spreadSyntaxObject <- function(...) {
    parameters <- list(...)
    newObject <- list()
    for (parameterIndex in seq_along(parameters)) {
        parameter <- parameters[[parameterIndex]]
        parameterType <- getType(parameter)
        if (parameterType == "object") {
            for (objectKey in names(parameter)) {
                objectValue <- parameter[[objectKey]]
                newObject[[objectKey]] <- objectValue
            }
            next
        }
        if (parameterType == "array") {
            for (arrayItemIndex in seq_along(parameter)) {
                arrayItem <- parameter[[arrayItemIndex]]
                newObject[[as.character(arrayItemIndex)]] <- arrayItem
            }
            next
        }
    }
    return(newObject)
}

spreadSyntaxArray <- function(...) {
    parameters <- list(...)
    newArray <- list()
    for (parameterIndex in seq_along(parameters)) {
        parameter <- parameters[[parameterIndex]]
        parameterType <- getType(parameter)
        if (parameterType == "object") {
            objectLength <- length(parameter)
            if (objectLength == 1) {
                for (objectKey in names(parameter)) {
                    objectValue <- parameter[[objectKey]]
                    newArray <- append(newArray, list(objectValue))
                }
                next
            }
            newArray <- append(newArray, parameter)
            next
        }
        if (parameterType == "array") {
            for (arrayItemIndex in seq_along(parameter)) {
                arrayItem <- parameter[[arrayItemIndex]]
                newArray <- append(newArray, list(arrayItem))
            }
            next
        }
    }
    return(newArray)
}

cat("\n# JavaScript-like Spread Syntax (...) in R\n")

fruits <- list("Mango", "Melon", "Banana")
cat(paste(sep = "", "fruits: ", prettyArrayOfPrimitives(fruits), "\n"))

vegetables <- list("Carrot", "Tomato")
cat(paste(sep = "", "vegetables: ", prettyArrayOfPrimitives(vegetables), "\n"))

countryCapitalsInAsia <- list(
    Thailand = "Bangkok",
    China = "Beijing",
    Japan = "Tokyo"
)
cat(paste(sep = "", "countryCapitalsInAsia: ", prettyJsonStringify(countryCapitalsInAsia), "\n"))

countryCapitalsInEurope <- list(
    France = "Paris",
    England = "London"
)
cat(paste(sep = "", "countryCapitalsInEurope: ", prettyJsonStringify(countryCapitalsInEurope), "\n"))

cat("\n# [...array1, ...array2]:\n")

combination1 <- spreadSyntaxArray(fruits, vegetables)
cat(paste(sep = "", "combination1: ", prettyJsonStringify(combination1), "\n"))
# combination1: [
#     "Mango",
#     "Melon",
#     "Banana",
#     "Carrot",
#     "Tomato"
# ]

combination2 <- spreadSyntaxArray(fruits, list("Cucumber", "Onion"))
cat(paste(sep = "", "combination2: ", prettyJsonStringify(combination2), "\n"))
# combination2: [
#     "Mango",
#     "Melon",
#     "Banana",
#     "Cucumber",
#     "Onion"
# ]

cat("\n# { ...object1, ...object2 }:\n")

combination3 <- spreadSyntaxObject(countryCapitalsInAsia, countryCapitalsInEurope)
cat(paste(sep = "", "combination3: ", prettyJsonStringify(combination3), "\n"))
# combination3: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "France": "Paris",
#     "England": "London"
# }

combination4 <- spreadSyntaxObject(countryCapitalsInAsia, list(Germany = "Berlin", Italy = "Rome"))
cat(paste(sep = "", "combination4: ", prettyJsonStringify(combination4), "\n"))
# combination4: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "Germany": "Berlin",
#     "Italy": "Rome"
# }

cat("\n# [...array1, array2]:\n")

combination5 <- spreadSyntaxArray(fruits, list(vegetables = vegetables))
cat(paste(sep = "", "combination5: ", prettyJsonStringify(combination5), "\n"))
# combination5: [
#     "Mango",
#     "Melon",
#     "Banana",
#     [
#         "Carrot",
#         "Tomato"
#     ]
# ]

combination6 <- spreadSyntaxArray(fruits, list(vegetables = list("Cucumber", "Onion")))
cat(paste(sep = "", "combination6: ", prettyJsonStringify(combination6), "\n"))
# combination6: [
#     "Mango",
#     "Melon",
#     "Banana",
#     [
#         "Cucumber",
#         "Onion"
#     ]
# ]

cat("\n# [...array1, object1]:\n")

combination7 <- spreadSyntaxArray(fruits, list(countryCapitalsInAsia = countryCapitalsInAsia))
cat(paste(sep = "", "combination7: ", prettyJsonStringify(combination7), "\n"))
# combination7: [
#     "Mango",
#     "Melon",
#     "Banana",
#     {
#         "Thailand": "Bangkok",
#         "China": "Beijing",
#         "Japan": "Tokyo"
#     }
# ]

combination8 <- spreadSyntaxArray(fruits, list(countryCapitalsInEurope = list(Germany = "Berlin", Italy = "Rome")))
cat(paste(sep = "", "combination8: ", prettyJsonStringify(combination8), "\n"))
# combination8: [
#     "Mango",
#     "Melon",
#     "Banana",
#     {
#         "Germany": "Berlin",
#         "Italy": "Rome"
#     }
# ]

cat("\n# { ...object1, object2 }:\n")

combination9 <- spreadSyntaxObject(countryCapitalsInAsia, list(countryCapitalsInEurope = countryCapitalsInEurope))
cat(paste(sep = "", "combination9: ", prettyJsonStringify(combination9), "\n"))
# combination9: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "countryCapitalsInEurope" : {
#       "France" : "Paris",
#       "England" : "London"
#    }
# }

combination10 <- spreadSyntaxObject(countryCapitalsInAsia, list(countryCapitalsInEurope = list(Germany = "Berlin", Italy = "Rome")))
cat(paste(sep = "", "combination10: ", prettyJsonStringify(combination10), "\n"))
# combination10: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "countryCapitalsInEurope": {
#         "Germany": "Berlin",
#         "Italy": "Rome"
#     }
# }

cat("\n# { ...object1, array2 }:\n")

combination11 <- spreadSyntaxObject(countryCapitalsInAsia, list(vegetables = vegetables))
cat(paste(sep = "", "combination11: ", prettyJsonStringify(combination11), "\n"))
# combination11: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "vegetables": [
#         "Carrot",
#         "Tomato"
#     ]
# }

combination12 <- spreadSyntaxObject(countryCapitalsInAsia, list(vegetables = list("Cucumber", "Onion")))
cat(paste(sep = "", "combination12: ", prettyJsonStringify(combination12), "\n"))
# combination12: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "vegetables": [
#         "Cucumber",
#         "Onion"
#     ]
# }

cat("\n# { ...object1, ...array2 }:\n")

combination13 <- spreadSyntaxObject(countryCapitalsInAsia, vegetables)
cat(paste(sep = "", "combination13: ", prettyJsonStringify(combination13), "\n"))
# combination13: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "1" : "Carrot",
#    "2" : "Tomato"
# }

combination14 <- spreadSyntaxObject(countryCapitalsInAsia, list("Cucumber", "Onion"))
cat(paste(sep = "", "combination14: ", prettyJsonStringify(combination14), "\n"))
# combination14: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "1" : "Cucumber",
#    "2" : "Onion"
# }

# cat("\n# [...array1, ...object1]: // this combination throw an error in JavaScript\n")

# this combination throw an error in JavaScript
# combinationErrorInJavascript1 <- spreadSyntaxArray(fruits, countryCapitalsInAsia)
# cat(paste(sep = "", "combinationErrorInJavascript1: ", prettyJsonStringify(combinationErrorInJavascript1), "\n"))

# this combination throw an error in JavaScript
# combinationErrorInJavascript2 <- spreadSyntaxArray(fruits, list(Germany = "Berlin", Italy = "Rome"))
# cat(paste(sep = "", "combinationErrorInJavascript2: ", prettyJsonStringify(combinationErrorInJavascript2), "\n"))
