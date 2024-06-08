.section .text
.global socket

// socket(int domain, int type, int protocol)
socket:
    // Arguments:
    // x0: domain
    // x1: type
    // x2: protocol

    mov x8, #198             // syscall number for socket (198)
    svc #0                   // make the syscall
    ret                      // return the socket file descriptor
