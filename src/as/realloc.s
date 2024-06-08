.section .text
.global realloc

// realloc(void* ptr, size_t size)
realloc:
    // Arguments:
    // x0: original pointer
    // x1: new size
    // Return value: new pointer (X1)
    // realloc( NULL, size ) is equivalent to malloc(size)
    // realloc( ptr, 0 ) is equivalent to free(ptr)
    
    // If ptr is NULL, simply call malloc(size)
    cbz x0, realloc_malloc

    // If size is zero, free the memory and return NULL
    cbz x1, realloc_free

    // Allocate new memory block
    mov x2, x1
    bl malloc
    cbz x0, realloc_fail

    // Copy data from the old block to the new block
    mov x3, x0 // Save the old pointer in x3
    mov x4, x1 // Save the new size in x4

    // Load the size of the original block (assuming stored at the address just before the block)
    ldr x5, [x3, #-8]

    // Determine the number of bytes to copy
    cmp x4, x5
    csel x6, x5, x4, lo

    // Copy bytes from old block to new block
    mov x7, #0
realloc_copy_loop:
    cmp x7, x6
    b.ge realloc_copy_done
    ldrb w8, [x3, x7]
    strb w8, [x0, x7]
    add x7, x7, #1
    b realloc_copy_loop

realloc_copy_done:
    // Free the old block
    mov x0, x3
    bl free

    // Return the new pointer
    mov x0, x0
    ret

realloc_malloc:
    // Equivalent to malloc(size)
    bl malloc
    ret

realloc_free:
    // Equivalent to free(ptr)
    bl free
    mov x0, #0
    ret

realloc_fail:
    // Malloc failed, return NULL
    mov x0, #0
    ret
