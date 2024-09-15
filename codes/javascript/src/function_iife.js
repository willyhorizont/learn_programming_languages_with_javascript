/* eslint-disable wrap-iife */
/* eslint-disable func-names */

console.log("// Immediately Invoked Function Expression (IIFE) in JavaScript");
console.log("// a Self-Executing Anonymous Function that runs as soon as it is defined");
console.log("// https://developer.mozilla.org/en-US/docs/Glossary/IIFE");

(function () {
    console.log("// self-executing after defined");
})();

(() => {
    console.log("// self-executing after defined");
})();

(() => console.log("// self-executing after defined"))();
