@echo off
setlocal enabledelayedexpansion

:: Help if no args or help requested
if "%~1"=="" goto help
if /i "%~1"=="h" goto help

:: Initialize variables
set "mode=g"
set "file="
set "prog_args="

:: Check for mode in the first argument
if /i "%~1"=="d" (
    set "mode=d"
    shift
) else if /i "%~1"=="c" (
    set "mode=c"
    shift
) else if /i "%~1"=="cd" (
    set "mode=cd"
    shift
) else if /i "%~1"=="s" (
    set "mode=s"
    shift
)

:: Check if file is provided
if "%~1"=="" (
    echo Error: No input file specified
    goto help
)
set "file=%~1"
shift

:: Remaining arguments are program arguments
set "prog_args=%*"

:: Check if file exists
if not exist "!file!" (
    echo File not found: !file!
    exit /b 1
)

:: Extract file extension
for %%f in ("!file!") do set "ext=%%~xf"
set "out=!file:.c=.exe!"
set "out=!out:.cpp=.exe!"

:: Detect compiler based on mode and extension
if /i "!ext!"==".c" (
    if /i "!mode!"=="c" (set "cc=clang") else (set "cc=gcc")
) else if /i "!ext!"==".cpp" (
    if /i "!mode!"=="c" (set "cc=clang++") else (set "cc=g++")
) else (
    echo Unsupported file type: !ext!
    exit /b 1
)

:: Compile and run
if /i "!mode!"=="d" (
    !cc! -g -o "!out!" "!file!" && gdb "!out!"
) else if /i "!mode!"=="cd" (
    !cc! -g -o "!out!" "!file!" && lldb "!out!"
) else if /i "!mode!"=="s" (
    !cc! -Wall -fsanitize=address -o "!out!" "!file!" && "!out!" !prog_args!
) else (
    !cc! -Wall -o "!out!" "!file!" && "!out!" !prog_args!
)
exit /b 0

:help
echo  Usage: crun [mode] filename.c/.cpp [program_args]
echo  Modes:
echo   g   = Compile with GCC/G++ (default)
echo   d   = Compile and debug with GDB
echo   c   = Compile with Clang/Clang++
echo   cd  = Compile and debug with LLDB
echo   s   = Compile with AddressSanitizer
echo   h   = display this help
echo.
echo  Example:
echo   crun test.c                # Compile with GCC and run without arguments
echo   crun test.c arg1 arg2      # Compile with GCC and run with arguments
echo   crun d program.cpp         # Compile with debugging symbols and run with GDB
echo   crun s app.c input.txt     # Compile with AddressSanitizer and pass input file
echo   crun c mycode.cpp param1   # Compile with Clang++ and pass parameters
exit /b 0