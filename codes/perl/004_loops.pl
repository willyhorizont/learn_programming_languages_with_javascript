use strict;
use warnings;

# while loop

my $i1 = 1;
while (1) {
    if ($i1 == 2) {
        $i1 += 1;
        last if ($i1 > 5);
        next;
    }
    print("while loop v1, \$i1 is $i1\n");
    $i1 += 1;
    last if ($i1 > 5);
}

my $i2 = 1;
while ($i2 <= 5) {
    if ($i2 == 2) {
        $i2 += 1;
        next;
    }
    print("while loop v2, \$i2 is $i2\n");
    $i2 += 1;
}

# for loop

for (my $i3 = 1; $i3 <= 5; $i3 += 1) {
    next if ($i3 == 2);
    print("for loop, \$i3 is $i3\n");
}
