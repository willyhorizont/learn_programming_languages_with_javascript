<?php

// while loop

$i = 1;
while (true) {
    if ($i === 2) {
        if ($i >= 5) break;
        $i += 1;
        continue;
    }
    echo("\n" . "while loop v1, i is " . $i);
    if ($i >= 5) break;
    $i += 1;
}

$i = 1;
while ($i <= 5) {
    if ($i === 2) {
        $i += 1;
        continue;
    }
    echo("\n" . "while loop v2, i is " . $i);
    $i += 1;
}

// for loop

for ($i = 1; $i <= 5; $i += 1) {
    if ($i === 2) continue;
    echo("\n" . "for loop, i is " . $i);
}

// foreach loop

foreach (range(1, 5, 1) as $i) { // (start, stop, step)
    if ($i === 2) continue;
    echo("\n" . "foreach loop ascending, i is " . $i);
}

foreach (range(5, 1, -1) as $i) { // (start, stop, step)
    if ($i === 2) continue;
    echo("\n" . "foreach loop descending, i is " . $i);
}
