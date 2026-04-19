"Smalltalk does not have native continue 🤮"

"while loop"

i := 1.
[ true ] whileTrue: [
    (i > 5) ifTrue: [ ^self ]. "break"
    ('while loop v1, i is ', i printString) displayNl.
    i := i + 1.
].

i := 1.
[ i <= 5 ] whileTrue: [
    ('while loop v2, i is ', i printString) displayNl.
    i := i + 1.
].

"for loop"

1 to: 10 do: [ :i |
    (i > 5) ifTrue: [ ^self ].  "break"
    ('for loop, i is ', i printString) displayNl.
].

