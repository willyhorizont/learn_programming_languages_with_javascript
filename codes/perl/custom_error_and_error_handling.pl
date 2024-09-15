use strict;
use warnings;
use Try::Tiny; # https://metacpan.org/pod/Try::Tiny

print("\n# Custom Error and Error Handling in Perl", "\n");

sub give_me_respect {
    my ($argument) = @_;
    # Custom Error
    die("Error: You should give me \"respect\"!") if ($argument ne "respect");
    return "Thank you for giving me \"respect\"!";
}

my $response;

# Error Handling using 3rd party module "Try::Tiny"
# https://metacpan.org/pod/Try::Tiny
try {
    $response = give_me_respect("boo!");
    print($response, "\n");
} catch {
    print($_, "\n");
};
print("I'm sorry!", "\n");

# Without Error Handling
$response = give_me_respect("boo!");
# this will never executed
print($response, "\n");
print("I'm sorry!");
