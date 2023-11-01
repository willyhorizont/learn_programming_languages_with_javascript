/* eslint-disable func-names */
/* eslint-disable arrow-body-style */
/* eslint-disable no-unused-vars */

// 1
function getRectangleAreaV1(rectangleWidth, rectangleLength) {
    return rectangleWidth * rectangleLength;
}

// 2
const getRectangleAreaV2 = function (rectangleWidth, rectangleLength) {
    return rectangleWidth * rectangleLength;
};

// 3
const getRectangleAreaV4 = (rectangleWidth, rectangleLength) => {
    return rectangleWidth * rectangleLength;
};

// 4
const getRectangleAreaV5 = (rectangleWidth, rectangleLength) => rectangleWidth * rectangleLength;

// 5
// (rectangleWidth, rectangleLength) => rectangleWidth * rectangleLength

// 6
// function (rectangleWidth, rectangleLength) {
//     return rectangleWidth * rectangleLength;
// }

// 7
// (rectangleWidth, rectangleLength) => {
//     return rectangleWidth * rectangleLength;
// };
