.section .text
.global fork

fork:
    // return value: size_t
    // size_t fork()

    mov x8, #220                  // Syscall number for fork (220 for ARM64)
    svc #0                        // Make syscall
    ret                           // Return from function
