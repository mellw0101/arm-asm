.section .bss
.align 3
heap_base: .skip 4096           // Allocate 4KB for the heap
heap_end:

.section .data
heap_ptr: .quad heap_base       // Pointer to the current end of the heap

.section .text
.global malloc

malloc:
    // x0 = size

    ldr x1, =heap_ptr           // Load the address of heap_ptr
    ldr x2, [x1]                // Load the current heap pointer value into x2

    // Align the requested size to 8 bytes
    add x3, x0, #7              // x3 = size + 7
    bic x3, x3, #7              // x3 = x3 & ~7

    // Check if there is enough space
    add x4, x2, x3              // x4 = current heap pointer + aligned size
    ldr x5, =heap_end           // Load the address of the end of the heap
    cmp x4, x5                  // Compare x4 with heap_end
    bhs .error                  // If x4 >= heap_end, branch to error

    // Allocate the memory
    str x4, [x1]                // Update the heap pointer
    mov x0, x2                  // Return the original heap pointer
    ret                         // Return

    .error:
        mov x0, #0                  // Return NULL on error
        ret                         // Return

