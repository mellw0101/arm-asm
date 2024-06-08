// Function to read user input
.section .text
.global read, READ_STDIN

read:
    // Arguments:
    // x0 = fd (int)
    // x1 = buffer (char *)
    // x2 = size (size_t)
    // x3 = raw (int( )) - flag to toggle raw str mode
    // return value: ssize_t
    // ssize_t read(int fd, void *buf, size_t count, int raw);
    // ssize_t is a signed integer type capable of representing the size of any object in bytes

    mov x8, #63              // Syscall number for sys_read
    svc #0                   // Trigger syscall
    ret                      // Return from function
