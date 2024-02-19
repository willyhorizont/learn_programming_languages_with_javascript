#![allow(unused_variables)]
#![allow(unused_parens)]
#![allow(dead_code)]
#![allow(while_true)]

fn main() {
    // while loop

    let mut i1 = 1;
    while (true) {
        if (i1 == 2) {
            i1 += 1;
            if (i1 > 5){
                break;
            }
            continue;
        }
        println!("while loop v1, i1 is {i1}");
        i1 += 1;
        if (i1 > 5){
            break;
        }
    }

    let mut i2 = 1;
    while (i2 <= 5) {
        if (i2 == 2) {
            i2 += 1;
            continue;
        }
        println!("while loop v2, i2 is {i2}");
        i2 += 1;
    }

    let mut i3 = 1;
    loop {
        if (i3 == 2) {
            i3 += 1;
            if (i3 > 5){
                break;
            }
            continue;
        }
        println!("while loop v1, i3 is {i3}");
        i3 += 1;
        if (i3 > 5){
            break;
        }
    }

    // for loop

    for i4 in (1..(5 + 1)) {
        if (i4 == 2) {
            continue;
        }
        println!("for loop, i4 is {i4}");
    }

    for i5 in (1..(5 + 1)).rev() {
        if (i5 == 2) {
            continue;
        }
        println!("for loop, i5 is {i5}");
    }
}
