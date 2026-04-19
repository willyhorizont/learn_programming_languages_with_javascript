import {
    jsonStringify,
} from "./utils.js";

console.log("\n// Array.includes() in JavaScript");

const myFriends = ["Alisa", "Trivia"];
console.log(`my friends: ${jsonStringify(myFriends)}`);

{
    const anyName = "Alisa";
    const isMyFriend = myFriends.includes(anyName);
    console.log(`is my friends includes "${anyName}": ${isMyFriend}`);
    // is my friends includes "Alisa": true
}

{
    const anyName = "Trivia";
    const isMyFriend = myFriends.includes(anyName);
    console.log(`is my friends includes "${anyName}": ${isMyFriend}`);
    // is my friends includes "Trivia": true
}

{
    const anyName = "Tony";
    const isMyFriend = myFriends.includes(anyName);
    console.log(`is my friends includes "${anyName}": ${isMyFriend}`);
    // is my friends includes "Tony": false
}

{
    const anyName = "Ezekiel";
    const isMyFriend = myFriends.includes(anyName);
    console.log(`is my friends includes "${anyName}": ${isMyFriend}`);
    // is my friends includes "Ezekiel": false
}
