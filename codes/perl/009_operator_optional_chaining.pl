use strict;
use warnings;

print("\n# JavaScript-like Optional Chaining Operator (?.) in Perl\n");

sub pretty_json_stringify {
    my ($anything) = @_;
    use JSON;
    my $pretty_json_string = JSON->new->allow_nonref->pretty->encode($anything);
    $pretty_json_string =~ s/   /    /g;
    $pretty_json_string =~ s/\n$//g;
    return $pretty_json_string;
}

# There's no JavaScript-like Optional Chaining Operator (?.) in Perl.
# But, we don't need that in Perl.

my %JSON_OBJECT = (
    "foo" => {
        "bar" => "baz"
    },
    "fruits" => ["apple", "mango", "banana"]
);
print("JSON_OBJECT: " . pretty_json_stringify(\%JSON_OBJECT) . "\n");

print("JSON_OBJECT?.foo?.bar: " . pretty_json_stringify($JSON_OBJECT{"foo"}{"bar"}) . "\n");
# JSON_OBJECT?.foo?.bar: "baz"
print("JSON_OBJECT?.foo?.baz: " . pretty_json_stringify($JSON_OBJECT{"foo"}{"baz"}) . "\n");
# JSON_OBJECT?.foo?.baz: null

print("JSON_OBJECT?.fruits?.[2]: " . pretty_json_stringify($JSON_OBJECT{"fruits"}[2]) . "\n");
# JSON_OBJECT?.fruits?.[2]: "banana"
print("JSON_OBJECT?.fruits?.[5]: " . pretty_json_stringify($JSON_OBJECT{"fruits"}[5]) . "\n");
# JSON_OBJECT?.fruits?.[5]: null
