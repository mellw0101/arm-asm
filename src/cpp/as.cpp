#include "../lib.h"
#include <cstdio>
#include <cstring>

namespace as {
    /// @class @c cout
        cout::cout() {} // Only for the sake of the compiler
        auto cout::operator << ( const int i       ) -> cout& {
            string s = int_to_str(i);
            for (size_t i=0;; ++i) {
                if (s[i] > '9' && s[i] < '0') {
                    s[i] = '\0';
                    break;
                }
            }
            return *this;
        }

        auto cout::operator << ( const char c       )  ->  cout& {
            char buf[2] = {c, '\0'};
            printf("buf: %s", buf);
            return *this;
        }
        auto cout::operator << ( const char* str    )  ->  cout& {
            printf("%s", str);
            return *this;
        }
        auto cout::operator << ( const string& str  )  ->  cout& {
            printf("%s", str.data.c_data());
            return *this;
        }
    //

    /// @class @c cin 
        char* cin::operator >> ( char* buf ) {
            read(0, buf, 256);
            return buf;
        }

        as::buf<char> cin::operator >> ( as::buf<char>& buf ) {
            read(0, buf.c_data(), buf.c_size());
            return buf;
        }
    //

    /// @class @c string
        /// @p data == @p NULL Doen not mean the string is empty
        /// @p data == @p ""   Means the string is empty
        string::string ( const char* str )
            : data(as::buf<char>(str)) {
        }

        auto string::operator << ( const char* str ) -> string& {
            data << str;
            return *this;
        }

        void string::operator << ( const char c ) {
            data << c;
        }

        bool string::operator == ( const char* str ) {
            return !(strcmp(data, str) == 0);
        }

        string::operator char* ( ) const {
            return data;
        }

        size_t string::length() noexcept {
            return data.get_size();
        }

        bool string::empty () noexcept {
            return ! (strcmp(data, ""));
        }

        void string::clear () noexcept {
            for (size_t i=0; i<data.get_size(); ++i) {
                data[i] = '\0';
            }
        }

        char* string::c_str() const noexcept {
            return data;
        }
    //
}