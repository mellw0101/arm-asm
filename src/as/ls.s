.section .bss
.align 3
buffer:
    .space 1024               // Buffer for directory entries

.section .data
.section .text
.global ls

ls:
    // Arguments:
    // x0: directory name (const char*)

    // Open directory
    mov x8, #56               // syscall number for openat (56)
    mov x1, #-100             // AT_FDCWD (-100)
    mov x2, #0                // flags (O_RDONLY)
    mov x3, #0                // mode (not used here)
    svc #0                    // make the syscall
    cbz x0, ls_fail           // If openat fails, branch to ls_fail
    mov x20, x0               // Save directory file descriptor in x20

    // Read directory entries
    mov x1, x20               // Directory file descriptor in x1
    ldr x0, =buffer           // Buffer for directory entries
    mov x2, #1024             // Buffer size
    mov x8, #217              // syscall number for getdents64 (217)

ls_read_loop:
    svc #0                    // make the syscall
    cbz x0, ls_close          // If getdents64 returns 0, no more entries
    cmp x0, #0                // Check for error
    blt ls_fail               // If error, branch to ls_fail

    // Print directory entries
    mov x1, x20               // Reset buffer position
    mov x2, x0                // Number of bytes read
    ldr x3, =buffer           // Start of buffer

ls_print_loop:
    cmp x2, #0                // Check if all bytes are processed
    beq ls_read_loop          // If yes, read more entries

    // Get directory entry
    ldr x4, [x3, #8]          // d_reclen (entry length)
    ldr x5, [x3, #18]         // d_name (entry name)

    // Write entry name to stdout
    mov x0, #1                // File descriptor (stdout)
    mov x1, x5                // Entry name
    mov x2, x4                // Entry length
    mov x8, #64               // syscall number for write (64)
    svc #0                    // make the syscall

    add x3, x3, x4            // Move to next entry
    sub x2, x2, x4            // Decrease remaining bytes
    b ls_print_loop           // Repeat

ls_close:
    mov x0, x20               // Directory file descriptor
    mov x8, #57               // syscall number for close (57)
    svc #0                    // make the syscall
    ret

ls_fail:
    mov x0, #1                // Return 1 on failure
    ret
