/* start of willyhorizont.github.io/codes required standard library */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <stdarg.h>

/* end of willyhorizont.github.io/codes required standard library */



/* start of willyhorizont.github.io/codes template */

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

typedef any* (*JsLikeFunctionRef)(any* firstArgumentRef, ...);

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

    char* endOfStringRef;
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

    long long parseIntStringResult = strtoll(stringBuffer, &endOfStringRef, 10);
    if ('\0' == *endOfStringRef) {
        any* anyNumericIntRef = malloc(sizeof(any));
        (*anyNumericIntRef).type = ANY_NUMERIC;
        (*anyNumericIntRef).value.jsLikeNumeric.type = ANY_NUMERIC_INT;
        (*anyNumericIntRef).value.jsLikeNumeric.value.jsLikeNumericInt = parseIntStringResult;
        return anyNumericIntRef;
    }

    long double parseFloatStringResult = strtold(stringBuffer, &endOfStringRef);
    if ('\0' == *endOfStringRef) {
        any* anyNumericFloatRef = malloc(sizeof(any));
        (*anyNumericFloatRef).type = ANY_NUMERIC;
        (*anyNumericFloatRef).value.jsLikeNumeric.type = ANY_NUMERIC_FLOAT;
        (*anyNumericFloatRef).value.jsLikeNumeric.value.jsLikeNumericFloat = parseFloatStringResult;
        return anyNumericFloatRef;
    }

    throwNewError("Error: not number\n");
    return NULL;
}

any* createJsLikeString(const char* anythingRef) {
    any* newJsLikeStringRef = malloc(sizeof(any));
    (*newJsLikeStringRef).type = ANY_STRING;
    (*newJsLikeStringRef).value.jsLikeString = strdup(anythingRef);
    return newJsLikeStringRef;
}

any* createJsLikeNull() {
    any* newJsLikeNull = malloc(sizeof(any));
    (*newJsLikeNull).type = ANY_NULL;
    return newJsLikeNull;
}

any* createJsLikeBoolean(bool anythingRef) {
    any* newJsLikeBooleanRef = malloc(sizeof(any));
    (*newJsLikeBooleanRef).type = ANY_BOOL;
    (*newJsLikeBooleanRef).value.jsLikeBoolean = anythingRef;
    return newJsLikeBooleanRef;
}

JsLikeObjectEntry createJsLikeObjectEntry(const char* newObjectKey, any* newObjectValue) {
    JsLikeObjectEntry newJsLikeObjectEntry;
    newJsLikeObjectEntry.key = strdup(newObjectKey);
    newJsLikeObjectEntry.value = newObjectValue;
    return newJsLikeObjectEntry;
}

any* createJsLikeArray(any* firstArgumentRef, ...) {
    va_list restArguments;
    va_start(restArguments, firstArgumentRef);

    size_t memoryCapacity = 4;
    size_t newJsLikeArrayLength = 0;
    any** newJsLikeArrayValue = malloc(sizeof(any*) * memoryCapacity);

    for (any* currentArgument = firstArgumentRef; (currentArgument != NULL); currentArgument = va_arg(restArguments, any*)) {
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
    }

    va_end(restArguments);

    any* newJsLikeArrayRef = malloc(sizeof(any));
    (*newJsLikeArrayRef).type = ANY_ARRAY;
    (*newJsLikeArrayRef).value.jsLikeArray.value = newJsLikeArrayValue;
    (*newJsLikeArrayRef).value.jsLikeArray.length = newJsLikeArrayLength;
    (*newJsLikeArrayRef).value.jsLikeArray.memoryCapacity = memoryCapacity;
    return newJsLikeArrayRef;
}

any* createJsLikeObject(JsLikeObjectEntry firstObjectEntry, ...) {
    va_list restArguments;
    va_start(restArguments, firstObjectEntry);

    size_t memoryCapacity = 4;
    size_t newJsLikeObjectKeysLength = 0;
    JsLikeObjectEntry* newJsLikeObjectValue = malloc(sizeof(JsLikeObjectEntry) * memoryCapacity);

    for (JsLikeObjectEntry currentObjectEntry = firstObjectEntry; (currentObjectEntry.key != NULL); currentObjectEntry = va_arg(restArguments, JsLikeObjectEntry)) {
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
    }

    va_end(restArguments);

    any* newJsLikeObjectRef = malloc(sizeof(any));
    (*newJsLikeObjectRef).type = ANY_OBJECT;
    (*newJsLikeObjectRef).value.jsLikeObject.value = newJsLikeObjectValue;
    (*newJsLikeObjectRef).value.jsLikeObject.objectKeysLength = newJsLikeObjectKeysLength;
    (*newJsLikeObjectRef).value.jsLikeObject.memoryCapacity = memoryCapacity;
    return newJsLikeObjectRef;
}

any* getJsLikeFunctionParentLocalScopeVariableValue(any* jsLikeFunctionRef, const char* anyObjectKeyRef) {
    if (!jsLikeFunctionRef || ((*jsLikeFunctionRef).type != ANY_OBJECT)) return NULL;

    for (size_t i = 0; (i < (*jsLikeFunctionRef).value.jsLikeObject.objectKeysLength); i += 1) {
        JsLikeObjectEntry* anyObjectRef = &(*jsLikeFunctionRef).value.jsLikeObject.value[i];
        if (0 == strcmp((*anyObjectRef).key, anyObjectKeyRef)) return (*anyObjectRef).value;
    }

    return NULL;
}

void setJsLikeFunctionParentLocalScopeVariableValue(any* jsLikeFunctionRef, any* jsLikeFunctionParentLocalScopeVariableRef) {
    if (!jsLikeFunctionRef || !jsLikeFunctionParentLocalScopeVariableRef) return;

    size_t jsLikeFunctionParentLocalScopeVariableExistingObjectKeysLength = (*jsLikeFunctionRef).value.jsLikeObject.objectKeysLength;
    size_t jsLikeFunctionParentLocalScopeVariableParentObjectKeysLength = (*jsLikeFunctionParentLocalScopeVariableRef).value.jsLikeObject.objectKeysLength;

    (*jsLikeFunctionRef).value.jsLikeObject.value = realloc((*jsLikeFunctionRef).value.jsLikeObject.value, (sizeof(JsLikeObjectEntry) * (jsLikeFunctionParentLocalScopeVariableExistingObjectKeysLength + jsLikeFunctionParentLocalScopeVariableParentObjectKeysLength)));

    if (!(*jsLikeFunctionRef).value.jsLikeObject.value) {
        perror("realloc");
        exit(EXIT_FAILURE);
    }

    for (size_t i = 0; (i < jsLikeFunctionParentLocalScopeVariableParentObjectKeysLength); i += 1) {
        (*jsLikeFunctionRef).value.jsLikeObject.value[jsLikeFunctionParentLocalScopeVariableExistingObjectKeysLength + i] = (*jsLikeFunctionParentLocalScopeVariableRef).value.jsLikeObject.value[i];
    }

    (*jsLikeFunctionRef).value.jsLikeObject.objectKeysLength += jsLikeFunctionParentLocalScopeVariableParentObjectKeysLength;
}

any* createJsLikeFunction(JsLikeFunctionRef jsLikeFunctionRef, any* jsLikeFunctionParentLocalScopeVariableRef) {
    any* newJsLikeFunctionRef = malloc(sizeof(any));
    (*newJsLikeFunctionRef).type = ANY_OBJECT; /* treat functions as object */

    /* allocate memory for object keys */
    (*newJsLikeFunctionRef).value.jsLikeObject.value = malloc(sizeof(JsLikeObjectEntry));
    (*newJsLikeFunctionRef).value.jsLikeObject.objectKeysLength = 1;
    (*newJsLikeFunctionRef).value.jsLikeObject.memoryCapacity = 1;

    /* store function pointer */
    JsLikeFunction* jsLikeFunctionObjectRef = malloc(sizeof(JsLikeFunction));
    (*jsLikeFunctionObjectRef).value = jsLikeFunctionRef;
    (*newJsLikeFunctionRef).value.jsLikeObject.value[0].key = strdup("[object Function]");
    (*newJsLikeFunctionRef).value.jsLikeObject.value[0].value = (any*)jsLikeFunctionObjectRef;

    /* set parent local scope variable */
    setJsLikeFunctionParentLocalScopeVariableValue(newJsLikeFunctionRef, jsLikeFunctionParentLocalScopeVariableRef);

    return newJsLikeFunctionRef;
}

any* callJsLikeFunction(any* jsLikeFunctionRef, any* firstArgumentRef, ...) {
    if (!jsLikeFunctionRef || ((*jsLikeFunctionRef).type != ANY_OBJECT) || (0 == (*jsLikeFunctionRef).value.jsLikeObject.objectKeysLength)) throwNewError("not function\n");

    JsLikeFunction* jsLikeFunctionObjectRef = (JsLikeFunction*)(*jsLikeFunctionRef).value.jsLikeObject.value[0].value;
    if (!jsLikeFunctionObjectRef || !(*jsLikeFunctionObjectRef).value) throwNewError("function pointer is null\n");

    va_list restArguments;
    va_start(restArguments, firstArgumentRef);

    // create temporary array to store all arguments + self
    size_t restArgumentsCapacity = 8;
    size_t argumentsLength = 0;
    any** argumentsArray = malloc(sizeof(any*) * restArgumentsCapacity);

    for (any* currentArgument = firstArgumentRef; (currentArgument != NULL); currentArgument = va_arg(restArguments, any*)) {
        if (argumentsLength >= restArgumentsCapacity) {
            restArgumentsCapacity *= 2;
            argumentsArray = realloc(argumentsArray, (sizeof(any*) * restArgumentsCapacity));
        }
        argumentsArray[argumentsLength] = currentArgument;
        argumentsLength += 1;
    }

    va_end(restArguments);

    // add jsLikeFunctionRef as last argument (like "this")
    if (argumentsLength >= restArgumentsCapacity) {
        restArgumentsCapacity += 1;
        argumentsArray = realloc(argumentsArray, (sizeof(any*) * restArgumentsCapacity));
    }
    argumentsArray[argumentsLength] = jsLikeFunctionRef;
    argumentsLength += 1;

    // call function with first argument (can be interpret va_list inside function)
    any* jsLikeFunctionCallResult = (*jsLikeFunctionObjectRef).value(argumentsArray[0], (argumentsArray + 1));

    free(argumentsArray);

    return jsLikeFunctionCallResult;
}

void freeMemory(any* anythingRef) {
    if (!anythingRef) return;

    switch ((*anythingRef).type) {
        case ANY_STRING:
            if ((*anythingRef).value.jsLikeString) free((*anythingRef).value.jsLikeString);
            break;

        case ANY_ARRAY:
            if ((*anythingRef).value.jsLikeArray.value) {
                for (size_t i = 0; (i < (*anythingRef).value.jsLikeArray.length); i += 1) {
                    freeMemory((*anythingRef).value.jsLikeArray.value[i]);
                }
                free((*anythingRef).value.jsLikeArray.value);
            }
            break;

        case ANY_OBJECT:
            if ((*anythingRef).value.jsLikeObject.value) {
                for (size_t i = 0; (i < (*anythingRef).value.jsLikeObject.objectKeysLength); i += 1) {
                    JsLikeObjectEntry* anyObjectEntryRef = &(*anythingRef).value.jsLikeObject.value[i];
                    if ((*anyObjectEntryRef).key) free((*anyObjectEntryRef).key);
                    if ((*anyObjectEntryRef).value) freeMemory((*anyObjectEntryRef).value);
                }
                free((*anythingRef).value.jsLikeObject.value);
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

    free(anythingRef);
}

void reassignValue(any** targetRef, any* newValueRef) {
    if (*targetRef != NULL) freeMemory(*targetRef);
    *targetRef = newValueRef;
}

/* end of willyhorizont.github.io/codes template */



/* start of local scope function of main */

any* sayHello(any* firstArgumentRef, ...) {
    va_list restArguments;
    va_start(restArguments, firstArgumentRef);
    
    /*
    for (any* currentArgument = firstArgumentRef; (currentArgument != NULL); currentArgument = va_arg(restArguments, any*)) {
        // do something with currentArgument
    }
    */

    va_end(restArguments);

    any* callbackFunction = firstArgumentRef;
    printf("hello\n");
    callJsLikeFunction(callbackFunction, NULL);
    freeMemory(callbackFunction);

    return createJsLikeNull();
}

any* sayHowAreYou(any* firstArgumentRef, ...) {
    va_list restArguments;
    va_start(restArguments, firstArgumentRef);

    /*
    for (any* currentArgument = firstArgumentRef; (currentArgument != NULL); currentArgument = va_arg(restArguments, any*)) {
        // do something with currentArgument
    }
    */

    va_end(restArguments);

    printf("how are you?\n");

    return createJsLikeNull();
}

any* multiplyBy(any* firstArgumentRef, ...) {
    va_list restArguments;
    va_start(restArguments, firstArgumentRef);

    /*
    for (any* currentArgument = firstArgumentRef; (currentArgument != NULL); currentArgument = va_arg(restArguments, any*)) {
        // do something with currentArgument
    }
    */

    any* bRef = firstArgumentRef;
    any** restArgs = va_arg(restArguments, any**); // args[1..] include self
    any* thisFunction = restArgs[0];

    va_end(restArguments);

    any* aRef = getJsLikeFunctionParentLocalScopeVariableValue(thisFunction, "a");

    if (!aRef || !bRef) return createJsLikeNull();

    if ((ANY_NUMERIC == (*aRef).type) && (ANY_NUMERIC == (*bRef).type)) {
        long double aValue = ((ANY_NUMERIC_INT == (*aRef).value.jsLikeNumeric.type) ? (*aRef).value.jsLikeNumeric.value.jsLikeNumericInt : (*aRef).value.jsLikeNumeric.value.jsLikeNumericFloat);
        long double bValue = ((ANY_NUMERIC_INT == (*bRef).value.jsLikeNumeric.type) ? (*bRef).value.jsLikeNumeric.value.jsLikeNumericInt : (*bRef).value.jsLikeNumeric.value.jsLikeNumericFloat);
        return createJsLikeNumeric(aValue * bValue);
    }

    return createJsLikeNull();
}

any* multiply(any* firstArgumentRef, ...) {
    va_list restArguments;
    va_start(restArguments, firstArgumentRef);

    /*
    for (any* currentArgument = firstArgumentRef; (currentArgument != NULL); currentArgument = va_arg(restArguments, any*)) {
        // do something with currentArgument
    }
    */

    va_end(restArguments);

    any* aRef = firstArgumentRef;

    return createJsLikeFunction(&multiplyBy, createJsLikeObject(createJsLikeObjectEntry("a", aRef), NULL));
}

/* end of local scope function of main */



int main() {
    /*
x. variable can store dynamic data type and dynamic value, variable can inferred data type from value, value of variable can be reassign with different data type or has option to make variable can store dynamic data type and dynamic value
    */
    any* something = NULL;
    reassignValue(&something, createJsLikeString("foo"));
    reassignValue(&something, createJsLikeNumeric(123));
    reassignValue(&something, createJsLikeNumeric(123.789));
    reassignValue(&something, createJsLikeNumeric(-123));
    reassignValue(&something, createJsLikeNumeric(-123.789));
    reassignValue(&something, createJsLikeBoolean(true));
    reassignValue(&something, createJsLikeBoolean(false));
    reassignValue(&something, createJsLikeNull());
    reassignValue(&something, createJsLikeArray(createJsLikeNumeric(1), createJsLikeNumeric(2), createJsLikeNumeric(3), NULL));
    reassignValue(&something, createJsLikeObject(createJsLikeObjectEntry("foo", createJsLikeString("bar")), NULL));

    freeMemory(something);

    /*
x. it is possible to access and modify variables defined outside of the current scope within nested functions, so it is possible to have closure too
    */
   // TODO

    /*
x. object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure can store dynamic data type and dynamic value
    */
    any* myObject = createJsLikeObject(
        createJsLikeObjectEntry("my_string", createJsLikeString("foo")),
        createJsLikeObjectEntry("my_numeric_1", createJsLikeNumeric(123)),
        createJsLikeObjectEntry("my_numeric_2", createJsLikeNumeric(123.789)),
        createJsLikeObjectEntry("my_numeric_3", createJsLikeNumeric(-123)),
        createJsLikeObjectEntry("my_numeric_4", createJsLikeNumeric(-123.789)),
        createJsLikeObjectEntry("my_boolean_1", createJsLikeBoolean(true)),
        createJsLikeObjectEntry("my_boolean_2", createJsLikeBoolean(false)),
        createJsLikeObjectEntry("my_null", createJsLikeNull()),
        createJsLikeObjectEntry("my_array", createJsLikeArray(createJsLikeNumeric(1), createJsLikeNumeric(2), createJsLikeNumeric(3), NULL)),
        createJsLikeObjectEntry("my_object", createJsLikeObject(createJsLikeObjectEntry("foo", createJsLikeString("bar")), NULL)),
    NULL);

    /*
x. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
    */
    any* myArray = createJsLikeArray(
        createJsLikeString("foo"),
        createJsLikeNumeric(123),
        createJsLikeNumeric(123.789),
        createJsLikeNumeric(-123),
        createJsLikeNumeric(-123.789),
        createJsLikeBoolean(true),
        createJsLikeBoolean(false),
        createJsLikeNull(),
        createJsLikeArray(createJsLikeNumeric(1), createJsLikeNumeric(2), createJsLikeNumeric(3), NULL),
        createJsLikeObject(createJsLikeObjectEntry("foo", createJsLikeString("bar")), NULL),
    NULL);

    /*
x. support passing functions as arguments to other functions
    */
    sayHello(createJsLikeFunction(&sayHowAreYou, NULL), NULL);

    /*
x. support returning functions as values from other functions
    */
    any* multiplyBy2 = multiply(createJsLikeNumeric(2));
    any* multiplyBy2ResultRef = callJsLikeFunction(multiplyBy2, createJsLikeNumeric(10), NULL);
    if (ANY_NUMERIC == (*multiplyBy2ResultRef).type) {
        printf("multiplyBy2ResultRef: %.17Lg\n", ((ANY_NUMERIC_INT == (*multiplyBy2ResultRef).value.jsLikeNumeric.type) ? (*multiplyBy2ResultRef).value.jsLikeNumeric.value.jsLikeNumericInt : (*multiplyBy2ResultRef).value.jsLikeNumeric.value.jsLikeNumericFloat));
    }
    freeMemory(multiplyBy2);



    any* myStringRef = createJsLikeString("foo");
    any* myNumberOneRef = createJsLikeNumeric(123);
    any* myNumberTwoRef = createJsLikeNumeric(123.789);
    any* myNumberThreeRef = createJsLikeNumeric(-123);
    any* myNumberFourRef = createJsLikeNumeric(-123.789);
    any* myBooleanOneRef = createJsLikeBoolean(true);
    any* myBooleanTwoRef = createJsLikeBoolean(false);
    any* myNull = createJsLikeNull();

    if (ANY_STRING == (*myStringRef).type) {
        printf("myStringRef: %s\n", (*myStringRef).value.jsLikeString);
    } else {
        printf("myStringRef: not myStringRef\n");
    }

    if ((ANY_NUMERIC == (*myNumberOneRef).type) && (ANY_NUMERIC_INT == (*myNumberOneRef).value.jsLikeNumeric.type)) {
        printf("myNumberOneRef: %lld\n", (*myNumberOneRef).value.jsLikeNumeric.value.jsLikeNumericInt);
    } else {
        printf("myNumberOneRef: not myNumberOneRef\n");
    }

    if ((ANY_NUMERIC == (*myNumberTwoRef).type) && (ANY_NUMERIC_FLOAT == (*myNumberTwoRef).value.jsLikeNumeric.type)) {
        printf("myNumberTwoRef: %.17Lg\n", (*myNumberTwoRef).value.jsLikeNumeric.value.jsLikeNumericFloat);
    } else {
        printf("myNumberTwoRef: not myNumberTwoRef\n");
    }

    if ((ANY_NUMERIC == (*myNumberThreeRef).type) && (ANY_NUMERIC_INT == (*myNumberThreeRef).value.jsLikeNumeric.type)) {
        printf("myNumberThreeRef: %lld\n", (*myNumberThreeRef).value.jsLikeNumeric.value.jsLikeNumericInt);
    } else {
        printf("myNumberThreeRef: not myNumberThreeRef\n");
    }

    if ((ANY_NUMERIC == (*myNumberFourRef).type) && (ANY_NUMERIC_FLOAT == (*myNumberFourRef).value.jsLikeNumeric.type)) {
        printf("myNumberFourRef: %.17Lg\n", (*myNumberFourRef).value.jsLikeNumeric.value.jsLikeNumericFloat);
    } else {
        printf("myNumberFourRef: not myNumberFourRef\n");
    }

    if (ANY_BOOL == (*myBooleanOneRef).type) {
        printf("myBooleanOneRef: %s\n", ((*myBooleanOneRef).value.jsLikeBoolean ? "true" : "false"));
    } else {
        printf("myBooleanOneRef: not myBooleanOneRef\n");
    }

    if (ANY_BOOL == (*myBooleanTwoRef).type) {
        printf("myBooleanTwoRef: %s\n", ((*myBooleanTwoRef).value.jsLikeBoolean ? "true" : "false"));
    } else {
        printf("myBooleanTwoRef: not myBooleanTwoRef\n");
    }

    if (ANY_NULL == (*myNull).type) {
        printf("myNull: null\n");
    } else {
        printf("myNull: not myNull\n");
    }

    freeMemory(myStringRef);
    freeMemory(myNumberOneRef);
    freeMemory(myNumberTwoRef);
    freeMemory(myNumberThreeRef);
    freeMemory(myNumberFourRef);
    freeMemory(myBooleanOneRef);
    freeMemory(myBooleanTwoRef);
    freeMemory(myNull);
    freeMemory(myArray);
    freeMemory(myObject);
return 0;}
