use strict;
use warnings;
use Scalar::Util qw(looks_like_number);

print("\n# JavaScript-like Optional Chaining Operator (?.) in Perl", "\n");

sub json_stringify {
    my ($anything_ref, %optionalar_gument) = @_;
    my $pretty = $optionalar_gument{"pretty"} // 0;
    my $indent = $optionalar_gument{"indent"} // "    ";
    my $indent_level = 0;
    my $json_stringify_inner;
    $json_stringify_inner = sub {
        my ($anything_inner_ref, $indent_inner) = @_;
        return "null" if (!defined($anything_inner_ref));
        return "$anything_inner_ref" if looks_like_number($anything_inner_ref);
        return "\"" . $anything_inner_ref . "\"" if (ref($anything_inner_ref) eq "");
        if (ref($anything_inner_ref) eq "ARRAY") {
            return "[]" if (scalar(@{$anything_inner_ref}) == 0);
            $indent_level += 1;
            my $result = (!$pretty ? "[" : ("[\n" . ($indent_inner x $indent_level)));
            for my $array_item_index (0..(scalar(@{$anything_inner_ref}) - 1)) {
                my $array_item = $anything_inner_ref->[$array_item_index];
                $result .= $json_stringify_inner->($array_item, $indent_inner);
                $result .= (!$pretty ? ", " : (",\n" . ($indent_inner x $indent_level))) if (($array_item_index + 1) != scalar(@{$anything_inner_ref}));
            }
            $indent_level -= 1;
            $result .= (!$pretty ? "]" : ("\n" . ($indent_inner x $indent_level) . "]"));
            return $result;
        }
        if (ref($anything_inner_ref) eq "HASH") {
            return "{}" if (scalar(keys(%{$anything_inner_ref})) == 0);
            $indent_level += 1;
            my $result = (!$pretty ? "{" : ("{\n" . ($indent_inner x $indent_level)));
            my $object_entry_index = 0;
            foreach my $object_key (keys(%{$anything_inner_ref})) {
                my $object_value = $anything_inner_ref->{$object_key};
                $result .= "\"" . $object_key . "\": " . $json_stringify_inner->($object_value, $indent_inner);
                $result .= (!$pretty ? ", " : (",\n" . ($indent_inner x $indent_level))) if (($object_entry_index + 1) != scalar(keys(%{$anything_inner_ref})));
                $object_entry_index += 1;
            }
            $indent_level -= 1;
            $result .= (!$pretty ? "}" : ("\n" . ($indent_inner x $indent_level) . "}"));
            return $result;
        }
        return "null";
    };
    return $json_stringify_inner->($anything_ref, $indent);
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
