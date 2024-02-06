# while loop

my $i1 = 1;
while (True) {
    if ($i1 == 2) {
        $i1 += 1;
        last if ($i1 > 5);
        next;
    }
    print("while loop v1, \$i1 is {$i1}\n");
    $i1 += 1;
    last if ($i1 > 5);
}

my $i2 = 1;
loop {
    if ($i2 == 2) {
        $i2 += 1;
        last if ($i2 > 5);
        next;
    }
    print("while loop v2, \$i2 is {$i2}\n");
    $i2 += 1;
    last if ($i2 > 5);
}

my $i3 = 1;
while ($i3 <= 5) {
    if ($i3 == 2) {
        $i3 += 1;
        next;
    }
    print("while loop v3, \$i3 is {$i3}\n");
    $i3 += 1;
}

# for loop

loop (my $i4 = 1; $i4 <= 5; $i4 += 1) {
    next if ($i4 == 2);
    print("for loop v1, \$i4 is {$i4}\n");
}

for (1..5) {
    next if ($_ == 2);
    print("for loop v2 ascending, \$_ is {$_}\n");
}

for (1..5) -> $i5 {
    next if ($i5 == 2);
    print("for loop v2 ascending, \$i5 is {$i5}\n");
}

for (1...5) -> $i6 {
    next if ($i6 == 2);
    print("for loop v2 ascending, \$i6 is {$i6}\n");
}

for (5...1) -> $i7 {
    next if ($i7 == 2);
    print("for loop v2 descending, \$i7 is {$i7}\n");
}
