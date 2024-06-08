.section .text
.global strcmp

strcmp:
    // x0 = str1
    // x1 = str2
    // x2 = len
    // x3 = result
    // x4 = counter
    // x5 = str1_char
    // x6 = str2_char
    // x7 = str1_ptr
    // x8 = str2_ptr

    mov x4, #0                  // Init counter
    mov x3, #0                  // Init result

    .loop:
        ldrb w5, [x0, x4]       // Load w5 with byte from x0 + x4
        ldrb w6, [x1, x4]       // Load w6 with byte from x1 + x4
        cmp w5, w6              // Compare w5 and w6
        bne .failure            // If w5 != w6 jump to .strcmp_done
        cbz w5, .success        // If w5 is null terminator jump to .strcmp_done
        add x4, x4, #1          // Add 1 to counter
        b .loop                 // Iterate loop

    .failure:
        mov x0, #-1                 // Move -1 (failure) to x0
        b .return                   // Jump to .return

    .success:
        mov x0, #0                  // Move 0 (success) to x0

    .return:
        ret                         // Return
