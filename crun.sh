#!/bin/bash

# Help if no args or help requested
if [[ -z "$1" || "$1" == "h" ]]; then
    echo "Usage: crun [mode] filename.c/.cpp [program_args]"
    echo "Modes:"
    echo "  g   = Compile with GCC/G++ (default)"
    echo "  d   = Compile and debug with GDB"
    echo "  c   = Compile with Clang/Clang++"
    echo "  cd  = Compile and debug with LLDB"
    echo "  s   = Compile with AddressSanitizer"
    echo ""
    echo "Example:"
    echo "  crun test.c                # Compile with GCC and run without arguments"
    echo "  crun test.c arg1 arg2      # Compile with GCC and run with arguments"
    echo "  crun d program.cpp         # Compile with debugging symbols and run with GDB"
    echo "  crun s app.c input.txt     # Compile with AddressSanitizer and pass input file"
    echo "  crun c mycode.cpp param1   # Compile with Clang++ and pass parameters"
    exit 0
fi

# Initialize variables
mode="g"
file=""
prog_args=()

# Check for mode in the first argument
case "$1" in
    d|c|cd|s)
        mode="$1"
        shift
        ;;
esac

# Check if file is provided
if [[ -z "$1" ]]; then
    echo "Error: No input file specified"
    exit 1
fi

file="$1"
shift

# Remaining arguments are program arguments
prog_args=("$@")

# Check if file exists
if [[ ! -f "$file" ]]; then
    echo "File not found: $file"
    exit 1
fi

# Extract file extension
ext="${file##*.}"
out="${file%.*}"

# Detect compiler based on mode and extension
if [[ "$ext" == "c" ]]; then
    if [[ "$mode" == "c" ]]; then
        cc="clang"
    else
        cc="gcc"
    fi
elif [[ "$ext" == "cpp" ]]; then
    if [[ "$mode" == "c" ]]; then
        cc="clang++"
    else
        cc="g++"
    fi
else
    echo "Unsupported file type: .$ext"
    exit 1
fi

# Compile and run
case "$mode" in
    d)
        $cc -g -o "$out" "$file" && gdb "./$out"
        ;;
    cd)
        $cc -g -o "$out" "$file" && lldb "./$out"
        ;;
    s)
        $cc -Wall -fsanitize=address -o "$out" "$file" && "./$out" "${prog_args[@]}"
        ;;
    *)
        $cc -Wall -o "$out" "$file" && "./$out" "${prog_args[@]}"
        ;;
esac