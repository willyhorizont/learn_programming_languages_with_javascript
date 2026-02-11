/* start of willyhorizont.github.io/codes needed standard library */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <stdarg.h>

/* end of willyhorizont.github.io/codes needed standard library */



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

typedef any* (*JsLikeFunctionPointer)(any* firstArgument, ...);

typedef struct {
    JsLikeFunctionPointer value;
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

    char* endOfStringPointer;
    char* stringBufferForJsLikeNumericInt;
    bool isAllStringZero = true;

    const char *dotStringIndex = strchr(stringBuffer, '.');
    if (dotStringIndex != NULL) {
        const char *afterDotStringIndex = (dotStringIndex + 1);
        for (const char *restOfStringIndex = afterDotStringIndex; (*restOfStringIndex != '\0'); restOfStringIndex += 1) {
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

    long long parseIntStringResult = strtoll(stringBuffer, &endOfStringPointer, 10);
    if (*endOfStringPointer == '\0') {
        any* anyNumericInt = malloc(sizeof(any));
        anyNumericInt->type = ANY_NUMERIC;
        anyNumericInt->value.jsLikeNumeric.type = ANY_NUMERIC_INT;
        anyNumericInt->value.jsLikeNumeric.value.jsLikeNumericInt = parseIntStringResult;
        return anyNumericInt;
    }

    long double parseFloatStringResult = strtold(stringBuffer, &endOfStringPointer);
    if (*endOfStringPointer == '\0') {
        any* anyNumericFloat = malloc(sizeof(any));
        anyNumericFloat->type = ANY_NUMERIC;
        anyNumericFloat->value.jsLikeNumeric.type = ANY_NUMERIC_FLOAT;
        anyNumericFloat->value.jsLikeNumeric.value.jsLikeNumericFloat = parseFloatStringResult;
        return anyNumericFloat;
    }

    throwNewError("Error: not a number\n");
    return NULL;
}

any* createJsLikeString(const char* anything) {
    any* newJsLikeString = malloc(sizeof(any));
    newJsLikeString->type = ANY_STRING;
    newJsLikeString->value.jsLikeString = strdup(anything);
    return newJsLikeString;
}

any* createJsLikeNull() {
    any* newJsLikeNull = malloc(sizeof(any));
    newJsLikeNull->type = ANY_NULL;
    return newJsLikeNull;
}

any* createJsLikeBoolean(bool anything) {
    any* newJsLikeBoolean = malloc(sizeof(any));
    newJsLikeBoolean->type = ANY_BOOL;
    newJsLikeBoolean->value.jsLikeBoolean = anything;
    return newJsLikeBoolean;
}

JsLikeObjectEntry createJsLikeObjectEntry(const char* newObjectKey, any* newObjectValue) {
    JsLikeObjectEntry newJsLikeObjectEntry;
    newJsLikeObjectEntry.key = strdup(newObjectKey);
    newJsLikeObjectEntry.value = newObjectValue;
    return newJsLikeObjectEntry;
}

any* createJsLikeArray(any* firstArgument, ...) {
    va_list restArguments;
    va_start(restArguments, firstArgument);

    size_t memoryCapacity = 4;
    size_t newJsLikeArrayLength = 0;
    any** newJsLikeArrayValue = malloc(sizeof(any*) * memoryCapacity);

    for (any* currentArgument = firstArgument; (currentArgument != NULL); currentArgument = va_arg(restArguments, any*)) {
        if (newJsLikeArrayLength >= memoryCapacity) {
            memoryCapacity *= 2;
            newJsLikeArrayValue = realloc(newJsLikeArrayValue, sizeof(any*) * memoryCapacity);
            if (!newJsLikeArrayValue) {
                perror("realloc");
                exit(EXIT_FAILURE);
            }
        }
        newJsLikeArrayValue[newJsLikeArrayLength] = currentArgument;
        newJsLikeArrayLength += 1;
    }

    va_end(restArguments);

    any* newJsLikeArray = malloc(sizeof(any));
    newJsLikeArray->type = ANY_ARRAY;
    newJsLikeArray->value.jsLikeArray.value = newJsLikeArrayValue;
    newJsLikeArray->value.jsLikeArray.length = newJsLikeArrayLength;
    newJsLikeArray->value.jsLikeArray.memoryCapacity = memoryCapacity;
    return newJsLikeArray;
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

    any* newJsLikeObject = malloc(sizeof(any));
    newJsLikeObject->type = ANY_OBJECT;
    newJsLikeObject->value.jsLikeObject.value = newJsLikeObjectValue;
    newJsLikeObject->value.jsLikeObject.objectKeysLength = newJsLikeObjectKeysLength;
    newJsLikeObject->value.jsLikeObject.memoryCapacity = memoryCapacity;
    return newJsLikeObject;
}

any* createJsLikeFunction(JsLikeFunctionPointer jsLikeFunction, any* jsLikeFunctionParentVariable) {
    any* newJsLikeFunction = malloc(sizeof(any));
    newJsLikeFunction->type = ANY_OBJECT; /* treat functions as objects */
    
    /* alocate memory for object keys */
    newJsLikeFunction->value.jsLikeObject.value = malloc(sizeof(JsLikeObjectEntry));
    newJsLikeFunction->value.jsLikeObject.objectKeysLength = 1;
    newJsLikeFunction->value.jsLikeObject.memoryCapacity = 1;

    /* store function pointer */
    JsLikeFunction* jsLikeFunctionContainer = malloc(sizeof(JsLikeFunction));
    jsLikeFunctionContainer->value = jsLikeFunction;
    newJsLikeFunction->value.jsLikeObject.value[0].key = strdup("[object Function]");
    newJsLikeFunction->value.jsLikeObject.value[0].value = (any*)jsLikeFunctionContainer;

    /* store parent variables if exist */
    if (jsLikeFunctionParentVariable) {
        size_t existingKeys = newJsLikeFunction->value.jsLikeObject.objectKeysLength;
        size_t parentKeys = jsLikeFunctionParentVariable->value.jsLikeObject.objectKeysLength;
        newJsLikeFunction->value.jsLikeObject.value = realloc(newJsLikeFunction->value.jsLikeObject.value, (sizeof(JsLikeObjectEntry) * (existingKeys + parentKeys)));

        for (size_t i = 0; i < parentKeys; i++) {
            newJsLikeFunction->value.jsLikeObject.value[existingKeys + i] = jsLikeFunctionParentVariable->value.jsLikeObject.value[i];
        }
        newJsLikeFunction->value.jsLikeObject.objectKeysLength += parentKeys;
    }

    return newJsLikeFunction;
}

any* callJsLikeFunction(any* jsLikeFunction, any* firstArgument, ...) {
    if (!jsLikeFunction || (jsLikeFunction->type != ANY_OBJECT) || (jsLikeFunction->value.jsLikeObject.objectKeysLength == 0)) throwNewError("not a function\n");

    JsLikeFunction* jsLikeFunctionContainer = (JsLikeFunction*)jsLikeFunction->value.jsLikeObject.value[0].value;
    if (!jsLikeFunctionContainer || !jsLikeFunctionContainer->value) throwNewError("function pointer is null\n");

    va_list restArguments;
    va_start(restArguments, firstArgument);
    any* jsLikeFunctionCallResult = jsLikeFunctionContainer->value(firstArgument, restArguments); /* pass va_list as second arg if needed */
    va_end(restArguments);

    return jsLikeFunctionCallResult;
}

void freeMemory(any* anything) {
    if (!anything) return;

    switch (anything->type) {
        case ANY_STRING:
            if (anything->value.jsLikeString) free(anything->value.jsLikeString);
            break;

        case ANY_ARRAY:
            if (anything->value.jsLikeArray.value) {
                for (size_t i = 0; (i < anything->value.jsLikeArray.length); i += 1) {
                    freeMemory(anything->value.jsLikeArray.value[i]);
                }
                free(anything->value.jsLikeArray.value);
            }
            break;

        case ANY_OBJECT:
            if (anything->value.jsLikeObject.value) {
                for (size_t i = 0; (i < anything->value.jsLikeObject.objectKeysLength); i += 1) {
                    JsLikeObjectEntry *anyObjectEntry = &anything->value.jsLikeObject.value[i];
                    if (anyObjectEntry->key) free(anyObjectEntry->key);
                    if (anyObjectEntry->value) freeMemory(anyObjectEntry->value);
                }
                free(anything->value.jsLikeObject.value);
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

/* end of willyhorizont.github.io/codes template */



/* start of willyhorizont.github.io/codes main local function */

any* sayHello(any* firstArgument, ...) {
    va_list restArguments;
    va_start(restArguments, firstArgument);
    
    /*
    for (any* currentArgument = firstArgument; (currentArgument != NULL); currentArgument = va_arg(restArguments, any*)) {
        currentArgument = va_arg(restArguments, any*);
    }
    */

    any* callbackFunction = firstArgument;
    printf("hello\n");
    callJsLikeFunction(callbackFunction, NULL);
    freeMemory(callbackFunction);

    va_end(restArguments);
}

any* sayHowAreYou(any* firstArgument, ...) {
    va_list restArguments;
    va_start(restArguments, firstArgument);

    /*
    for (any* currentArgument = firstArgument; (currentArgument != NULL); currentArgument = va_arg(restArguments, any*)) {
        currentArgument = va_arg(restArguments, any*);
    }
    */

    printf("how are you?\n");

    va_end(restArguments);
}

any* multiplyBy(any* firstArgument, ...) {
    va_list restArguments;
    va_start(restArguments, firstArgument);

    /*
    for (any* currentArgument = firstArgument; (currentArgument != NULL); currentArgument = va_arg(restArguments, any*)) {
        currentArgument = va_arg(restArguments, any*);
    }
    */

    any* b = firstArgument;

    any* thisFunction = va_arg(restArguments, any*);

    any* a = NULL;
    for (size_t i = 0; (i < thisFunction->value.jsLikeObject.objectKeysLength); i += 1) {
        JsLikeObjectEntry* anyObject = &thisFunction->value.jsLikeObject.value[i];
        if (strcmp(anyObject->key, "a") == 0) {
            a = anyObject->value;
            break;
        }
    }

    va_end(restArguments);

    if (!a || !b) return createJsLikeNull();

    if (a->type == ANY_NUMERIC && b->type == ANY_NUMERIC) {
        long double aValue = ((a->value.jsLikeNumeric.type == ANY_NUMERIC_INT) ? a->value.jsLikeNumeric.value.jsLikeNumericInt : a->value.jsLikeNumeric.value.jsLikeNumericFloat);
        long double bValue = ((b->value.jsLikeNumeric.type == ANY_NUMERIC_INT) ? b->value.jsLikeNumeric.value.jsLikeNumericInt : b->value.jsLikeNumeric.value.jsLikeNumericFloat);
        return createJsLikeNumeric(aValue * bValue);
    }

    return createJsLikeNull();
}

any* multiply(any* firstArgument, ...) {
    va_list restArguments;
    va_start(restArguments, firstArgument);

    /*
    for (any* currentArgument = firstArgument; (currentArgument != NULL); currentArgument = va_arg(restArguments, any*)) {
        currentArgument = va_arg(restArguments, any*);
    }
    */

    any* a = firstArgument;

    va_end(restArguments);

    return createJsLikeFunction(&multiplyBy, createJsLikeObject(createJsLikeObjectEntry("a", a), NULL));
}

any* functionVariadicBase(any* firstArgument, ...) {
    va_list restArguments;
    va_start(restArguments, firstArgument);

    for (any* currentArgument = firstArgument; (currentArgument != NULL); currentArgument = va_arg(restArguments, any*)) {
        currentArgument = va_arg(restArguments, any*);
    }

    va_end(restArguments);
}

/* end of willyhorizont.github.io/codes main local function */



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
    any* multiplyBy2Result = callJsLikeFunction(multiplyBy2, createJsLikeNumeric(10), NULL);

    if (multiplyBy2Result->type == ANY_NUMERIC && multiplyBy2Result->value.jsLikeNumeric.type == ANY_NUMERIC_INT) {
        printf("multiplyBy2Result: %lld\n", multiplyBy2Result->value.jsLikeNumeric.value.jsLikeNumericInt);
    } else {
        printf("multiplyBy2Result: not multiplyBy2Result\n");
    }
    freeMemory(multiplyBy2);



    any* myString = createJsLikeString("foo");
    any* myNumber1 = createJsLikeNumeric(123);
    any* myNumber2 = createJsLikeNumeric(123.789);
    any* myNumber3 = createJsLikeNumeric(-123);
    any* myNumber4 = createJsLikeNumeric(-123.789);
    any* myBoolean1 = createJsLikeBoolean(true);
    any* myBoolean2 = createJsLikeBoolean(false);
    any* myNull = createJsLikeNull();

    if (myString->type == ANY_STRING) {
        printf("myString: %s\n", myString->value.jsLikeString);
    } else {
        printf("myString: not myString\n");
    }

    if (myNumber1->type == ANY_NUMERIC && myNumber1->value.jsLikeNumeric.type == ANY_NUMERIC_INT) {
        printf("myNumber1: %lld\n", myNumber1->value.jsLikeNumeric.value.jsLikeNumericInt);
    } else {
        printf("myNumber1: not myNumber1\n");
    }

    if (myNumber2->type == ANY_NUMERIC && myNumber2->value.jsLikeNumeric.type == ANY_NUMERIC_FLOAT) {
        printf("myNumber2: %.17Lg\n", myNumber2->value.jsLikeNumeric.value.jsLikeNumericFloat);
    } else {
        printf("myNumber2: not myNumber2\n");
    }

    if (myNumber3->type == ANY_NUMERIC && myNumber3->value.jsLikeNumeric.type == ANY_NUMERIC_INT) {
        printf("myNumber3: %lld\n", myNumber3->value.jsLikeNumeric.value.jsLikeNumericInt);
    } else {
        printf("myNumber3: not myNumber3\n");
    }

    if (myNumber4->type == ANY_NUMERIC && myNumber4->value.jsLikeNumeric.type == ANY_NUMERIC_FLOAT) {
        printf("myNumber4: %.17Lg\n", myNumber4->value.jsLikeNumeric.value.jsLikeNumericFloat);
    } else {
        printf("myNumber4: not myNumber4\n");
    }

    if (myBoolean1->type == ANY_BOOL) {
        printf("myBoolean1: %s\n", (myBoolean1->value.jsLikeBoolean ? "true" : "false"));
    } else {
        printf("myBoolean1: not myBoolean1\n");
    }

    if (myBoolean2->type == ANY_BOOL) {
        printf("myBoolean2: %s\n", (myBoolean2->value.jsLikeBoolean ? "true" : "false"));
    } else {
        printf("myBoolean2: not myBoolean2\n");
    }

    if (myNull->type == ANY_NULL) {
        printf("myNull: null\n");
    } else {
        printf("myNull: not myNull\n");
    }

    freeMemory(myString);
    freeMemory(myNumber1);
    freeMemory(myNumber2);
    freeMemory(myNumber3);
    freeMemory(myNumber4);
    freeMemory(myBoolean1);
    freeMemory(myBoolean2);
    freeMemory(myNull);
    freeMemory(myArray);
    freeMemory(myObject);
return 0;}
