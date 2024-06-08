.section .text
.global readdir

// readdir(int fd, struct dirent* entry)
readdir:
    // Arguments:
    // x0: directory file descriptor (int)
    // x1: buffer to store the directory entry (struct dirent*)

    mov x8, #217            // syscall number for getdents64 (217)
    svc #0                  // make the syscall

    ret                     // return, x0 holds the number of bytes read or error code
