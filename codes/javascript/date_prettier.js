import {
    AnyType,
    getType,
    extractDate,
    datePrettier,
    prettyFormatDate,
} from "./utils.js";

const datePrettierV1 = (anything = new Date(), { precise = false } = {}) => {
    const anythingType = getType(anything);
    const [fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit] = ((anythingType === AnyType["String"]) ? extractDate(new Date(anything).toISOString()) : ((anythingType === AnyType["Date"]) ? extractDate(anything.toISOString()) : []));
    return (prettyFormatDate(precise, fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit));
};

console.log(datePrettierV1());
console.log(datePrettierV1(new Date()));
console.log(datePrettierV1(new Date().toISOString()));
console.log(datePrettierV1(new Date("2025-07-20T21:03:18.068Z")));
console.log(datePrettierV1(new Date("2025-07-20T21:03:18.068Z").toISOString()));

const datePrettierV2 = datePrettier;

console.log(datePrettierV2());
console.log(datePrettierV2(new Date()));
console.log(datePrettierV2(new Date().toISOString()));
console.log(datePrettierV2(new Date("2025-07-20T21:03:18.068Z")));
console.log(datePrettierV2(new Date("2025-07-20T21:03:18.068Z").toISOString()));
