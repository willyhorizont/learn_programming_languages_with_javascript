import {
    rangeInclusive,
    listComprehension,
} from "./utils.js";

// print([(any_array_item + any_array_item) for any_array_item in range(1, (4 + 1))])
console.log(listComprehension(rangeInclusive(1, 4), (anyArrayItem) => (anyArrayItem + anyArrayItem)));

// print([(any_array_item + any_array_item) for any_array_item in [1, 2, 3, 4]])
console.log(listComprehension([1, 2, 3, 4], (anyArrayItem) => (anyArrayItem + anyArrayItem)));

// print([any_array_item for any_array_item in range(1, (4 + 1)) if ((any_array_item % 2) == 0)])
console.log(listComprehension(rangeInclusive(1, 4), (anyArrayItem) => (anyArrayItem), (anyArrayItem) => ((anyArrayItem % 2) === 0)));

// print([any_array_item for any_array_item in [1, 2, 3, 4] if ((any_array_item % 2) == 0)])
console.log(listComprehension([1, 2, 3, 4], (anyArrayItem) => (anyArrayItem), (anyArrayItem) => ((anyArrayItem % 2) === 0)));
