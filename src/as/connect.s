.section .text
.global connect

// connect(int sockfd, const struct sockaddr *addr, socklen_t addrlen)
connect:
    // Arguments:
    // x0: sockfd
    // x1: addr
    // x2: addrlen

    mov x8, #203             // syscall number for connect (203)
    svc #0                   // make the syscall
    ret                      // return 0 on success, -1 on error
