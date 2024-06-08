.section .text
.global memset

// void* memset(void* s, int c, size_t n)
memset:
    // Arguments:
    // x0: s (pointer to the block of memory to fill)
    // x1: c (value to set)
    // x2: n (number of bytes to set)

    cmp x2, #0                // Check if n is 0
    beq memset_done           // If n is 0, return immediately

    // Loop to set each byte
memset_loop:
    strb w1, [x0], #1         // Store byte value and increment pointer
    subs x2, x2, #1           // Decrement count
    bne memset_loop           // Repeat until count is zero

memset_done:
    ret                       // Return the original pointer
