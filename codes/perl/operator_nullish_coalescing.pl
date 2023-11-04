use strict;
use warnings;
use JSON;

print("\n# JavaScript-like Nullish Coalescing Operator (??) in Perl\n");

# There's no JavaScript-like Nullish Coalescing Operator (??) in Perl.
# But, we can create our own function to mimic it in Perl.

sub nullish_coalescing_v1 {
    # JavaScript-like Nullish Coalescing Operator (??) function
    my ($value, $default_value) = @_;
    if (!defined($default_value)) {
        die("Required parameter not provided");
    }
    if (!$value) {
        return $default_value;
    }
    return $value;
}

sub nullish_coalescing_v2 {
    # JavaScript-like Nullish Coalescing Operator (??) function
    my ($value, $default_value) = @_;
    die("Required parameter not provided") if !defined($default_value);
    return !$value ? $default_value : $value;
}

sub nullish_coalescing_v3 {
    # JavaScript-like Nullish Coalescing Operator (??) function
    my ($value, $default_value) = @_;
    die("Required parameter not provided") unless defined($default_value);
    return !$value ? $default_value : $value;
}

my %JSON_OBJECT = (
    "foo" => {
        "bar" => "baz"
    },
);
print("JSON_OBJECT: ", JSON->new->allow_nonref->pretty->encode(\%JSON_OBJECT));

print("JSON_OBJECT?.foo?.bar ?? \"not found\": ", JSON->new->allow_nonref->pretty->encode(nullish_coalescing_v1($JSON_OBJECT{"foo"}{"bar"}, "not found")));
# JSON_OBJECT?.foo?.bar ?? "not found": "baz"
print("JSON_OBJECT?.foo?.bar ?? \"not found\": ", JSON->new->allow_nonref->pretty->encode(nullish_coalescing_v1($JSON_OBJECT{"foo"}{"baz"}, "not found")));
# JSON_OBJECT?.foo?.bar ?? "not found": "not found"

print("JSON_OBJECT?.foo?.bar ?? \"not found\": ", JSON->new->allow_nonref->pretty->encode(nullish_coalescing_v2($JSON_OBJECT{"foo"}{"bar"}, "not found")));
# JSON_OBJECT?.foo?.bar ?? "not found": "baz"
print("JSON_OBJECT?.foo?.bar ?? \"not found\": ", JSON->new->allow_nonref->pretty->encode(nullish_coalescing_v2($JSON_OBJECT{"foo"}{"baz"}, "not found")));
# JSON_OBJECT?.foo?.bar ?? "not found": "not found"

print("JSON_OBJECT?.foo?.bar ?? \"not found\": ", JSON->new->allow_nonref->pretty->encode(nullish_coalescing_v3($JSON_OBJECT{"foo"}{"bar"}, "not found")));
# JSON_OBJECT?.foo?.bar ?? "not found": "baz"
print("JSON_OBJECT?.foo?.bar ?? \"not found\": ", JSON->new->allow_nonref->pretty->encode(nullish_coalescing_v3($JSON_OBJECT{"foo"}{"baz"}, "not found")));
# JSON_OBJECT?.foo?.bar ?? "not found": "not found"
