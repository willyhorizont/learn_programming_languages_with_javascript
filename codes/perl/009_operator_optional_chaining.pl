use strict;
use warnings;

print("\n# JavaScript-like Optional Chaining Operator (?.) in Perl", "\n");

sub json_stringify {
    use JSON;
    my ($anything_ref, %additional_parameter) = @_;
    my $pretty = $additional_parameter{"pretty"} // 0;
    my $indent = $additional_parameter{"indent"} // "    ";
    return JSON->new->allow_nonref->space_after->encode($anything_ref) if ($pretty == 0);
    my $json_string_pretty = JSON->new->allow_nonref->pretty->encode($anything_ref);
    $json_string_pretty =~ s/   /$indent/g;
    $json_string_pretty =~ s/\n$//g;
    return $json_string_pretty;
}

# There's no JavaScript-like Optional Chaining Operator (?.) in Perl.
# But, we don't need that in Perl.

my %JSON_OBJECT = (
    "foo" => {
        "bar" => "baz"
    },
    "fruits" => ["apple", "mango", "banana"]
);
print("JSON_OBJECT: ", json_stringify(\%JSON_OBJECT, "pretty" => 1), "\n");

print("JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: ", json_stringify($JSON_OBJECT{"foo"}{"bar"}), "\n");
# JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: "baz"

print("JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: ", json_stringify($JSON_OBJECT{"foo"}{"baz"}), "\n");
# JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: null

print("JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: ", json_stringify($JSON_OBJECT{"fruits"}[2]), "\n");
# JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: "banana"

print("JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: ", json_stringify($JSON_OBJECT{"fruits"}[5]), "\n");
# JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: null
