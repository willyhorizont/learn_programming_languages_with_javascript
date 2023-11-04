console.log('\n// Array.includes() in JavaScript');

const myFriends = ['Alisa', 'Trivia'];
console.log(`my friends: ${JSON.stringify(myFriends).split(',').join(', ')}`);

let name;
let isMyFriend;

name = 'Alisa';
console.log(`name: "${name}"`);
isMyFriend = myFriends.includes(name);
console.log(`is my friends includes "${name}": ${isMyFriend}`);
// is my friends includes "Alisa": true

name = 'Trivia';
console.log(`name: "${name}"`);
isMyFriend = myFriends.includes(name);
console.log(`is my friends includes "${name}": ${isMyFriend}`);
// is my friends includes "Trivia": true

name = 'Tony';
console.log(`name: "${name}"`);
isMyFriend = myFriends.includes(name);
console.log(`is my friends includes "${name}": ${isMyFriend}`);
// is my friends includes "Tony": false

name = 'Ezekiel';
console.log(`name: "${name}"`);
isMyFriend = myFriends.includes(name);
console.log(`is my friends includes "${name}": ${isMyFriend}`);
// is my friends includes "Ezekiel": false
