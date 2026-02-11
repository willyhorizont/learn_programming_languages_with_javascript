#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>

typedef struct Any {
    int type;
    void* value;
} any;

/* === Helper untuk collect arguments === */
any** collectArguments(any* firstArgument, va_list restArguments) {
    size_t capacity = 4;
    size_t length = 0;
    any** args = malloc(sizeof(any*) * capacity);

    any* current = firstArgument;
    while (current != NULL) {
        if (length >= capacity) {
            capacity *= 2;
            args = realloc(args, sizeof(any*) * capacity);
        }
        args[length++] = current;
        current = va_arg(restArguments, any*);
    }

    // sentinel NULL
    if (length >= capacity) {
        args = realloc(args, sizeof(any*) * (capacity + 1));
    }
    args[length] = NULL;

    return args; // caller bertanggung jawab free()
}

/* === Function variadic base === */
any* functionVariadicBase(any* firstArgument, ...) {
    va_list restArguments;
    va_start(restArguments, firstArgument);

    any** args = collectArguments(firstArgument, restArguments);

    va_end(restArguments);

    // contoh: print jumlah argumen
    size_t count = 0;
    for (; args[count] != NULL; count++) {
        printf("Arg #%zu at %p\n", count, (void*)args[count]);
    }
    printf("Total args: %zu\n", count);

    free(args); // jangan lupa free array hasil collectArguments
    return NULL; // misalnya return null JS-like
}

int main(void) {
    any a, b, c;
    functionVariadicBase(&a, &b, &c, NULL);

    return 0;
}
