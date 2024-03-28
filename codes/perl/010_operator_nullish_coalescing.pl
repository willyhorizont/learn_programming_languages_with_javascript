use strict;
use warnings;

print("\n# JavaScript-like Nullish Coalescing Operator (??) in Perl\n");

sub pretty_json_stringify {
    my ($anything) = @_;
    use JSON;
    my $pretty_json_string = JSON->new->allow_nonref->pretty->encode($anything);
    $pretty_json_string =~ s/   /    /g;
    $pretty_json_string =~ s/\n$//g;
    return $pretty_json_string;
}

# There's no JavaScript-like Nullish Coalescing Operator (??) in Perl.
# But, we can create our own function to mimic it in Perl.

sub nullish_coalescing {
    # JavaScript-like Nullish Coalescing Operator (??) function
    my ($value, $default_value) = @_;
    die("Required parameter not provided") unless defined($default_value);
    return (!$value ? $default_value : $value);
}

my %JSON_OBJECT = (
    "foo" => {
        "bar" => "baz"
    },
    "fruits" => ["apple", "mango", "banana"]
);
print("JSON_OBJECT: " . pretty_json_stringify(\%JSON_OBJECT) . "\n");

print("(JSON_OBJECT?.foo?.bar ?? 'not found') or (JSON_OBJECT?.['foo']?.['bar'] ?? 'not found'): " . pretty_json_stringify(nullish_coalescing($JSON_OBJECT{"foo"}{"bar"}, "not found")) . "\n");
# (JSON_OBJECT?.foo?.bar ?? 'not found') or (JSON_OBJECT?.['foo']?.['bar'] ?? 'not found'): "baz"
print("(JSON_OBJECT?.foo?.baz ?? 'not found') or (JSON_OBJECT?.['foo']?.['baz'] ?? 'not found'): " . pretty_json_stringify(nullish_coalescing($JSON_OBJECT{"foo"}{"baz"}, "not found")) . "\n");
# (JSON_OBJECT?.foo?.baz ?? 'not found') or (JSON_OBJECT?.['foo']?.['baz'] ?? 'not found'): "not found"

print("(JSON_OBJECT?.fruits?.[2] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[2] ?? 'not found'): " . pretty_json_stringify(nullish_coalescing($JSON_OBJECT{"fruits"}[2], "not found")) . "\n");
# (JSON_OBJECT?.fruits?.[2] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[2] ?? 'not found'): "banana"
print("(JSON_OBJECT?.fruits?.[5] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[5] ?? 'not found'): " . pretty_json_stringify(nullish_coalescing($JSON_OBJECT{"fruits"}[5], "not found")) . "\n");
# (JSON_OBJECT?.fruits?.[5] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[5] ?? 'not found'): "not found"
