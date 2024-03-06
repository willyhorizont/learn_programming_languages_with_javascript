use strict;
use warnings;
use JSON;
use Scalar::Util qw(looks_like_number);

print("\n# Factorial(n) in Perl\n");

sub factorial_v1 {
    my ($number) = @_;
    return "argument should be a number" if !(looks_like_number($number));
    return 1 if !($number > 1);
    my $result = 1;
    my $i = $number;
    while (1) {
        $result *= $i;
        $i -= 1;
        last if ($i <= 0);
    }
    return $result;
}

sub factorial_v2 {
    my ($number) = @_;
    return "argument should be a number" if !(looks_like_number($number));
    return 1 if !($number > 1);
    my $result = 1;
    my $i = $number;
    while ($i >= 1) {
        $result *= $i;
        $i -= 1;
    }
    return $result;
}

sub factorial_v3 {
    my ($number) = @_;
    return "argument should be a number" if !(looks_like_number($number));
    return 1 if !($number > 1);
    my $result = 1;
    for (my $i = $number; $i >= 1; $i -= 1) {
        $result *= $i;
    }
    return $result;
}

print("# using factorial function \"factorial_v1\"\n");
print("Factorial(5): " . factorial_v1(5) . "\n");
# Factorial(5): 120

print("# using factorial function \"factorial_v2\"\n");
print("Factorial(5): " . factorial_v2(5) . "\n");
# Factorial(5): 120

print("# using factorial function \"factorial_v3\"\n");
print("Factorial(5): " . factorial_v3(5) . "\n");
# Factorial(5): 120
