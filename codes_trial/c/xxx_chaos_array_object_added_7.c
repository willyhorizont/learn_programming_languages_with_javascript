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

any* createJsLikeNumeric(long double anyNumericInFloat) {
    char stringBuffer[128];
    snprintf(stringBuffer, sizeof(stringBuffer), "%Lf", anyNumericInFloat);

    char* endPointer;

    long long parseIntStringResult = strtoll(stringBuffer, &endPointer, 10);
    if (*endPointer == '\0') {
        any* anyNumericInt = malloc(sizeof(any));
        anyNumericInt->type = ANY_NUMERIC;
        anyNumericInt->value.jsLikeNumeric.type = ANY_NUMERIC_INT;
        anyNumericInt->value.jsLikeNumeric.value.jsLikeNumericInt = parseIntStringResult;
        return anyNumericInt;
    }

    long double parseFloatStringResult = strtold(stringBuffer, &endPointer);
    if (*endPointer == '\0') {
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

any* createJsLikeArray(any* firstArrayItem, ...) {
    va_list restArguments;
    va_start(restArguments, firstArrayItem);

    size_t memoryCapacity = 4;
    size_t newJsLikeArrayLength = 0;
    any** newJsLikeArrayValue = malloc(sizeof(any*) * memoryCapacity);

    for (any* currentArrayItem = firstArrayItem; (currentArrayItem != NULL); currentArrayItem = va_arg(restArguments, any*)) {
        if (newJsLikeArrayLength >= memoryCapacity) {
            memoryCapacity *= 2;
            newJsLikeArrayValue = realloc(newJsLikeArrayValue, sizeof(any*) * memoryCapacity);
            if (!newJsLikeArrayValue) {
                perror("realloc");
                exit(EXIT_FAILURE);
            }
        }
        newJsLikeArrayValue[newJsLikeArrayLength] = currentArrayItem;
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
    any* anyNumericInt = createJsLikeNumeric(123);
    any* anyNumericFloat = createJsLikeNumeric(123.789);
    any* anyBoolean = createJsLikeBoolean(true);
    any* anyNull = createJsLikeNull();
    any* anyArray = createJsLikeArray(
        createJsLikeString("foo"),
        createJsLikeNumeric(123),
        createJsLikeNumeric(123.789),
        createJsLikeBoolean(true),
        createJsLikeNull(),
    NULL);
    any* anyObject = createJsLikeObject(
        createJsLikeObjectEntry("myString", createJsLikeString("foo")),
        createJsLikeObjectEntry("myNumericInt", createJsLikeNumeric(123)),
        createJsLikeObjectEntry("myNumericFloat", createJsLikeNumeric(123.789)),
        createJsLikeObjectEntry("myBoolean", createJsLikeBoolean(true)),
        createJsLikeObjectEntry("myNull", createJsLikeNull()),
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
    reassignValue(&anything, createJsLikeNumeric(123));
    reassignValue(&anything, createJsLikeNumeric(123.789));
    reassignValue(&anything, createJsLikeBoolean(true));
    reassignValue(&anything, createJsLikeNull());
    reassignValue(&anything, createJsLikeArray(
        createJsLikeString("foo"),
        createJsLikeNumeric(123),
        createJsLikeNumeric(123.789),
        createJsLikeBoolean(true),
        createJsLikeNull(),
    NULL));
    reassignValue(&anything, createJsLikeObject(
        createJsLikeObjectEntry("myString", createJsLikeString("foo")),
        createJsLikeObjectEntry("myNumericInt", createJsLikeNumeric(123)),
        createJsLikeObjectEntry("myNumericFloat", createJsLikeNumeric(123.789)),
        createJsLikeObjectEntry("myBoolean", createJsLikeBoolean(true)),
        createJsLikeObjectEntry("myNull", createJsLikeNull()),
    NULL));

    freeMemory(anything);
return 0;}
