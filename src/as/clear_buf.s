.section .text
.global clear_buf

.include "src/as.inc"

clear_buf:
    // x0 = buffer
    // x1 = size
    // x2 = counter
    // x3 = char pointer

    mov w3, NULL
    mov x2, #0                  // Init reg x2 to 0
    .loop:
        strb w3, [x0, x2]       // Store w3 in x0 + x2
        add x2, x2, #1          // Add 1 to counter
        cmp x2, x1              // Compare counter to size
        bne .loop               // If counter != size, iterate loop
        ret                     // Return
