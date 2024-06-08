.section .text
.global send

// send(int sockfd, const void *buf, size_t len, int flags)
send:
    // Arguments:
    // x0: sockfd
    // x1: buf
    // x2: len
    // x3: flags

    mov x8, #206             // syscall number for send (206)
    svc #0                   // make the syscall
    ret                      // return the number of bytes sent
