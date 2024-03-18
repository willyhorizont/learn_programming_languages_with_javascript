use strict;
use warnings;
use Try::Tiny; # https://metacpan.org/pod/Try::Tiny

print("\n# Custom Error and Error Handling in Perl\n");

sub give_me_respect {
    my ($parameter) = @_;
    # Custom Error
    die("Error: You should give me \"respect\"!") if ($parameter ne "respect");
    return "Thank you for giving me \"respect\"!";
}

my $response;

# Error Handling using 3rd party module "Try::Tiny"
# https://metacpan.org/pod/Try::Tiny
try {
    $response = give_me_respect("bool!");
    print($response . "\n");
} catch {
    print($_ . "\n");
};
print("I'm sorry!" . "\n");

# Without Error Handling
$response = give_me_respect("bool!");
# this will never executed
print($response . "\n");
print("I'm sorry!");
