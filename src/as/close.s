.section .text
.global close

// close(int sockfd)
close:
    // Arguments:
    // x0: sockfd

    mov x8, #57              // syscall number for close (57)
    svc #0                   // make the syscall
    ret                      // return 0 on success, -1 on error
