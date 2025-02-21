/* eslint-disable no-use-before-define */
/* eslint-disable no-unreachable-loop */
/* eslint-disable no-constant-condition */
/* eslint-disable no-shadow */
/* eslint-disable vars-on-top */
/* eslint-disable prefer-const */
/* eslint-disable no-redeclare */
/* eslint-disable block-scoped-var */
/* eslint-disable no-var */
/* eslint-disable wrap-iife */
/* eslint-disable func-names */

console.log("// Variables and Scopes in JavaScript");

// global scope

var xxx = "global_scope, 0"; // "var" instantiate function scope!, allow redefinement and allow reassignment !, don't ever use this !, this used in legacy code before ECMAScript 6 (ES6) 2015 !
var xxx = "global_scope, 1"; // doesn't throw error when redefined !
let yyy = "global_scope, 2"; // "let" instantiate block scope, allow reassignment, use this whenever know going to need to reassign value!
const zzz = "global_scope, 3"; // "const" instantiate block scope, use this whenever possible!
console.log(`xxx: ${xxx}`); // xxx: global_scope, 1
console.log(`yyy: ${yyy}`); // yyy: global_scope, 2
console.log(`zzz: ${zzz}`); // zzz: global_scope, 3

// local scope: function scope, block scope ({}, if{}, for{}, while{})

var xxx = "global_scope, 1"; // doesn't throw error when redefined !

// local scope block scope {}

{
    var xxx = "local_scope_block_scope {}, 00"; // "var" instantiate function scope!, allow redefinement and allow reassignment !, don't ever use this !, this used in legacy code before ECMAScript 6 (ES6) 2015 !
    var xxx = "local_scope_block_scope {}, 10"; // doesn't throw error when redefined !
    let yyy = "local_scope_block_scope {}, 20"; // "let" instantiate block scope, allow reassignment, use this whenever know going to need to reassign value!
    const zzz = "local_scope_block_scope {}, 30"; // "const" instantiate block scope, use this whenever possible!
    const aaa = "local_scope_block_scope {}, 40"; // "const" instantiate block scope, use this whenever possible!
    console.log(`xxx: ${xxx}`); // xxx: local_scope_block_scope {}, 10
    console.log(`yyy: ${yyy}`); // yyy: local_scope_block_scope {}, 20
    console.log(`zzz: ${zzz}`); // zzz: local_scope_block_scope {}, 30
    console.log(`aaa: ${aaa}`); // aaa: local_scope_block_scope {}, 40
}
console.log(`xxx: ${xxx}`); // xxx: local_scope_block_scope {}, 10
console.log(`yyy: ${yyy}`); // yyy: global_scope, 2
console.log(`zzz: ${zzz}`); // zzz: global_scope, 3
// console.log(`aaa: ${aaa}`); // "aaa" is not defined

var xxx = "global_scope, 1"; // doesn't throw error when redefined !

// local scope block scope if{}

if (true) {
    var xxx = "local_scope_block_scope if{}, 00"; // "var" instantiate function scope!, allow redefinement and allow reassignment !, don't ever use this !, this used in legacy code before ECMAScript 6 (ES6) 2015 !
    var xxx = "local_scope_block_scope if{}, 10"; // doesn't throw error when redefined !
    let yyy = "local_scope_block_scope if{}, 20"; // "let" instantiate block scope, allow reassignment, use this whenever know going to need to reassign value!
    const zzz = "local_scope_block_scope if{}, 30"; // "const" instantiate block scope, use this whenever possible!
    const aaa = "local_scope_block_scope if{}, 40"; // "const" instantiate block scope, use this whenever possible!
    console.log(`xxx: ${xxx}`); // xxx: local_scope_block_scope if{}, 10
    console.log(`yyy: ${yyy}`); // yyy: local_scope_block_scope if{}, 20
    console.log(`zzz: ${zzz}`); // zzz: local_scope_block_scope if{}, 30
    console.log(`aaa: ${aaa}`); // aaa: local_scope_block_scope if{}, 40
}
console.log(`xxx: ${xxx}`); // xxx: local_scope_block_scope if{}, 10
console.log(`yyy: ${yyy}`); // yyy: global_scope, 2
console.log(`zzz: ${zzz}`); // zzz: global_scope, 3
// console.log(`aaa: ${aaa}`); // "aaa" is not defined

var xxx = "global_scope, 1"; // doesn't throw error when redefined !

// local scope block scope for{}

for (let i = 0; (i < 1); i += 1) {
    var xxx = "local_scope_block_scope for{}, 00"; // "var" instantiate function scope!, allow redefinement and allow reassignment !, don't ever use this !, this used in legacy code before ECMAScript 6 (ES6) 2015 !
    var xxx = "local_scope_block_scope for{}, 10"; // doesn't throw error when redefined !
    let yyy = "local_scope_block_scope for{}, 20"; // "let" instantiate block scope, allow reassignment, use this whenever know going to need to reassign value!
    const zzz = "local_scope_block_scope for{}, 30"; // "const" instantiate block scope, use this whenever possible!
    const aaa = "local_scope_block_scope for{}, 40"; // "const" instantiate block scope, use this whenever possible!
    console.log(`xxx: ${xxx}`); // xxx: local_scope_block_scope for{}, 10
    console.log(`yyy: ${yyy}`); // yyy: local_scope_block_scope for{}, 20
    console.log(`zzz: ${zzz}`); // zzz: local_scope_block_scope for{}, 30
    console.log(`aaa: ${aaa}`); // aaa: local_scope_block_scope for{}, 40
}
console.log(`xxx: ${xxx}`); // xxx: local_scope_block_scope for{}, 10
console.log(`yyy: ${yyy}`); // yyy: global_scope, 2
console.log(`zzz: ${zzz}`); // zzz: global_scope, 3
// console.log(`aaa: ${aaa}`); // "aaa" is not defined

var xxx = "global_scope, 1"; // doesn't throw error when redefined !

// local scope block scope while{}

while (true) {
    var xxx = "local_scope_block_scope while{}, 00"; // "var" instantiate function scope!, allow redefinement and allow reassignment !, don't ever use this !, this used in legacy code before ECMAScript 6 (ES6) 2015 !
    var xxx = "local_scope_block_scope while{}, 10"; // doesn't throw error when redefined !
    let yyy = "local_scope_block_scope while{}, 20"; // "let" instantiate block scope, allow reassignment, use this whenever know going to need to reassign value!
    const zzz = "local_scope_block_scope while{}, 30"; // "const" instantiate block scope, use this whenever possible!
    const aaa = "local_scope_block_scope while{}, 40"; // "const" instantiate block scope, use this whenever possible!
    console.log(`xxx: ${xxx}`); // xxx: local_scope_block_scope while{}, 10
    console.log(`yyy: ${yyy}`); // yyy: local_scope_block_scope while{}, 20
    console.log(`zzz: ${zzz}`); // zzz: local_scope_block_scope while{}, 30
    console.log(`aaa: ${aaa}`); // aaa: local_scope_block_scope while{}, 40
    break;
}
console.log(`xxx: ${xxx}`); // xxx: local_scope_block_scope while{}, 10
console.log(`yyy: ${yyy}`); // yyy: global_scope, 2
console.log(`zzz: ${zzz}`); // zzz: global_scope, 3
// console.log(`aaa: ${aaa}`); // "aaa" is not defined

var xxx = "global_scope, 1"; // doesn't throw error when redefined !

// local scope function scope function () {}

(function () {
    var xxx = "local_scope_function_scope function () {}, 000"; // "var" instantiate function scope!, allow redefinement and allow reassignment !, don't ever use this !, this used in legacy code before ECMAScript 6 (ES6) 2015 !
    var xxx = "local_scope_function_scope function () {}, 100"; // doesn't throw error when redefined !
    let yyy = "local_scope_function_scope function () {}, 200"; // "let" instantiate block scope, allow reassignment, use this whenever know going to need to reassign value!
    const zzz = "local_scope_function_scope function () {}, 300"; // "const" instantiate block scope, use this whenever possible!
    const aaa = "local_scope_function_scope function () {}, 400"; // "const" instantiate block scope, use this whenever possible!
    console.log(`xxx: ${xxx}`); // xxx: local_scope_function_scope function () {}, 100
    console.log(`yyy: ${yyy}`); // yyy: local_scope_function_scope function () {}, 200
    console.log(`zzz: ${zzz}`); // zzz: local_scope_function_scope function () {}, 300
    console.log(`aaa: ${aaa}`); // aaa: local_scope_function_scope function () {}, 400
})();
console.log(`xxx: ${xxx}`); // xxx: global_scope, 1
console.log(`yyy: ${yyy}`); // yyy: global_scope, 2
console.log(`zzz: ${zzz}`); // zzz: global_scope, 3
// console.log(`aaa: ${aaa}`); // "aaa" is not defined

var xxx = "global_scope, 1"; // doesn't throw error when redefined !

// local scope function scope () => {}

(() => {
    var xxx = "local_scope_function_scope () => {}, 000"; // "var" instantiate function scope!, allow redefinement and allow reassignment !, don't ever use this !, this used in legacy code before ECMAScript 6 (ES6) 2015 !
    var xxx = "local_scope_function_scope () => {}, 100"; // doesn't throw error when redefined !
    let yyy = "local_scope_function_scope () => {}, 200"; // "let" instantiate block scope, allow reassignment, use this whenever know going to need to reassign value!
    const zzz = "local_scope_function_scope () => {}, 300"; // "const" instantiate block scope, use this whenever possible!
    const aaa = "local_scope_function_scope () => {}, 400"; // "const" instantiate block scope, use this whenever possible!
    console.log(`xxx: ${xxx}`); // xxx: local_scope_function_scope () => {}, 100
    console.log(`yyy: ${yyy}`); // yyy: local_scope_function_scope () => {}, 200
    console.log(`zzz: ${zzz}`); // zzz: local_scope_function_scope () => {}, 300
    console.log(`aaa: ${aaa}`); // aaa: local_scope_function_scope () => {}, 400
})();
console.log(`xxx: ${xxx}`); // xxx: global_scope, 1
console.log(`yyy: ${yyy}`); // yyy: global_scope, 2
console.log(`zzz: ${zzz}`); // zzz: global_scope, 3
// console.log(`aaa: ${aaa}`); // "aaa" is not defined
