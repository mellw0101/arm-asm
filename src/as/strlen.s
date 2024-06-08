.section .text
.global strlen

// x0: pointer to the string
strlen:
    mov x1, #0                      // x1 will hold the length of the string

    .strlen_loop:
        ldrb w2, [x0, x1]           // load byte from address x0 + x1 into w2
        cbz w2, .strlen_done        // if w2 (current character) is zero, jump to strlen_done
        add x1, x1, #1              // x1 = x1 + 1
        b .strlen_loop              // Repeat the loop

    .strlen_done:
        mov x0, x1                  // move the length into x0 for the return value
        ret                         // return
