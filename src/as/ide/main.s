.section .data
prompt:     .asciz " -> "
buffer:     .space 128

.section .text
.global _start

.include "src/as.inc"

_start:
    .loop:
        IMprint_str prompt
        IMread buffer, #128
        IMprint_str buffer

        b .loop

    IMexit #0
//.global _start
//
//.section .data
//prompt: .asciz "editor> "
//prompt_len = . - prompt
//
//.section .bss
//input: .space 100
//
//.section .text
//_start:
//    // Print prompt
//    mov x0, #1           // file descriptor (stdout)
//    ldr x1, =prompt      // address of prompt
//    mov x2, #prompt_len  // length of prompt
//    mov x8, #64          // syscall: write
//    svc 0
//
//    // Read input
//    mov x0, #0           // file descriptor (stdin)
//    ldr x1, =input       // address of input buffer
//    mov x2, #100         // number of bytes to read
//    mov x8, #63          // syscall: read
//    svc 0
//
//    // Echo input (simple implementation)
//    mov x0, #1           // file descriptor (stdout)
//    ldr x1, =input       // address of input buffer
//    mov x2, #100         // number of bytes to write
//    mov x8, #64          // syscall: write
//    svc 0
//
//    // Loop to continue reading input (simplified for illustration)
//    b _start
