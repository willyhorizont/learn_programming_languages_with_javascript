(*
1. variable can store dynamic data type and dynamic value, variable can inferred data type from value, value of variable can be reassign with different data type or has option to make variable can store dynamic data type and dynamic value
```javascript
let something = "foo";
console.log("something:", something);
something = 123;
console.log("something:", something);
something = true;
console.log("something:", something);
something = null;
console.log("something:", something);
something = [1, 2, 3];
console.log("something:", something);
something = { "foo": "bar" };
console.log("something:", something);
```
```go
type Any interface{}
```
*)

something = "foo";
Print["something: ", something];
something = 123;
Print["something: ", something];
something = True;
Print["something: ", something];
something = Null;
Print["something: ", something];
something = {1, 2, 3};
Print["something: ", something];
something = <|"foo" -> "bar"|>;
Print["something: ", something];
