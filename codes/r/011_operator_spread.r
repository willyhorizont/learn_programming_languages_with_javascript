typeOf <- function(anything) {
    if (is.list(anything) == FALSE) return(class(anything))
    if (length(anything) == 0) return("array")
    if (is.null(names(anything)) == TRUE) return("array")
    return("object")
}

jsonStringify <- function(anything, pretty = FALSE, indent = strrep(" ", 4)) {
    indentLevel <- 0
    jsonStringifyInner <- function(anythingInner, indentInner) {
        if (is.null(anythingInner)) return("null")
        if (is.character(anythingInner)) return(paste(sep = "", "\"", anythingInner, "\""))
        if (is.numeric(anythingInner) || is.logical(anythingInner)) return(paste(sep = "", anythingInner))
        if (typeOf(anythingInner) == "array") {
            if (length(anythingInner) == 0) return("[]")
            indentLevel <<- (indentLevel + 1)
            result <- (if (pretty == TRUE) paste(sep = "", "[\n", strrep(indentInner, indentLevel)) else "[")
            for (arrayItemIndex in seq_along(anythingInner)) {
                arrayItem <- anythingInner[[arrayItemIndex]]
                result <- paste(sep = "", result, jsonStringifyInner(arrayItem, indentInner))
                if (arrayItemIndex != length(anythingInner)) result <- (if (pretty == TRUE) paste(sep = "", result, ",\n", strrep(indentInner, indentLevel)) else paste(sep = "", result, ", "))
            }
            indentLevel <<- (indentLevel - 1)
            result <- (if (pretty == TRUE) paste(sep = "", result, "\n", strrep(indentInner, indentLevel), "]") else paste(sep = "", result, "]"))
            return(result)
        }
        if (typeOf(anythingInner) == "object") {
            if (length(names(anythingInner)) == 0) return("{}")
            indentLevel <<- (indentLevel + 1)
            result <- (if (pretty == TRUE) paste(sep = "", "{\n", strrep(indentInner, indentLevel)) else "{")
            for (objectEntryIndex in seq_along(anythingInner)) {
                objectKey <- names(anythingInner)[objectEntryIndex]
                objectValue <- anythingInner[[objectEntryIndex]]
                result <- paste(sep = "", result, "\"", objectKey, "\": ", jsonStringifyInner(objectValue, indentInner))
                if (objectEntryIndex != length(names(anythingInner))) result <- (if (pretty == TRUE) paste(sep = "", result, ",\n", strrep(indentInner, indentLevel)) else paste(sep = "", result, ", "))
            }
            indentLevel <<- (indentLevel - 1)
            result <- (if (pretty == TRUE) paste(sep = "", result, "\n", strrep(indentInner, indentLevel), "}") else paste(sep = "", result, "}"))
            return(result)
        }
        return("null")
    }
    return(jsonStringifyInner(anything, indent))
}

# In R, we can use "c()" function to mimic JavaScript-like Spread Syntax (...) for Arrays
# But for Objects, we need to create custom function because "c()" function doesn't merge Objects.

cc <- function(...) {
    parameters <- list(...)
    newObject <- list()
    for (parameterIndex in seq_along(parameters)) {
        parameter <- parameters[[parameterIndex]]
        parameterType <- typeOf(parameter)
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

cat("\n# JavaScript-like Spread Syntax (...) in R\n")

fruits <- list("Mango", "Melon", "Banana")
cat(paste(sep = "", "fruits: ", jsonStringify(fruits), "\n"))

vegetables <- list("Carrot", "Tomato")
cat(paste(sep = "", "vegetables: ", jsonStringify(vegetables), "\n"))

countryCapitalsInAsia <- list(
    Thailand = "Bangkok",
    China = "Beijing",
    Japan = "Tokyo"
)
cat(paste(sep = "", "countryCapitalsInAsia: ", jsonStringify(countryCapitalsInAsia, pretty = TRUE), "\n"))

countryCapitalsInEurope <- list(
    France = "Paris",
    England = "London"
)
cat(paste(sep = "", "countryCapitalsInEurope: ", jsonStringify(countryCapitalsInEurope, pretty = TRUE), "\n"))

cat("\n# [...array1, ...array2]:\n")

combination1 <- c(fruits, vegetables)
cat(paste(sep = "", "combination1: ", jsonStringify(combination1, pretty = TRUE), "\n"))
# combination1: [
#     "Mango",
#     "Melon",
#     "Banana",
#     "Carrot",
#     "Tomato"
# ]

combination2 <- c(fruits, list("Cucumber", "Cabbage"))
cat(paste(sep = "", "combination2: ", jsonStringify(combination2, pretty = TRUE), "\n"))
# combination2: [
#     "Mango",
#     "Melon",
#     "Banana",
#     "Cucumber",
#     "Cabbage"
# ]

cat("\n# { ...object1, ...object2 }:\n")

combination3 <- cc(countryCapitalsInAsia, countryCapitalsInEurope)
cat(paste(sep = "", "combination3: ", jsonStringify(combination3, pretty = TRUE), "\n"))
# combination3: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "France": "Paris",
#     "England": "London"
# }

combination4 <- cc(countryCapitalsInAsia, list(Germany = "Berlin", Italy = "Rome"))
cat(paste(sep = "", "combination4: ", jsonStringify(combination4, pretty = TRUE), "\n"))
# combination4: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "Germany": "Berlin",
#     "Italy": "Rome"
# }

cat("\n# [...array1, array2] || [...array1, newArrayItem1, newArrayItem2]:\n")

combination5 <- c(fruits, list(vegetables))
cat(paste(sep = "", "combination5: ", jsonStringify(combination5, pretty = TRUE), "\n"))
# combination5: [
#     "Mango",
#     "Melon",
#     "Banana",
#     [
#         "Carrot",
#         "Tomato"
#     ]
# ]

combination6 <- c(fruits, list(list("Cucumber", "Cabbage")))
cat(paste(sep = "", "combination6: ", jsonStringify(combination6, pretty = TRUE), "\n"))
# combination6: [
#     "Mango",
#     "Melon",
#     "Banana",
#     [
#         "Cucumber",
#         "Cabbage"
#     ]
# ]

cat("\n# [...array1, object1] || [...array1, newArrayItem1, newArrayItem2]:\n")

combination7 <- c(fruits, list(countryCapitalsInAsia))
cat(paste(sep = "", "combination7: ", jsonStringify(combination7, pretty = TRUE), "\n"))
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

combination8 <- c(fruits, list(list(Germany = "Berlin", Italy = "Rome")))
cat(paste(sep = "", "combination8: ", jsonStringify(combination8, pretty = TRUE), "\n"))
# combination8: [
#     "Mango",
#     "Melon",
#     "Banana",
#     {
#         "Germany": "Berlin",
#         "Italy": "Rome"
#     }
# ]

cat("\n# { ...object1, object2 } || { ...object1, objectKey: objectValue }:\n")

combination9 <- cc(countryCapitalsInAsia, list(countryCapitalsInEurope = countryCapitalsInEurope))
cat(paste(sep = "", "combination9: ", jsonStringify(combination9, pretty = TRUE), "\n"))
# combination9: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "countryCapitalsInEurope" : {
#       "France" : "Paris",
#       "England" : "London"
#    }
# }

combination10 <- cc(countryCapitalsInAsia, list(countryCapitalsInEurope = list(Germany = "Berlin", Italy = "Rome")))
cat(paste(sep = "", "combination10: ", jsonStringify(combination10, pretty = TRUE), "\n"))
# combination10: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "countryCapitalsInEurope": {
#         "Germany": "Berlin",
#         "Italy": "Rome"
#     }
# }

cat("\n# { ...object1, array2 } || { ...object1, objectKey: objectValue }:\n")

combination11 <- cc(countryCapitalsInAsia, list(vegetables = vegetables))
cat(paste(sep = "", "combination11: ", jsonStringify(combination11, pretty = TRUE), "\n"))
# combination11: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "vegetables": [
#         "Carrot",
#         "Tomato"
#     ]
# }

combination12 <- cc(countryCapitalsInAsia, list(vegetables = list("Cucumber", "Cabbage")))
cat(paste(sep = "", "combination12: ", jsonStringify(combination12, pretty = TRUE), "\n"))
# combination12: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "vegetables": [
#         "Cucumber",
#         "Cabbage"
#     ]
# }

cat("\n# { ...object1, ...array2 }:\n")

combination13 <- cc(countryCapitalsInAsia, vegetables)
cat(paste(sep = "", "combination13: ", jsonStringify(combination13, pretty = TRUE), "\n"))
# combination13: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "1" : "Carrot",
#    "2" : "Tomato"
# }

combination14 <- cc(countryCapitalsInAsia, list("Cucumber", "Cabbage"))
cat(paste(sep = "", "combination14: ", jsonStringify(combination14, pretty = TRUE), "\n"))
# combination14: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "1" : "Cucumber",
#    "2" : "Cabbage"
# }

# cat("\n# [...array1, ...object1]: // this combination throw an error in JavaScript\n")

# this combination throw an error in JavaScript
# combinationErrorInJavascript1 <- c(fruits, countryCapitalsInAsia)
# cat(paste(sep = "", "combinationErrorInJavascript1: ", jsonStringify(combinationErrorInJavascript1, pretty = TRUE), "\n"))

# this combination throw an error in JavaScript
# combinationErrorInJavascript2 <- c(fruits, list(Germany = "Berlin", Italy = "Rome"))
# cat(paste(sep = "", "combinationErrorInJavascript2: ", jsonStringify(combinationErrorInJavascript2, pretty = TRUE), "\n"))
