#include "../lib.h"
#include <iostream>

int main(int argc, char** argv) {
    as::string args;
    for (int i=0; i<argc; ++i) {
        as::string arg = argv[i];
        if (arg == "alang\n") {
            continue;
        }
        args << arg << " ";
    }

	std::cout << args << '\n';
    return 0;
}