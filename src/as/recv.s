.section .text
.global recv

// recv(int sockfd, void *buf, size_t len, int flags)
recv:
    // Arguments:
    // x0: sockfd
    // x1: buf
    // x2: len
    // x3: flags

    mov x8, #207             // syscall number for recv (207)
    svc #0                   // make the syscall
    ret                      // return the number of bytes received
