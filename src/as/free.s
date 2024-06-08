.section .text
.global free

free:
    // x0: pointer to the memory to free
    mov x8, #3                    // Syscall number for sys_free (may vary depending on the specific syscall for free)
    svc #0                        // Make syscall
    ret                           // Return from function
