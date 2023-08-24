console.log('\n// Nullish Coalescing Operator (??) in JavaScript');

const JSON_OBJECT = {
    "foo": {
        "bar": "baz",
    }
};

console.log('JSON_OBJECT?.foo?.bar:', JSON_OBJECT?.foo?.bar ?? "not found");
// JSON_OBJECT?.foo?.bar: baz

console.log('JSON_OBJECT?.foo?.baz:', JSON_OBJECT?.foo?.baz ?? "not found");
// JSON_OBJECT?.foo?.baz: not found
