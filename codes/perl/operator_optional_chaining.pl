use strict;
use warnings;
use JSON;

print("\n# JavaScript-like Optional Chaining Operator (?.) in Perl\n");

# There's no JavaScript-like Optional Chaining Operator (?.) in Perl.
# But, we don't need that in Perl.

my %JSON_OBJECT = (
    "foo" => {
        "bar" => "baz"
    },
);
print("JSON_OBJECT: ", JSON->new->allow_nonref->pretty->encode(\%JSON_OBJECT));

print("JSON_OBJECT?.foo?.bar: ", JSON->new->allow_nonref->pretty->encode($JSON_OBJECT{"foo"}{"bar"}));
# JSON_OBJECT?.foo?.bar: "baz"
print("JSON_OBJECT?.foo?.bar: ", JSON->new->allow_nonref->pretty->encode($JSON_OBJECT{"foo"}{"baz"}));
# JSON_OBJECT?.foo?.bar: null
