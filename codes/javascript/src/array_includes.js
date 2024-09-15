const jsonStringify = (anything, { pretty = false } = {}) => ((pretty === true) ? (JSON.stringify(anything, null, " ".repeat(4))) : (JSON.stringify(anything)?.split?.(",")?.join?.(", ")?.split?.(":")?.join?.(": ")?.split?.("{")?.join?.("{ ")?.split?.("}")?.join?.(" }")));

console.log("\n// Array.includes() in JavaScript");

const myFriends = ["Alisa", "Trivia"];
console.log(`my friends: ${jsonStringify(myFriends)}`);

let aName;
let isMyFriend;

aName = "Alisa";
isMyFriend = myFriends.includes(aName);
console.log(`is my friends includes "${aName}": ${isMyFriend}`);
// is my friends includes "Alisa": true

aName = "Trivia";
isMyFriend = myFriends.includes(aName);
console.log(`is my friends includes "${aName}": ${isMyFriend}`);
// is my friends includes "Trivia": true

aName = "Tony";
isMyFriend = myFriends.includes(aName);
console.log(`is my friends includes "${aName}": ${isMyFriend}`);
// is my friends includes "Tony": false

aName = "Ezekiel";
isMyFriend = myFriends.includes(aName);
console.log(`is my friends includes "${aName}": ${isMyFriend}`);
// is my friends includes "Ezekiel": false
