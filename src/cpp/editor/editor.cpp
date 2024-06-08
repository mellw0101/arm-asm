#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <istream>
#include <unistd.h>
#include <iostream>
#include <unistd.h>
#include <termios.h>

using namespace std;



vector<string> openFile(const string& filename) {
    ifstream file(filename);
    if (!file.is_open()) {
        cerr << "Error: Could not open file" << endl;
        return {};
    }

    vector<string> result;
    string line;
    while (getline(file, line)) {
        result.push_back(line);
    }

    file.close();
    return result;
}

class App {
    vector<string> lines;
    size_t numLines = 0;
    
    void load_data(const string& filename) {
        lines = openFile(filename);
        numLines = lines.size();
    }

public:
    App(const string& filename = "") {
        if (!filename.empty()) {
            load_data(filename);
        }
    }

    int run() {
        while(true) {
            char c;
            while ((read(STDIN_FILENO, &c, 1)) != 1);
            // Example: Print the key to the console
            cout << "Keypress: " << c <<  endl;
        }

        return 0;
    }
};

class InputHandler {
public:
    InputHandler() {
        // Get the current terminal settings
        tcgetattr(STDIN_FILENO, &orig_termios);
        // Copy the settings to modify
        new_termios = orig_termios;
        // Disable canonical mode and echo
        new_termios.c_lflag &= ~(ICANON | ECHO);
        // Set the new settings immediately
        tcsetattr(STDIN_FILENO, TCSANOW, &new_termios);
    }

    ~InputHandler() {
        // Restore the original terminal settings
        tcsetattr(STDIN_FILENO, TCSANOW, &orig_termios);
    }

    int run() {
        while (true) {
            char c;
            // Read 1 character
            if (read(STDIN_FILENO, &c, 1) == 1) {
                // Print the key to the console
                std::cout << "Keypress: " << c << std::endl;
                if (c == '[') {
                    read(STDIN_FILENO, &c, 1);
                    if (c == 'D') {
                        std::cout << "Left arrow key pressed" << std::endl;
                    } else if (c == 'C') {
                        std::cout << "Right arrow key pressed" << std::endl;
                    } else if (c == 'A') {
                        std::cout << "Up arrow key pressed" << std::endl;
                    } else if (c == 'B') {
                        std::cout << "Down arrow key pressed" << std::endl;
                    }
                }
                // Optionally, exit the loop if a specific key is pressed
                else if (c == 'q') {  // Press 'q' to quit
                    break;
                }
            }
        }
        return 0;
    }

private:
    termios orig_termios;
    termios new_termios;
};

int main(int argc, char** argv) {
    if (argc < 2) {
        std::cerr << "Error: No file specified" << std::endl;
        return 1;
    }

    InputHandler inputHandler;
    return inputHandler.run();
}