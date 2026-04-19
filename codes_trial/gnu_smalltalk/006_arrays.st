" anyArray := #(1 2 3). "
" anyArray := (OrderedCollection withAll: #(1 2 3)). "
" anyArray := { 1. 2. 3 }. "
" fruits := #('apple' 'mango' 'orange'). "
" fruits := OrderedCollection withAll: #('apple' 'mango' 'orange'). "
fruits := { 'apple'. 'mango'. 'orange' }.

i := 1.
[ true ] whileTrue: [
    (i > fruits size) ifTrue: [ ^self ]. "break"
    ('Index: ', i printString, ' Fruit: ', (fruits at: i)) displayNl.
    i := i + 1.
].

i := 1.
[ i <= fruits size ] whileTrue: [
    ('Index: ', i printString, ' Fruit: ', (fruits at: i)) displayNl.
    i := i + 1.
].

1 to: fruits size do: [ :i |
    ('Index: ', i printString, ' Fruit: ', (fruits at: i)) displayNl.
].

i := 1.
fruits do: [ :fruit |
    ('Index: ', i printString, ' Fruit: ', fruit) displayNl.
    i := i + 1.
].

fruits keysAndValuesDo: [ :index :fruit |
    ('Index: ', index printString, ' Fruit: ', fruit) displayNl.
].
