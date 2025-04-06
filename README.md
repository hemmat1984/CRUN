
# **CRUN — Compile & Run C/C++ Code with Ease**
![CRUN Logo](assets/logo.png)

**CRUN** is a minimalist, cross-platform command-line utility that simplifies compiling and running C/C++ programs using a single command — ideal for students, developers, and tinkerers.

---

## 🚀 Features

- ✅ Compile and run `.c` / `.cpp` files instantly.
- 🧠 Smart compiler selection: GCC/G++, Clang/Clang++.
- 🐞 Debug support with GDB and LLDB.
- 🧪 AddressSanitizer integration.
- 🧾 Pass runtime arguments easily.
- 💻 Works on both **Windows** and **Linux**.

---

## 🛠️ Requirements

Ensure the following tools are installed and accessible in your system’s `PATH`:

- **GCC/G++ or Clang/Clang++** — required
- **GDB or LLDB** — optional (for debugging)
- **Windows**: Use `crun.bat`
- **Linux**: Use `crun.sh`

---

## 📦 Installation

### On **Windows**:
1. Download `crun.bat`.
2. Copy it to a directory included in your system `PATH` (e.g., `C:\Windows\System32`).
3. Open Command Prompt and type:
   ```cmd
   crun
   ```

### On **Linux**:
1. Download `crun.sh`.
2. Make it executable:
	 chmod +x crun.sh
3. Move it to a directory in your `PATH`:
	 `sudo mv crun.sh /usr/local/bin/crun`
4. Test it:
	```cmd
	crun
	 ```


## 🧪 **Usage**
```
crun [mode] filename.c/.cpp [program_args]
```

### Modes
| Mode  | Description |
|-----|------|
|g	|  Compile with GCC/G++ (default)
|d	|   Compile with debug symbols & run GDB
|c	|	Compile with Clang/Clang++
|cd	|	Compile and debug with LLDB
|s	|	Compile with AddressSanitizer
|h	|	Display help message
---

## 📘 Examples

	crun hello.c
	crun d main.cpp
	crun s app.c input.txt
	crun c program.cpp arg1 arg2



## 📂 Examples Directory

The `examples/` folder includes:
```
test.c:		 Basic C program with argument parsing.
hello.cpp: 	 "Hello, World!" in C++.
input.txt:	 Sample input for testing.
```

## 🔖 Notes
Ensure all tools (like gcc, g++, gdb, clang) are installed and in your `PATH` .

For file paths with spaces, enclose them in double quotes `" "`.

Debugging modes require GDB (Linux/Windows) or LLDB (macOS/Linux).


## 📝 License

	This project is licensed under the MIT License.

## 🤝 Contributing

	Pull requests and issues are welcome!
	If you have ideas or spot bugs, let’s improve it together.


