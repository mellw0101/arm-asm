.section .text
.global htons

htons:
    // Arguments:
    // x0: port number

    rev16 x0, x0 // Reverse byte order
    ret
