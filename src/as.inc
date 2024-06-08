.equ SYS_EXIT, 93       // System call number for exit
.equ SYS_WRITE, 64      // System call number for write
.equ STDOUT, 1          // File descriptor for stdout
.equ NULL, 0            // Null pointer


.macro m_print_str_2, str
    adrp x0, \str                   // Load page address of str into x0
    add x0, x0, :lo12:\str          // Adjust to exact address of str
    bl print_str                    // Call print_str    
.endm

.macro m_print_str str
    .pushsection .data.strings, "a"
    .balign 4

    .L_\@: 
        .asciz "\str"
    .L_\@_end:
        .popsection

    adrp x0, .L_\@                // Load page address of the string into x0
    add x0, x0, :lo12:.L_\@       // Adjust to the exact address of the string
    bl print_str                  // Call print_str
.endm

.macro ROR d s b
    vshr.u32    \d, \s, #\b
    vsil.u32    \d, \s, #(32-\b)
.endm

.macro IMprint_str str
    adrp x0, \str
    add x0, x0, :lo12:\str
    bl print_str
.endm

.macro IMread buf size
    // Read user input
    mov x0, #0              // File descriptor 0 (stdin)
    ldr x1, =\buf           // Load the address of the buffer into x1
    mov x2, \size           // Number of bytes to read into x2
    bl read                 // Call the read_input function
.endm

.macro IMexit status
    mov x0, \status         // Load the status code into x0
    mov x8, #SYS_EXIT       // Load the system call number into x8
    svc #0                  // Make the system call
.endm

.macro READ_STDIN buffer, size
    mov x0, #0               // File descriptor 0 (stdin)
    ldr x1, =\buffer         // Load the address of the buffer into x1
    mov x2, #\size           // Number of bytes to read into x2
    bl read                  // Call the read_input function
.endm
