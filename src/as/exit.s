.section .data
msg:    .ASCII "Exiting with status: \n"


.section .text
.global exit

.include "src/as.inc"

exit:
    // x0 = status
    
    mov x1, x0                      // Move status to x1
    mov x0, #0                      // Set exit status to 0
    mov x8, #93                     // Syscall number for exit
    svc #0
