print("\n# Factorial(n) in Raku", "\n");

sub factorial-v1(Int $number) {
    die("Argument should be >= 0") if ($number < 0);
    return 1 if ($number === 0);
    my $result = 1;
    my $i = $number;
    while (True) {
        $result *= $i;
        last if ($i <= 1);
        $i -= 1;
    }
    return $result;
}

sub factorial-v2(Int $number) {
    die("Argument should be >= 0") if ($number < 0);
    return 1 if ($number === 0);
    my $result = 1;
    my $i = $number;
    loop {
        $result *= $i;
        last if ($i <= 1);
        $i -= 1;
    }
    return $result;
}

sub factorial-v3(Int $number) {
    die("Argument should be >= 0") if ($number < 0);
    return 1 if ($number === 0);
    my $result = 1;
    my $i = $number;
    while ($i >= 1) {
        $result *= $i;
        $i -= 1;
    }
    return $result;
}

sub factorial-v4(Int $number) {
    die("Argument should be >= 0") if ($number < 0);
    return 1 if ($number === 0);
    my $result = 1;
    loop (my $i = $number; $i >= 1; $i -= 1) {
        $result *= $i;
    }
    return $result;
}

sub factorial-v5(Int $number) {
    die("Argument should be >= 0") if ($number < 0);
    return 1 if ($number === 0);
    my $result = 1;
    for ($number...1) -> $i {
        $result *= $i;
    }
    return $result;
}

sub factorial-v6(Int $number) {
    die("Argument should be >= 0") if ($number < 0);
    return 1 if ($number === 0);
    return ($number * factorial-v4($number - 1));
}

print("# using factorial function \"factorial-v1\"\n");
print("Factorial(5): ", factorial-v1(5), "\n");
# Factorial(5): 120

print("# using factorial function \"factorial-v2\"\n");
print("Factorial(5): ", factorial-v2(5), "\n");
# Factorial(5): 120

print("# using factorial function \"factorial-v3\"\n");
print("Factorial(5): ", factorial-v3(5), "\n");
# Factorial(5): 120

print("# using factorial function \"factorial-v4\"\n");
print("Factorial(5): ", factorial-v4(5), "\n");
# Factorial(5): 120

print("# using factorial function \"factorial-v5\"\n");
print("Factorial(5): ", factorial-v5(5), "\n");
# Factorial(5): 120

print("# using factorial function \"factorial-v6\"\n");
print("Factorial(5): ", factorial-v6(5), "\n");
# Factorial(5): 120
