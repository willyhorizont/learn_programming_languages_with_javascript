/* eslint-disable object-shorthand */
/* eslint-disable arrow-body-style */
/* eslint-disable prefer-arrow-callback */
/* eslint-disable func-names */
/* eslint-disable no-unused-vars */

// ? function statement or function declaration
function getRectangleAreaV1(rectangleWidth, rectangleLength) {
    return rectangleWidth * rectangleLength;
}

// ? function expression
const getRectangleAreaV2 = function (rectangleWidth, rectangleLength) {
    return rectangleWidth * rectangleLength;
};

// ? anonymous function
// function (rectangleWidth, rectangleLength) {
//     return rectangleWidth * rectangleLength;
// }

// ? named function expression 🤮
const getRectangleAreaV3 = function doSomething(rectangleWidth, rectangleLength) {
    return rectangleWidth * rectangleLength;
};

// ? arrow function or named arrow function
const getRectangleAreaV4 = (rectangleWidth, rectangleLength) => {
    return rectangleWidth * rectangleLength;
};
const getRectangleAreaV5 = (rectangleWidth, rectangleLength) => rectangleWidth * rectangleLength;

// ? anonymous arrow function
// (rectangleWidth, rectangleLength) => {
//     return rectangleWidth * rectangleLength;
// };
// (rectangleWidth, rectangleLength) => rectangleWidth * rectangleLength

/*
? In JavaScript, a function is a first-class citizen, which means it supports:
? • Passing functions as arguments to other functions
? • Returning functions as values from other functions
? • Assigning functions to variables or storing them in data structures
*/

// ? Passing functions as arguments to other functions

function getBlockVolume(getRectangleAreaFunction, blockHeight) {
    return getRectangleAreaFunction() * blockHeight;
}
function getRectangleAreaV6(rectangleWidth, rectangleLength) {
    return rectangleWidth * rectangleLength;
}
const blockVolume1 = getBlockVolume(getRectangleAreaV6, 10);
const blockVolume2 = getBlockVolume(
    function (rectangleWidth, rectangleLength) {
        return rectangleWidth * rectangleLength;
    },
    10
);
const blockVolume3 = getBlockVolume(
    (rectangleWidth, rectangleLength) => {
        return rectangleWidth * rectangleLength;
    },
    10
);
const blockVolume4 = getBlockVolume((rectangleWidth, rectangleLength) => rectangleWidth * rectangleLength, 10);

// ? Returning functions as values from other functions

function multiplyV1(a) {
    function multiplyBy(b) {
        return a * b;
    }
    return multiplyBy;
}
const multiplyBy2 = multiplyV1(2);
const multiplyBy2Result = multiplyBy2(10); // 20

function multiplyV2(a) {
    const multiplyBy = function (b) {
        return a * b;
    };
    return multiplyBy;
}
const multiplyBy3 = multiplyV2(3);
const multiplyBy3Result = multiplyBy3(10); // 30

function multiplyV3(a) {
    const multiplyBy = (b) => {
        return a * b;
    };
    return multiplyBy;
}
const multiplyBy4 = multiplyV3(4);
const multiplyBy4Result = multiplyBy4(10); // 40

function multiplyV4(a) {
    const multiplyBy = (b) => a * b;
    return multiplyBy;
}
const multiplyBy5 = multiplyV4(5);
const multiplyBy5Result = multiplyBy5(10); // 50

function multiplyV5(a) {
    return (b) => a * b;
}
const multiplyBy6 = multiplyV5(6);
const multiplyBy6Result = multiplyBy6(10); // 60

function multiplyV6(a) {
    return function (b) {
        return a * b;
    };
}
const multiplyBy7 = multiplyV6(7);
const multiplyBy7Result = multiplyBy7(10); // 70

function multiplyV7(a) {
    return (b) => {
        return a * b;
    };
}
const multiplyBy8 = multiplyV7(8);
const multiplyBy8Result = multiplyBy8(10); // 80

const multiplyV8 = function (a) {
    function multiplyBy(b) {
        return a * b;
    }
    return multiplyBy;
};
const multiplyBy9 = multiplyV8(9);
const multiplyBy9Result = multiplyBy9(10); // 90

const multiplyV9 = function (a) {
    const multiplyBy = function (b) {
        return a * b;
    };
    return multiplyBy;
};
const multiplyBy10 = multiplyV9(10);
const multiplyBy10Result = multiplyBy10(10); // 100

const multiplyV10 = function (a) {
    const multiplyBy = (b) => {
        return a * b;
    };
    return multiplyBy;
};
const multiplyBy11 = multiplyV10(11);
const multiplyBy11Result = multiplyBy11(10); // 110

const multiplyV11 = function (a) {
    const multiplyBy = (b) => a * b;
    return multiplyBy;
};
const multiplyBy12 = multiplyV11(12);
const multiplyBy12Result = multiplyBy12(10); // 120

const multiplyV12 = function (a) {
    return (b) => a * b;
};
const multiplyBy13 = multiplyV12(13);
const multiplyBy13Result = multiplyBy13(10); // 130

const multiplyV13 = function (a) {
    return function (b) {
        return a * b;
    };
};
const multiplyBy14 = multiplyV13(14);
const multiplyBy14Result = multiplyBy14(10); // 140

const multiplyV14 = function (a) {
    return (b) => {
        return a * b;
    };
};
const multiplyBy15 = multiplyV14(15);
const multiplyBy15Result = multiplyBy15(10); // 150

const multiplyV15 = (a) => {
    function multiplyBy(b) {
        return a * b;
    }
    return multiplyBy;
};
const multiplyBy16 = multiplyV15(16);
const multiplyBy16Result = multiplyBy16(10); // 160

const multiplyV16 = (a) => {
    const multiplyBy = function (b) {
        return a * b;
    };
    return multiplyBy;
};
const multiplyBy17 = multiplyV16(17);
const multiplyBy17Result = multiplyBy17(10); // 170

const multiplyV17 = (a) => {
    const multiplyBy = (b) => {
        return a * b;
    };
    return multiplyBy;
};
const multiplyBy18 = multiplyV17(18);
const multiplyBy18Result = multiplyBy18(10); // 180

const multiplyV18 = (a) => {
    const multiplyBy = (b) => a * b;
    return multiplyBy;
};
const multiplyBy19 = multiplyV18(19);
const multiplyBy19Result = multiplyBy19(10); // 190

const multiplyV19 = (a) => {
    return (b) => a * b;
};
const multiplyBy20 = multiplyV19(20);
const multiplyBy20Result = multiplyBy20(10); // 200

const multiplyV20 = (a) => {
    return function (b) {
        return a * b;
    };
};
const multiplyBy21 = multiplyV20(21);
const multiplyBy21Result = multiplyBy21(10); // 210

const multiplyV21 = (a) => {
    return (b) => {
        return a * b;
    };
};
const multiplyBy22 = multiplyV21(22);
const multiplyBy22Result = multiplyBy22(10); // 220

const multiplyV22 = (a) => (b) => a * b;
const multiplyBy23 = multiplyV22(23);
const multiplyBy23Result = multiplyBy23(10); // 230

// Assigning functions to variables or storing them in data structures

const getRectangleAreaV7 = (rectangleWidth, rectangleLength) => {
    return rectangleWidth * rectangleLength;
};

const getRectangleAreaV8 = (rectangleWidth, rectangleLength) => rectangleWidth * rectangleLength;

const myArrayOfGetRectangleAreaFunctions = [
    function (rectangleWidth, rectangleLength) {
        return rectangleWidth * rectangleLength;
    },
    (rectangleWidth, rectangleLength) => {
        return rectangleWidth * rectangleLength;
    },
    (rectangleWidth, rectangleLength) => rectangleWidth * rectangleLength
];
const getRectangleAreaFunction1 = myArrayOfGetRectangleAreaFunctions[0](3, 5);
const getRectangleAreaFunction2 = myArrayOfGetRectangleAreaFunctions[1](3, 5);
const getRectangleAreaFunction3 = myArrayOfGetRectangleAreaFunctions[2](3, 5);

const simpleCalculator = {
    multiplication: function (a, b) {
        return a * b;
    },
    division: (a, b) => {
        return a / b;
    },
    addition: (a, b) => a + b,
    subtraction(a, b) {
        return a - b;
    },
};
const simpleCalculatorResult1 = simpleCalculator.addition(7, 8);
const simpleCalculatorResult2 = simpleCalculator.division(81, 9);
const simpleCalculatorResult3 = simpleCalculator.addition(3, 4);
const simpleCalculatorResult4 = simpleCalculator.subtraction(35, 8);
