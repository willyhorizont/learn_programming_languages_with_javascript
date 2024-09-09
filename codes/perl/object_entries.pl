use strict;
use warnings;
use Scalar::Util qw(looks_like_number);

sub json_stringify {
    my ($anything_ref, %additional_parameter) = @_;
    my $pretty = $additional_parameter{"pretty"} // 0;
    my $indent = $additional_parameter{"indent"} // "    ";
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

# There's no JavaScript-like Object.entries() in Perl.
# But, we can create our own function to mimic it in Perl.

sub object_entries {
    # JavaScript-like Object.entries() function
    my ($an_object_ref) = @_;
    my @new_array = ();
    my %an_object = %{$an_object_ref};
    foreach my $object_key (keys(%an_object)) {
        my $object_value = $an_object{$object_key};
        @new_array = (@new_array, [$object_key, $object_value]);
    }
    return @new_array;
}

print("\n# JavaScript-like Object.entries() in Perl Hash", "\n");

my %friend = (
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
);
print("friend: ", json_stringify(\%friend, "pretty" => 1), "\n");

print("# using JavaScript-like Object.entries() function \"object_entries\"\n");

print("friend entries: ", json_stringify([object_entries(\%friend)]), "\n");
# friend entries: [["name", "Alisa"], ["country", "Finland"], ["age", 25]]

my $friend_ref = {
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
};
print("friend_ref: ", json_stringify($friend_ref, "pretty" => 1), "\n");

print("# using JavaScript-like Object.entries() function \"object_entries\"\n");

print("friend_ref entries: ", json_stringify([object_entries($friend_ref)]), "\n");
# friend_ref entries: [["name", "Alisa"], ["country", "Finland"], ["age", 25]]
