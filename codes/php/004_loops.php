<?php

// while loop

$i = 1;
while (true) {
    if ($i === 2) {
        if ($i >= 5) break;
        $i += 1;
        continue;
    }
    echo("while loop v1, i is " . $i . "\n");
    if ($i >= 5) break;
    $i += 1;
}

$i = 1;
while ($i <= 5) {
    if ($i === 2) {
        $i += 1;
        continue;
    }
    echo("while loop v2, i is " . $i . "\n");
    $i += 1;
}

// for loop

for ($i = 1; $i <= 10; $i += 1) {
    if ($i > 5) break;
    if ($i === 2) continue;
    echo("for loop, i is " . $i . "\n");
}

// forEach loop

foreach (range(1, 10, 1) as $i) { // (start, stop, step)
    if ($i > 5) break;
    if ($i === 2) continue;
    echo("forEach loop ascending, i is " . $i . "\n");
}

foreach (range(10, 1, -1) as $i) { // (start, stop, step)
    if ($i <= 5) break;
    if ($i === 9) continue;
    echo("forEach loop descending, i is " . $i . "\n");
}
