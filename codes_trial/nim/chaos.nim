import std/typeinfo
var x: Any

var i = 42
x = i.toAny
# assert x.kind == akInt
# assert x.getInt == 42

var s = @[1, 2, 3]
x = s.toAny
# assert x.kind == akSequence
# assert x.len == 3