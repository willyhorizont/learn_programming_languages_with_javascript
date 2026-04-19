import {
    datePrettier,
    formatDate,
} from "./utils.js";

const formatDateV1 = (timestamp, ...restArguments) => (timestamp.toLocaleString(...restArguments));

const formatDateV2 = formatDate; // formatDateV2

const createNewDate = ({ fullYear, zeroPaddedMonth, zeroPaddedDay, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit } = {}) => (new Date(Number(fullYear), (Number(zeroPaddedMonth) - 1), Number(zeroPaddedDay), Number(zeroPaddedHourTwentyFourHourClock), Number(zeroPaddedMinute), Number(zeroPaddedSecond), Number(zeroPaddedMiliSecondThreeDigit)));

console.log(datePrettier(new Date()));

console.log(datePrettier(new Date().toISOString()));

console.log(datePrettier(createNewDate({ fullYear: "2025", zeroPaddedMonth: "07", zeroPaddedDay: "21", zeroPaddedHourTwentyFourHourClock: "14", zeroPaddedMinute: "13", zeroPaddedSecond: "26", zeroPaddedMiliSecondThreeDigit: "219" })));

console.log(datePrettier(new Date(2025, (7 - 1), 21, 14, 13, 26, 219)));

console.log(datePrettier(new Date("2025-07-21T07:13:26.219Z")));

console.log(datePrettier(new Date(2025, (7 - 1), 21, 14, 13, 26, 219).toISOString()));

console.log(datePrettier(new Date("2025-07-21T07:13:26.219Z").toISOString()));

console.log(datePrettier(new Date(), { precise: true }));

console.log(datePrettier(new Date().toISOString(), { precise: true }));

console.log(datePrettier(createNewDate({ fullYear: "2025", zeroPaddedMonth: "07", zeroPaddedDay: "21", zeroPaddedHourTwentyFourHourClock: "14", zeroPaddedMinute: "13", zeroPaddedSecond: "26", zeroPaddedMiliSecondThreeDigit: "219" }), { precise: true }));

console.log(datePrettier(new Date(2025, (7 - 1), 21, 14, 13, 26, 219), { precise: true }));

console.log(datePrettier(new Date("2025-07-21T07:13:26.219Z"), { precise: true }));

console.log(datePrettier(new Date(2025, (7 - 1), 21, 14, 13, 26, 219).toISOString(), { precise: true }));

console.log(datePrettier(new Date("2025-07-21T07:13:26.219Z").toISOString(), { precise: true }));
