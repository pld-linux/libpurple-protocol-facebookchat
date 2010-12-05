PREFIX=/usr
LIBDIR=$(PREFIX)/lib
ICONDIR=$(PREFIX)/share/pixmaps/pidgin/protocols
FACEBOOK_SOURCES = \
	libfacebook.c \
	fb_blist.c \
	fb_connection.c \
	fb_conversation.c \
	fb_info.c \
	fb_managefriends.c \
	fb_messages.c \
	fb_notifications.c \
	fb_search.c \
	fb_util.c \
	fb_friendlist.c \
	fb_json.c \
	fb_chat.c \
	libfacebook.h \
	fb_blist.h \
	fb_connection.h \
	fb_conversation.h \
	fb_info.h \
	fb_managefriends.h \
	fb_messages.h \
	fb_notifications.h \
	fb_search.h \
	fb_util.h \
	fb_friendlist.h \
	fb_json.h \
	fb_chat.h

PURPLE_CFLAGS := $(shell pkg-config --cflags --libs purple)
PURPLE_CFLAGS += -DPURPLE_PLUGINS -DENABLE_NLS -fPIC -DPIC -DNO_ZLIB -shared $(CFLAGS)
CC=gcc

#Standard stuff here
.PHONY:	all clean install sourcepackage

all:	libfacebook.so

install: libfacebook.so
	mkdir -p $(DESTDIR)$(LIBDIR)/purple-2
	install -p libfacebook.so $(DESTDIR)$(LIBDIR)/purple-2
	mkdir -p $(DESTDIR)$(ICONDIR)/{16,22,48}
	cp -p facebook16.png $(DESTDIR)$(ICONDIR)/16/facebook.png
	cp -p facebook22.png $(DESTDIR)$(ICONDIR)/22/facebook.png
	cp -p facebook48.png $(DESTDIR)$(ICONDIR)/48/facebook.png

clean:
	rm -f *.so *~

libfacebook.so: ${FACEBOOK_SOURCES}
	${CC} ${PURPLE_CFLAGS} -I. -I/usr/include/json-glib-1.0 -ljson-glib-1.0 -pipe ${FACEBOOK_SOURCES} -o $@

sourcepackage:	*.c *.h Makefile facebook16.png facebook22.png facebook48.png COPYING facebook.nsi
	tar --bzip2 -cf pidgin-facebookchat-source.tar.bz2 $^
