/* eslint-disable dot-notation */
console.log('\n// Optional Chaining Operator (?.) in JavaScript');

const JSON_OBJECT = {
    "foo": {
        "bar": "baz",
    },
    "fruits": ["apple", "mango", "banana"]
};
console.log(`JSON_OBJECT: ${JSON.stringify(JSON_OBJECT, null, ' '.repeat(4))}`);

console.log('JSON_OBJECT?.foo?.bar:', JSON_OBJECT?.foo?.bar);
// JSON_OBJECT?.foo?.bar: baz

console.log('JSON_OBJECT?.foo?.baz:', JSON_OBJECT?.foo?.baz);
// JSON_OBJECT?.foo?.baz: undefined

console.log('JSON_OBJECT?.fruits?.[2]:', JSON_OBJECT?.fruits?.[2]);
// JSON_OBJECT?.fruits?.[2]: banana

console.log('JSON_OBJECT?.fruits?.[5]:', JSON_OBJECT?.fruits?.[5]);
// JSON_OBJECT?.fruits?.[5]: undefined

console.log('JSON_OBJECT?.foo?.bar:', JSON_OBJECT?.['foo']?.['bar']);
// JSON_OBJECT?.foo?.bar: baz

console.log('JSON_OBJECT?.foo?.baz:', JSON_OBJECT?.['foo']?.['baz']);
// JSON_OBJECT?.foo?.baz: undefined

console.log('JSON_OBJECT?.fruits?.[2]:', JSON_OBJECT?.['fruits']?.[2]);
// JSON_OBJECT?.fruits?.[2]: banana

console.log('JSON_OBJECT?.fruits?.[5]:', JSON_OBJECT?.['fruits']?.[5]);
// JSON_OBJECT?.fruits?.[5]: undefined
