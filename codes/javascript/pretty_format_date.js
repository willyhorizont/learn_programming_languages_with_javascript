import {
    extractDate,
    prettyFormatDate,
} from "./utils.js";

const prettyFormatDateV1 = (precise, fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit) => (`${fullYear}-(${zeroPaddedMonth}|${monthThreeFirstLetter})-(${zeroPaddedDay}|${dayThreeFirstLetter})-(${(precise === true) ? "(" : ""}${zeroPaddedHourTwelveHourClock}:${zeroPaddedMinute}${amPm}|${zeroPaddedHourTwentyFourHourClock}:${zeroPaddedMinute})${(precise === true) ? (`:${zeroPaddedSecond}.${zeroPaddedMiliSecondThreeDigit}`) : ("")}${(precise === true) ? ")" : ""}`);

const prettyFormatDateV2 = prettyFormatDate;

{
    const [fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit] = extractDate(new Date(2025, (7 - 1), 21, 14, 13, 26, 219).toISOString());
    console.log(prettyFormatDateV1(true, fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit));
    console.log(prettyFormatDateV1(false, fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit));
}

{
    const [fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit] = extractDate(new Date(2025, (7 - 1), 21, 14, 13, 26, 219).toISOString());
    console.log(prettyFormatDateV2(true, fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit));
    console.log(prettyFormatDateV2(false, fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit));
}