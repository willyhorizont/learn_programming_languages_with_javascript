getSum := [ :args |
    | a b |
    a := args at: 1.
    b := args at: 2.
    a + b.
].

result := getSum value: (OrderedCollection withAll: #(1 2 3 4)).
result printString displayNl.
