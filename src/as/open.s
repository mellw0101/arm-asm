.global open

open:
    // Arguments
    // x0: const char *pathname
    // x1: int flags    ( O_READ, O_WRITE, O_RDWR, O_CREAT, O_APPEND, O_TRUNC, O_EXCL, O_SYNC, O_NONBLOCK, O_NOFOLLOW, O_DIRECTORY, O_CLOEXEC ) = 0x0001, 0x0002, 0x0004, 0x0008, 0x0200, 0x0400, 0x0800, 0x2000, 0x4000, 0x0100, 0x1000, 0x8000
    // x2: mode_t mode (used only if O_CREAT is specified in flags) Default = 0644 
    // Ret Value = int File Descriptor 

    mov     x8, #56         // syscall number for openat
    mov     x1, #0          // AT_FDCWD, for the openat system call
    svc     #0              // make the syscall
    ret
