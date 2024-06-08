.section .text
.global get_term_rows

get_term_rows:
    // int get_term_rows();

    mov x0, #1                    // STDOUT file descriptor
    adr x1, winsize               // Address of winsize structure
    mov x2, #0x5413               // TIOCGWINSZ ioctl command
    mov x8, #54                   // Syscall number for ioctl
    svc #0                        // Make syscall
    ldr x0, [x1, #0]              // Load the number of rows into w0
    ret                           // Return from function

.section .bss
winsize:
    .space 8                      // Reserve 8 bytes for winsize structure
