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

# There's no JavaScript-like Array.includes() in Perl.
# But, we can create our own function to mimic it in Perl.

sub array_includes_v1 {
    # JavaScript-like Array.includes() function
    my ($search_element, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    my $is_element_found = 0;
    for my $array_item (@an_array) {
        my $is_condition_match = ((looks_like_number($array_item) && looks_like_number($search_element)) ? ($array_item == $search_element) : $array_item eq $search_element);
        if ($is_condition_match) {
            $is_element_found = 1;
            last;
        }
    }
    return $is_element_found;
}

sub array_includes_v2 {
    # JavaScript-like Array.includes() function
    my ($search_element, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    my $is_element_found = 0;
    for my $array_item (@an_array) {
        if ((looks_like_number($array_item) && looks_like_number($search_element)) ? ($array_item == $search_element) : $array_item eq $search_element) {
            $is_element_found = 1;
            last;
        }
    }
    return $is_element_found;
}

sub array_includes_v3 {
    # JavaScript-like Array.includes() function
    my ($search_element, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    for my $array_item (@an_array) {
        my $is_condition_match = ((looks_like_number($array_item) && looks_like_number($search_element)) ? ($array_item == $search_element) : $array_item eq $search_element);
        return 1 if ($is_condition_match);
    }
    return 0;
}

sub array_includes_v4 {
    # JavaScript-like Array.includes() function
    my ($search_element, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    for my $array_item (@an_array) {
        return 1 if ((looks_like_number($array_item) && looks_like_number($search_element)) ? ($array_item == $search_element) : $array_item eq $search_element);
    }
    return 0;
}

sub is_false {
    my ($anything) = @_;
    return (($anything == 0) || ($anything eq "0") || !defined($anything) || ($anything eq "") || (ref($anything) eq "ARRAY" && scalar(@{$anything}) == 0));
}

sub bool_to_string {
    my ($anything) = @_;
    return (is_false($anything) ? "false" : "true");
}

print("\n# JavaScript-like Array.includes() in Perl", "\n");

my @my_friends = ("Alisa", "Trivia");
print("my friends: ", json_stringify(\@my_friends), "\n");

my $name;
my $is_my_friend;

print("# using JavaScript-like Array.includes() function \"array_includes_v1\"\n");

$name = "Alisa";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v1($name, \@my_friends);
print("is my friends includes \"$name\": ", bool_to_string($is_my_friend), "\n");
# is my friends includes "Alisa": true

$name = "Trivia";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v1($name, \@my_friends);
print("is my friends includes \"$name\": ", bool_to_string($is_my_friend), "\n");
# is my friends includes "Trivia": true

$name = "Tony";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v1($name, \@my_friends);
print("is my friends includes \"$name\": ", bool_to_string($is_my_friend), "\n");
# is my friends includes "Tony": false

$name = "Ezekiel";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v1($name, \@my_friends);
print("is my friends includes \"$name\": ", bool_to_string($is_my_friend), "\n");
# is my friends includes "Ezekiel": false

print("# using JavaScript-like Array.includes() function \"array_includes_v2\"\n");

$name = "Alisa";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v2($name, \@my_friends);
print("is my friends includes \"$name\": ", bool_to_string($is_my_friend), "\n");
# is my friends includes "Alisa": true

$name = "Trivia";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v2($name, \@my_friends);
print("is my friends includes \"$name\": ", bool_to_string($is_my_friend), "\n");
# is my friends includes "Trivia": true

$name = "Tony";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v2($name, \@my_friends);
print("is my friends includes \"$name\": ", bool_to_string($is_my_friend), "\n");
# is my friends includes "Tony": false

$name = "Ezekiel";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v2($name, \@my_friends);
print("is my friends includes \"$name\": ", bool_to_string($is_my_friend), "\n");
# is my friends includes "Ezekiel": false

print("# using JavaScript-like Array.includes() function \"array_includes_v3\"\n");

$name = "Alisa";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v3($name, \@my_friends);
print("is my friends includes \"$name\": ", bool_to_string($is_my_friend), "\n");
# is my friends includes "Alisa": true

$name = "Trivia";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v3($name, \@my_friends);
print("is my friends includes \"$name\": ", bool_to_string($is_my_friend), "\n");
# is my friends includes "Trivia": true

$name = "Tony";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v3($name, \@my_friends);
print("is my friends includes \"$name\": ", bool_to_string($is_my_friend), "\n");
# is my friends includes "Tony": false

$name = "Ezekiel";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v3($name, \@my_friends);
print("is my friends includes \"$name\": ", bool_to_string($is_my_friend), "\n");
# is my friends includes "Ezekiel": false

print("# using JavaScript-like Array.includes() function \"array_includes_v4\"\n");

$name = "Alisa";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v4($name, \@my_friends);
print("is my friends includes \"$name\": ", bool_to_string($is_my_friend), "\n");
# is my friends includes "Alisa": true

$name = "Trivia";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v4($name, \@my_friends);
print("is my friends includes \"$name\": ", bool_to_string($is_my_friend), "\n");
# is my friends includes "Trivia": true

$name = "Tony";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v4($name, \@my_friends);
print("is my friends includes \"$name\": ", bool_to_string($is_my_friend), "\n");
# is my friends includes "Tony": false

$name = "Ezekiel";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v4($name, \@my_friends);
print("is my friends includes \"$name\": ", bool_to_string($is_my_friend), "\n");
# is my friends includes "Ezekiel": false
