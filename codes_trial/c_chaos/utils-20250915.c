#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <stdarg.h>

typedef enum { ANY_NUMERIC, ANY_STRING, ANY_NULL, ANY_BOOL, ANY_ARRAY, ANY_OBJECT } AnyType;

typedef enum { ANY_NUMERIC_INT, ANY_NUMERIC_FLOAT } NumericType;

typedef struct any any;

typedef struct {
    NumericType type;
    union {
        long long jsLikeNumericInt;
        long double jsLikeNumericFloat;
    } value;
} JsLikeNumeric;

typedef struct {
    char* key;
    any* value;
} JsLikeObjectEntry;

typedef struct {
    JsLikeObjectEntry* value;
    size_t objectKeysLength;
    size_t memoryCapacity;
} JsLikeObject;

typedef struct {
    any** value;
    size_t length;
    size_t memoryCapacity;
} JsLikeArray;

typedef any* (*JsLikeFunctionRef)(any* languageVariadicArgumentsFirstArgument, ...);

typedef struct {
    JsLikeFunctionRef value;
} JsLikeFunction;

struct any {
    AnyType type;
    union {
        bool jsLikeBoolean;
        char* jsLikeString;
        JsLikeNumeric jsLikeNumeric;
        JsLikeArray jsLikeArray;
        JsLikeObject jsLikeObject;
    } value;
};

void throwNewError(const char* errorMessageInString) {
    fprintf(stderr, "%s", errorMessageInString);
    exit(EXIT_FAILURE);
}

any* createJsLikeNumeric(long double anyNumericInFloat) {
    char stringBuffer[128];
    snprintf(stringBuffer, sizeof(stringBuffer), "%.17Lg", anyNumericInFloat);

    char* endOfString;
    char* stringBufferForJsLikeNumericInt;
    bool isAllStringZero = true;

    const char* dotStringIndex = strchr(stringBuffer, '.');
    if (dotStringIndex != NULL) {
        const char* afterDotStringIndex = (dotStringIndex + 1);
        for (const char* restOfStringIndex = afterDotStringIndex; (*restOfStringIndex != '\0'); restOfStringIndex += 1) {
            if (*restOfStringIndex != '0') {
                isAllStringZero = false;
                break;
            }
        }
        if (isAllStringZero) {
            size_t parseIntStringResultLength = (dotStringIndex - stringBuffer); 
            stringBuffer[parseIntStringResultLength] = '\0';
        }
    }

    long long parseIntStringResult = strtoll(stringBuffer, &endOfString, 10);
    if ('\0' == *endOfString) {
        any* anyNumericInt = malloc(sizeof(any));
        (*anyNumericInt).type = ANY_NUMERIC;
        (*anyNumericInt).value.jsLikeNumeric.type = ANY_NUMERIC_INT;
        (*anyNumericInt).value.jsLikeNumeric.value.jsLikeNumericInt = parseIntStringResult;
        return anyNumericInt;
    }

    long double parseFloatStringResult = strtold(stringBuffer, &endOfString);
    if ('\0' == *endOfString) {
        any* anyNumericFloat = malloc(sizeof(any));
        (*anyNumericFloat).type = ANY_NUMERIC;
        (*anyNumericFloat).value.jsLikeNumeric.type = ANY_NUMERIC_FLOAT;
        (*anyNumericFloat).value.jsLikeNumeric.value.jsLikeNumericFloat = parseFloatStringResult;
        return anyNumericFloat;
    }

    throwNewError("Error: not number\n");
    return NULL;
}

any* createJsLikeString(const char* anything) {
    any* newJsLikeString = malloc(sizeof(any));
    (*newJsLikeString).type = ANY_STRING;
    (*newJsLikeString).value.jsLikeString = strdup(anything);
    return newJsLikeString;
}

any* createJsLikeNull() {
    any* newJsLikeNull = malloc(sizeof(any));
    (*newJsLikeNull).type = ANY_NULL;
    return newJsLikeNull;
}

any* createJsLikeBoolean(bool anything) {
    any* newJsLikeBoolean = malloc(sizeof(any));
    (*newJsLikeBoolean).type = ANY_BOOL;
    (*newJsLikeBoolean).value.jsLikeBoolean = anything;
    return newJsLikeBoolean;
}

JsLikeObjectEntry createJsLikeObjectEntry(const char* newObjectKey, any* newObjectValue) {
    JsLikeObjectEntry newJsLikeObjectEntry;
    newJsLikeObjectEntry.key = strdup(newObjectKey);
    newJsLikeObjectEntry.value = newObjectValue;
    return newJsLikeObjectEntry;
}

#define createJsLikeArray(...) createJsLikeArrayInner(__VA_ARGS__, NULL)
any* createJsLikeArrayInner(any* languageVariadicArgumentsFirstArgument, ...) {
    va_list languageVariadicArguments;
    va_start(languageVariadicArguments, languageVariadicArgumentsFirstArgument);
    any** restArguments = va_arg(languageVariadicArguments, any**);
    va_end(languageVariadicArguments);

    any** newJsLikeArrayValue = NULL;
    size_t newJsLikeArrayLength = 0;
    size_t memoryCapacity = (sizeof(any*) * (newJsLikeArrayLength + 1));

    int i = 0;
    any* currentArgument = languageVariadicArgumentsFirstArgument;
    while (currentArgument != NULL) {
        newJsLikeArrayValue = realloc(newJsLikeArrayValue, memoryCapacity);
        newJsLikeArrayValue[newJsLikeArrayLength] = currentArgument;

        i += 1;
        currentArgument = restArguments[i];

        newJsLikeArrayLength += 1;
        memoryCapacity = (sizeof(any*) * newJsLikeArrayLength);
    }

    newJsLikeArrayLength += 1;
    memoryCapacity = (sizeof(any*) * newJsLikeArrayLength);

    newJsLikeArrayValue = realloc(newJsLikeArrayValue, memoryCapacity);
    newJsLikeArrayValue[newJsLikeArrayLength] = NULL;

    any* newJsLikeArray = malloc(sizeof(any));
    (*newJsLikeArray).type = ANY_ARRAY;
    (*newJsLikeArray).value.jsLikeArray.value = newJsLikeArrayValue;
    (*newJsLikeArray).value.jsLikeArray.length = newJsLikeArrayLength;
    (*newJsLikeArray).value.jsLikeArray.memoryCapacity = memoryCapacity;
    return newJsLikeArray;
}

#define createJsLikeArray2(...) createJsLikeArrayInner2((any*[]){__VA_ARGS__}, (sizeof((any*[]){__VA_ARGS__}) / sizeof(any*)))
any* createJsLikeArrayInner2(const any** languageVariadicArguments, size_t languageVariadicArgumentsLength) {
    size_t newJsLikeArrayLength = (languageVariadicArgumentsLength + 1);
    size_t memoryCapacity = (sizeof(any*) * newJsLikeArrayLength);
    any** newJsLikeArrayValue = malloc(memoryCapacity);
    for (size_t i = 0; (i < languageVariadicArgumentsLength); i += 1) {
        newJsLikeArrayValue[i] = languageVariadicArguments[i];
    }
    newJsLikeArrayValue[languageVariadicArgumentsLength] = NULL;

    any* newJsLikeArray = malloc(sizeof(any));
    (*newJsLikeArray).type = ANY_ARRAY;
    (*newJsLikeArray).value.jsLikeArray.value = newJsLikeArrayValue;
    (*newJsLikeArray).value.jsLikeArray.length = newJsLikeArrayLength;
    (*newJsLikeArray).value.jsLikeArray.memoryCapacity = memoryCapacity;
    return newJsLikeArray;
}

any* createJsLikeArrayOld(any* languageVariadicArgumentsFirstArgument, ...) {
    va_list languageVariadicArguments;
    va_start(languageVariadicArguments, languageVariadicArgumentsFirstArgument);
    any** restArguments = va_arg(languageVariadicArguments, any**);
    va_end(languageVariadicArguments);

    size_t memoryCapacity = 4;
    size_t newJsLikeArrayLength = 0;
    any** newJsLikeArrayValue = malloc(sizeof(any*) * memoryCapacity);

    int i = 0;
    any* currentArgument = languageVariadicArgumentsFirstArgument;
    while (currentArgument != NULL) {
        if (newJsLikeArrayLength >= memoryCapacity) {
            memoryCapacity *= 2;
            newJsLikeArrayValue = realloc(newJsLikeArrayValue, (sizeof(any*) * memoryCapacity));
            if (!newJsLikeArrayValue) {
                perror("realloc");
                exit(EXIT_FAILURE);
            }
        }
        newJsLikeArrayValue[newJsLikeArrayLength] = currentArgument;
        newJsLikeArrayLength += 1;

        i += 1;
        currentArgument = restArguments[i];
    }

    any* newJsLikeArray = malloc(sizeof(any));
    (*newJsLikeArray).type = ANY_ARRAY;
    (*newJsLikeArray).value.jsLikeArray.value = newJsLikeArrayValue;
    (*newJsLikeArray).value.jsLikeArray.length = newJsLikeArrayLength;
    (*newJsLikeArray).value.jsLikeArray.memoryCapacity = memoryCapacity;
    return newJsLikeArray;
}

any* createJsLikeObject(JsLikeObjectEntry firstObjectEntry, ...) {
    va_list languageVariadicArguments;
    va_start(languageVariadicArguments, firstObjectEntry);

    size_t memoryCapacity = 4;
    size_t newJsLikeObjectKeysLength = 0;
    JsLikeObjectEntry* newJsLikeObjectValue = malloc(sizeof(JsLikeObjectEntry) * memoryCapacity);

    JsLikeObjectEntry currentObjectEntry = firstObjectEntry;
    while (currentObjectEntry.key != NULL) {
        if (newJsLikeObjectKeysLength >= memoryCapacity) {
            memoryCapacity *= 2;
            newJsLikeObjectValue = realloc(newJsLikeObjectValue, sizeof(JsLikeObjectEntry) * memoryCapacity);
            if (!newJsLikeObjectValue) {
                perror("realloc");
                exit(EXIT_FAILURE);
            }
        }

        newJsLikeObjectValue[newJsLikeObjectKeysLength] = currentObjectEntry;
        newJsLikeObjectKeysLength += 1;

        currentObjectEntry = va_arg(languageVariadicArguments, JsLikeObjectEntry);
    }

    va_end(languageVariadicArguments);

    any* newJsLikeObject = malloc(sizeof(any));
    (*newJsLikeObject).type = ANY_OBJECT;
    (*newJsLikeObject).value.jsLikeObject.value = newJsLikeObjectValue;
    (*newJsLikeObject).value.jsLikeObject.objectKeysLength = newJsLikeObjectKeysLength;
    (*newJsLikeObject).value.jsLikeObject.memoryCapacity = memoryCapacity;
    return newJsLikeObject;
}

any* getJsLikeFunctionParentLocalScopeVariableValue(any* jsLikeFunction, const char* anyObjectKey) {
    if (!jsLikeFunction || ((*jsLikeFunction).type != ANY_OBJECT)) return NULL;

    for (size_t i = 0; (i < (*jsLikeFunction).value.jsLikeObject.objectKeysLength); i += 1) {
        JsLikeObjectEntry* anyObject = &(*jsLikeFunction).value.jsLikeObject.value[i];
        if (0 == strcmp((*anyObject).key, anyObjectKey)) return (*anyObject).value;
    }

    return NULL;
}

void setJsLikeFunctionParentLocalScopeVariableValue(any* jsLikeFunction, any* jsLikeFunctionParentLocalScopeVariable) {
    if (!jsLikeFunction || !jsLikeFunctionParentLocalScopeVariable) return;

    size_t jsLikeFunctionParentLocalScopeVariableExistingObjectKeysLength = (*jsLikeFunction).value.jsLikeObject.objectKeysLength;
    size_t jsLikeFunctionParentLocalScopeVariableParentObjectKeysLength = (*jsLikeFunctionParentLocalScopeVariable).value.jsLikeObject.objectKeysLength;

    (*jsLikeFunction).value.jsLikeObject.value = realloc((*jsLikeFunction).value.jsLikeObject.value, (sizeof(JsLikeObjectEntry) * (jsLikeFunctionParentLocalScopeVariableExistingObjectKeysLength + jsLikeFunctionParentLocalScopeVariableParentObjectKeysLength)));

    if (!(*jsLikeFunction).value.jsLikeObject.value) {
        perror("realloc");
        exit(EXIT_FAILURE);
    }

    for (size_t i = 0; (i < jsLikeFunctionParentLocalScopeVariableParentObjectKeysLength); i += 1) {
        (*jsLikeFunction).value.jsLikeObject.value[jsLikeFunctionParentLocalScopeVariableExistingObjectKeysLength + i] = (*jsLikeFunctionParentLocalScopeVariable).value.jsLikeObject.value[i];
    }

    (*jsLikeFunction).value.jsLikeObject.objectKeysLength += jsLikeFunctionParentLocalScopeVariableParentObjectKeysLength;
}

any* createJsLikeFunction(JsLikeFunctionRef jsLikeFunction, any* jsLikeFunctionParentLocalScopeVariable) {
    any* newJsLikeFunction = malloc(sizeof(any));
    (*newJsLikeFunction).type = ANY_OBJECT; /* treat functions as object */

    /* allocate memory for object keys */
    (*newJsLikeFunction).value.jsLikeObject.value = malloc(sizeof(JsLikeObjectEntry));
    (*newJsLikeFunction).value.jsLikeObject.objectKeysLength = 1;
    (*newJsLikeFunction).value.jsLikeObject.memoryCapacity = 1;

    /* store function pointer */
    JsLikeFunction* jsLikeFunctionObject = malloc(sizeof(JsLikeFunction));
    (*jsLikeFunctionObject).value = jsLikeFunction;
    (*newJsLikeFunction).value.jsLikeObject.value[0].key = strdup("[object Function]");
    (*newJsLikeFunction).value.jsLikeObject.value[0].value = (any*)jsLikeFunctionObject;

    /* set parent local scope variable */
    setJsLikeFunctionParentLocalScopeVariableValue(newJsLikeFunction, jsLikeFunctionParentLocalScopeVariable);

    return newJsLikeFunction;
}

any* callJsLikeFunction(any* jsLikeFunction, any* languageVariadicArgumentsFirstArgument, ...) {
    if (!jsLikeFunction || ((*jsLikeFunction).type != ANY_OBJECT) || (0 == (*jsLikeFunction).value.jsLikeObject.objectKeysLength)) throwNewError("not function\n");

    JsLikeFunction* jsLikeFunctionObject = (JsLikeFunction*)(*jsLikeFunction).value.jsLikeObject.value[0].value;
    if (!jsLikeFunctionObject || !(*jsLikeFunctionObject).value) throwNewError("function pointer is null\n");

    va_list languageVariadicArguments;
    va_start(languageVariadicArguments, languageVariadicArgumentsFirstArgument);

    // create temporary array to store all arguments + self
    size_t restArgumentsCapacity = 8;
    size_t argumentsLength = 0;
    any** argumentsArray = malloc(sizeof(any*) * restArgumentsCapacity);

    for (any* currentArgument = languageVariadicArgumentsFirstArgument; (currentArgument != NULL); currentArgument = va_arg(languageVariadicArguments, any*)) {
        if (argumentsLength >= restArgumentsCapacity) {
            restArgumentsCapacity *= 2;
            argumentsArray = realloc(argumentsArray, (sizeof(any*) * restArgumentsCapacity));
        }
        argumentsArray[argumentsLength] = currentArgument;
        argumentsLength += 1;
    }

    va_end(languageVariadicArguments);

    // add jsLikeFunction as last argument (like "this")
    if (argumentsLength >= restArgumentsCapacity) {
        restArgumentsCapacity += 1;
        argumentsArray = realloc(argumentsArray, (sizeof(any*) * restArgumentsCapacity));
    }
    argumentsArray[argumentsLength] = jsLikeFunction;
    argumentsLength += 1;

    // call function with first argument (can be interpret va_list inside function)
    any* jsLikeFunctionCallResult = (*jsLikeFunctionObject).value(argumentsArray[0], (argumentsArray + 1));

    free(argumentsArray);

    return jsLikeFunctionCallResult;
}

void freeMemory(any* anything) {
    if (!anything) return;

    switch ((*anything).type) {
        case ANY_STRING:
            if ((*anything).value.jsLikeString) free((*anything).value.jsLikeString);
            break;

        case ANY_ARRAY:
            if ((*anything).value.jsLikeArray.value) {
                for (size_t i = 0; (i < (*anything).value.jsLikeArray.length); i += 1) {
                    freeMemory((*anything).value.jsLikeArray.value[i]);
                }
                free((*anything).value.jsLikeArray.value);
            }
            break;

        case ANY_OBJECT:
            if ((*anything).value.jsLikeObject.value) {
                for (size_t i = 0; (i < (*anything).value.jsLikeObject.objectKeysLength); i += 1) {
                    JsLikeObjectEntry* anyObjectEntry = &(*anything).value.jsLikeObject.value[i];
                    if ((*anyObjectEntry).key) free((*anyObjectEntry).key);
                    if ((*anyObjectEntry).value) freeMemory((*anyObjectEntry).value);
                }
                free((*anything).value.jsLikeObject.value);
            }
            break;

        case ANY_NUMERIC:
            /* no need to free memory here */
        case ANY_BOOL:
            /* no need to free memory here */
        case ANY_NULL:
            /* no need to free memory here */
        default:
            /* no need to free memory here */
            break;
    }

    free(anything);
}

void reassignValue(any** target, any* newValue) {
    if (*target != NULL) freeMemory(*target);
    *target = newValue;
}
