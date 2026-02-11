import {
    AnyType,
    getType,
    formatDate,
    extractDate,
    prettyFormatDate,
    jsonStringify,
} from "./utils.js";

const extractDateV1 = (anything) => {
    const anythingType = getType(anything);
    const anyDate = ((anythingType === AnyType["String"]) ? new Date(anything) : ((anythingType === AnyType["Date"]) ? anything : undefined));
    if (anyDate === undefined) return;
    const fullYear = String(anyDate.getFullYear());
    const zeroPaddedMonth = String(anyDate.getMonth() + 1).padStart(2, "0");
    const monthThreeFirstLetter = formatDate(anyDate, "en-US", { month: "short" });
    const zeroPaddedDay = String(anyDate.getDate()).padStart(2, "0");
    const dayThreeFirstLetter = formatDate(anyDate, "en-US", { weekday: "short" });
    const [hourMinuteTwentyFourHourClockAllZeroPaddedJoinByColon, amPm] = formatDate(anyDate, "en-US", { hour: "2-digit", minute: "2-digit", hour12: true }).split(" ");
    const [zeroPaddedHourTwelveHourClock, _] = hourMinuteTwentyFourHourClockAllZeroPaddedJoinByColon.split(":");
    const [zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute] = formatDate(anyDate, "en-GB", { hour: "2-digit", minute: "2-digit", hour12: false }).split(":");
    const zeroPaddedSecond = String(anyDate.getSeconds()).padStart(2, "0");
    const zeroPaddedMiliSecondThreeDigit = String(anyDate.getMilliseconds()).padStart(3, "0");
    return ([fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit]);
};

const extractDateV2 = (anything) => {
    const anythingType = getType(anything);
    const anyDate = ((anythingType === AnyType["String"]) ? new Date(anything) : ((anythingType === AnyType["Date"]) ? anything : undefined));
    if (anyDate === undefined) return;
    const [hourMinuteTwentyFourHourClockAllZeroPaddedJoinByColon, amPm] = formatDate(anyDate, "en-US", { hour: "2-digit", minute: "2-digit", hour12: true }).split(" ");
    const [zeroPaddedHourTwelveHourClock, _] = hourMinuteTwentyFourHourClockAllZeroPaddedJoinByColon.split(":");
    const [zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute] = formatDate(anyDate, "en-GB", { hour: "2-digit", minute: "2-digit", hour12: false }).split(":");
    return ([(String(anyDate.getFullYear())), (String(anyDate.getMonth() + 1).padStart(2, "0")), (formatDate(anyDate, "en-US", { month: "short" })), (String(anyDate.getDate()).padStart(2, "0")), (formatDate(anyDate, "en-US", { weekday: "short" })), zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, (String(anyDate.getSeconds()).padStart(2, "0")), (String(anyDate.getMilliseconds()).padStart(3, "0"))]);
};

const extractDateV3 = extractDate // extractDateV3

{
    const [fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit] = extractDateV1(new Date().toISOString());
    console.log(prettyFormatDate(true, fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit));
    console.log(jsonStringify([fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit]));
    console.log(jsonStringify({ fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit }));
}

{
    const [fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit] = extractDateV2(new Date().toISOString());
    console.log(prettyFormatDate(true, fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit));
    console.log(jsonStringify([fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit]));
    console.log(jsonStringify({ fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit }));
}

{
    const [fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit] = extractDateV3(new Date().toISOString());
    console.log(prettyFormatDate(true, fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit));
    console.log(jsonStringify([fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit]));
    console.log(jsonStringify({ fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit }));
}

{
    const [fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit] = extractDateV1(new Date(2025, (7 - 1), 21, 14, 13, 26, 219).toISOString());
    console.log(prettyFormatDate(true, fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit));
    console.log(jsonStringify([fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit]));
    console.log(jsonStringify({ fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit }));
}

{
    const [fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit] = extractDateV2(new Date(2025, (7 - 1), 21, 14, 13, 26, 219).toISOString());
    console.log(prettyFormatDate(true, fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit));
    console.log(jsonStringify([fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit]));
    console.log(jsonStringify({ fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit }));
}

{
    const [fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit] = extractDateV3(new Date(2025, (7 - 1), 21, 14, 13, 26, 219).toISOString());
    console.log(prettyFormatDate(true, fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit));
    console.log(jsonStringify([fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit]));
    console.log(jsonStringify({ fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit }));
}
