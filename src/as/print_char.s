// .section .bss
// buffer: 
//     .space 2  // 1 character + null terminator
// 
// null:
//     .byte 0

//.section .text
//.global print_char

// .include "src/as.inc"

//print_char:
    // Store the character in the buffer
   // adrp x3, buffer
   // add x3, x3, :lo12:buffer
   // // mov x1, x0
   // strb w0, [x3]         // Store the character in buffer[0]
   // ldr x0, [null]
   // strb w0, [x3, #1]         // Store the null terminator in buffer[1]
    // mov w1, null
    // strb w1, [x3, #1]         // Store the null terminator in buffer[1]
    //mov x0, x1

    ; // adrp x4, null
    ; // add x4, x4, :lo12:null
    ; ldr x4, =null
    ; strb w4, [x3, #1]         // Store the null terminator in buffer[1]

    // Load the address of the buffer into x0
    ; adrp x0, buffer
    ; add x0, x0, :lo12:buffer

    // Call print_str
    // bl print_str
    
