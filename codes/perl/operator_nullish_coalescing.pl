use strict;
use warnings;
use JSON;

print("\n# JavaScript-like Nullish Coalescing Operator (??) in Perl\n");

# There's no JavaScript-like Nullish Coalescing Operator (??) in Perl.
# But, we can create our own function to mimic it in Perl.

sub nullish_coalescing {
    # JavaScript-like Nullish Coalescing Operator (??) function
    my ($value, $default_value) = @_;
    if (!defined($default_value)) {
        die "Required parameter not provided";
    }
    if (!$value) {
        return $default_value;
    }
    return $value;
};

my %JSON_OBJECT = (
    "foo" => {
        "bar" => "baz"
    },
);
print("JSON_OBJECT?.foo?.bar: ", JSON->new->allow_nonref->pretty->encode(\%JSON_OBJECT));

print("JSON_OBJECT?.foo?.bar: ", JSON->new->allow_nonref->pretty->encode(nullish_coalescing($JSON_OBJECT{"foo"}{"bar"}, "not found")));
# JSON_OBJECT?.foo?.bar: "baz"
print("JSON_OBJECT?.foo?.bar: ", JSON->new->allow_nonref->pretty->encode(nullish_coalescing($JSON_OBJECT{"foo"}{"baz"}, "not found")));
# JSON_OBJECT?.foo?.bar: "not found"
