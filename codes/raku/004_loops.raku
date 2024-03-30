# while loop

my $i1 = 1;
while (True) {
    if ($i1 === 2) {
        last if ($i1 >= 5);
        $i1 += 1;
        next;
    }
    print("while loop v1, \$i1 is {$i1}", "\n");
    last if ($i1 >= 5);
    $i1 += 1;
}

my $i2 = 1;
while ($i2 <= 5) {
    if ($i2 === 2) {
        $i2 += 1;
        next;
    }
    print("while loop v2, \$i2 is {$i2}", "\n");
    $i2 += 1;
}

my $i3 = 1;
until (False) {
    if ($i3 === 2) {
        last if ($i3 >= 5);
        $i3 += 1;
        next;
    }
    print("while loop v3, \$i3 is {$i3}", "\n");
    last if ($i3 >= 5);
    $i3 += 1;
}

my $i4 = 1;
# until === while not True
# until (($i4 <= 5) === False)
until ($i4 > 5) {
    if ($i4 === 2) {
        $i4 += 1;
        next;
    }
    print("while loop v4, \$i4 is {$i4}", "\n");
    $i4 += 1;
}

my $i5 = 1;
loop {
    if ($i5 === 2) {
        last if ($i5 >= 5);
        $i5 += 1;
        next;
    }
    print("while loop v5, \$i5 is {$i5}", "\n");
    last if ($i5 >= 5);
    $i5 += 1;
}

# for loop

loop (my $i6 = 1; $i6 <= 10; $i6 += 1) {
    last if ($i6 > 5);
    next if ($i6 === 2);
    print("for loop v1, \$i6 is {$i6}", "\n");
}

# for loop and also foreach loop

for (1...10) -> $i7 {
    last if ($i7 > 5);
    next if ($i7 === 2);
    print("for loop v2 ascending, \$i7 is {$i7}", "\n");
}

for (10...1) -> $i8 {
    last if ($i8 <= 5);
    next if ($i8 === 9);
    print("for loop v2 descending, \$i8 is {$i8}", "\n");
}
