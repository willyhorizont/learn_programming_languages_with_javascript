use strict;
use warnings;
use Scalar::Util qw(looks_like_number);

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

# There's no JavaScript-like Object.fromEntries() in Perl.
# But, we can create our own function to mimic it in Perl.

sub object_from_entries {
    # JavaScript-like Object.fromEntries() function
    my ($an_object_entries_ref) = @_;
    my %new_object;
    my @object_entries = @{$an_object_entries_ref};
    for (my $array_item_index = 0; $array_item_index < scalar(@object_entries); $array_item_index += 1) {
        my $object_entry_ref = $object_entries[$array_item_index];
        my @object_entry = @{$object_entry_ref};
        my $object_key = $object_entry[0];
        my $object_value = $object_entry[1];
        $new_object{"$object_key"} = $object_value;
    }
    return %new_object;
}

print("\n# JavaScript-like Object.fromEntries() in Perl Hash", "\n");

my @friend_entries = (["name", "Alisa"], ["country", "Finland"], ["age", 25]);
print("friend entries: ", json_stringify(\@friend_entries, "pretty" => 1), "\n");

print("# using JavaScript-like Object.fromEntries() function \"object_from_entries\"\n");

print("friend object from friend entries: ", json_stringify({object_from_entries(\@friend_entries)}, "pretty" => 1), "\n");
# friend object from friend entries: {
#     "name": "Alisa",
#     "country": "Finland",
#     "age": 25
# }

my $friend_entries_ref = [["name", "Alisa"], ["country", "Finland"], ["age", 25]];
print("friend entries: ", json_stringify($friend_entries_ref, "pretty" => 1), "\n");

print("# using JavaScript-like Object.fromEntries() function \"object_from_entries\"\n");

print("friend object from friend entries: ", json_stringify({object_from_entries($friend_entries_ref)}, "pretty" => 1), "\n");
# friend object from friend entries: {
#     "name": "Alisa",
#     "country": "Finland",
#     "age": 25
# }
