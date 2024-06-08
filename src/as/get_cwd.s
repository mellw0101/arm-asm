.section .text
.global get_cwd

get_cwd:
    // Arguments:
    // x0 = buffer (char *)
    // x1 = size (size_t)

    mov x8, #17               // syscall number for getcwd
    svc 0                     // invoke syscall
    ret                       // return to caller
