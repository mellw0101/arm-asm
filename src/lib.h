#ifndef ARM_ASM_H
#define ARM_ASM_H

#include <unistd.h>
#include <cstdint>
#include <string>

// Function Declarations for C/CPP
    #ifdef __cplusplus
    extern "C" {
        #endif

        // size_t   print_str       ( const char* str );
        char*    int_to_str      ( size_t i );
        // size_t   strcmp          ( const char* str1, const char* str2 );
        // extern size_t   strlen          ( const char* str );
        // extern void     exit            ( size_t status );
        // extern size_t   execve          ( const char* path, char* const argv[], char* const envp[] );
        // extern void*    malloc          ( size_t size );
        // extern const void* realloc      ( void* ptr, size_t size );
        // // extern size_t   aligned_alloc   (size_t alignment, size_t size);
        // extern size_t   free            ( void* ptr );
        // extern char*    appstr          ( const char* str1, const char* str2 );
        // extern char*    get_cwd         ( char* buf, size_t size );
        // extern size_t   strcpy          ( char* dest, const char* src );
        // extern ssize_t  read            ( int fd, void* buf, size_t count );
        // extern int      opendir         ( const char* name );
        // extern ssize_t  readdir         ( int fd, struct dirent* entry );
        // extern int      closedir        ( int fd );

        // int             open            ( const char* pathname, int flags, int mode );
        // int             socket          ( int domain, int type, int protocol );
        // int             connect         ( int sockfd, const struct sockaddr *addr, u32_t addrlen );
        // ssize_t         send            ( int sockfd, const void *buf, size_t len, int flags );
        // ssize_t         recv            ( int sockfd, void *buf, size_t len, int flags );
        // int             close           ( int sockfd);
        // int             inet_pton       ( int af, const char* src, void* dst);
        // u16_t           htons           ( u16_t hostshort);
        // void*           memset          ( void* s, int c, size_t n);
        // size_t          assert          ( int expression, const char* fail_msg );
        // char*           append          ( char* str1, const char* str2, size_t len );

        // enum            CheckPathResult {
        //     CHECK_PATH_FILE        = 0,
        //     CHECK_PATH_DIR         = 1,
        //     CHECK_PATH_NOT_FOUND   = -1
        // };
        // size_t          check_path      ( const char *pathname );

        #ifdef __cplusplus
    }
    #endif

    #ifdef __cplusplus
        namespace as {
            // Class Defenitions
                /**
                    @class @p buf
                    @brief Standard Raw Array Obj, Used For All Standard
                        Classes That Need To Store Data In A Buffer
                    
                    @tparam @p T Internal *( 'Ptr Type' ) Of The Buffer
                    */
                template<class T> class buf {
                    T* data;
                    size_t size, capacity;

                    /** Ret      Operator/Name                      Input @param's               Const flag    Trailing Ret */
                        auto        check_size              (                               )                   -> buf<T>&  ;
                        auto        check_and_inc_size      (                               )                   -> buf<T>&  ;
                        auto        get_null_terminator     (                               )                   -> size_t   ;
                    public:
                        buf         <T>                     ( T const*  other               )                               ;
                        buf         <T>                     ( size_t    capacity            )                               ;
                        ~buf        <T>                     (                               )                               ;
                        buf         <T>                     ( T*        other               )                               ;
                        operator    char*                   (                               )       const                   ;
                        auto        push_back               ( T item                        )                   -> void     ;
                        auto        get_size                (                               )                   -> size_t   ;
                        auto        get_capacity            (                               )                   -> size_t   ;
                        auto        operator        <<      ( T item                        )                   -> buf<T>&  ;
                        auto        operator        <<      ( T const* item                 )                   -> buf<T>&  ;
                        auto        c_data                  (                               )       const       -> T*       ;
                        auto        c_size                  (                               )       const       -> size_t   ;
                        auto        c_capacity              (                               )       const       -> size_t   ;
                };
                  /** @p private: Methods                                                                                               */
                    template < typename T > auto    as::buf < T >::     check_size             (                   )       -> buf<T>&  {
                        if (this->size >= this->capacity) { // If the buffer is full
                            this->capacity *= 2;
                            T* new_data = (T*)malloc(this->capacity);
                            this->data = new_data;
                        }
                        return *this;
                    }
                    template < typename T > auto    as::buf < T >::     check_and_inc_size     (                   )       -> buf<T>&  {
                        check_size();
                        size++;
                        return *this;
                    }
                    template < typename T > auto    as::buf < T >::     get_null_terminator    (                   )       -> size_t   {
                        size_t i = 0;
                        for (;; ++i) {
                            if (this->data[i] == '\0') {
                                break;
                            }
                        }
                        return i;
                    }
                  /** @p public:  Methods                                                                                               */
                    template < typename T >         as::buf < T >::    buf                     ( size_t capacity   )                   {
                        this->capacity = capacity;
                        this->size = 0;
                        this->data = (T*)malloc(capacity*sizeof(T));
                    }
                    template < typename T >         as::buf < T >::    ~buf                    (                   )                   {
                        free(this->data);
                    }
                    template < typename T >         as::buf < T >::    buf                     ( const T* other    )                   {
                        size_t i = 0;
                        for (;; ++i) {
                            if (other[i] == '\0') {
                                break;
                            }
                        }
                        this->size = i;
                        this->data = (T*)malloc(this->size);
                        for (size_t i=0; i<this->size; ++i) {
                            this->data[i] = other[i];
                        }
                    }
                    template < typename T >         as::buf < T >::    buf                     ( T* other          )                   {
                        size_t i = 0;
                        for (;; ++i) {
                            if (other[i] == '\0') {
                                break;
                            }
                        }
                        this->size = i;
                        this->capacity = this->size;
                        this->data = (T*)malloc(this->capacity);
                        for (size_t i=0; i<this->size; ++i) {
                            this->data[i] = other[i];
                        }
                    }
                    template < typename T >         as::buf < T >::    operator char*          (                   ) const             {
                        return (char*)this->data;
                    }                
                    template < typename T > auto    as::buf < T >::    push_back               ( T item            )       -> void     {
                        check_and_inc_size();
                        this->data[this->size] = item;
                    }
                    template < typename T > auto    as::buf < T >::    get_size                (                   )       -> size_t   {
                        return this->size;
                    }
                    template < typename T > auto    as::buf < T >::    get_capacity            (                   )       -> size_t   {
                        return this->capacity;
                    }
                    template < typename T > auto    as::buf < T >::    operator    <<          ( T item            )       -> buf<T>&  {
                        if (size >= capacity) {
                            capacity = capacity * 2;
                            T* new_data = (T*)malloc(capacity);
                        }
                        size++;
                        data[size-1] = item;
                        return *this;
                    }
                    template < typename T > auto    as::buf < T >::    operator    <<          ( const T* item     )       -> buf<T>&  {
                        if (!(size > 0)) {      // If the buffer is empty
                            size_t len = 0;
                            for (;; ++len) {
                                if (item[len] == '\0') {
                                    break;
                                }
                            }
                            T* new_data = (T*)malloc(len);
                            for (size_t i=0; item[i] != '\0'; ++i) {
                                new_data[i] = item[i];
                            }
                            free(data);
                            data = new_data;
                        }
                        else {                  // Else append
                            size_t len = 0;
                            for (;; ++len) {
                                if (item[len] == '\0') {
                                    break;
                                }
                            }
                            size_t new_size = this->size + len;
                            T* new_data = (T*)malloc(new_size);
                            for (size_t i=0; i<this->size; ++i) {
                                new_data[i] = this->data[i];
                            }
                            for (size_t i=0; i<len; ++i) {
                                new_data[this->size+i] = item[i];
                            }
                            free(data);
                            data = new_data;
                        }
                        return *this;
                    }
                    template < typename T > auto    as::buf < T >::    c_data                  (                   ) const -> T*       {
                        return this->data;
                    }
                    template < typename T > auto    as::buf < T >::    c_size                  (                   ) const -> size_t   {
                        return this->size;
                    }
                    template < typename T > auto    as::buf < T >::    c_capacity              (                   ) const -> size_t   {
                        return this->capacity;
                    }
                //

                /**
                    @class string
                    @brief Object To Make String Managenment Easy
                    */
                class string {
                public:
                    as::buf<char> data;

                    string                  ( const char* str = ""  )                       ;
                    void operator   <<      ( const char c          )                       ;
                    auto operator   <<      ( const char* c         )           -> string&  ;
                    bool operator   ==      ( const char* str       )                       ;
                    operator        char*   (                       ) const                 ;
                    size_t          length  (                       ) noexcept              ;
                    bool            empty   (                       ) noexcept              ;
                    void            clear   (                       ) noexcept              ;
                    char*           c_str   (                       ) const noexcept        ;
                };

                class cout {
                public:
                    cout();
                    auto operator << ( const int  c         ) -> cout&;
                    auto operator << ( const char c         ) -> cout&;
                    auto operator << ( const char* str      ) -> cout&;
                    auto operator << ( const string& str    ) -> cout&;
                };
                
                class cin {
                public:
                    cin() {}
                
                    char* operator >> ( char* buf );
                    as::buf<char> operator >> ( as::buf<char>& buf );
                };
                
                static class cout   cout;
                static class cin    cin;
            //

            namespace sys {
                static void ls () {
                    as::string cwd;
                    getcwd(cwd, 256);
                    char* argv[] = {(char*)"ls", cwd, NULL};
                    execve("/bin/ls", argv, NULL);
                }
            }
        }
        //
    #endif // __cplusplus
//

#define __asm__call(__name, ...)                                                                                        \
    int result;                                                                                                         \
    __asm__ volatile(                                                                                                   \
        "bl " #__name "\n"                                                                                              \
        "mov %0, x0\n"                                                                                                  \
        : "=r"(result)                                                                                                  \
        : "r"(__VA_ARGS__)                                                                                              \
        : "x0");                                                                                                        \
    if (result < 0) {                                                                                                   \
        as::cout << "__asm__call( " << #__name  << " ) failed with code: " << result << '\n';                               \
        errno = -result;                                                                                                \
    }
//

#endif // ARM_ASM_H