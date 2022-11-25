g++ -std=gnu++20 -Wall -Wextra -g -fsanitize=address -fsanitize=undefined -fno-sanitize-recover -O2 -o $1 $1.cpp
