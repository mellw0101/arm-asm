.section .text
.global closedir

// closedir(int fd)
closedir:
    // Arguments:
    // x0: directory file descriptor (int)

    mov x8, #57             // syscall number for close (57)
    svc #0                  // make the syscall

    ret                     // return, x0 holds the return value (0 on success, -1 on error)