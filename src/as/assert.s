.section .text
.global assert

assert:
    // size_t assert ( int Expression, const char *message ( Print If Assertion Failed ( Expression != True ))) -> ( 0/1 (( 0 = 'OK STATE' ),  ( !0 = 'FAIL STATE' )));
    // Arguments
    // x0: int expression
    // x1: const char *message

    cbz x0, .success                // If x0 is 0 jump to .success

    mov x0, #2                      // Set x0 to stderr(2)
    mov x8, #64                     // 64 = syscall to write
    svc #0                          // Make syscall

    mov x0, #1                      // Move 1 (failure) to x0
    b .exit                         // Jump to .exit

    .success:
        mov x0, #0

    .exit:
        ret                         // Return
