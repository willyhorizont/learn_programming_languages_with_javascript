use strict;
use warnings;
use Scalar::Util qw(looks_like_number);

print("\n# Factorial(n) in Perl", "\n");

sub factorial_v1 {
    my ($number) = @_;
    die("Argument should be a number") if !(looks_like_number($number));
    die("Argument should be >= 0") if ($number < 0);
    return 1 if ($number == 0);
    my $result = 1;
    my $i = $number;
    while (1) {
        $result *= $i;
        last if ($i <= 1);
        $i -= 1;
    }
    return $result;
}

sub factorial_v2 {
    my ($number) = @_;
    die("Argument should be a number") if !(looks_like_number($number));
    die("Argument should be >= 0") if ($number < 0);
    return 1 if ($number == 0);
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
    die("Argument should be a number") if !(looks_like_number($number));
    die("Argument should be >= 0") if ($number < 0);
    return 1 if ($number == 0);
    my $result = 1;
    for (my $i = $number; $i >= 1; $i -= 1) {
        $result *= $i;
    }
    return $result;
}

sub factorial_v4 {
    my ($number) = @_;
    die("Argument should be a number") if !(looks_like_number($number));
    die("Argument should be >= 0") if ($number < 0);
    return 1 if ($number == 0);
    return ($number * factorial_v4($number - 1));
}

print("# using factorial function \"factorial_v1\"\n");
print("Factorial(5): ", factorial_v1(5), "\n");
# Factorial(5): 120

print("# using factorial function \"factorial_v2\"\n");
print("Factorial(5): ", factorial_v2(5), "\n");
# Factorial(5): 120

print("# using factorial function \"factorial_v3\"\n");
print("Factorial(5): ", factorial_v3(5), "\n");
# Factorial(5): 120

print("# using factorial function \"factorial_v4\"\n");
print("Factorial(5): ", factorial_v4(5), "\n");
# Factorial(5): 120
