#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <stdarg.h>

typedef char* JsLikeString;

typedef bool JsLikeBoolean;

typedef long long JsLikeInt;

typedef long double JsLikeFloat;

typedef enum { JS_LIKE_INT, JS_LIKE_FLOAT, JS_LIKE_STRING, JS_LIKE_NULL, JS_LIKE_BOOLEAN, JS_LIKE_ARRAY, JS_LIKE_OBJECT, JS_LIKE_ERROR } JsLikeDataTypes;

typedef struct JsLikeAny JsLikeAny;

typedef struct {
    JsLikeAny** value;
    JsLikeInt length;
    JsLikeInt memoryCapacity;
} JsLikeArray;

typedef struct {
    JsLikeAny** value;
    JsLikeInt objectKeysLength;
    JsLikeInt memoryCapacity;
} JsLikeObject;

typedef struct {
    JsLikeAny** value;
    JsLikeInt objectKeysLength;
    JsLikeInt memoryCapacity;
} JsLikeError;

typedef JsLikeAny* (*JsLikeFunctionRef)(JsLikeAny* languageVariadicArgumentsFirstArgument, ...);

typedef struct {
    JsLikeFunctionRef value;
} JsLikeFunction;

struct JsLikeAny {
    JsLikeDataTypes type;
    union {
        JsLikeBoolean jsLikeBoolean;
        JsLikeString jsLikeString;
        JsLikeInt jsLikeInt;
        JsLikeFloat jsLikeFloat;
        JsLikeArray jsLikeArray;
        JsLikeObject jsLikeObject;
        JsLikeError jsLikeError;
    } value;
};

void throwNewError(const char* errorMessageInString) {
    fprintf(stderr, "%s", errorMessageInString);
    exit(EXIT_FAILURE);
}

JsLikeAny* createJsLikeError(JsLikeAny* anything) {
    // TODO
    return anything;
}

JsLikeAny* createJsLikeNumeric(JsLikeFloat anyNumericInFloat) {
    char stringBuffer[128];
    snprintf(stringBuffer, sizeof(stringBuffer), "%.17Lg", anyNumericInFloat);

    char* endOfString;
    char* stringBufferForJsLikeInt;
    JsLikeBoolean isAllStringZero = true;

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
            JsLikeInt parseIntStringResultLength = (dotStringIndex - stringBuffer); 
            stringBuffer[parseIntStringResultLength] = '\0';
        }
    }

    JsLikeInt parseIntStringResult = strtoll(stringBuffer, &endOfString, 10);
    if ('\0' == *endOfString) {
        JsLikeAny* anyInt = malloc(sizeof(JsLikeAny));
        (*anyInt).type = JS_LIKE_INT;
        (*anyInt).value.jsLikeInt = parseIntStringResult;
        return anyInt;
    }

    JsLikeFloat parseFloatStringResult = strtold(stringBuffer, &endOfString);
    if ('\0' == *endOfString) {
        JsLikeAny* anyFloat = malloc(sizeof(JsLikeAny));
        (*anyFloat).type = JS_LIKE_FLOAT;
        (*anyFloat).value.jsLikeFloat = parseFloatStringResult;
        return anyFloat;
    }

    throwNewError("Error: not number\n");
    return NULL;
}

JsLikeAny* createJsLikeString(const char* anything) {
    JsLikeAny* newJsLikeString = malloc(sizeof(JsLikeAny));
    (*newJsLikeString).type = JS_LIKE_STRING;
    (*newJsLikeString).value.jsLikeString = strdup(anything);
    return newJsLikeString;
}

JsLikeAny* createJsLikeNull() {
    JsLikeAny* newJsLikeNull = malloc(sizeof(JsLikeAny));
    (*newJsLikeNull).type = JS_LIKE_NULL;
    return newJsLikeNull;
}

JsLikeAny* createJsLikeBoolean(JsLikeBoolean anything) {
    JsLikeAny* newJsLikeBoolean = malloc(sizeof(JsLikeAny));
    (*newJsLikeBoolean).type = JS_LIKE_BOOLEAN;
    (*newJsLikeBoolean).value.jsLikeBoolean = anything;
    return newJsLikeBoolean;
}

#define createJsLikeArray(...) createJsLikeArrayInner(__VA_ARGS__, NULL)
JsLikeAny* createJsLikeArrayInner(JsLikeAny* languageVariadicArgumentsFirstArgument, ...) {
    va_list languageVariadicArguments;
    va_start(languageVariadicArguments, languageVariadicArgumentsFirstArgument);

    JsLikeAny** newJsLikeArrayValue = NULL;
    JsLikeInt newJsLikeArrayLength = 0;
    JsLikeInt memoryCapacity = 0;

    JsLikeAny* currentArgument = languageVariadicArgumentsFirstArgument;
    while (currentArgument != NULL) {
        memoryCapacity = (sizeof(JsLikeAny*) * (newJsLikeArrayLength + 1));
        newJsLikeArrayValue = realloc(newJsLikeArrayValue, memoryCapacity);
        if (!newJsLikeArrayValue) {
            perror("realloc");
            exit(EXIT_FAILURE);
        }
        newJsLikeArrayValue[newJsLikeArrayLength] = currentArgument;
        currentArgument = va_arg(languageVariadicArguments, JsLikeAny*);
        newJsLikeArrayLength += 1;
    }

    va_end(languageVariadicArguments);

    JsLikeAny* newJsLikeArray = malloc(sizeof(JsLikeAny));
    (*newJsLikeArray).type = JS_LIKE_ARRAY;
    (*newJsLikeArray).value.jsLikeArray.value = newJsLikeArrayValue;
    (*newJsLikeArray).value.jsLikeArray.length = newJsLikeArrayLength;
    (*newJsLikeArray).value.jsLikeArray.memoryCapacity = memoryCapacity;
    return newJsLikeArray;
}

#define createJsLikeObject(...) createJsLikeObjectInner(__VA_ARGS__, NULL)
JsLikeAny* createJsLikeObjectInner(JsLikeAny* languageVariadicArgumentsFirstArgument, ...) {
    va_list languageVariadicArguments;
    va_start(languageVariadicArguments, languageVariadicArgumentsFirstArgument);

    JsLikeAny** newJsLikeObjectValue = NULL;
    JsLikeInt newJsLikeObjectKeysLength = 0;
    JsLikeInt memoryCapacity = 0;

    JsLikeAny* currentArgument = languageVariadicArgumentsFirstArgument;
    while (currentArgument != NULL) {
        memoryCapacity = (sizeof(JsLikeAny*) * (newJsLikeObjectKeysLength + 1));
        newJsLikeObjectValue = realloc(newJsLikeObjectValue, memoryCapacity);
        if (!newJsLikeObjectValue) {
            perror("realloc");
            exit(EXIT_FAILURE);
        }
        newJsLikeObjectValue[newJsLikeObjectKeysLength] = currentArgument;
        currentArgument = va_arg(languageVariadicArguments, JsLikeAny*);
        newJsLikeObjectKeysLength += 1;
    }

    va_end(languageVariadicArguments);

    JsLikeAny* newJsLikeObject = malloc(sizeof(JsLikeAny));
    (*newJsLikeObject).type = JS_LIKE_OBJECT;
    (*newJsLikeObject).value.jsLikeObject.value = newJsLikeObjectValue;
    (*newJsLikeObject).value.jsLikeObject.objectKeysLength = newJsLikeObjectKeysLength;
    (*newJsLikeObject).value.jsLikeObject.memoryCapacity = memoryCapacity;
    return newJsLikeObject;
}
/* 
JsLikeAny* getJsLikeFunctionParentLocalScopeVariableValue(JsLikeAny* jsLikeFunction, const char* anyObjectKey) {
    if (!jsLikeFunction || ((*jsLikeFunction).type != JS_LIKE_OBJECT)) return NULL;

    for (JsLikeInt i = 0; (i < (*jsLikeFunction).value.jsLikeObject.objectKeysLength); i += 1) {
        JsLikeObjectEntry* anyObject = &(*jsLikeFunction).value.jsLikeObject.value[i];
        if (0 == strcmp((*anyObject).key, anyObjectKey)) return (*anyObject).value;
    }

    return NULL;
}
 */
/* 
void setJsLikeFunctionParentLocalScopeVariableValue(JsLikeAny* jsLikeFunction, JsLikeAny* jsLikeFunctionParentLocalScopeVariable) {
    if (!jsLikeFunction || !jsLikeFunctionParentLocalScopeVariable) return;

    JsLikeInt jsLikeFunctionParentLocalScopeVariableExistingObjectKeysLength = (*jsLikeFunction).value.jsLikeObject.objectKeysLength;
    JsLikeInt jsLikeFunctionParentLocalScopeVariableParentObjectKeysLength = (*jsLikeFunctionParentLocalScopeVariable).value.jsLikeObject.objectKeysLength;

    (*jsLikeFunction).value.jsLikeObject.value = realloc((*jsLikeFunction).value.jsLikeObject.value, (sizeof(JsLikeObjectEntry) * (jsLikeFunctionParentLocalScopeVariableExistingObjectKeysLength + jsLikeFunctionParentLocalScopeVariableParentObjectKeysLength)));

    if (!(*jsLikeFunction).value.jsLikeObject.value) {
        perror("realloc");
        exit(EXIT_FAILURE);
    }

    for (JsLikeInt i = 0; (i < jsLikeFunctionParentLocalScopeVariableParentObjectKeysLength); i += 1) {
        (*jsLikeFunction).value.jsLikeObject.value[jsLikeFunctionParentLocalScopeVariableExistingObjectKeysLength + i] = (*jsLikeFunctionParentLocalScopeVariable).value.jsLikeObject.value[i];
    }

    (*jsLikeFunction).value.jsLikeObject.objectKeysLength += jsLikeFunctionParentLocalScopeVariableParentObjectKeysLength;
}
 */
JsLikeAny* createJsLikeFunction(JsLikeAny* jsLikeFunctionParentLocalScopeVariable, JsLikeAny* jsLikeFunction) {
    JsLikeAny** newJsLikeObjectValue = NULL;
    JsLikeInt newJsLikeObjectKeysLength = 0;
    JsLikeInt memoryCapacity = 0;

    memoryCapacity = (sizeof(JsLikeAny*) * (newJsLikeObjectKeysLength + 1));
    newJsLikeObjectValue[newJsLikeObjectKeysLength] = createJsLikeObject(createJsLikeArray(createJsLikeString("call"), jsLikeFunction));

    JsLikeAny* newJsLikeObject = malloc(sizeof(JsLikeAny));
    (*newJsLikeObject).type = JS_LIKE_OBJECT;
    (*newJsLikeObject).value.jsLikeObject.value = newJsLikeObjectValue;
    (*newJsLikeObject).value.jsLikeObject.objectKeysLength = 1;
    (*newJsLikeObject).value.jsLikeObject.memoryCapacity = memoryCapacity;
    return newJsLikeObject;
}
/* 
JsLikeAny* callJsLikeFunction(JsLikeAny* jsLikeFunction, JsLikeAny* languageVariadicArgumentsFirstArgument, ...) {
    if (!jsLikeFunction || ((*jsLikeFunction).type != JS_LIKE_OBJECT) || (0 == (*jsLikeFunction).value.jsLikeObject.objectKeysLength)) throwNewError("not function\n");

    JsLikeFunction* jsLikeFunctionObject = (JsLikeFunction*)(*jsLikeFunction).value.jsLikeObject.value[0].value;
    if (!jsLikeFunctionObject || !(*jsLikeFunctionObject).value) throwNewError("function pointer is null\n");

    va_list languageVariadicArguments;
    va_start(languageVariadicArguments, languageVariadicArgumentsFirstArgument);

    // create temporary array to store all arguments + self
    JsLikeInt restArgumentsCapacity = 8;
    JsLikeInt argumentsLength = 0;
    JsLikeAny** argumentsArray = malloc(sizeof(JsLikeAny*) * restArgumentsCapacity);

    for (JsLikeAny* currentArgument = languageVariadicArgumentsFirstArgument; (currentArgument != NULL); currentArgument = va_arg(languageVariadicArguments, JsLikeAny*)) {
        if (argumentsLength >= restArgumentsCapacity) {
            restArgumentsCapacity *= 2;
            argumentsArray = realloc(argumentsArray, (sizeof(JsLikeAny*) * restArgumentsCapacity));
        }
        argumentsArray[argumentsLength] = currentArgument;
        argumentsLength += 1;
    }

    va_end(languageVariadicArguments);

    // add jsLikeFunction as last argument (like "this")
    if (argumentsLength >= restArgumentsCapacity) {
        restArgumentsCapacity += 1;
        argumentsArray = realloc(argumentsArray, (sizeof(JsLikeAny*) * restArgumentsCapacity));
    }
    argumentsArray[argumentsLength] = jsLikeFunction;
    argumentsLength += 1;

    // call function with first argument (can be interpret va_list inside function)
    JsLikeAny* jsLikeFunctionCallResult = (*jsLikeFunctionObject).value(argumentsArray[0], (argumentsArray + 1));

    free(argumentsArray);

    return jsLikeFunctionCallResult;
}
 */
void freeMemory(JsLikeAny* anything) {
    if (!anything) return;

    switch ((*anything).type) {
        case JS_LIKE_STRING:
            if ((*anything).value.jsLikeString) free((*anything).value.jsLikeString);
            break;

        case JS_LIKE_ARRAY:
            if ((*anything).value.jsLikeArray.value) {
                for (JsLikeInt i = 0; (i < (*anything).value.jsLikeArray.length); i += 1) {
                    freeMemory((*anything).value.jsLikeArray.value[i]);
                }
                free((*anything).value.jsLikeArray.value);
            }
            break;

        case JS_LIKE_OBJECT:
            if ((*anything).value.jsLikeObject.value) {
                for (JsLikeInt i = 0; (i < (*anything).value.jsLikeObject.objectKeysLength); i += 1) {
                    JsLikeAny* anyObjectEntry = (*anything).value.jsLikeObject.value[i];
                    if ((*anyObjectEntry).value.jsLikeArray.value[0]) free((*anyObjectEntry).value.jsLikeArray.value[0]);
                    if ((*anyObjectEntry).value.jsLikeArray.value[1]) freeMemory((*anyObjectEntry).value.jsLikeArray.value[1]);
                }
                free((*anything).value.jsLikeObject.value);
            }
            break;

        case JS_LIKE_INT:
            /* no need to free memory here */
        case JS_LIKE_FLOAT:
            /* no need to free memory here */
        case JS_LIKE_BOOLEAN:
            /* no need to free memory here */
        case JS_LIKE_NULL:
            /* no need to free memory here */
        default:
            /* no need to free memory here */
            break;
    }

    free(anything);
}

void reassignValue(JsLikeAny** target, JsLikeAny* newValue) {
    if (*target != NULL) freeMemory(*target);
    *target = newValue;
}
