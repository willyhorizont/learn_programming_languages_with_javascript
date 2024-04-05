use strict;
use warnings;
use Scalar::Util qw(looks_like_number);

# There's no JavaScript-like Array.includes() in Perl.
# But, we can create our own function to mimic it in Perl.

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

sub is_false {
    my ($anything) = @_;
    return (($anything == 0) || ($anything eq "0") || !defined($anything) || ($anything eq "") || (ref($anything) eq "ARRAY" && scalar(@{$anything}) == 0));
}

sub bool_to_string {
    my ($anything) = @_;
    return (is_false($anything) ? "false" : "true");
}

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
