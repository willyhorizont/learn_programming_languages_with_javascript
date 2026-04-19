getRestArguments := [ :variadicArguments |
    [ :sliceStart :rest |
        rest copyFrom: sliceStart to: rest size.
    ] valueWithArguments: { (variadicArguments at: 1). (variadicArguments at: 2) }.
].

arrayReduceV1 := [ :variadicArguments |
    [ :callbackFunction :anyArray :initialValue |
        currentResult := initialValue.
        anyArray keysAndValuesDo: [ :arrayItemIndex :arrayItem |
            currentResult := callbackFunction value: { currentResult. arrayItem. arrayItemIndex. anyArray }.
        ].
        currentResult.
    ] valueWithArguments: { (variadicArguments at: 1). (variadicArguments at: 2). (variadicArguments at: 3) }.
].

(arrayReduceV1 value: { 1. 2. 3. 4 }) displayNl.
