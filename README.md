# lua-build
Lua for windows build using makefile and Clang/LLVM compiler

# Dependencies
- Clang/LLVM
- Windows SDK
- gmake

# How to build
- Lua Compiler
  - Open Makefile and change line 127 in `SRCS` variable to src/luac.c
  - change in line 128 in `PROGRAM` variable to build/luac.exe
  ```
  SRCS		=	src/luac.c
  PROGRAM		=	build/luac.exe
  ```
- lua Interpreter
  - Open Makefile and change line 127 in `SRCS` variable to src/lua.c
  - change in line 128 in `PROGRAM` variable to build/lua.exe
  ```
  SRCS		=	src/lua.c
  PROGRAM		=	build/lua.exe
  ```
  
- For build the program
```
mkdir build
make buildware
```

# Other
This build are for version `lua 5.4.5`
