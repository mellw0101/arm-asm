//.section .text
//.global appstr
//
//appstr:
//    // x0 = str_1
//    // x1 = str_2
//    // x2 = counter
//    // x3 = counter_2
//    // x4 = char pointer
//    // x5 = char pointer_2
//
//    mov x2, #0                  // Init reg x2 to 0
//    .find_null:
//        ldrb w4, [x0, x2]       // Load w3 with byte from x0 + x2
//        cbz w4, .null_found     // If w3 is null terminator jump to .null_found
//        add x2, x2, #1          // Add 1 to counter
//        b .find_null            // Iterate loop
//    
//    .null_found:
//        ldrb w4, [x1, x3]       // Load w4 with byte from x1 + x2
//        strb [x0 + x2], w4 
//        add x2, x2, #1          // Add 1 to counter
//        add x3, x3, #1          // Add 1 to counter_2
//        cbz w4, .exit           // If w4 is null terminator jump to .exit
//        b .null_found           // Iterate loop
//
//    .exit:
//        ret                     // Return
//

.global append

append:
    // Arguments
    // x0: dst (char *)
    // x1: src (char *)
    // x2: bytesRead (size_t)

    cbz     x2, done        // If bytesRead is 0, return immediately

loop:
    ldrb    w3, [x1], #1    // Load byte from src and increment src pointer
    strb    w3, [x0], #1    // Store byte to dst and increment dst pointer
    subs    x2, x2, #1      // Decrement bytesRead
    b.ne    loop            // If bytesRead is not zero, continue loop

done:
    ret                     // Return from function
