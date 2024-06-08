.section .text
.global execve

execve:
    // x0 = path
    // x1 = argv
    // x2 = environ

    mov x8, #221
    svc #0
