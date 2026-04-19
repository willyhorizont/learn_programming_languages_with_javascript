#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

typedef enum { ANY_NUMERIC, ANY_STRING, ANY_NULL, ANY_BOOL } AnyType;

typedef enum {
    NUM_LONG_LONG,
    NUM_LONG_DOUBLE
} NumericType;

typedef struct any any;

struct any {
    AnyType type;
    union {
        bool jsLikeBoolean;
        char* jsLikeString;
        struct {
            NumericType numericType;
            union {
                long long wholeNumberValue;
                long double fractionalNumberValue;
            } value;
        } jsLikeNumeric;
    } value;
};

any* createJsLikeNumeric(const char* anyNumericInString) {
    long long parsedWhole;
    long double parsedFraction;

    if (sscanf(anyNumericInString, "%lld", &parsedWhole) == 1) {
        any* wholeNumber = malloc(sizeof(any));
        wholeNumber->type = ANY_NUMERIC;
        wholeNumber->value.jsLikeNumeric.numericType = NUM_LONG_LONG;
        wholeNumber->value.jsLikeNumeric.value.wholeNumberValue = parsedWhole;
        return wholeNumber;
    }

    if (sscanf(anyNumericInString, "%Lf", &parsedFraction) == 1) {
        any* fractionalNumber = malloc(sizeof(any));
        fractionalNumber->type = ANY_NUMERIC;
        fractionalNumber->value.jsLikeNumeric.numericType = NUM_LONG_DOUBLE;
        fractionalNumber->value.jsLikeNumeric.value.fractionalNumberValue = parsedFraction;
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

void freeAny(any* anything) {
    if (!anything) return;
    if ((anything->type == ANY_STRING) && (anything->value.jsLikeString)) {
        free(anything->value.jsLikeString);
    }
    free(anything);
}

int main() {
    any* anyWholeNumber = createJsLikeNumeric("42");
    any* anyFractionalNumber = createJsLikeNumeric("3.14159");
    any* anyString = createJsLikeString("hello");
    any* anyBoolean = createJsLikeBoolean(true);
    any* anyNull = createJsLikeNull();

    if (anyWholeNumber->type == ANY_NUMERIC && anyWholeNumber->value.jsLikeNumeric.numericType == NUM_LONG_LONG)
        printf("anyWholeNumber: %lld\n", anyWholeNumber->value.jsLikeNumeric.value.wholeNumberValue);

    if (anyFractionalNumber->type == ANY_NUMERIC && anyFractionalNumber->value.jsLikeNumeric.numericType == NUM_LONG_DOUBLE)
        printf("anyFractionalNumber: %Lf\n", anyFractionalNumber->value.jsLikeNumeric.value.fractionalNumberValue);

    if (anyString->type == ANY_STRING)
        printf("anyString: %s\n", anyString->value.jsLikeString);

    if (anyBoolean->type == ANY_BOOL)
        printf("anyBoolean: %s\n", (anyBoolean->value.jsLikeBoolean ? "true" : "false"));

    if (anyNull->type == ANY_NULL)
        printf("anyNull: null\n");

    freeAny(anyWholeNumber);
    freeAny(anyFractionalNumber);
    freeAny(anyString);
    freeAny(anyBoolean);
    freeAny(anyNull);

    return 0;
}
