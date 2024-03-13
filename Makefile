# # Makefile for installing Lua
# # See doc/readme.html for installation and customization instructions.

# # == CHANGE THE SETTINGS BELOW TO SUIT YOUR ENVIRONMENT =======================

# # Your platform. See PLATS for possible values.
# PLAT= guess

# # Where to install. The installation starts in the src and doc directories,
# # so take care if INSTALL_TOP is not an absolute path. See the local target.
# # You may want to make INSTALL_LMOD and INSTALL_CMOD consistent with
# # LUA_ROOT, LUA_LDIR, and LUA_CDIR in luaconf.h.
# INSTALL_TOP= /usr/local
# INSTALL_BIN= $(INSTALL_TOP)/bin
# INSTALL_INC= $(INSTALL_TOP)/include
# INSTALL_LIB= $(INSTALL_TOP)/lib
# INSTALL_MAN= $(INSTALL_TOP)/man/man1
# INSTALL_LMOD= $(INSTALL_TOP)/share/lua/$V
# INSTALL_CMOD= $(INSTALL_TOP)/lib/lua/$V

# # How to install. If your install program does not support "-p", then
# # you may have to run ranlib on the installed liblua.a.
# INSTALL= install -p
# INSTALL_EXEC= $(INSTALL) -m 0755
# INSTALL_DATA= $(INSTALL) -m 0644
# #
# # If you don't have "install" you can use "cp" instead.
# # INSTALL= cp -p
# # INSTALL_EXEC= $(INSTALL)
# # INSTALL_DATA= $(INSTALL)

# # Other utilities.
# MKDIR= mkdir -p
# RM= rm -f

# # == END OF USER SETTINGS -- NO NEED TO CHANGE ANYTHING BELOW THIS LINE =======

# # Convenience platforms targets.
# PLATS= guess aix bsd c89 freebsd generic ios linux linux-readline macosx mingw posix solaris

# # What to install.
# TO_BIN= lua luac
# TO_INC= lua.h luaconf.h lualib.h lauxlib.h lua.hpp
# TO_LIB= liblua.a
# TO_MAN= lua.1 luac.1

# # Lua version and release.
# V= 5.4
# R= $V.5

# # Targets start here.
# all:	$(PLAT)

# $(PLATS) help test clean:
# 	@cd src && $(MAKE) $@

# install: dummy
# 	cd src && $(MKDIR) $(INSTALL_BIN) $(INSTALL_INC) $(INSTALL_LIB) $(INSTALL_MAN) $(INSTALL_LMOD) $(INSTALL_CMOD)
# 	cd src && $(INSTALL_EXEC) $(TO_BIN) $(INSTALL_BIN)
# 	cd src && $(INSTALL_DATA) $(TO_INC) $(INSTALL_INC)
# 	cd src && $(INSTALL_DATA) $(TO_LIB) $(INSTALL_LIB)
# 	cd doc && $(INSTALL_DATA) $(TO_MAN) $(INSTALL_MAN)

# uninstall:
# 	cd src && cd $(INSTALL_BIN) && $(RM) $(TO_BIN)
# 	cd src && cd $(INSTALL_INC) && $(RM) $(TO_INC)
# 	cd src && cd $(INSTALL_LIB) && $(RM) $(TO_LIB)
# 	cd doc && cd $(INSTALL_MAN) && $(RM) $(TO_MAN)

# local:
# 	$(MAKE) install INSTALL_TOP=../install

# # make may get confused with install/ if it does not support .PHONY.
# dummy:

# # Echo config parameters.
# echo:
# 	@cd src && $(MAKE) -s echo
# 	@echo "PLAT= $(PLAT)"
# 	@echo "V= $V"
# 	@echo "R= $R"
# 	@echo "TO_BIN= $(TO_BIN)"
# 	@echo "TO_INC= $(TO_INC)"
# 	@echo "TO_LIB= $(TO_LIB)"
# 	@echo "TO_MAN= $(TO_MAN)"
# 	@echo "INSTALL_TOP= $(INSTALL_TOP)"
# 	@echo "INSTALL_BIN= $(INSTALL_BIN)"
# 	@echo "INSTALL_INC= $(INSTALL_INC)"
# 	@echo "INSTALL_LIB= $(INSTALL_LIB)"
# 	@echo "INSTALL_MAN= $(INSTALL_MAN)"
# 	@echo "INSTALL_LMOD= $(INSTALL_LMOD)"
# 	@echo "INSTALL_CMOD= $(INSTALL_CMOD)"
# 	@echo "INSTALL_EXEC= $(INSTALL_EXEC)"
# 	@echo "INSTALL_DATA= $(INSTALL_DATA)"

# # Echo pkg-config data.
# pc:
# 	@echo "version=$R"
# 	@echo "prefix=$(INSTALL_TOP)"
# 	@echo "libdir=$(INSTALL_LIB)"
# 	@echo "includedir=$(INSTALL_INC)"

# # Targets that do not create files (not all makes understand .PHONY).
# .PHONY: all $(PLATS) help test clean install uninstall local dummy echo pc

# # (end of Makefile)

CXX			=	clang
CXFLAGS		=	-O3
CXFLAGS		+=	-fstack-protector-strong -fvectorize -fslp-vectorize \
				-fstrict-enums -fsplit-lto-unit \
				-fstrict-float-cast-overflow -fstrict-vtable-pointers \
				-fconvergent-functions -fenable-matrix

CXFLAGS		+=	-fno-fixed-point -fno-strict-aliasing -fno-exceptions \
				-fno-spell-checking -fno-rtti -fno-rtti-data -fno-access-control \
				-fno-addrsig -fno-gnu-inline-asm

CXFLAGS		+=	-mstack-arg-probe -mstackrealign -msoft-float -mno-lvi-cfi \
				-mlvi-cfi -mlvi-hardening

CXFLAGS		+=	-Wall -Wno-pedantic
CXFLAGS		+=	-v -H

CXLIBS		=	-mwindows

SRCS		=	src/lua.c
PROGRAM		=	build/lua.exe

LIBS		= 	src/lapi.c src/lcode.c src/lctype.c src/ldebug.c src/ldo.c src/ldump.c src/lfunc.c \
				src/lgc.c src/llex.c src/lmem.c src/lobject.c src/lopcodes.c src/lparser.c src/lstate.c \
				src/lstring.c src/ltable.c src/ltm.c src/lundump.c src/lvm.c src/lzio.c src/lauxlib.c \
				src/lbaselib.c src/lcorolib.c src/ldblib.c src/liolib.c src/lmathlib.c src/loadlib.c \
				src/loslib.c src/lstrlib.c src/ltablib.c src/lutf8lib.c src/linit.c

buildware:
	$(CXX) $(CXFLAGS) $(CXLIBS) $(LIBS) $(SRCS) -o $(PROGRAM)