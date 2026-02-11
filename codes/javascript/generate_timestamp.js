import {
    extractDate,
    prettyFormatDate,
    generateTimestamp,
} from "./utils.js";

const generateTimestampV1 = ({ precise = false } = {}) => {
    const [fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit] = extractDate(new Date().toISOString());
    return (prettyFormatDate(precise, fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit));
};

const generateTimestampV2 = generateTimestamp // generateTimestampV2

console.log(generateTimestampV1());

console.log(generateTimestampV2());

console.log(generateTimestampV1({ precise: true }));

console.log(generateTimestampV2({ precise: true }));
