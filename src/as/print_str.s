.section .text
.global print_str, print_str_cerr
.set syscall_write, 64

print_str:
    // Used For Printing Strings
    // size_t print_str ( const char *str ) -> ( 0/1 (( 0 = 'OK STATE' ),  ( !0 = 'FAIL STATE' )));
    // x0 = pointer to the string
    //
    mov x1, #0                  // Init reg x1 to 0

    .get_len:
        ldrb w2, [x0, x1]       // Load w2 with byte from x0 + x1
        cbz w2, .null_found     // If w2 is null terminator jump to .null_found
        add x1, x1, #1          // Add 1 to counter
        b .get_len              // Iterate loop

    .null_found:
        mov x2, x1              // Move result to reg x2
        mov x1, x0              // Move str ptr to reg x1
        mov x0, #1              // Set x0 to stdout(1) 
        mov x8, #64             // 64 = syscall to write
        svc #0                  // Make syscall
        cmp x0, #-1             // Check if syscall was successful
        bne .success            // If x0 != -1 jump to .success
        mov x0, #1              // Move 1 (failure) to x0
        b .exit                 // Jump to .exit

        .success:
            mov x0, #0

        .exit:
            ret                     // Return

print_str_cerr:
    // Used To Print To Stderr
    // size_t print_str_cerr ( const char *str ) -> ( 0/1 (( 0 = 'OK STATE' ),  ( !0 = 'FAIL STATE' )));
    // x0 = pointer to the string
    //
    mov x1, #0                  // Init reg x1 to 0

    .get_len_cerr:
        ldrb w2, [x0, x1]       // Load w2 with byte from x0 + x1
        cbz w2, .null_found_cerr // If w2 is null terminator jump to .null_found
        add x1, x1, #1          // Add 1 to counter
        b .get_len_cerr         // Iterate loop

    .null_found_cerr:
        mov x2, x1              // Move result to reg x2
        mov x1, x0              // Move str ptr to reg x1
        mov x0, #2              // Set x0 to stderr(2) 
        mov x8, #64             // 64 = syscall to write
        svc #0                  // Make syscall
        cmp x0, #-1             // Check if syscall was successful
        bne .success_cerr       // If x0 != -1 jump to .success
        mov x0, #1              // Move 1 (failure) to x0
        b .exit_cerr            // Jump to .exit

        .success_cerr:
            mov x0, #0

        .exit_cerr:
            ret                     // Return
