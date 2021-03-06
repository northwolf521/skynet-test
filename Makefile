.PHONY: all skynet clean

PLAT ?= linux
SHARED := -fPIC --shared
LUA_CLIB_PATH ?= server/luaclib

CFLAGS = -g -O2 -Wall 
DEPS = -Iskynet/3rd/lua

LUA_CLIB = protobuf log

all : skynet

skynet/Makefile :
	git submodule update --init

skynet : skynet/Makefile
	cd skynet && $(MAKE) $(PLAT) && cd ..

all : \
  $(foreach v, $(LUA_CLIB), $(LUA_CLIB_PATH)/$(v).so)

$(LUA_CLIB_PATH) :
	mkdir $(LUA_CLIB_PATH)


$(LUA_CLIB_PATH)/protobuf.so : | $(LUA_CLIB_PATH)
	cd server/lualib-src/pbc && $(MAKE) lib $(DEPS) && cd binding/lua53  && $(MAKE) $(DEPS) && cd ../../../../.. && cp server/lualib-src/pbc/binding/lua53/protobuf.so $@

$(LUA_CLIB_PATH)/log.so : server/lualib-src/lua-log.c | $(LUA_CLIB_PATH)
	$(CC) $(CFLAGS) $(SHARED) $^ -o $@ $(DEPS)

clean :
	cd skynet && $(MAKE) clean
	
