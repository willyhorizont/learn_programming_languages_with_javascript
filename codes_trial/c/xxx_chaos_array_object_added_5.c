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
    size_t capacity;
} JsLikeObject;

typedef struct {
    any** value;
    size_t length;
    size_t capacity;
} JsLikeArray;

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

void throwNewError(const char* errorMessage) {
    fprintf(stderr, errorMessage);
    exit(EXIT_FAILURE);
}

any* createJsLikeNumeric(const char* anyNumericInString) {
    long long parseIntStringResult;
    long double parseFloatStringResult;

    if (sscanf(anyNumericInString, "%lld", &parseIntStringResult) == 1) {
        any* anyNumericInt = malloc(sizeof(any));
        anyNumericInt->type = ANY_NUMERIC;
        anyNumericInt->value.jsLikeNumeric.type = ANY_NUMERIC_INT;
        anyNumericInt->value.jsLikeNumeric.value.jsLikeNumericInt = parseIntStringResult;
        return anyNumericInt;
    }

    if (sscanf(anyNumericInString, "%Lf", &parseFloatStringResult) == 1) {
        any* anyNumericFloat = malloc(sizeof(any));
        anyNumericFloat->type = ANY_NUMERIC;
        anyNumericFloat->value.jsLikeNumeric.type = ANY_NUMERIC_FLOAT;
        anyNumericFloat->value.jsLikeNumeric.value.jsLikeNumericFloat = parseFloatStringResult;
        return anyNumericFloat;
    }

    throwNewError("Error: numericify string expected\n");
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
    va_list functionArguments;
    va_start(functionArguments, firstArgument);

    size_t capacity = 4;
    size_t newJsLikeArrayLength = 0;
    any** newJsLikeArrayValue = malloc(sizeof(any*) * capacity);

    for (any* current = firstArgument; (current != NULL); current = va_arg(functionArguments, any*)) {
        if (newJsLikeArrayLength >= capacity) {
            capacity *= 2;
            newJsLikeArrayValue = realloc(newJsLikeArrayValue, sizeof(any*) * capacity);
            if (!newJsLikeArrayValue) {
                perror("realloc");
                exit(EXIT_FAILURE);
            }
        }
        newJsLikeArrayValue[newJsLikeArrayLength] = current;
        newJsLikeArrayLength += 1;
    }

    va_end(functionArguments);

    any* newJsLikeArray = malloc(sizeof(any));
    newJsLikeArray->type = ANY_ARRAY;
    newJsLikeArray->value.jsLikeArray.value = newJsLikeArrayValue;
    newJsLikeArray->value.jsLikeArray.length = newJsLikeArrayLength;
    newJsLikeArray->value.jsLikeArray.capacity = capacity;
    return newJsLikeArray;
}

any* createJsLikeObject(const char* firstKey, ...) {
    va_list functionArguments;
    va_start(functionArguments, firstKey);

    size_t capacity = 4;
    size_t newJsLikeObjectKeysLength = 0;
    JsLikeObjectEntry* newJsLikeObjectValue = malloc(sizeof(JsLikeObjectEntry) * capacity);

    for (const char* currentKey = firstKey; (currentKey != NULL); currentKey = va_arg(functionArguments, const char*)) {
        any* currentValue = va_arg(functionArguments, any*);

        if (newJsLikeObjectKeysLength >= capacity) {
            capacity *= 2;
            newJsLikeObjectValue = realloc(newJsLikeObjectValue, sizeof(JsLikeObjectEntry) * capacity);
            if (!newJsLikeObjectValue) {
                perror("realloc");
                exit(EXIT_FAILURE);
            }
        }

        newJsLikeObjectValue[newJsLikeObjectKeysLength] = createJsLikeObjectEntry(currentKey, currentValue);
        newJsLikeObjectKeysLength += 1;
    }

    va_end(functionArguments);

    any* newJsLikeObject = malloc(sizeof(any));
    newJsLikeObject->type = ANY_OBJECT;
    newJsLikeObject->value.jsLikeObject.value = newJsLikeObjectValue;
    newJsLikeObject->value.jsLikeObject.objectKeysLength = newJsLikeObjectKeysLength;
    newJsLikeObject->value.jsLikeObject.capacity = capacity;
    return newJsLikeObject;
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
                    JsLikeObjectEntry *anyObjectEntries = &anything->value.jsLikeObject.value[i];
                    if (anyObjectEntries->key) free(anyObjectEntries->key);
                    if (anyObjectEntries->value) freeMemory(anyObjectEntries->value);
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
    if (*target != NULL) {
        freeMemory(*target);
    }
    *target = newValue;
}

/* end of willyhorizont.github.io/codes template */



int main() {
    any* anyString = createJsLikeString("foo");
    any* anyNumericInt = createJsLikeNumeric("123");
    any* anyNumericFloat = createJsLikeNumeric("123.789");
    any* anyBoolean = createJsLikeBoolean(true);
    any* anyNull = createJsLikeNull();
    any* anyArray = createJsLikeArray(
        createJsLikeString("foo"),
        createJsLikeNumeric("123"),
        createJsLikeNumeric("123.789"),
        createJsLikeBoolean(true),
        createJsLikeNull(),
    NULL);
    any* anyObject = createJsLikeObject(
        "myString", createJsLikeString("foo"),
        "myNumericInt", createJsLikeNumeric("123"),
        "myNumericFloat", createJsLikeNumeric("123.789"),
        "myBoolean", createJsLikeBoolean(true),
        "myNull", createJsLikeNull(),
    NULL);

    if (anyString->type == ANY_STRING)
        printf("anyString: %s\n", anyString->value.jsLikeString);

    if (anyNumericInt->type == ANY_NUMERIC && anyNumericInt->value.jsLikeNumeric.type == ANY_NUMERIC_INT)
        printf("anyNumericInt: %lld\n", anyNumericInt->value.jsLikeNumeric.value.jsLikeNumericInt);

    if (anyNumericFloat->type == ANY_NUMERIC && anyNumericFloat->value.jsLikeNumeric.type == ANY_NUMERIC_FLOAT)
        printf("anyNumericFloat: %Lf\n", anyNumericFloat->value.jsLikeNumeric.value.jsLikeNumericFloat);

    if (anyBoolean->type == ANY_BOOL)
        printf("anyBoolean: %s\n", (anyBoolean->value.jsLikeBoolean ? "true" : "false"));

    if (anyNull->type == ANY_NULL)
        printf("anyNull: null\n");

    freeMemory(anyNumericInt);
    freeMemory(anyNumericFloat);
    freeMemory(anyString);
    freeMemory(anyBoolean);
    freeMemory(anyNull);
    freeMemory(anyArray);
    freeMemory(anyObject);

    any* anything = NULL;
    reassignValue(&anything, createJsLikeString("foo"));
    reassignValue(&anything, createJsLikeNumeric("123"));
    reassignValue(&anything, createJsLikeNumeric("123.789"));
    reassignValue(&anything, createJsLikeBoolean(true));
    reassignValue(&anything, createJsLikeNull());
    reassignValue(&anything, createJsLikeArray(
        createJsLikeString("foo"),
        createJsLikeNumeric("123"),
        createJsLikeNumeric("123.789"),
        createJsLikeBoolean(true),
        createJsLikeNull(),
        NULL
    ));
    reassignValue(&anything, createJsLikeObject(
        "myString", createJsLikeString("foo"),
        "myNumericInt", createJsLikeNumeric("123"),
        "myNumericFloat", createJsLikeNumeric("123.789"),
        "myBoolean", createJsLikeBoolean(true),
        "myNull", createJsLikeNull(),
        NULL
    ));

    freeMemory(anything);
return 0;}
