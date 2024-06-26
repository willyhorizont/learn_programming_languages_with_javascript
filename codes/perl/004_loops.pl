use strict;
use warnings;

# while loop

my $i1 = 1;
while (1) {
    if ($i1 == 2) {
        last if ($i1 >= 5);
        $i1 += 1;
        next;
    }
    print("while loop v1, \$i1 is ", $i1, "\n");
    last if ($i1 >= 5);
    $i1 += 1;
}

my $i2 = 1;
while ($i2 <= 5) {
    if ($i2 == 2) {
        $i2 += 1;
        next;
    }
    print("while loop v2, \$i2 is ", $i2, "\n");
    $i2 += 1;
}

# for loop

for (my $i3 = 1; $i3 <= 10; $i3 += 1) {
    last if ($i3 > 5);
    next if ($i3 == 2);
    print("for loop v1, \$i3 is ", $i3, "\n");
}

for my $i4 (1..10) {
    last if ($i4 > 5);
    next if ($i4 == 2);
    print("for loop v2 ascending, \$i4 is ", $i4, "\n");
}

for my $i5 (reverse(1..10)) {
    last if ($i5 <= 5);
    next if ($i5 == 9);
    print("for loop v2 descending, \$i5 is ", $i5, "\n");
}

foreach my $i6 (1..10) {
    last if ($i6 > 5);
    next if ($i6 == 2);
    print("for loop v3 ascending, \$i6 is ", $i6, "\n");
}

foreach my $i7 (reverse(1..10)) {
    last if ($i7 <= 5);
    next if ($i7 == 9);
    print("for loop v3 descending, \$i7 is ", $i7, "\n");
}
