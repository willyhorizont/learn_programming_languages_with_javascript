#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <stdarg.h>

typedef enum { ANY_NUMERIC, ANY_STRING, ANY_NULL, ANY_BOOL, ANY_ARRAY, ANY_OBJECT } AnyType;

typedef enum {
    NUM_LONG_LONG,
    NUM_LONG_DOUBLE
} NumericType;

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
    size_t keysLength;
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

any* createJsLikeNumeric(const char* anyNumericInString) {
    long long parseIntStringResult;
    long double parseFloatStringResult;

    if (sscanf(anyNumericInString, "%lld", &parseIntStringResult) == 1) {
        any* wholeNumber = malloc(sizeof(any));
        wholeNumber->type = ANY_NUMERIC;
        wholeNumber->value.jsLikeNumeric.type = NUM_LONG_LONG;
        wholeNumber->value.jsLikeNumeric.value.jsLikeNumericInt = parseIntStringResult;
        return wholeNumber;
    }

    if (sscanf(anyNumericInString, "%Lf", &parseFloatStringResult) == 1) {
        any* fractionalNumber = malloc(sizeof(any));
        fractionalNumber->type = ANY_NUMERIC;
        fractionalNumber->value.jsLikeNumeric.type = NUM_LONG_DOUBLE;
        fractionalNumber->value.jsLikeNumeric.value.jsLikeNumericFloat = parseFloatStringResult;
        return fractionalNumber;
    }

    fprintf(stderr, "Error: numericify string expected\n");
    exit(EXIT_FAILURE);
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
    size_t length = 0;
    any** values = malloc(sizeof(any*) * capacity);

    for (any* current = firstArgument; (current != NULL); current = va_arg(functionArguments, any*)) {
        if (length >= capacity) {
            capacity *= 2;
            values = realloc(values, sizeof(any*) * capacity);
            if (!values) {
                perror("realloc");
                exit(EXIT_FAILURE);
            }
        }
        values[length] = current;
        length += 1;
    }

    va_end(functionArguments);

    any* newJsLikeArray = malloc(sizeof(any));
    newJsLikeArray->type = ANY_ARRAY;
    newJsLikeArray->value.jsLikeArray.value = values;
    newJsLikeArray->value.jsLikeArray.length = length;
    newJsLikeArray->value.jsLikeArray.capacity = capacity;
    return newJsLikeArray;
}

any* createJsLikeObject(const char* firstKey, ...) {
    va_list functionArguments;
    va_start(functionArguments, firstKey);

    size_t capacity = 4;
    size_t length = 0;
    JsLikeObjectEntry* entries = malloc(sizeof(JsLikeObjectEntry) * capacity);

    for (const char* currentKey = firstKey; (currentKey != NULL); currentKey = va_arg(functionArguments, const char*)) {
        any* currentValue = va_arg(functionArguments, any*);

        if (length >= capacity) {
            capacity *= 2;
            entries = realloc(entries, sizeof(JsLikeObjectEntry) * capacity);
            if (!entries) {
                perror("realloc");
                exit(EXIT_FAILURE);
            }
        }

        entries[length] = createJsLikeObjectEntry(currentKey, currentValue);
        length += 1;
    }

    va_end(functionArguments);

    any* newJsLikeObject = malloc(sizeof(any));
    newJsLikeObject->type = ANY_OBJECT;
    newJsLikeObject->value.jsLikeObject.value = entries;
    newJsLikeObject->value.jsLikeObject.keysLength = length;
    newJsLikeObject->value.jsLikeObject.capacity = capacity;
    return newJsLikeObject;
}

void freeAny(any* anything) {
    if (!anything) return;

    switch (anything->type) {
        case ANY_STRING:
            if (anything->value.jsLikeString) free(anything->value.jsLikeString);
            break;

        case ANY_ARRAY:
            if (anything->value.jsLikeArray.value) {
                for (size_t i = 0; (i < anything->value.jsLikeArray.length); i += 1) {
                    freeAny(anything->value.jsLikeArray.value[i]);
                }
                free(anything->value.jsLikeArray.value);
            }
            break;

        case ANY_OBJECT:
            if (anything->value.jsLikeObject.value) {
                for (size_t i = 0; (i < anything->value.jsLikeObject.keysLength); i += 1) {
                    JsLikeObjectEntry *anyObjectEntries = &anything->value.jsLikeObject.value[i];
                    if (anyObjectEntries->key) free(anyObjectEntries->key);
                    if (anyObjectEntries->value) freeAny(anyObjectEntries->value);
                }
                free(anything->value.jsLikeObject.value);
            }
            break;

        case ANY_NUMERIC:
        case ANY_BOOL:
        case ANY_NULL:
        default:
            break;
    }

    free(anything);
}

int main() {
    any* anyString = createJsLikeString("foo");
    any* anyWholeNumber = createJsLikeNumeric("123");
    any* anyFractionalNumber = createJsLikeNumeric("123.789");
    any* anyBoolean = createJsLikeBoolean(true);
    any* anyNull = createJsLikeNull();
    any* anyArray = createJsLikeArray(
        createJsLikeString("foo"),
        createJsLikeNumeric("123"),
        createJsLikeNumeric("123.789"),
        createJsLikeBoolean(true),
        createJsLikeNull(),
        NULL
    );
    any* anyObject = createJsLikeObject(
        "my_string", createJsLikeString("foo"),
        "my_numeric", createJsLikeNumeric("123"),
        "my_fractional", createJsLikeNumeric("123.789"),
        "my_boolean", createJsLikeBoolean(true),
        "my_null", createJsLikeNull(),
        NULL
    );

    if (anyString->type == ANY_STRING)
        printf("anyString: %s\n", anyString->value.jsLikeString);

    if (anyWholeNumber->type == ANY_NUMERIC && anyWholeNumber->value.jsLikeNumeric.type == NUM_LONG_LONG)
        printf("anyWholeNumber: %lld\n", anyWholeNumber->value.jsLikeNumeric.value.jsLikeNumericInt);

    if (anyFractionalNumber->type == ANY_NUMERIC && anyFractionalNumber->value.jsLikeNumeric.type == NUM_LONG_DOUBLE)
        printf("anyFractionalNumber: %Lf\n", anyFractionalNumber->value.jsLikeNumeric.value.jsLikeNumericFloat);

    if (anyBoolean->type == ANY_BOOL)
        printf("anyBoolean: %s\n", (anyBoolean->value.jsLikeBoolean ? "true" : "false"));

    if (anyNull->type == ANY_NULL)
        printf("anyNull: null\n");

    freeAny(anyWholeNumber);
    freeAny(anyFractionalNumber);
    freeAny(anyString);
    freeAny(anyBoolean);
    freeAny(anyNull);
    freeAny(anyArray);
    freeAny(anyObject);

    return 0;
}
