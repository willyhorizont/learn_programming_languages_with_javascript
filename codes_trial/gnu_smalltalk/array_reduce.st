getRestArguments := [ :variadicArguments |
    [ :sliceStart :rest |
        rest copyFrom: sliceStart to: (rest size).
    ] valueWithArguments: { (variadicArguments at: 1). (variadicArguments at: 2) }.
].

arrayReduceV1 := [ :variadicArguments |
    [ :callbackFunction :anyArray :initialValue |
        currentResult := initialValue.
        1 to: (anyArray size) do: [ :arrayItemIndex |
            arrayItem := (anyArray at: arrayItemIndex).
            currentResult := callbackFunction value: { currentResult. arrayItem. arrayItemIndex. anyArray }.
        ].
        currentResult.
    ] valueWithArguments: { (variadicArguments at: 1). (variadicArguments at: 2). (variadicArguments at: 3) }.
].

arrayReduceV2 := [ :variadicArguments |
    [ :callbackFunction :anyArray :initialValue |
        arrayReduceV2Inner := [ :arrayItemIndex :currentResult |
            (arrayItemIndex > (anyArray size)) ifTrue: [ currentResult ] ifFalse: [ arrayReduceV2Inner valueWithArguments: { (arrayItemIndex + 1). callbackFunction value: { currentResult. (anyArray at: arrayItemIndex). arrayItemIndex. anyArray } } ]
        ].
        arrayReduceV2Inner valueWithArguments: { 1. initialValue }.
    ] valueWithArguments: { (variadicArguments at: 1). (variadicArguments at: 2). (variadicArguments at: 3) }.
].

(arrayReduceV1 value: { [ :variadicArguments | [ :currentResult :arrayItem | (currentResult + arrayItem) ] valueWithArguments: { (variadicArguments at: 1). (variadicArguments at: 2) } ]. ({ 1. 2. 3. 4 }). 0 }) displayNl.
(arrayReduceV2 value: { [ :variadicArguments | [ :currentResult :arrayItem | (currentResult + arrayItem) ] valueWithArguments: { (variadicArguments at: 1). (variadicArguments at: 2) } ]. ({ 1. 2. 3. 4 }). 0 }) displayNl.

(({ 1. 2. 3. 4 }) size) displayNl.
