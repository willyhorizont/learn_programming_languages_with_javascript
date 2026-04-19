#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

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
} JsLikeObject;

typedef struct {
    any** value;
    size_t length;
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

/*
createJsLikeArray: copies pointers into a newly allocated array on heap.
Ownership semantic: constructor takes the passed elements (assumes they were freshly created) and this any will own/free them via freeAny().
*/
any* createJsLikeArray(any** anyArray) {
    size_t newLength = 0;
    while (anyArray[newLength] != NULL) {
        newLength += 1;
    }

    any** anyArrayCopy = malloc(newLength * sizeof(any*));
    if (!anyArrayCopy && newLength) {
        perror("malloc");
        exit(EXIT_FAILURE);
    }
    for (size_t i = 0; (i < newLength); i += 1) {
        anyArrayCopy[i] = anyArray[i];
    }

    any* newJsLikeArray = malloc(sizeof(any));
    newJsLikeArray->type = ANY_ARRAY;
    newJsLikeArray->value.jsLikeArray.value = anyArrayCopy;
    newJsLikeArray->value.jsLikeArray.length = newLength;
    return newJsLikeArray;
}

/*
Helper to make an entry (duplicating key). The returned JsLikeObjectEntry has key strdup'd; caller can pass an array of entries and then call createJsLikeObject.
*/
JsLikeObjectEntry createJsLikeObjectEntry(const char* newObjectKey, any* newObjectValue) {
    JsLikeObjectEntry newJsLikeObjectEntry;
    newJsLikeObjectEntry.key = strdup(newObjectKey);
    newJsLikeObjectEntry.value = newObjectValue;
    return newJsLikeObjectEntry;
}

/* createJsLikeObject: copies JsLikeObjectEntry array into heap storage.
The entries passed must use strdup'd keys (as produced by createJsLikeObjectEntry).
This object takes ownership of entries and of entry->value.
*/
any* createJsLikeObject(JsLikeObjectEntry* anyObjectEntries) {
    size_t newLength = 0;
    while (anyObjectEntries[newLength].key != NULL) {
        newLength += 1;
    }

    JsLikeObjectEntry* anyObjectEntriesCopy = malloc(newLength * sizeof(JsLikeObjectEntry));
    if (!anyObjectEntriesCopy && newLength) {
        perror("malloc");
        exit(EXIT_FAILURE);
    }

    for (size_t i = 0; (i < newLength); i += 1) {
        anyObjectEntriesCopy[i] = anyObjectEntries[i]; // shallow copy; key already strdup'd
    }

    any* newJsLikeObject = malloc(sizeof(any));
    newJsLikeObject->type = ANY_OBJECT;
    newJsLikeObject->value.jsLikeObject.value = anyObjectEntriesCopy;
    newJsLikeObject->value.jsLikeObject.keysLength = newLength;
    return newJsLikeObject;
}

/*
Frees an any and all owned sub-objects/strings. Assumes no sharing.
If you plan to share pointers between containers, you must add refcounting or ensure only one owner calls freeAny.
*/
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
            /* nothing special to free */
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
    any* anyArray = createJsLikeArray((any*[]){
        createJsLikeString("foo"),
        createJsLikeNumeric("123"),
        createJsLikeNumeric("123.789"),
        createJsLikeBoolean(true),
        createJsLikeNull(),
        NULL
    });
    any* anyObject = createJsLikeObject((JsLikeObjectEntry[]){
        createJsLikeObjectEntry("my_string", createJsLikeString("foo")),
        createJsLikeObjectEntry("my_numeric_int", createJsLikeNumeric("123")),
        createJsLikeObjectEntry("my_numeric_float", createJsLikeNumeric("123.789")),
        createJsLikeObjectEntry("my_boolean", createJsLikeBoolean(true)),
        createJsLikeObjectEntry("my_null", createJsLikeNull()),
        { NULL, NULL }
    });

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

    /* cleanup: free everything created */
    freeAny(anyArray);
    freeAny(anyObject);
    freeAny(anyWholeNumber);
    freeAny(anyFractionalNumber);
    freeAny(anyString);
    freeAny(anyBoolean);
    freeAny(anyNull);

    return 0;
}
