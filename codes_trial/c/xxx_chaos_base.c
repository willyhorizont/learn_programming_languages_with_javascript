#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

typedef enum { ANY_INT, ANY_DOUBLE, ANY_STRING, ANY_NULL, ANY_BOOL, ANY_LIST, ANY_DICT } AnyType;

typedef struct any any; // forward declaration

typedef struct {
    char* key;
    any* value;
} DictEntry;

struct any {
    AnyType type;
    union {
        int i;
        double d;
        char* s;
        bool b;
        struct {
            any** items;
            size_t length;
        } list;
        struct {
            DictEntry* entries;
            size_t length;
        } dict;
    } value;
};

// --- Constructors ---
any* makeInt(int x) {
    any* a = malloc(sizeof(any));
    a->type = ANY_INT;
    a->value.i = x;
    return a;
}

any* makeDouble(double d) {
    any* a = malloc(sizeof(any));
    a->type = ANY_DOUBLE;
    a->value.d = d;
    return a;
}

any* makeString(const char* s) {
    any* a = malloc(sizeof(any));
    a->type = ANY_STRING;
    a->value.s = strdup(s);
    return a;
}

any* makeNull(void) {
    any* a = malloc(sizeof(any));
    a->type = ANY_NULL;
    return a;
}

any* makeBool(bool b) {
    any* a = malloc(sizeof(any));
    a->type = ANY_BOOL;
    a->value.b = b;
    return a;
}

any* makeListWithSentinel(any** items) {
    size_t len = 0;
    while (items[len] != NULL) len++;

    any* a = malloc(sizeof(any));
    a->type = ANY_LIST;
    a->value.list.items = items;
    a->value.list.length = len;
    return a;
}

any* makeDict(DictEntry* entries, size_t length) {
    any* a = malloc(sizeof(any));
    a->type = ANY_DICT;
    a->value.dict.entries = entries;
    a->value.dict.length = length;
    return a;
}

// --- DictEntry helpers ---
DictEntry makeDictEntry(const char* key, any* value) {
    DictEntry e;
    e.key = strdup(key);
    e.value = value;
    return e;
}

any* makeDictWithSentinel(DictEntry* entries) {
    size_t len = 0;
    while (entries[len].key != NULL) len++;

    return makeDict(entries, len);
}

// --- Printers ---
void printAny(any* a);

void printDict(any* a) {
    printf("{");
    for (size_t i = 0; i < a->value.dict.length; i++) {
        DictEntry e = a->value.dict.entries[i];
        printf("\"%s\": ", e.key);
        printAny(e.value);
        if (i + 1 < a->value.dict.length) printf(", ");
    }
    printf("}");
}

void printAny(any* a) {
    switch (a->type) {
        case ANY_INT:    printf("%d", a->value.i); break;
        case ANY_DOUBLE: printf("%f", a->value.d); break;
        case ANY_STRING: printf("\"%s\"", a->value.s); break;
        case ANY_NULL:   printf("NULL"); break;
        case ANY_BOOL:   printf(a->value.b ? "true" : "false"); break;
        case ANY_LIST: {
            printf("[");
            for (size_t i = 0; i < a->value.list.length; i++) {
                printAny(a->value.list.items[i]);
                if (i + 1 < a->value.list.length) printf(", ");
            }
            printf("]");
            break;
        }
        case ANY_DICT: printDict(a); break;
    }
}

// --- Demo ---
int main(void) {
    any* myList = makeListWithSentinel((any*[]){
        makeInt(10),
        makeNull(),
        makeBool(true),
        makeString("hello"),
        makeDouble(3.14),
        NULL
    });

    any* myDict = makeDictWithSentinel((DictEntry[]){
        makeDictEntry("name", makeString("Willy")),
        makeDictEntry("age", makeInt(25)),
        makeDictEntry("isCoder", makeBool(true)),
        makeDictEntry("data", myList),
        { NULL, NULL } // sentinel
    });

    printAny(myDict);
    return 0;
}
