'"Variables and Scopes in JavaScript"' displayNl.

"global scope"

| yyy |

yyy := 'global_scope, 1'.
('yyy: ', yyy) displayNl. "yyy: global_scope, 1"

"local scope"

1 to: 1 do: [ :i |
    | yyy aaa |
    yyy := 'local_scope, 1'.
    aaa := 'local_scope, 2'.
    ('yyy: ', yyy) displayNl. "yyy: local_scope, 1"
    ('aaa: ', aaa) displayNl. "aaa: local_scope, 2"
].

"('aaa: ', aaa) displayNl." "'aaa' is not defined"
('yyy: ', yyy) displayNl. "yyy: global_scope, 1"

yyy := 'global_scope, 1'.

[
    | yyy aaa |
    yyy := 'local_scope, 10'.
    aaa := 'local_scope, 20'.
    ('yyy: ', yyy) displayNl. "yyy: local_scope, 10"
    ('aaa: ', aaa) displayNl. "aaa: local_scope, 10"
] value.

('aaa: ', aaa == nil) displayNl. "'aaa' is not defined"
('yyy: ', yyy) displayNl. "yyy: global_scope, 1"

yyy := 'global_scope, 1'.
