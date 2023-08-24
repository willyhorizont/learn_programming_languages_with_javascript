console.log('\n// Optional Chaining Operator (?.) in JavaScript');

const JSON_OBJECT = {
    "foo": {
        "bar": "baz",
    }
};

console.log('JSON_OBJECT?.foo?.bar:', JSON_OBJECT?.foo?.bar);
// JSON_OBJECT?.foo?.bar: baz

console.log('JSON_OBJECT?.foo?.baz:', JSON_OBJECT?.foo?.baz);
// JSON_OBJECT?.foo?.baz: undefined
