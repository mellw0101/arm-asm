.section .text
.global strcpy

strcpy:
    // x0 = dest
    // x1 = src
    // x2 = counter
    // x3 = char pointer
    // x4 = char pointer_2

    mov x2, #0                  // Init reg x2 to 0
    .find_null:
        ldrb w3, [x1, x2]       // Load w3 with byte from x1 + x2
        cbz w3, .null_found     // If w3 is null terminator jump to .null_found
        strb w3, [x0, x2]       // Store w3 in x0 + x2
        add x2, x2, #1          // Add 1 to counter
        b .find_null            // Iterate loop

    .null_found:
        ret                     // Return
