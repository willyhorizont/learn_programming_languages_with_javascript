/* eslint-disable dot-notation */
/* eslint-disable no-console */
/* eslint-disable object-shorthand */
/* eslint-disable arrow-body-style */
/* eslint-disable prefer-arrow-callback */
/* eslint-disable func-names */

// ? function statement or function declaration

function getRectangleAreaV1(rectangleWidth, rectangleLength) {
    return (rectangleWidth * rectangleLength);
}
console.log(`getRectangleAreaV1(7, 5): ${getRectangleAreaV1(7, 5)}`);

// ? function expression

const getRectangleAreaV2 = function (rectangleWidth, rectangleLength) {
    return (rectangleWidth * rectangleLength);
};
console.log(`getRectangleAreaV2(7, 5): ${getRectangleAreaV2(7, 5)}`);

// ? function expression with arrow function or named arrow function

const getRectangleAreaV3 = (rectangleWidth, rectangleLength) => {
    return (rectangleWidth * rectangleLength);
};
console.log(`getRectangleAreaV3(7, 5): ${getRectangleAreaV3(7, 5)}`);

const getRectangleAreaV4 = (rectangleWidth, rectangleLength) => (rectangleWidth * rectangleLength);
console.log(`getRectangleAreaV4(7, 5): ${getRectangleAreaV4(7, 5)}`);

// ? named function expression 🤮

const getRectangleAreaV5 = function doSomething(rectangleWidth, rectangleLength) {
    return (rectangleWidth * rectangleLength);
};
console.log(`getRectangleAreaV5(7, 5): ${getRectangleAreaV5(7, 5)}`);

// ? anonymous function

// function (rectangleWidth, rectangleLength) {
//     return (rectangleWidth * rectangleLength);
// }

// ? anonymous arrow function

// (rectangleWidth, rectangleLength) => {
//     return (rectangleWidth * rectangleLength);
// };
// (rectangleWidth, rectangleLength) => (rectangleWidth * rectangleLength)

/*
    ? In JavaScript, a function is a first-class citizen, which means it supports:
    ? • Passing functions as arguments to other functions
    ? • Assigning functions to variables or storing them in data structures
    ? • Returning functions as values from other functions
*/

// ? Passing functions as arguments to other functions

function sayHello(callbackFunction) {
    console.log("hello");
    callbackFunction();
}

function sayHowAreYou() {
    console.log("how are you?");
}

sayHello(sayHowAreYou);

sayHello(function () {
    console.log("how are you?");
});

sayHello(() => {
    console.log("how are you?");
});

sayHello(() => console.log("how are you?"));

// ? Assigning functions to variables or storing them in data structures

const getRectangleAreaV2Copy = function (rectangleWidth, rectangleLength) {
    return (rectangleWidth * rectangleLength);
};
console.log(`getRectangleAreaV2Copy(7, 5): ${getRectangleAreaV2Copy(7, 5)}`);

const getRectangleAreaV3Copy = (rectangleWidth, rectangleLength) => {
    return (rectangleWidth * rectangleLength);
};
console.log(`getRectangleAreaV3Copy(7, 5): ${getRectangleAreaV3Copy(7, 5)}`);

const getRectangleAreaV4Copy = (rectangleWidth, rectangleLength) => (rectangleWidth * rectangleLength);
console.log(`getRectangleAreaV4Copy(7, 5): ${getRectangleAreaV4Copy(7, 5)}`);

const myArrayOfGetRectangleAreaFunctions = [
    getRectangleAreaV1,
    function (rectangleWidth, rectangleLength) {
        return (rectangleWidth * rectangleLength);
    },
    (rectangleWidth, rectangleLength) => {
        return (rectangleWidth * rectangleLength);
    },
    (rectangleWidth, rectangleLength) => (rectangleWidth * rectangleLength)
];
console.log(`myArrayOfGetRectangleAreaFunctions[0](7, 5): ${myArrayOfGetRectangleAreaFunctions[0](7, 5)}`);
console.log(`myArrayOfGetRectangleAreaFunctions[1](7, 5): ${myArrayOfGetRectangleAreaFunctions[1](7, 5)}`);
console.log(`myArrayOfGetRectangleAreaFunctions[2](7, 5): ${myArrayOfGetRectangleAreaFunctions[2](7, 5)}`);
console.log(`myArrayOfGetRectangleAreaFunctions[3](7, 5): ${myArrayOfGetRectangleAreaFunctions[3](7, 5)}`);
console.log(`myArrayOfGetRectangleAreaFunctions?.[0]?.(7, 5): ${myArrayOfGetRectangleAreaFunctions?.[0]?.(7, 5)}`);
console.log(`myArrayOfGetRectangleAreaFunctions?.[1]?.(7, 5): ${myArrayOfGetRectangleAreaFunctions?.[1]?.(7, 5)}`);
console.log(`myArrayOfGetRectangleAreaFunctions?.[2]?.(7, 5): ${myArrayOfGetRectangleAreaFunctions?.[2]?.(7, 5)}`);
console.log(`myArrayOfGetRectangleAreaFunctions?.[3]?.(7, 5): ${myArrayOfGetRectangleAreaFunctions?.[3]?.(7, 5)}`);

function exponentiation(a, b) {
    return (a ** b);
}

const simpleCalculator = {
    exponentiation,
    multiplication: function (a, b) {
        return (a * b);
    },
    division: (a, b) => {
        return (a / b);
    },
    addition: (a, b) => (a + b),
    subtraction(a, b) {
        return (a - b);
    },
};
console.log(`simpleCalculator["exponentiation"](2, 4): ${simpleCalculator["exponentiation"](2, 4)}`);
console.log(`simpleCalculator["multiplication"](7, 5): ${simpleCalculator["multiplication"](7, 5)}`);
console.log(`simpleCalculator["division"](81, 9): ${simpleCalculator["division"](81, 9)}`);
console.log(`simpleCalculator["addition"](9, 3): ${simpleCalculator["addition"](9, 3)}`);
console.log(`simpleCalculator["subtraction"](35, 8): ${simpleCalculator["subtraction"](35, 8)}`);
console.log(`simpleCalculator.exponentiation(2, 4): ${simpleCalculator.exponentiation(2, 4)}`);
console.log(`simpleCalculator.multiplication(7, 5): ${simpleCalculator.multiplication(7, 5)}`);
console.log(`simpleCalculator.division(81, 9): ${simpleCalculator.division(81, 9)}`);
console.log(`simpleCalculator.addition(9, 3): ${simpleCalculator.addition(9, 3)}`);
console.log(`simpleCalculator.subtraction(35, 8): ${simpleCalculator.subtraction(35, 8)}`);
console.log(`simpleCalculator?.["exponentiation"]?.(2, 4): ${simpleCalculator?.["exponentiation"]?.(2, 4)}`);
console.log(`simpleCalculator?.["multiplication"]?.(7, 5): ${simpleCalculator?.["multiplication"]?.(7, 5)}`);
console.log(`simpleCalculator?.["division"]?.(81, 9): ${simpleCalculator?.["division"]?.(81, 9)}`);
console.log(`simpleCalculator?.["addition"]?.(9, 3): ${simpleCalculator?.["addition"]?.(9, 3)}`);
console.log(`simpleCalculator?.["subtraction"]?.(35, 8): ${simpleCalculator?.["subtraction"]?.(35, 8)}`);
console.log(`simpleCalculator?.exponentiation?.(2, 4): ${simpleCalculator?.exponentiation?.(2, 4)}`);
console.log(`simpleCalculator?.multiplication?.(7, 5): ${simpleCalculator?.multiplication?.(7, 5)}`);
console.log(`simpleCalculator?.division?.(81, 9): ${simpleCalculator?.division?.(81, 9)}`);
console.log(`simpleCalculator?.addition?.(9, 3): ${simpleCalculator?.addition?.(9, 3)}`);
console.log(`simpleCalculator?.subtraction?.(35, 8): ${simpleCalculator?.subtraction?.(35, 8)}`);

// ? Returning functions as values from other functions

function multiplyV1(a) {
    function multiplyBy(b) {
        return (a * b);
    }
    return multiplyBy;
}
const multiplyBy2 = multiplyV1(2);
const multiplyBy2Result = multiplyBy2(10);
console.log(`multiplyBy2(10): ${multiplyBy2Result}`);

function multiplyV2(a) {
    const multiplyBy = function (b) {
        return (a * b);
    };
    return multiplyBy;
}
const multiplyBy3 = multiplyV2(3);
const multiplyBy3Result = multiplyBy3(10);
console.log(`multiplyBy3(10): ${multiplyBy3Result}`);

function multiplyV3(a) {
    const multiplyBy = (b) => {
        return (a * b);
    };
    return multiplyBy;
}
const multiplyBy4 = multiplyV3(4);
const multiplyBy4Result = multiplyBy4(10);
console.log(`multiplyBy4(10): ${multiplyBy4Result}`);

function multiplyV4(a) {
    const multiplyBy = (b) => (a * b);
    return multiplyBy;
}
const multiplyBy5 = multiplyV4(5);
const multiplyBy5Result = multiplyBy5(10);
console.log(`multiplyBy5(10): ${multiplyBy5Result}`);

function multiplyV5(a) {
    return (b) => (a * b);
}
const multiplyBy6 = multiplyV5(6);
const multiplyBy6Result = multiplyBy6(10);
console.log(`multiplyBy6(10): ${multiplyBy6Result}`);

function multiplyV6(a) {
    return function (b) {
        return (a * b);
    };
}
const multiplyBy7 = multiplyV6(7);
const multiplyBy7Result = multiplyBy7(10);
console.log(`multiplyBy7(10): ${multiplyBy7Result}`);

function multiplyV7(a) {
    return (b) => {
        return (a * b);
    };
}
const multiplyBy8 = multiplyV7(8);
const multiplyBy8Result = multiplyBy8(10);
console.log(`multiplyBy8(10): ${multiplyBy8Result}`);

const multiplyV8 = function (a) {
    function multiplyBy(b) {
        return (a * b);
    }
    return multiplyBy;
};
const multiplyBy9 = multiplyV8(9);
const multiplyBy9Result = multiplyBy9(10);
console.log(`multiplyBy9(10): ${multiplyBy9Result}`);

const multiplyV9 = function (a) {
    const multiplyBy = function (b) {
        return (a * b);
    };
    return multiplyBy;
};
const multiplyBy10 = multiplyV9(10);
const multiplyBy10Result = multiplyBy10(10);
console.log(`multiplyBy10(10): ${multiplyBy10Result}`);

const multiplyV10 = function (a) {
    const multiplyBy = (b) => {
        return (a * b);
    };
    return multiplyBy;
};
const multiplyBy11 = multiplyV10(11);
const multiplyBy11Result = multiplyBy11(10);
console.log(`multiplyBy11(10): ${multiplyBy11Result}`);

const multiplyV11 = function (a) {
    const multiplyBy = (b) => (a * b);
    return multiplyBy;
};
const multiplyBy12 = multiplyV11(12);
const multiplyBy12Result = multiplyBy12(10);
console.log(`multiplyBy12(10): ${multiplyBy12Result}`);

const multiplyV12 = function (a) {
    return (b) => (a * b);
};
const multiplyBy13 = multiplyV12(13);
const multiplyBy13Result = multiplyBy13(10);
console.log(`multiplyBy13(10): ${multiplyBy13Result}`);

const multiplyV13 = function (a) {
    return function (b) {
        return (a * b);
    };
};
const multiplyBy14 = multiplyV13(14);
const multiplyBy14Result = multiplyBy14(10);
console.log(`multiplyBy14(10): ${multiplyBy14Result}`);

const multiplyV14 = function (a) {
    return (b) => {
        return (a * b);
    };
};
const multiplyBy15 = multiplyV14(15);
const multiplyBy15Result = multiplyBy15(10);
console.log(`multiplyBy15(10): ${multiplyBy15Result}`);

const multiplyV15 = (a) => {
    function multiplyBy(b) {
        return (a * b);
    }
    return multiplyBy;
};
const multiplyBy16 = multiplyV15(16);
const multiplyBy16Result = multiplyBy16(10);
console.log(`multiplyBy16(10): ${multiplyBy16Result}`);

const multiplyV16 = (a) => {
    const multiplyBy = function (b) {
        return (a * b);
    };
    return multiplyBy;
};
const multiplyBy17 = multiplyV16(17);
const multiplyBy17Result = multiplyBy17(10);
console.log(`multiplyBy17(10): ${multiplyBy17Result}`);

const multiplyV17 = (a) => {
    const multiplyBy = (b) => {
        return (a * b);
    };
    return multiplyBy;
};
const multiplyBy18 = multiplyV17(18);
const multiplyBy18Result = multiplyBy18(10);
console.log(`multiplyBy18(10): ${multiplyBy18Result}`);

const multiplyV18 = (a) => {
    const multiplyBy = (b) => (a * b);
    return multiplyBy;
};
const multiplyBy19 = multiplyV18(19);
const multiplyBy19Result = multiplyBy19(10);
console.log(`multiplyBy19(10): ${multiplyBy19Result}`);

const multiplyV19 = (a) => {
    return (b) => (a * b);
};
const multiplyBy20 = multiplyV19(20);
const multiplyBy20Result = multiplyBy20(10);
console.log(`multiplyBy20(10): ${multiplyBy20Result}`);

const multiplyV20 = (a) => {
    return function (b) {
        return (a * b);
    };
};
const multiplyBy21 = multiplyV20(21);
const multiplyBy21Result = multiplyBy21(10);
console.log(`multiplyBy21(10): ${multiplyBy21Result}`);

const multiplyV21 = (a) => {
    return (b) => {
        return (a * b);
    };
};
const multiplyBy22 = multiplyV21(22);
const multiplyBy22Result = multiplyBy22(10);
console.log(`multiplyBy22(10): ${multiplyBy22Result}`);

const multiplyV22 = (a) => (b) => (a * b);
const multiplyBy23 = multiplyV22(23);
const multiplyBy23Result = multiplyBy23(10);
console.log(`multiplyBy23(10): ${multiplyBy23Result}`);
