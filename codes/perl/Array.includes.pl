use strict;
use warnings;
use JSON;
use Scalar::Util qw(looks_like_number);

# There's no JavaScript-like Array.includes() in Perl.
# But, we can create our own function to mimic it in Perl.

sub pretty_array_of_primitives {
    my $number_of_parameters = @_;
    my $result = "[";
    for (my $array_item_index = 0; $array_item_index < $number_of_parameters; $array_item_index += 1) {
        my $array_item = $_[$array_item_index];
        my $is_string = (defined($array_item) && ref($array_item) eq "");
        my $is_number = looks_like_number($array_item);
        last if (!$is_string && !$is_number);
        $result = $result . "\"" . $array_item . "\"" if ($is_string && !$is_number);
        $result = $result . $array_item if ($is_number);
        $result = $result . ", " if (($array_item_index + 1) != $number_of_parameters);
    }
    $result = $result . "]";
    return $result;
}

sub array_includes_v1 {
    # JavaScript-like Array.includes() function
    my ($search_element, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    my $element_found = 0;
    for my $array_item (@an_array) {
        my $is_condition_match = looks_like_number($array_item) ? $array_item == $search_element : $array_item eq $search_element;
        if ($is_condition_match) {
            $element_found = 1;
            last;
        }
    }
    return $element_found;
}

sub array_includes_v2 {
    # JavaScript-like Array.includes() function
    my ($search_element, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    my $element_found = 0;
    for my $array_item (@an_array) {
        if (looks_like_number($array_item) ? $array_item == $search_element : $array_item eq $search_element) {
            $element_found = 1;
            last;
        }
    }
    return $element_found;
}

sub array_includes_v3 {
    # JavaScript-like Array.includes() function
    my ($search_element, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    my $element_found = 0;
    for my $array_item (@an_array) {
        my $is_condition_match = looks_like_number($array_item) ? $array_item == $search_element : $array_item eq $search_element;
        if ($is_condition_match) {
            $element_found = 1;
            return $element_found;
        }
    }
    return $element_found;
}

sub array_includes_v4 {
    # JavaScript-like Array.includes() function
    my ($search_element, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    my $element_found = 0;
    for my $array_item (@an_array) {
        if (looks_like_number($array_item) ? $array_item == $search_element : $array_item eq $search_element) {
            $element_found = 1;
            return $element_found;
        }
    }
    return $element_found;
}

sub array_includes_v5 {
    # JavaScript-like Array.includes() function
    my ($search_element, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    for my $array_item (@an_array) {
        my $is_condition_match = looks_like_number($array_item) ? $array_item == $search_element : $array_item eq $search_element;
        if ($is_condition_match) {
            return 1;
        }
    }
    return 0;
}

sub array_includes_v6 {
    # JavaScript-like Array.includes() function
    my ($search_element, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    for my $array_item (@an_array) {
        if (looks_like_number($array_item) ? $array_item == $search_element : $array_item eq $search_element) {
            return 1;
        }
    }
    return 0;
}

sub array_includes_v7 {
    # JavaScript-like Array.includes() function
    my ($search_element, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    my $element_found = 0;
    for my $array_item (@an_array) {
        my $is_condition_match = looks_like_number($array_item) ? $array_item == $search_element : $array_item eq $search_element;
        return 1 if ($is_condition_match);
    }
    return $element_found;
}

sub array_includes_v8 {
    # JavaScript-like Array.includes() function
    my ($search_element, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    my $element_found = 0;
    for my $array_item (@an_array) {
        return 1 if (looks_like_number($array_item) ? $array_item == $search_element : $array_item eq $search_element);
    }
    return $element_found;
}

sub array_includes_v9 {
    # JavaScript-like Array.includes() function
    my ($search_element, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    for my $array_item (@an_array) {
        my $is_condition_match = looks_like_number($array_item) ? $array_item == $search_element : $array_item eq $search_element;
        return 1 if ($is_condition_match);
    }
    return 0;
}

sub array_includes_v10 {
    # JavaScript-like Array.includes() function
    my ($search_element, $an_array_ref) = @_;
    my @an_array = @{$an_array_ref};
    for my $array_item (@an_array) {
        return 1 if (looks_like_number($array_item) ? $array_item == $search_element : $array_item eq $search_element);
    }
    return 0;
}

print("\n# JavaScript-like Array.includes() in Perl\n");

my @my_friends = ("Alisa", "Trivia");
print("my friends: ", pretty_array_of_primitives(@my_friends), "\n");

my $name;
my $is_my_friend;

print("# using JavaScript-like Array.includes() function \"array_includes_v1\"\n");

$name = "Alisa";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v1($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Alisa": true

$name = "Trivia";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v1($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Trivia": true

$name = "Tony";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v1($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Tony": false

$name = "Ezekiel";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v1($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Ezekiel": false

print("# using JavaScript-like Array.includes() function \"array_includes_v2\"\n");

$name = "Alisa";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v2($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Alisa": true

$name = "Trivia";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v2($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Trivia": true

$name = "Tony";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v2($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Tony": false

$name = "Ezekiel";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v2($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Ezekiel": false

print("# using JavaScript-like Array.includes() function \"array_includes_v3\"\n");

$name = "Alisa";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v3($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Alisa": true

$name = "Trivia";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v3($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Trivia": true

$name = "Tony";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v3($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Tony": false

$name = "Ezekiel";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v3($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Ezekiel": false

print("# using JavaScript-like Array.includes() function \"array_includes_v4\"\n");

$name = "Alisa";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v4($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Alisa": true

$name = "Trivia";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v4($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Trivia": true

$name = "Tony";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v4($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Tony": false

$name = "Ezekiel";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v4($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Ezekiel": false

print("# using JavaScript-like Array.includes() function \"array_includes_v5\"\n");

$name = "Alisa";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v5($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Alisa": true

$name = "Trivia";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v5($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Trivia": true

$name = "Tony";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v5($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Tony": false

$name = "Ezekiel";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v5($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Ezekiel": false

print("# using JavaScript-like Array.includes() function \"array_includes_v6\"\n");

$name = "Alisa";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v6($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Alisa": true

$name = "Trivia";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v6($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Trivia": true

$name = "Tony";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v6($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Tony": false

$name = "Ezekiel";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v6($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Ezekiel": false

print("# using JavaScript-like Array.includes() function \"array_includes_v7\"\n");

$name = "Alisa";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v7($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Alisa": true

$name = "Trivia";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v7($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Trivia": true

$name = "Tony";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v7($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Tony": false

$name = "Ezekiel";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v7($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Ezekiel": false

print("# using JavaScript-like Array.includes() function \"array_includes_v8\"\n");

$name = "Alisa";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v8($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Alisa": true

$name = "Trivia";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v8($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Trivia": true

$name = "Tony";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v8($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Tony": false

$name = "Ezekiel";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v8($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Ezekiel": false

print("# using JavaScript-like Array.includes() function \"array_includes_v9\"\n");

$name = "Alisa";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v9($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Alisa": true

$name = "Trivia";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v9($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Trivia": true

$name = "Tony";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v9($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Tony": false

$name = "Ezekiel";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v9($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Ezekiel": false

print("# using JavaScript-like Array.includes() function \"array_includes_v10\"\n");

$name = "Alisa";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v10($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Alisa": true

$name = "Trivia";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v10($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Trivia": true

$name = "Tony";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v10($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Tony": false

$name = "Ezekiel";
print("name: \"$name\"\n");
$is_my_friend = array_includes_v10($name, \@my_friends) ? "true" : "false";
print("is my friends includes \"$name\": $is_my_friend\n");
# is my friends includes "Ezekiel": false
