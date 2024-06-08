//.section .text
//.global aligned_alloc
//
//// aligned_alloc(size_t alignment, size_t size)
//aligned_alloc:
//    // Arguments:
//    // x0: alignment
//    // x1: size
//
//    // Check if alignment is a power of two and greater than or equal to sizeof(void*)
//    tst x0, x0 - 1
//    b.ne invalid_alignment
//    cmp x0, #8
//    b.lt invalid_alignment
//
//    // Call malloc(size + alignment + sizeof(void*))
//    add x1, x1, x0
//    add x1, x1, #8
//    mov x2, x1
//    bl malloc
//
//    // Save the original pointer
//    mov x2, x0
//    sub x1, x0, #1
//    add x0, x0, #8
//    and x0, x0, x1
//    stp x0, x2, [x0, #-16]!
//
//    // Return the aligned pointer
//    ret
//
//invalid_alignment:
//    // Return NULL for invalid alignment
//    mov x0, #0
//    ret
//
