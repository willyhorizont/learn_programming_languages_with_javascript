import {
    rangeInclusive,
    generatorExpression,
} from "./utils.js";

// print((any_array_item + any_array_item) for any_array_item in range(1, (4 + 1)))
console.log(generatorExpression(rangeInclusive(1, 4), (anyArrayItem) => (anyArrayItem + anyArrayItem)));

// print(list((any_array_item + any_array_item) for any_array_item in range(1, (4 + 1))))
console.log(Array.from(generatorExpression(rangeInclusive(1, 4), (anyArrayItem) => (anyArrayItem + anyArrayItem))));
