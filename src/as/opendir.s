.section .text
.global opendir

// opendir(const char* name)
opendir:
    // Arguments:
    // x0: directory name (const char*)

    mov x8, #56             // syscall number for openat (56)
    mov x1, #-100           // AT_FDCWD (-100)
    mov x2, #0              // flags (O_RDONLY)
    mov x3, #0              // mode (not used here)
    svc #0                  // make the syscall

    ret                     // return, x0 holds the directory file descriptor
