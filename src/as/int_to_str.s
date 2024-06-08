.section .data
buffer: .space 20    // Allocate space for 20 characters

.section .text
.global int_to_str

int_to_str:
    // x0 = number (i)

    // adrp x1, buffer             // Load the page address of buffer into x1
    // add x1, x1, :lo12:buffer    // Add the lower 12 bits to get the actual address of buffer

    ldr x1, =buffer             // Load the address of buffer into x1

    mov x2, x0                  // x2 = number
    mov x3, #10                 // x3 = base
    mov x5, 0                   // Counter

    add x1, x1, #19             // x1 = x1 + 19 (end of buffer)
    mov w4, #0                  // w4 = 0 (temporary for character storage)

    .loop:
        udiv x0, x2, x3         // x0 = x2 / x3
        msub x4, x0, x3, x2     // x4 = x2 - (x0 * x3)
        add x4, x4, #48         // x4 = x4 + 48 (convert to ASCII)
        strb w4, [x1], #-1      // *x1 = w4, x1 = x1 - 1
        mov x2, x0              // x2 = x0
        cbz x2, .exit           // if x2 == 0, jump to .exit
        add x5, x5, #1          // x5 = x5 + 1
        b .loop                 // repeat loop

    .exit:
        add x1, x1, #1          // x1 = x1 + 1 (adjust pointer to start)
        strb wzr, [x1, #-1]     // Set null terminator at the end of the string
        mov x0, x1              // return the pointer to the resulting string
        ret                     // return
