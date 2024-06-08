.section .text
.global check_path

check_path:
    // size_t check_path ( const char *pathname ) -> ( 0/1 (( 0 = 'Regular File' ),  ( 1 = 'Directory' )));
    // Arguments
    // x0: const char *pathname

    mov     x8, #4          // syscall number for stat
    mov     x1, sp          // place the stat struct on the stack
    svc     #0              // make the syscall

    cbnz    x0, path_error  // if x0 != 0, an error occurred

    ldr     x1, [sp, #0]    // load the st_mode field from struct stat
    and     x1, x1, #0xF000 // extract the file type bits

    cmp     x1, #0x4000     // S_IFDIR: directory
    b.eq    is_dir

    cmp     x1, #0x8000     // S_IFREG: regular file
    b.eq    is_file

path_error:
    mov     x0, #-1         // error or not found
    ret

is_dir:
    mov     x0, #1          // directory
    ret

is_file:
    mov     x0, #0          // regular file
    ret
