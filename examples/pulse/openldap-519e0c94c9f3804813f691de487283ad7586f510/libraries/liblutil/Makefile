# $OpenLDAP$
## This work is part of OpenLDAP Software <http://www.openldap.org/>.
##
## Copyright 1998-2022 The OpenLDAP Foundation.
## All rights reserved.
##
## Redistribution and use in source and binary forms, with or without
## modification, are permitted only as authorized by the OpenLDAP
## Public License.
##
## A copy of this license is available in the file LICENSE in the
## top-level directory of the distribution or, alternatively, at
##---------------------------------------------------------------------------
#
# Top-level Makefile template
#

PACKAGE= OpenLDAP
VERSION= 2.X
RELEASEDATE= 0000/00/00


SHELL = /bin/sh

top_builddir = ../..

srcdir = .
top_srcdir = ../..

prefix = /usr/local
exec_prefix = ${prefix}
ldap_subdir = /openldap

bindir = ${exec_prefix}/bin
datarootdir = ${prefix}/share
datadir = ${datarootdir}$(ldap_subdir)
includedir = ${prefix}/include
infodir = ${datarootdir}/info
libdir = ${exec_prefix}/lib
libexecdir = ${exec_prefix}/libexec
localstatedir = ${prefix}/var
mandir = ${datarootdir}/man
moduledir = ${exec_prefix}/libexec$(ldap_subdir)
sbindir = ${exec_prefix}/sbin
sharedstatedir = ${prefix}/com
sysconfdir = ${prefix}/etc$(ldap_subdir)
schemadir = $(sysconfdir)/schema
systemdsystemunitdir = 

PLAT = UNIX
EXEEXT = 
OBJEXT = o

BUILD_LIBS_DYNAMIC = static

SHTOOL = $(top_srcdir)/build/shtool

INSTALL = $(SHTOOL) install -c
INSTALL_PROGRAM = $(INSTALL)
INSTALL_DATA = $(INSTALL) -m 644
INSTALL_SCRIPT = $(INSTALL)

STRIP_OPTS = -s

LINT = lint
5LINT = 5lint

MKDEP = $(top_srcdir)/build/mkdep $(MKDEPFLAG) \
	-d "$(srcdir)" -c "$(MKDEP_CC)" -m "$(MKDEP_CFLAGS)"
MKDEP_CC	= cc
MKDEP_CFLAGS = -M

MKVERSION = $(top_srcdir)/build/mkversion -v "$(VERSION)"

LIBTOOL = $(SHELL) $(top_builddir)/libtool
LIBVERSION = 0:0:0
LTVERSION = -version-info $(LIBVERSION)

# libtool --only flag for libraries: platform specific
NT_LTONLY_LIB = # --only-$(BUILD_LIBS_DYNAMIC)
LTONLY_LIB = $(UNIX_LTONLY_LIB)

# libtool --only flag for modules: depends on linkage of module
# The BUILD_MOD macro is defined in each backend Makefile.in file
LTONLY_yes = --tag=disable-shared
LTONLY_mod = --tag=disable-static
LTONLY_MOD = $(LTONLY_$(BUILD_MOD))

# platform-specific libtool flags
NT_LTFLAGS_LIB = -no-undefined -avoid-version -rpath $(libdir)
NT_LTFLAGS_MOD = -no-undefined -avoid-version -rpath $(moduledir)
UNIX_LTFLAGS_LIB = $(LTVERSION) -rpath $(libdir)
UNIX_LTFLAGS_MOD = $(LTVERSION) -rpath $(moduledir)

# libtool flags
LTFLAGS     = $(UNIX_LTFLAGS)
LTFLAGS_LIB = $(UNIX_LTFLAGS_LIB)
LTFLAGS_MOD = $(UNIX_LTFLAGS_MOD)

# LIB_DEFS defined in liblber and libldap Makefile.in files.
# MOD_DEFS defined in backend Makefile.in files.

# platform-specific LINK_LIBS defined in various Makefile.in files.
# LINK_LIBS referenced in library and module link commands.
LINK_LIBS = $(MOD_LIBS) $(UNIX_LINK_LIBS)

# compiler options for versioned library symbol support
OL_VERSIONED_SYMBOLS = -Wl,--version-script=

LTSTATIC = -static

LTLINK   = $(LIBTOOL) --mode=link \
	$(CC) $(LTSTATIC) $(LT_CFLAGS) $(LDFLAGS) $(LTFLAGS)

LTCOMPILE_LIB = $(LIBTOOL) $(LTONLY_LIB) --mode=compile \
	$(CC) $(LT_CFLAGS) $(LT_CPPFLAGS) $(LIB_DEFS) -c

LTLINK_LIB = $(LIBTOOL) $(LTONLY_LIB) --mode=link \
	$(CC) $(LT_CFLAGS) $(LDFLAGS) $(LTFLAGS_LIB) $(SYMBOL_VERSION_FLAGS)

LTCOMPILE_MOD = $(LIBTOOL) $(LTONLY_MOD) --mode=compile \
	$(CC) $(LT_CFLAGS) $(LT_CPPFLAGS) $(MOD_DEFS) -c

LTLINK_MOD = $(LIBTOOL) $(LTONLY_MOD) --mode=link \
	$(CC) $(LT_CFLAGS) $(LDFLAGS) $(LTFLAGS_MOD)

LTINSTALL = $(LIBTOOL) --mode=install $(INSTALL) 
LTFINISH = $(LIBTOOL) --mode=finish

# Misc UNIX commands used in build environment
AR = ar
BASENAME = basename
CAT = cat
CHMOD = chmod
DATE = date
ECHO = $(SHTOOL) echo
HOSTNAME = $(SHTOOL) echo -e "%h%d"
LN = $(SHTOOL) mkln
LN_H = $(LN)
LN_S = $(LN) -s
MAKEINFO = @MAKEINFO@
MKDIR = $(SHTOOL) mkdir -p
MV = $(SHTOOL) move
PWD = pwd
RANLIB = ranlib
RM = rm -f
SED = sed
SUBST = $(SHTOOL) subst

# For manual pages
# MANCOMPRESS=@MANCOMPRESS@
# MANCOMPRESSSUFFIX=@MANCOMPRESSSUFFIX@
MANCOMPRESS=$(CAT)
MANCOMPRESSSUFFIX=

SOELIM=soelim

INCLUDEDIR= $(top_srcdir)/include
LDAP_INCPATH= -I$(LDAP_INCDIR) -I$(INCLUDEDIR)
LDAP_LIBDIR= $(top_builddir)/libraries

CLIENT_LIBS = 

LUTIL_LIBS = 
LTHREAD_LIBS =  -pthread

SLAPD_NDB_LIBS = 
WT_LIBS = 

LEVENT_LIBS = 

LDAP_LIBLBER_LA = $(LDAP_LIBDIR)/liblber/liblber.la
LDAP_LIBLDAP_LA = $(LDAP_LIBDIR)/libldap/libldap.la

LDAP_LIBREWRITE_A = $(LDAP_LIBDIR)/librewrite/librewrite.a
LDAP_LIBLUNICODE_A = $(LDAP_LIBDIR)/liblunicode/liblunicode.a
LDAP_LIBLUTIL_A = $(LDAP_LIBDIR)/liblutil/liblutil.a

LDAP_L = $(LDAP_LIBLUTIL_A) \
	$(LDAP_LIBLDAP_LA) $(LDAP_LIBLBER_LA)
SLAPD_L = $(LDAP_LIBLUNICODE_A) $(LDAP_LIBREWRITE_A) \
	$(LDAP_LIBLUTIL_A) $(LDAP_LIBLDAP_LA) $(LDAP_LIBLBER_LA)
LLOADD_L = $(LDAP_LIBLUTIL_A) $(LDAP_LIBLDAP_LA) \
	$(LDAP_LIBLBER_LA)

WRAP_LIBS = 
# AutoConfig generated 
AC_CC	= cc
AC_CFLAGS = -g -O2
AC_DEFS =  # -DHAVE_CONFIG_H
AC_LDFLAGS = 
AC_LIBS = -lresolv 

SASL_LIBS = 
TLS_LIBS = 
AUTH_LIBS = 
ARGON2_LIBS = 
SECURITY_LIBS = $(SASL_LIBS) $(TLS_LIBS) $(AUTH_LIBS)
SYSTEMD_LIBS = 

MODULES_CPPFLAGS = 
MODULES_LDFLAGS = 
MODULES_LIBS = 
SLAPD_PERL_LDFLAGS = 

SLAPD_SQL_LDFLAGS = 
SLAPD_SQL_INCLUDES = 
SLAPD_SQL_LIBS = 

SLAPD_LIBS =       $(SYSTEMD_LIBS)
LLOADD_LIBS =  $(LEVENT_LIBS)

# Our Defaults
CC = $(AC_CC)
DEFS = $(LDAP_INCPATH) $(XINCPATH) $(XDEFS) $(AC_DEFS) $(DEFINES)
CFLAGS = $(AC_CFLAGS) $(DEFS)
LDFLAGS = $(LDAP_LIBPATH) $(AC_LDFLAGS) $(XLDFLAGS)
LIBS = $(XLIBS) $(XXLIBS) $(AC_LIBS) $(XXXLIBS)

LT_CFLAGS = $(AC_CFLAGS)
LT_CPPFLAGS = $(DEFS)

all:		all-common all-local FORCE
install:	install-common install-local FORCE
clean:		clean-common clean-local FORCE
veryclean:	veryclean-common veryclean-local FORCE
depend:		depend-common depend-local FORCE

# empty common rules
all-common:
install-common:
clean-common:
veryclean-common:	clean-common FORCE
depend-common:
lint-common:
lint5-common:

# empty local rules
all-local:
install-local:
clean-local:
veryclean-local:	clean-local FORCE
depend-local:
lint-local:
lint5-local:

veryclean: FORCE
	$(RM) Makefile
	$(RM) -r .libs

Makefile: Makefile.in $(top_srcdir)/build/top.mk

pathtest:
	$(SHTOOL) --version

# empty rule for forcing rules
FORCE:

##---------------------------------------------------------------------------

# Makefile for -llutil
# $OpenLDAP$
## This work is part of OpenLDAP Software <http://www.openldap.org/>.
## 
## Copyright 1998-2022 The OpenLDAP Foundation.
## All rights reserved.
##
## Redistribution and use in source and binary forms, with or without
## modification, are permitted only as authorized by the OpenLDAP
## Public License.
##
## A copy of this license is available in the file LICENSE in the
## top-level directory of the distribution or, alternatively, at
## <http://www.OpenLDAP.org/license.html>.

LIBRARY	= liblutil.a

LDAP_INCDIR= ../../include       
LDAP_LIBDIR= ../../libraries

NT_SRCS = ntservice.c
NT_OBJS = ntservice.o slapdmsg.res

UNIX_SRCS = detach.c
UNIX_OBJS = detach.o

XLIBS = $(LIBRARY) $(LDAP_LIBLBER_LA)

SRCS	= base64.c entropy.c sasl.c signal.c hash.c passfile.c \
	md5.c passwd.c sha1.c getpass.c lockf.c utils.c uuid.c sockpair.c \
	meter.c \
	 getpeereid.c $(UNIX_SRCS)

OBJS	= base64.o entropy.o sasl.o signal.o hash.o passfile.o \
	md5.o passwd.o sha1.o getpass.o lockf.o utils.o uuid.o sockpair.o \
	meter.o \
	 ${LIBOBJDIR}getpeereid$U.o $(UNIX_OBJS)

# These rules are for a Mingw32 build, specifically.
# It's ok for them to be here because the clean rule is harmless, and
# slapdmsg.res won't get built unless it's declared in OBJS.

RC = 

slapdmsg.bin: FORCE
	@if [ ! -f $@ ]; then cp $(srcdir)/$@ .; fi

slapdmsg.res: slapdmsg.rc slapdmsg.bin
	$(RC) $< -O coff -o $@

clean-local:
	$(RM) *.res

# $OpenLDAP$
## This work is part of OpenLDAP Software <http://www.openldap.org/>.
##
## Copyright 1998-2022 The OpenLDAP Foundation.
## All rights reserved.
##
## Redistribution and use in source and binary forms, with or without
## modification, are permitted only as authorized by the OpenLDAP
## Public License.
##
## A copy of this license is available in the file LICENSE in the
## top-level directory of the distribution or, alternatively, at
## <http://www.OpenLDAP.org/license.html>.
##---------------------------------------------------------------------------
#
# Makefile Template for Libraries
#

all-common: $(LIBRARY) $(PROGRAMS)

version.c: Makefile
	$(RM) $@
	$(MKVERSION) $(LIBRARY) > $@

version.o version.lo: version.c $(OBJS)

install-common: FORCE

lint: lint-local FORCE
	$(LINT) $(DEFS) $(DEFINES) $(SRCS)

lint5: lint5-local FORCE
	$(5LINT) $(DEFS) $(DEFINES) $(SRCS)

#
# In the mingw/cygwin environment, the so and dll files must be
# deleted separately, instead of using the {.so*,*.dll} construct
# that was previously used. It just didn't work.
#
clean-common: 	FORCE
	$(RM) $(LIBRARY) ../$(LIBRARY) $(XLIBRARY) \
		$(PROGRAMS) $(XPROGRAMS) $(XSRCS) $(XXSRCS) \
		*.o *.lo a.out *.exe *.pc core version.c .libs/*

depend-common: FORCE
	$(MKDEP) $(DEFS) $(DEFINES) $(SRCS) $(XXSRCS)

lint-local: FORCE
lint5-local: FORCE

Makefile: $(top_srcdir)/build/lib.mk

# $OpenLDAP$
## This work is part of OpenLDAP Software <http://www.openldap.org/>.
##
## Copyright 1998-2022 The OpenLDAP Foundation.
## All rights reserved.
##
## Redistribution and use in source and binary forms, with or without
## modification, are permitted only as authorized by the OpenLDAP
## Public License.
##
## A copy of this license is available in the file LICENSE in the
## top-level directory of the distribution or, alternatively, at
## <http://www.OpenLDAP.org/license.html>.
##---------------------------------------------------------------------------
#
# Makefile Template for Static Libraries
#

$(LIBRARY): version.o
	$(AR) ru $@ $(OBJS) version.o
	@$(RANLIB) $@

Makefile: $(top_srcdir)/build/lib-static.mk
# DO NOT DELETE THIS LINE -- mkdep uses it.
# DO NOT PUT ANYTHING AFTER THIS LINE, IT WILL GO AWAY.


#
# files: -I../../include -I../../include base64.c entropy.c sasl.c signal.c hash.c passfile.c md5.c passwd.c sha1.c getpass.c lockf.c utils.c uuid.c sockpair.c meter.c getpeereid.c detach.c
# command: cc -M -I.  -I../../include -I../../include base64.c entropy.c sasl.c signal.c hash.c passfile.c md5.c passwd.c sha1.c getpass.c lockf.c utils.c uuid.c sockpair.c meter.c getpeereid.c detach.c
#

base64.o: base64.c
base64.o: /usr/include/stdc-predef.h
base64.o: ../../include/portable.h
base64.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
base64.o: ../../include/ac/fdset.h
base64.o: /usr/include/x86_64-linux-gnu/bits/types.h
base64.o: /usr/include/features.h
base64.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
base64.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
base64.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
base64.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
base64.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
base64.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
base64.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
base64.o: /usr/include/x86_64-linux-gnu/bits/time64.h
base64.o: ../../include/ldap_cdefs.h
base64.o: ../../include/ldap_features.h
base64.o: ../../include/ac/assert.h
base64.o: /usr/include/assert.h
base64.o: ../../include/ac/localize.h
base64.o: ../../include/ac/assert.h
base64.o: ../../include/ac/stdlib.h
base64.o: /usr/include/stdlib.h
base64.o: /usr/include/x86_64-linux-gnu/bits/libc-header-start.h
base64.o: /usr/include/x86_64-linux-gnu/bits/waitflags.h
base64.o: /usr/include/x86_64-linux-gnu/bits/waitstatus.h
base64.o: /usr/include/x86_64-linux-gnu/bits/floatn.h
base64.o: /usr/include/x86_64-linux-gnu/bits/floatn-common.h
base64.o: /usr/include/x86_64-linux-gnu/sys/types.h
base64.o: /usr/include/x86_64-linux-gnu/bits/types/clock_t.h
base64.o: /usr/include/x86_64-linux-gnu/bits/types/clockid_t.h
base64.o: /usr/include/x86_64-linux-gnu/bits/types/time_t.h
base64.o: /usr/include/x86_64-linux-gnu/bits/types/timer_t.h
base64.o: /usr/include/x86_64-linux-gnu/bits/stdint-intn.h
base64.o: /usr/include/endian.h
base64.o: /usr/include/x86_64-linux-gnu/bits/endian.h
base64.o: /usr/include/x86_64-linux-gnu/bits/endianness.h
base64.o: /usr/include/x86_64-linux-gnu/bits/byteswap.h
base64.o: /usr/include/x86_64-linux-gnu/bits/uintn-identity.h
base64.o: /usr/include/x86_64-linux-gnu/sys/select.h
base64.o: /usr/include/x86_64-linux-gnu/bits/select.h
base64.o: /usr/include/x86_64-linux-gnu/bits/types/sigset_t.h
base64.o: /usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h
base64.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h
base64.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h
base64.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes.h
base64.o: /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h
base64.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h
base64.o: /usr/include/x86_64-linux-gnu/bits/struct_mutex.h
base64.o: /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h
base64.o: /usr/include/alloca.h
base64.o: /usr/include/x86_64-linux-gnu/bits/stdlib-float.h
base64.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/limits.h
base64.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/syslimits.h
base64.o: /usr/include/limits.h
base64.o: /usr/include/x86_64-linux-gnu/bits/posix1_lim.h
base64.o: /usr/include/x86_64-linux-gnu/bits/local_lim.h
base64.o: /usr/include/linux/limits.h
base64.o: /usr/include/x86_64-linux-gnu/bits/posix2_lim.h
base64.o: ../../include/ac/ctype.h
base64.o: /usr/include/ctype.h
base64.o: /usr/include/x86_64-linux-gnu/bits/types/locale_t.h
base64.o: /usr/include/x86_64-linux-gnu/bits/types/__locale_t.h
base64.o: ../../include/ac/string.h
base64.o: /usr/include/string.h
base64.o: /usr/include/strings.h
base64.o: ../../include/ac/socket.h
base64.o: /usr/include/poll.h
base64.o: /usr/include/x86_64-linux-gnu/sys/poll.h
base64.o: /usr/include/x86_64-linux-gnu/bits/poll.h
base64.o: /usr/include/x86_64-linux-gnu/sys/socket.h
base64.o: /usr/include/x86_64-linux-gnu/bits/types/struct_iovec.h
base64.o: /usr/include/x86_64-linux-gnu/bits/socket.h
base64.o: /usr/include/x86_64-linux-gnu/bits/socket_type.h
base64.o: /usr/include/x86_64-linux-gnu/bits/sockaddr.h
base64.o: /usr/include/x86_64-linux-gnu/asm/socket.h
base64.o: /usr/include/asm-generic/socket.h
base64.o: /usr/include/linux/posix_types.h
base64.o: /usr/include/linux/stddef.h
base64.o: /usr/include/x86_64-linux-gnu/asm/posix_types.h
base64.o: /usr/include/x86_64-linux-gnu/asm/posix_types_64.h
base64.o: /usr/include/asm-generic/posix_types.h
base64.o: /usr/include/x86_64-linux-gnu/asm/bitsperlong.h
base64.o: /usr/include/asm-generic/bitsperlong.h
base64.o: /usr/include/x86_64-linux-gnu/asm/sockios.h
base64.o: /usr/include/asm-generic/sockios.h
base64.o: /usr/include/x86_64-linux-gnu/bits/types/struct_osockaddr.h
base64.o: /usr/include/x86_64-linux-gnu/sys/un.h
base64.o: /usr/include/netinet/in.h
base64.o: /usr/include/x86_64-linux-gnu/bits/stdint-uintn.h
base64.o: /usr/include/x86_64-linux-gnu/bits/in.h
base64.o: /usr/include/netinet/tcp.h
base64.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdint.h
base64.o: /usr/include/stdint.h
base64.o: /usr/include/x86_64-linux-gnu/bits/wchar.h
base64.o: /usr/include/arpa/inet.h
base64.o: /usr/include/arpa/nameser.h
base64.o: /usr/include/x86_64-linux-gnu/sys/param.h
base64.o: /usr/include/signal.h
base64.o: /usr/include/x86_64-linux-gnu/bits/signum.h
base64.o: /usr/include/x86_64-linux-gnu/bits/signum-generic.h
base64.o: /usr/include/x86_64-linux-gnu/bits/types/sig_atomic_t.h
base64.o: /usr/include/x86_64-linux-gnu/bits/types/siginfo_t.h
base64.o: /usr/include/x86_64-linux-gnu/bits/types/__sigval_t.h
base64.o: /usr/include/x86_64-linux-gnu/bits/siginfo-arch.h
base64.o: /usr/include/x86_64-linux-gnu/bits/siginfo-consts.h
base64.o: /usr/include/x86_64-linux-gnu/bits/types/sigval_t.h
base64.o: /usr/include/x86_64-linux-gnu/bits/types/sigevent_t.h
base64.o: /usr/include/x86_64-linux-gnu/bits/sigevent-consts.h
base64.o: /usr/include/x86_64-linux-gnu/bits/sigaction.h
base64.o: /usr/include/x86_64-linux-gnu/bits/sigcontext.h
base64.o: /usr/include/x86_64-linux-gnu/bits/types/stack_t.h
base64.o: /usr/include/x86_64-linux-gnu/sys/ucontext.h
base64.o: /usr/include/x86_64-linux-gnu/bits/sigstack.h
base64.o: /usr/include/x86_64-linux-gnu/bits/ss_flags.h
base64.o: /usr/include/x86_64-linux-gnu/bits/types/struct_sigstack.h
base64.o: /usr/include/x86_64-linux-gnu/bits/sigthread.h
base64.o: /usr/include/x86_64-linux-gnu/bits/signal_ext.h
base64.o: /usr/include/x86_64-linux-gnu/bits/param.h
base64.o: /usr/include/linux/param.h
base64.o: /usr/include/x86_64-linux-gnu/asm/param.h
base64.o: /usr/include/asm-generic/param.h
base64.o: /usr/include/arpa/nameser_compat.h
base64.o: /usr/include/netdb.h
base64.o: /usr/include/rpc/netdb.h
base64.o: /usr/include/x86_64-linux-gnu/bits/netdb.h
base64.o: /usr/include/resolv.h
base64.o: /usr/include/stdio.h
base64.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdarg.h
base64.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h
base64.o: /usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h
base64.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos64_t.h
base64.o: /usr/include/x86_64-linux-gnu/bits/types/__FILE.h
base64.o: /usr/include/x86_64-linux-gnu/bits/types/FILE.h
base64.o: /usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h
base64.o: /usr/include/x86_64-linux-gnu/bits/stdio_lim.h
base64.o: /usr/include/x86_64-linux-gnu/bits/sys_errlist.h
base64.o: /usr/include/x86_64-linux-gnu/bits/types/res_state.h
base64.o: ../../include/lutil.h
base64.o: ../../include/ldap_cdefs.h
base64.o: ../../include/lber_types.h
entropy.o: entropy.c
entropy.o: /usr/include/stdc-predef.h
entropy.o: ../../include/portable.h
entropy.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
entropy.o: ../../include/ac/fdset.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/types.h
entropy.o: /usr/include/features.h
entropy.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
entropy.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
entropy.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/time64.h
entropy.o: ../../include/ldap_cdefs.h
entropy.o: ../../include/ldap_features.h
entropy.o: ../../include/ac/assert.h
entropy.o: /usr/include/assert.h
entropy.o: ../../include/ac/localize.h
entropy.o: ../../include/ac/string.h
entropy.o: /usr/include/string.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/libc-header-start.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/types/locale_t.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/types/__locale_t.h
entropy.o: /usr/include/strings.h
entropy.o: ../../include/ac/time.h
entropy.o: /usr/include/x86_64-linux-gnu/sys/time.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/types/time_t.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h
entropy.o: /usr/include/x86_64-linux-gnu/sys/select.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/select.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/types/sigset_t.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/endian.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/endianness.h
entropy.o: /usr/include/time.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/time.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/types/clock_t.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/types/struct_tm.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/types/clockid_t.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/types/timer_t.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/types/struct_itimerspec.h
entropy.o: ../../include/ac/unistd.h
entropy.o: /usr/include/x86_64-linux-gnu/sys/types.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/stdint-intn.h
entropy.o: /usr/include/endian.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/byteswap.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/uintn-identity.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/struct_mutex.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h
entropy.o: /usr/include/unistd.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/posix_opt.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/environments.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/confname.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/getopt_posix.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/getopt_core.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/unistd_ext.h
entropy.o: /usr/include/getopt.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/getopt_ext.h
entropy.o: ../../include/lutil_lockf.h
entropy.o: /usr/include/fcntl.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/fcntl.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/fcntl-linux.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/stat.h
entropy.o: ../../include/lutil.h
entropy.o: ../../include/ldap_cdefs.h
entropy.o: ../../include/lber_types.h
entropy.o: ../../include/ac/socket.h
entropy.o: /usr/include/poll.h
entropy.o: /usr/include/x86_64-linux-gnu/sys/poll.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/poll.h
entropy.o: /usr/include/x86_64-linux-gnu/sys/socket.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/types/struct_iovec.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/socket.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/socket_type.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/sockaddr.h
entropy.o: /usr/include/x86_64-linux-gnu/asm/socket.h
entropy.o: /usr/include/asm-generic/socket.h
entropy.o: /usr/include/linux/posix_types.h
entropy.o: /usr/include/linux/stddef.h
entropy.o: /usr/include/x86_64-linux-gnu/asm/posix_types.h
entropy.o: /usr/include/x86_64-linux-gnu/asm/posix_types_64.h
entropy.o: /usr/include/asm-generic/posix_types.h
entropy.o: /usr/include/x86_64-linux-gnu/asm/bitsperlong.h
entropy.o: /usr/include/asm-generic/bitsperlong.h
entropy.o: /usr/include/x86_64-linux-gnu/asm/sockios.h
entropy.o: /usr/include/asm-generic/sockios.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/types/struct_osockaddr.h
entropy.o: /usr/include/x86_64-linux-gnu/sys/un.h
entropy.o: /usr/include/netinet/in.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/stdint-uintn.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/in.h
entropy.o: /usr/include/netinet/tcp.h
entropy.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdint.h
entropy.o: /usr/include/stdint.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/wchar.h
entropy.o: /usr/include/arpa/inet.h
entropy.o: /usr/include/arpa/nameser.h
entropy.o: /usr/include/x86_64-linux-gnu/sys/param.h
entropy.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/limits.h
entropy.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/syslimits.h
entropy.o: /usr/include/limits.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/posix1_lim.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/local_lim.h
entropy.o: /usr/include/linux/limits.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/posix2_lim.h
entropy.o: /usr/include/signal.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/signum.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/signum-generic.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/types/sig_atomic_t.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/types/siginfo_t.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/types/__sigval_t.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/siginfo-arch.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/siginfo-consts.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/types/sigval_t.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/types/sigevent_t.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/sigevent-consts.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/sigaction.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/sigcontext.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/types/stack_t.h
entropy.o: /usr/include/x86_64-linux-gnu/sys/ucontext.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/sigstack.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/ss_flags.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/types/struct_sigstack.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/sigthread.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/signal_ext.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/param.h
entropy.o: /usr/include/linux/param.h
entropy.o: /usr/include/x86_64-linux-gnu/asm/param.h
entropy.o: /usr/include/asm-generic/param.h
entropy.o: /usr/include/arpa/nameser_compat.h
entropy.o: /usr/include/netdb.h
entropy.o: /usr/include/rpc/netdb.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/netdb.h
entropy.o: /usr/include/resolv.h
entropy.o: /usr/include/stdio.h
entropy.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdarg.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos64_t.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/types/__FILE.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/types/FILE.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/stdio_lim.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/sys_errlist.h
entropy.o: /usr/include/x86_64-linux-gnu/bits/types/res_state.h
entropy.o: ../../include/lutil_md5.h
sasl.o: sasl.c
sasl.o: /usr/include/stdc-predef.h
sasl.o: ../../include/portable.h
sasl.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
sasl.o: ../../include/ac/fdset.h
sasl.o: /usr/include/x86_64-linux-gnu/bits/types.h
sasl.o: /usr/include/features.h
sasl.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
sasl.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
sasl.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
sasl.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
sasl.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
sasl.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
sasl.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
sasl.o: /usr/include/x86_64-linux-gnu/bits/time64.h
sasl.o: ../../include/ldap_cdefs.h
sasl.o: ../../include/ldap_features.h
sasl.o: ../../include/ac/assert.h
sasl.o: /usr/include/assert.h
sasl.o: ../../include/ac/localize.h
signal.o: signal.c
signal.o: /usr/include/stdc-predef.h
signal.o: ../../include/portable.h
signal.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
signal.o: ../../include/ac/fdset.h
signal.o: /usr/include/x86_64-linux-gnu/bits/types.h
signal.o: /usr/include/features.h
signal.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
signal.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
signal.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
signal.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
signal.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
signal.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
signal.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
signal.o: /usr/include/x86_64-linux-gnu/bits/time64.h
signal.o: ../../include/ldap_cdefs.h
signal.o: ../../include/ldap_features.h
signal.o: ../../include/ac/assert.h
signal.o: /usr/include/assert.h
signal.o: ../../include/ac/localize.h
signal.o: ../../include/ac/string.h
signal.o: /usr/include/string.h
signal.o: /usr/include/x86_64-linux-gnu/bits/libc-header-start.h
signal.o: /usr/include/x86_64-linux-gnu/bits/types/locale_t.h
signal.o: /usr/include/x86_64-linux-gnu/bits/types/__locale_t.h
signal.o: /usr/include/strings.h
signal.o: ../../include/ac/signal.h
signal.o: /usr/include/signal.h
signal.o: /usr/include/x86_64-linux-gnu/bits/signum.h
signal.o: /usr/include/x86_64-linux-gnu/bits/signum-generic.h
signal.o: /usr/include/x86_64-linux-gnu/bits/types/sig_atomic_t.h
signal.o: /usr/include/x86_64-linux-gnu/bits/types/sigset_t.h
signal.o: /usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h
signal.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h
signal.o: /usr/include/x86_64-linux-gnu/bits/endian.h
signal.o: /usr/include/x86_64-linux-gnu/bits/endianness.h
signal.o: /usr/include/x86_64-linux-gnu/bits/types/siginfo_t.h
signal.o: /usr/include/x86_64-linux-gnu/bits/types/__sigval_t.h
signal.o: /usr/include/x86_64-linux-gnu/bits/siginfo-arch.h
signal.o: /usr/include/x86_64-linux-gnu/bits/siginfo-consts.h
signal.o: /usr/include/x86_64-linux-gnu/bits/types/sigval_t.h
signal.o: /usr/include/x86_64-linux-gnu/bits/types/sigevent_t.h
signal.o: /usr/include/x86_64-linux-gnu/bits/sigevent-consts.h
signal.o: /usr/include/x86_64-linux-gnu/bits/sigaction.h
signal.o: /usr/include/x86_64-linux-gnu/bits/sigcontext.h
signal.o: /usr/include/x86_64-linux-gnu/bits/types/stack_t.h
signal.o: /usr/include/x86_64-linux-gnu/sys/ucontext.h
signal.o: /usr/include/x86_64-linux-gnu/bits/sigstack.h
signal.o: /usr/include/x86_64-linux-gnu/bits/ss_flags.h
signal.o: /usr/include/x86_64-linux-gnu/bits/types/struct_sigstack.h
signal.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes.h
signal.o: /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h
signal.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h
signal.o: /usr/include/x86_64-linux-gnu/bits/struct_mutex.h
signal.o: /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h
signal.o: /usr/include/x86_64-linux-gnu/bits/sigthread.h
signal.o: /usr/include/x86_64-linux-gnu/bits/signal_ext.h
hash.o: hash.c
hash.o: /usr/include/stdc-predef.h
hash.o: ../../include/portable.h
hash.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
hash.o: ../../include/ac/fdset.h
hash.o: /usr/include/x86_64-linux-gnu/bits/types.h
hash.o: /usr/include/features.h
hash.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
hash.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
hash.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
hash.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
hash.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
hash.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
hash.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
hash.o: /usr/include/x86_64-linux-gnu/bits/time64.h
hash.o: ../../include/ldap_cdefs.h
hash.o: ../../include/ldap_features.h
hash.o: ../../include/ac/assert.h
hash.o: /usr/include/assert.h
hash.o: ../../include/ac/localize.h
hash.o: ../../include/lutil_hash.h
hash.o: ../../include/lber_types.h
hash.o: ../../include/ldap_cdefs.h
passfile.o: passfile.c
passfile.o: /usr/include/stdc-predef.h
passfile.o: ../../include/portable.h
passfile.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
passfile.o: ../../include/ac/fdset.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/types.h
passfile.o: /usr/include/features.h
passfile.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
passfile.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
passfile.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/time64.h
passfile.o: ../../include/ldap_cdefs.h
passfile.o: ../../include/ldap_features.h
passfile.o: ../../include/ac/assert.h
passfile.o: /usr/include/assert.h
passfile.o: ../../include/ac/localize.h
passfile.o: /usr/include/stdio.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/libc-header-start.h
passfile.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdarg.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos64_t.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/types/__FILE.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/types/FILE.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/stdio_lim.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/sys_errlist.h
passfile.o: ../../include/ac/stdlib.h
passfile.o: /usr/include/stdlib.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/waitflags.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/waitstatus.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/floatn.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/floatn-common.h
passfile.o: /usr/include/x86_64-linux-gnu/sys/types.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/types/clock_t.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/types/clockid_t.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/types/time_t.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/types/timer_t.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/stdint-intn.h
passfile.o: /usr/include/endian.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/endian.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/endianness.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/byteswap.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/uintn-identity.h
passfile.o: /usr/include/x86_64-linux-gnu/sys/select.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/select.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/types/sigset_t.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/struct_mutex.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h
passfile.o: /usr/include/alloca.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/stdlib-float.h
passfile.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/limits.h
passfile.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/syslimits.h
passfile.o: /usr/include/limits.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/posix1_lim.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/local_lim.h
passfile.o: /usr/include/linux/limits.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/posix2_lim.h
passfile.o: ../../include/ac/ctype.h
passfile.o: /usr/include/ctype.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/types/locale_t.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/types/__locale_t.h
passfile.o: ../../include/ac/string.h
passfile.o: /usr/include/string.h
passfile.o: /usr/include/strings.h
passfile.o: /usr/include/x86_64-linux-gnu/sys/stat.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/stat.h
passfile.o: ../../include/lber.h
passfile.o: ../../include/lber_types.h
passfile.o: ../../include/ldap_cdefs.h
passfile.o: ../../include/lutil.h
passfile.o: ../../include/ac/socket.h
passfile.o: /usr/include/poll.h
passfile.o: /usr/include/x86_64-linux-gnu/sys/poll.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/poll.h
passfile.o: /usr/include/x86_64-linux-gnu/sys/socket.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/types/struct_iovec.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/socket.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/socket_type.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/sockaddr.h
passfile.o: /usr/include/x86_64-linux-gnu/asm/socket.h
passfile.o: /usr/include/asm-generic/socket.h
passfile.o: /usr/include/linux/posix_types.h
passfile.o: /usr/include/linux/stddef.h
passfile.o: /usr/include/x86_64-linux-gnu/asm/posix_types.h
passfile.o: /usr/include/x86_64-linux-gnu/asm/posix_types_64.h
passfile.o: /usr/include/asm-generic/posix_types.h
passfile.o: /usr/include/x86_64-linux-gnu/asm/bitsperlong.h
passfile.o: /usr/include/asm-generic/bitsperlong.h
passfile.o: /usr/include/x86_64-linux-gnu/asm/sockios.h
passfile.o: /usr/include/asm-generic/sockios.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/types/struct_osockaddr.h
passfile.o: /usr/include/x86_64-linux-gnu/sys/un.h
passfile.o: /usr/include/netinet/in.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/stdint-uintn.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/in.h
passfile.o: /usr/include/netinet/tcp.h
passfile.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdint.h
passfile.o: /usr/include/stdint.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/wchar.h
passfile.o: /usr/include/arpa/inet.h
passfile.o: /usr/include/arpa/nameser.h
passfile.o: /usr/include/x86_64-linux-gnu/sys/param.h
passfile.o: /usr/include/signal.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/signum.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/signum-generic.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/types/sig_atomic_t.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/types/siginfo_t.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/types/__sigval_t.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/siginfo-arch.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/siginfo-consts.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/types/sigval_t.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/types/sigevent_t.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/sigevent-consts.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/sigaction.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/sigcontext.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/types/stack_t.h
passfile.o: /usr/include/x86_64-linux-gnu/sys/ucontext.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/sigstack.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/ss_flags.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/types/struct_sigstack.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/sigthread.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/signal_ext.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/param.h
passfile.o: /usr/include/linux/param.h
passfile.o: /usr/include/x86_64-linux-gnu/asm/param.h
passfile.o: /usr/include/asm-generic/param.h
passfile.o: /usr/include/arpa/nameser_compat.h
passfile.o: /usr/include/netdb.h
passfile.o: /usr/include/rpc/netdb.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/netdb.h
passfile.o: /usr/include/resolv.h
passfile.o: /usr/include/x86_64-linux-gnu/bits/types/res_state.h
md5.o: md5.c
md5.o: /usr/include/stdc-predef.h
md5.o: ../../include/portable.h
md5.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
md5.o: ../../include/ac/fdset.h
md5.o: /usr/include/x86_64-linux-gnu/bits/types.h
md5.o: /usr/include/features.h
md5.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
md5.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
md5.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
md5.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
md5.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
md5.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
md5.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
md5.o: /usr/include/x86_64-linux-gnu/bits/time64.h
md5.o: ../../include/ldap_cdefs.h
md5.o: ../../include/ldap_features.h
md5.o: ../../include/ac/assert.h
md5.o: /usr/include/assert.h
md5.o: ../../include/ac/localize.h
md5.o: ../../include/ac/string.h
md5.o: /usr/include/string.h
md5.o: /usr/include/x86_64-linux-gnu/bits/libc-header-start.h
md5.o: /usr/include/x86_64-linux-gnu/bits/types/locale_t.h
md5.o: /usr/include/x86_64-linux-gnu/bits/types/__locale_t.h
md5.o: /usr/include/strings.h
md5.o: ../../include/ac/socket.h
md5.o: /usr/include/x86_64-linux-gnu/sys/types.h
md5.o: /usr/include/x86_64-linux-gnu/bits/types/clock_t.h
md5.o: /usr/include/x86_64-linux-gnu/bits/types/clockid_t.h
md5.o: /usr/include/x86_64-linux-gnu/bits/types/time_t.h
md5.o: /usr/include/x86_64-linux-gnu/bits/types/timer_t.h
md5.o: /usr/include/x86_64-linux-gnu/bits/stdint-intn.h
md5.o: /usr/include/endian.h
md5.o: /usr/include/x86_64-linux-gnu/bits/endian.h
md5.o: /usr/include/x86_64-linux-gnu/bits/endianness.h
md5.o: /usr/include/x86_64-linux-gnu/bits/byteswap.h
md5.o: /usr/include/x86_64-linux-gnu/bits/uintn-identity.h
md5.o: /usr/include/x86_64-linux-gnu/sys/select.h
md5.o: /usr/include/x86_64-linux-gnu/bits/select.h
md5.o: /usr/include/x86_64-linux-gnu/bits/types/sigset_t.h
md5.o: /usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h
md5.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h
md5.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h
md5.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes.h
md5.o: /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h
md5.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h
md5.o: /usr/include/x86_64-linux-gnu/bits/struct_mutex.h
md5.o: /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h
md5.o: /usr/include/poll.h
md5.o: /usr/include/x86_64-linux-gnu/sys/poll.h
md5.o: /usr/include/x86_64-linux-gnu/bits/poll.h
md5.o: /usr/include/x86_64-linux-gnu/sys/socket.h
md5.o: /usr/include/x86_64-linux-gnu/bits/types/struct_iovec.h
md5.o: /usr/include/x86_64-linux-gnu/bits/socket.h
md5.o: /usr/include/x86_64-linux-gnu/bits/socket_type.h
md5.o: /usr/include/x86_64-linux-gnu/bits/sockaddr.h
md5.o: /usr/include/x86_64-linux-gnu/asm/socket.h
md5.o: /usr/include/asm-generic/socket.h
md5.o: /usr/include/linux/posix_types.h
md5.o: /usr/include/linux/stddef.h
md5.o: /usr/include/x86_64-linux-gnu/asm/posix_types.h
md5.o: /usr/include/x86_64-linux-gnu/asm/posix_types_64.h
md5.o: /usr/include/asm-generic/posix_types.h
md5.o: /usr/include/x86_64-linux-gnu/asm/bitsperlong.h
md5.o: /usr/include/asm-generic/bitsperlong.h
md5.o: /usr/include/x86_64-linux-gnu/asm/sockios.h
md5.o: /usr/include/asm-generic/sockios.h
md5.o: /usr/include/x86_64-linux-gnu/bits/types/struct_osockaddr.h
md5.o: /usr/include/x86_64-linux-gnu/sys/un.h
md5.o: /usr/include/netinet/in.h
md5.o: /usr/include/x86_64-linux-gnu/bits/stdint-uintn.h
md5.o: /usr/include/x86_64-linux-gnu/bits/in.h
md5.o: /usr/include/netinet/tcp.h
md5.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdint.h
md5.o: /usr/include/stdint.h
md5.o: /usr/include/x86_64-linux-gnu/bits/wchar.h
md5.o: /usr/include/arpa/inet.h
md5.o: /usr/include/arpa/nameser.h
md5.o: /usr/include/x86_64-linux-gnu/sys/param.h
md5.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/limits.h
md5.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/syslimits.h
md5.o: /usr/include/limits.h
md5.o: /usr/include/x86_64-linux-gnu/bits/posix1_lim.h
md5.o: /usr/include/x86_64-linux-gnu/bits/local_lim.h
md5.o: /usr/include/linux/limits.h
md5.o: /usr/include/x86_64-linux-gnu/bits/posix2_lim.h
md5.o: /usr/include/signal.h
md5.o: /usr/include/x86_64-linux-gnu/bits/signum.h
md5.o: /usr/include/x86_64-linux-gnu/bits/signum-generic.h
md5.o: /usr/include/x86_64-linux-gnu/bits/types/sig_atomic_t.h
md5.o: /usr/include/x86_64-linux-gnu/bits/types/siginfo_t.h
md5.o: /usr/include/x86_64-linux-gnu/bits/types/__sigval_t.h
md5.o: /usr/include/x86_64-linux-gnu/bits/siginfo-arch.h
md5.o: /usr/include/x86_64-linux-gnu/bits/siginfo-consts.h
md5.o: /usr/include/x86_64-linux-gnu/bits/types/sigval_t.h
md5.o: /usr/include/x86_64-linux-gnu/bits/types/sigevent_t.h
md5.o: /usr/include/x86_64-linux-gnu/bits/sigevent-consts.h
md5.o: /usr/include/x86_64-linux-gnu/bits/sigaction.h
md5.o: /usr/include/x86_64-linux-gnu/bits/sigcontext.h
md5.o: /usr/include/x86_64-linux-gnu/bits/types/stack_t.h
md5.o: /usr/include/x86_64-linux-gnu/sys/ucontext.h
md5.o: /usr/include/x86_64-linux-gnu/bits/sigstack.h
md5.o: /usr/include/x86_64-linux-gnu/bits/ss_flags.h
md5.o: /usr/include/x86_64-linux-gnu/bits/types/struct_sigstack.h
md5.o: /usr/include/x86_64-linux-gnu/bits/sigthread.h
md5.o: /usr/include/x86_64-linux-gnu/bits/signal_ext.h
md5.o: /usr/include/x86_64-linux-gnu/bits/param.h
md5.o: /usr/include/linux/param.h
md5.o: /usr/include/x86_64-linux-gnu/asm/param.h
md5.o: /usr/include/asm-generic/param.h
md5.o: /usr/include/arpa/nameser_compat.h
md5.o: /usr/include/netdb.h
md5.o: /usr/include/rpc/netdb.h
md5.o: /usr/include/x86_64-linux-gnu/bits/netdb.h
md5.o: /usr/include/resolv.h
md5.o: /usr/include/stdio.h
md5.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdarg.h
md5.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h
md5.o: /usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h
md5.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos64_t.h
md5.o: /usr/include/x86_64-linux-gnu/bits/types/__FILE.h
md5.o: /usr/include/x86_64-linux-gnu/bits/types/FILE.h
md5.o: /usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h
md5.o: /usr/include/x86_64-linux-gnu/bits/stdio_lim.h
md5.o: /usr/include/x86_64-linux-gnu/bits/sys_errlist.h
md5.o: /usr/include/x86_64-linux-gnu/bits/types/res_state.h
md5.o: ../../include/lutil_md5.h
md5.o: ../../include/lber_types.h
md5.o: ../../include/ldap_cdefs.h
passwd.o: passwd.c
passwd.o: /usr/include/stdc-predef.h
passwd.o: ../../include/portable.h
passwd.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
passwd.o: ../../include/ac/fdset.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/types.h
passwd.o: /usr/include/features.h
passwd.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
passwd.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
passwd.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/time64.h
passwd.o: ../../include/ldap_cdefs.h
passwd.o: ../../include/ldap_features.h
passwd.o: ../../include/ac/assert.h
passwd.o: /usr/include/assert.h
passwd.o: ../../include/ac/localize.h
passwd.o: /usr/include/stdio.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/libc-header-start.h
passwd.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdarg.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos64_t.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/types/__FILE.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/types/FILE.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/stdio_lim.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/sys_errlist.h
passwd.o: ../../include/ac/stdlib.h
passwd.o: /usr/include/stdlib.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/waitflags.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/waitstatus.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/floatn.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/floatn-common.h
passwd.o: /usr/include/x86_64-linux-gnu/sys/types.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/types/clock_t.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/types/clockid_t.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/types/time_t.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/types/timer_t.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/stdint-intn.h
passwd.o: /usr/include/endian.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/endian.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/endianness.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/byteswap.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/uintn-identity.h
passwd.o: /usr/include/x86_64-linux-gnu/sys/select.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/select.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/types/sigset_t.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/struct_mutex.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h
passwd.o: /usr/include/alloca.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/stdlib-float.h
passwd.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/limits.h
passwd.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/syslimits.h
passwd.o: /usr/include/limits.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/posix1_lim.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/local_lim.h
passwd.o: /usr/include/linux/limits.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/posix2_lim.h
passwd.o: ../../include/ac/string.h
passwd.o: /usr/include/string.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/types/locale_t.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/types/__locale_t.h
passwd.o: /usr/include/strings.h
passwd.o: ../../include/ac/unistd.h
passwd.o: /usr/include/unistd.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/posix_opt.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/environments.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/confname.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/getopt_posix.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/getopt_core.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/unistd_ext.h
passwd.o: /usr/include/getopt.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/getopt_ext.h
passwd.o: ../../include/lutil_lockf.h
passwd.o: ../../include/ac/param.h
passwd.o: /usr/include/x86_64-linux-gnu/sys/param.h
passwd.o: /usr/include/signal.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/signum.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/signum-generic.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/types/sig_atomic_t.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/types/siginfo_t.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/types/__sigval_t.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/siginfo-arch.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/siginfo-consts.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/types/sigval_t.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/types/sigevent_t.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/sigevent-consts.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/sigaction.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/sigcontext.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/types/stack_t.h
passwd.o: /usr/include/x86_64-linux-gnu/sys/ucontext.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/sigstack.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/ss_flags.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/types/struct_sigstack.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/sigthread.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/signal_ext.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/param.h
passwd.o: /usr/include/linux/param.h
passwd.o: /usr/include/x86_64-linux-gnu/asm/param.h
passwd.o: /usr/include/asm-generic/param.h
passwd.o: ../../include/lber.h
passwd.o: ../../include/lber_types.h
passwd.o: ../../include/ldap_cdefs.h
passwd.o: ../../include/ldap_pvt.h
passwd.o: ../../include/openldap.h
passwd.o: ../../include/ldap.h
passwd.o: ../../include/ldap_features.h
passwd.o: ../../include/lber_pvt.h
passwd.o: ../../include/ldap_pvt_uc.h
passwd.o: ../../include/ac/bytes.h
passwd.o: ../../include/../libraries/liblunicode/ucdata/ucdata.h
passwd.o: ../../include/lutil_md5.h
passwd.o: ../../include/lutil_sha1.h
passwd.o: ../../include/lutil.h
passwd.o: ../../include/ac/socket.h
passwd.o: /usr/include/poll.h
passwd.o: /usr/include/x86_64-linux-gnu/sys/poll.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/poll.h
passwd.o: /usr/include/x86_64-linux-gnu/sys/socket.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/types/struct_iovec.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/socket.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/socket_type.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/sockaddr.h
passwd.o: /usr/include/x86_64-linux-gnu/asm/socket.h
passwd.o: /usr/include/asm-generic/socket.h
passwd.o: /usr/include/linux/posix_types.h
passwd.o: /usr/include/linux/stddef.h
passwd.o: /usr/include/x86_64-linux-gnu/asm/posix_types.h
passwd.o: /usr/include/x86_64-linux-gnu/asm/posix_types_64.h
passwd.o: /usr/include/asm-generic/posix_types.h
passwd.o: /usr/include/x86_64-linux-gnu/asm/bitsperlong.h
passwd.o: /usr/include/asm-generic/bitsperlong.h
passwd.o: /usr/include/x86_64-linux-gnu/asm/sockios.h
passwd.o: /usr/include/asm-generic/sockios.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/types/struct_osockaddr.h
passwd.o: /usr/include/x86_64-linux-gnu/sys/un.h
passwd.o: /usr/include/netinet/in.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/stdint-uintn.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/in.h
passwd.o: /usr/include/netinet/tcp.h
passwd.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdint.h
passwd.o: /usr/include/stdint.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/wchar.h
passwd.o: /usr/include/arpa/inet.h
passwd.o: /usr/include/arpa/nameser.h
passwd.o: /usr/include/arpa/nameser_compat.h
passwd.o: /usr/include/netdb.h
passwd.o: /usr/include/rpc/netdb.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/netdb.h
passwd.o: /usr/include/resolv.h
passwd.o: /usr/include/x86_64-linux-gnu/bits/types/res_state.h
sha1.o: sha1.c
sha1.o: /usr/include/stdc-predef.h
sha1.o: ../../include/portable.h
sha1.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
sha1.o: ../../include/ac/fdset.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/types.h
sha1.o: /usr/include/features.h
sha1.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
sha1.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
sha1.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/time64.h
sha1.o: ../../include/ldap_cdefs.h
sha1.o: ../../include/ldap_features.h
sha1.o: ../../include/ac/assert.h
sha1.o: /usr/include/assert.h
sha1.o: ../../include/ac/localize.h
sha1.o: ../../include/ac/param.h
sha1.o: /usr/include/x86_64-linux-gnu/sys/param.h
sha1.o: /usr/include/x86_64-linux-gnu/sys/types.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/types/clock_t.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/types/clockid_t.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/types/time_t.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/types/timer_t.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/stdint-intn.h
sha1.o: /usr/include/endian.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/endian.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/endianness.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/byteswap.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/uintn-identity.h
sha1.o: /usr/include/x86_64-linux-gnu/sys/select.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/select.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/types/sigset_t.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/struct_mutex.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h
sha1.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/limits.h
sha1.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/syslimits.h
sha1.o: /usr/include/limits.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/libc-header-start.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/posix1_lim.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/local_lim.h
sha1.o: /usr/include/linux/limits.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/posix2_lim.h
sha1.o: /usr/include/signal.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/signum.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/signum-generic.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/types/sig_atomic_t.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/types/siginfo_t.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/types/__sigval_t.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/siginfo-arch.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/siginfo-consts.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/types/sigval_t.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/types/sigevent_t.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/sigevent-consts.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/sigaction.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/sigcontext.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/types/stack_t.h
sha1.o: /usr/include/x86_64-linux-gnu/sys/ucontext.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/sigstack.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/ss_flags.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/types/struct_sigstack.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/sigthread.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/signal_ext.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/param.h
sha1.o: /usr/include/linux/param.h
sha1.o: /usr/include/x86_64-linux-gnu/asm/param.h
sha1.o: /usr/include/asm-generic/param.h
sha1.o: ../../include/ac/unistd.h
sha1.o: /usr/include/unistd.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/posix_opt.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/environments.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/confname.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/getopt_posix.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/getopt_core.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/unistd_ext.h
sha1.o: /usr/include/getopt.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/getopt_ext.h
sha1.o: ../../include/lutil_lockf.h
sha1.o: ../../include/ac/string.h
sha1.o: /usr/include/string.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/types/locale_t.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/types/__locale_t.h
sha1.o: /usr/include/strings.h
sha1.o: ../../include/ac/socket.h
sha1.o: /usr/include/poll.h
sha1.o: /usr/include/x86_64-linux-gnu/sys/poll.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/poll.h
sha1.o: /usr/include/x86_64-linux-gnu/sys/socket.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/types/struct_iovec.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/socket.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/socket_type.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/sockaddr.h
sha1.o: /usr/include/x86_64-linux-gnu/asm/socket.h
sha1.o: /usr/include/asm-generic/socket.h
sha1.o: /usr/include/linux/posix_types.h
sha1.o: /usr/include/linux/stddef.h
sha1.o: /usr/include/x86_64-linux-gnu/asm/posix_types.h
sha1.o: /usr/include/x86_64-linux-gnu/asm/posix_types_64.h
sha1.o: /usr/include/asm-generic/posix_types.h
sha1.o: /usr/include/x86_64-linux-gnu/asm/bitsperlong.h
sha1.o: /usr/include/asm-generic/bitsperlong.h
sha1.o: /usr/include/x86_64-linux-gnu/asm/sockios.h
sha1.o: /usr/include/asm-generic/sockios.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/types/struct_osockaddr.h
sha1.o: /usr/include/x86_64-linux-gnu/sys/un.h
sha1.o: /usr/include/netinet/in.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/stdint-uintn.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/in.h
sha1.o: /usr/include/netinet/tcp.h
sha1.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdint.h
sha1.o: /usr/include/stdint.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/wchar.h
sha1.o: /usr/include/arpa/inet.h
sha1.o: /usr/include/arpa/nameser.h
sha1.o: /usr/include/arpa/nameser_compat.h
sha1.o: /usr/include/netdb.h
sha1.o: /usr/include/rpc/netdb.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/netdb.h
sha1.o: /usr/include/resolv.h
sha1.o: /usr/include/stdio.h
sha1.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdarg.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos64_t.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/types/__FILE.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/types/FILE.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/stdio_lim.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/sys_errlist.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/types/res_state.h
sha1.o: ../../include/ac/bytes.h
sha1.o: ../../include/lutil_sha1.h
sha1.o: ../../include/ldap_cdefs.h
sha1.o: ../../include/ac/stdlib.h
sha1.o: /usr/include/stdlib.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/waitflags.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/waitstatus.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/floatn.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/floatn-common.h
sha1.o: /usr/include/alloca.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/stdlib-float.h
sha1.o: ../../include/ac/errno.h
sha1.o: /usr/include/errno.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/errno.h
sha1.o: /usr/include/linux/errno.h
sha1.o: /usr/include/x86_64-linux-gnu/asm/errno.h
sha1.o: /usr/include/asm-generic/errno.h
sha1.o: /usr/include/asm-generic/errno-base.h
sha1.o: /usr/include/x86_64-linux-gnu/sys/file.h
sha1.o: /usr/include/fcntl.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/fcntl.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/fcntl-linux.h
sha1.o: /usr/include/x86_64-linux-gnu/bits/stat.h
getpass.o: getpass.c
getpass.o: /usr/include/stdc-predef.h
getpass.o: ../../include/portable.h
getpass.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
getpass.o: ../../include/ac/fdset.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/types.h
getpass.o: /usr/include/features.h
getpass.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
getpass.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
getpass.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/time64.h
getpass.o: ../../include/ldap_cdefs.h
getpass.o: ../../include/ldap_features.h
getpass.o: ../../include/ac/assert.h
getpass.o: /usr/include/assert.h
getpass.o: ../../include/ac/localize.h
getpass.o: /usr/include/stdio.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/libc-header-start.h
getpass.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdarg.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos64_t.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/types/__FILE.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/types/FILE.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/stdio_lim.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/sys_errlist.h
getpass.o: ../../include/ac/stdlib.h
getpass.o: /usr/include/stdlib.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/waitflags.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/waitstatus.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/floatn.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/floatn-common.h
getpass.o: /usr/include/x86_64-linux-gnu/sys/types.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/types/clock_t.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/types/clockid_t.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/types/time_t.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/types/timer_t.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/stdint-intn.h
getpass.o: /usr/include/endian.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/endian.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/endianness.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/byteswap.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/uintn-identity.h
getpass.o: /usr/include/x86_64-linux-gnu/sys/select.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/select.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/types/sigset_t.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/struct_mutex.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h
getpass.o: /usr/include/alloca.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/stdlib-float.h
getpass.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/limits.h
getpass.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/syslimits.h
getpass.o: /usr/include/limits.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/posix1_lim.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/local_lim.h
getpass.o: /usr/include/linux/limits.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/posix2_lim.h
getpass.o: ../../include/ac/ctype.h
getpass.o: /usr/include/ctype.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/types/locale_t.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/types/__locale_t.h
getpass.o: ../../include/ac/signal.h
getpass.o: /usr/include/signal.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/signum.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/signum-generic.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/types/sig_atomic_t.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/types/siginfo_t.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/types/__sigval_t.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/siginfo-arch.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/siginfo-consts.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/types/sigval_t.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/types/sigevent_t.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/sigevent-consts.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/sigaction.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/sigcontext.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/types/stack_t.h
getpass.o: /usr/include/x86_64-linux-gnu/sys/ucontext.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/sigstack.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/ss_flags.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/types/struct_sigstack.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/sigthread.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/signal_ext.h
getpass.o: ../../include/ac/string.h
getpass.o: /usr/include/string.h
getpass.o: /usr/include/strings.h
getpass.o: ../../include/ac/termios.h
getpass.o: /usr/include/termios.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/termios.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/termios-struct.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/termios-c_cc.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/termios-c_iflag.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/termios-c_oflag.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/termios-baud.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/termios-c_cflag.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/termios-c_lflag.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/termios-tcflow.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/termios-misc.h
getpass.o: /usr/include/x86_64-linux-gnu/sys/ttydefaults.h
getpass.o: ../../include/ac/time.h
getpass.o: /usr/include/x86_64-linux-gnu/sys/time.h
getpass.o: /usr/include/time.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/time.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/types/struct_tm.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/types/struct_itimerspec.h
getpass.o: ../../include/ac/unistd.h
getpass.o: /usr/include/unistd.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/posix_opt.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/environments.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/confname.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/getopt_posix.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/getopt_core.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/unistd_ext.h
getpass.o: /usr/include/getopt.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/getopt_ext.h
getpass.o: ../../include/lutil_lockf.h
getpass.o: /usr/include/fcntl.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/fcntl.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/fcntl-linux.h
getpass.o: /usr/include/x86_64-linux-gnu/bits/stat.h
getpass.o: ../../include/lber.h
getpass.o: ../../include/lber_types.h
getpass.o: ../../include/ldap_cdefs.h
getpass.o: ../../include/ldap.h
getpass.o: ../../include/ldap_features.h
getpass.o: ../../include/ldap_defaults.h
getpass.o: ../../include/ldap_config.h
lockf.o: lockf.c
lockf.o: /usr/include/stdc-predef.h
lockf.o: ../../include/portable.h
lockf.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
lockf.o: ../../include/ac/fdset.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/types.h
lockf.o: /usr/include/features.h
lockf.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
lockf.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
lockf.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/time64.h
lockf.o: ../../include/ldap_cdefs.h
lockf.o: ../../include/ldap_features.h
lockf.o: ../../include/ac/assert.h
lockf.o: /usr/include/assert.h
lockf.o: ../../include/ac/localize.h
lockf.o: /usr/include/stdio.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/libc-header-start.h
lockf.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdarg.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos64_t.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/types/__FILE.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/types/FILE.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/stdio_lim.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/sys_errlist.h
lockf.o: ../../include/ac/unistd.h
lockf.o: /usr/include/x86_64-linux-gnu/sys/types.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/types/clock_t.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/types/clockid_t.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/types/time_t.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/types/timer_t.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/stdint-intn.h
lockf.o: /usr/include/endian.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/endian.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/endianness.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/byteswap.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/uintn-identity.h
lockf.o: /usr/include/x86_64-linux-gnu/sys/select.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/select.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/types/sigset_t.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/struct_mutex.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h
lockf.o: /usr/include/unistd.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/posix_opt.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/environments.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/confname.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/getopt_posix.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/getopt_core.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/unistd_ext.h
lockf.o: /usr/include/getopt.h
lockf.o: /usr/include/x86_64-linux-gnu/bits/getopt_ext.h
lockf.o: ../../include/lutil_lockf.h
utils.o: utils.c
utils.o: /usr/include/stdc-predef.h
utils.o: ../../include/portable.h
utils.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
utils.o: ../../include/ac/fdset.h
utils.o: /usr/include/x86_64-linux-gnu/bits/types.h
utils.o: /usr/include/features.h
utils.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
utils.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
utils.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
utils.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
utils.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
utils.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
utils.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
utils.o: /usr/include/x86_64-linux-gnu/bits/time64.h
utils.o: ../../include/ldap_cdefs.h
utils.o: ../../include/ldap_features.h
utils.o: ../../include/ac/assert.h
utils.o: /usr/include/assert.h
utils.o: ../../include/ac/localize.h
utils.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/limits.h
utils.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/syslimits.h
utils.o: /usr/include/limits.h
utils.o: /usr/include/x86_64-linux-gnu/bits/libc-header-start.h
utils.o: /usr/include/x86_64-linux-gnu/bits/posix1_lim.h
utils.o: /usr/include/x86_64-linux-gnu/bits/local_lim.h
utils.o: /usr/include/linux/limits.h
utils.o: /usr/include/x86_64-linux-gnu/bits/posix2_lim.h
utils.o: /usr/include/stdio.h
utils.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdarg.h
utils.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h
utils.o: /usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h
utils.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos64_t.h
utils.o: /usr/include/x86_64-linux-gnu/bits/types/__FILE.h
utils.o: /usr/include/x86_64-linux-gnu/bits/types/FILE.h
utils.o: /usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h
utils.o: /usr/include/x86_64-linux-gnu/bits/stdio_lim.h
utils.o: /usr/include/x86_64-linux-gnu/bits/sys_errlist.h
utils.o: ../../include/ac/stdlib.h
utils.o: /usr/include/stdlib.h
utils.o: /usr/include/x86_64-linux-gnu/bits/waitflags.h
utils.o: /usr/include/x86_64-linux-gnu/bits/waitstatus.h
utils.o: /usr/include/x86_64-linux-gnu/bits/floatn.h
utils.o: /usr/include/x86_64-linux-gnu/bits/floatn-common.h
utils.o: /usr/include/x86_64-linux-gnu/sys/types.h
utils.o: /usr/include/x86_64-linux-gnu/bits/types/clock_t.h
utils.o: /usr/include/x86_64-linux-gnu/bits/types/clockid_t.h
utils.o: /usr/include/x86_64-linux-gnu/bits/types/time_t.h
utils.o: /usr/include/x86_64-linux-gnu/bits/types/timer_t.h
utils.o: /usr/include/x86_64-linux-gnu/bits/stdint-intn.h
utils.o: /usr/include/endian.h
utils.o: /usr/include/x86_64-linux-gnu/bits/endian.h
utils.o: /usr/include/x86_64-linux-gnu/bits/endianness.h
utils.o: /usr/include/x86_64-linux-gnu/bits/byteswap.h
utils.o: /usr/include/x86_64-linux-gnu/bits/uintn-identity.h
utils.o: /usr/include/x86_64-linux-gnu/sys/select.h
utils.o: /usr/include/x86_64-linux-gnu/bits/select.h
utils.o: /usr/include/x86_64-linux-gnu/bits/types/sigset_t.h
utils.o: /usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h
utils.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h
utils.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h
utils.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes.h
utils.o: /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h
utils.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h
utils.o: /usr/include/x86_64-linux-gnu/bits/struct_mutex.h
utils.o: /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h
utils.o: /usr/include/alloca.h
utils.o: /usr/include/x86_64-linux-gnu/bits/stdlib-float.h
utils.o: ../../include/ac/stdarg.h
utils.o: ../../include/ac/string.h
utils.o: /usr/include/string.h
utils.o: /usr/include/x86_64-linux-gnu/bits/types/locale_t.h
utils.o: /usr/include/x86_64-linux-gnu/bits/types/__locale_t.h
utils.o: /usr/include/strings.h
utils.o: ../../include/ac/ctype.h
utils.o: /usr/include/ctype.h
utils.o: ../../include/ac/unistd.h
utils.o: /usr/include/unistd.h
utils.o: /usr/include/x86_64-linux-gnu/bits/posix_opt.h
utils.o: /usr/include/x86_64-linux-gnu/bits/environments.h
utils.o: /usr/include/x86_64-linux-gnu/bits/confname.h
utils.o: /usr/include/x86_64-linux-gnu/bits/getopt_posix.h
utils.o: /usr/include/x86_64-linux-gnu/bits/getopt_core.h
utils.o: /usr/include/x86_64-linux-gnu/bits/unistd_ext.h
utils.o: /usr/include/getopt.h
utils.o: /usr/include/x86_64-linux-gnu/bits/getopt_ext.h
utils.o: ../../include/lutil_lockf.h
utils.o: ../../include/ac/time.h
utils.o: /usr/include/x86_64-linux-gnu/sys/time.h
utils.o: /usr/include/time.h
utils.o: /usr/include/x86_64-linux-gnu/bits/time.h
utils.o: /usr/include/x86_64-linux-gnu/bits/types/struct_tm.h
utils.o: /usr/include/x86_64-linux-gnu/bits/types/struct_itimerspec.h
utils.o: ../../include/ac/errno.h
utils.o: /usr/include/errno.h
utils.o: /usr/include/x86_64-linux-gnu/bits/errno.h
utils.o: /usr/include/linux/errno.h
utils.o: /usr/include/x86_64-linux-gnu/asm/errno.h
utils.o: /usr/include/asm-generic/errno.h
utils.o: /usr/include/asm-generic/errno-base.h
utils.o: /usr/include/fcntl.h
utils.o: /usr/include/x86_64-linux-gnu/bits/fcntl.h
utils.o: /usr/include/x86_64-linux-gnu/bits/fcntl-linux.h
utils.o: /usr/include/x86_64-linux-gnu/bits/stat.h
utils.o: ../../include/lutil.h
utils.o: ../../include/ldap_cdefs.h
utils.o: ../../include/lber_types.h
utils.o: ../../include/ac/socket.h
utils.o: /usr/include/poll.h
utils.o: /usr/include/x86_64-linux-gnu/sys/poll.h
utils.o: /usr/include/x86_64-linux-gnu/bits/poll.h
utils.o: /usr/include/x86_64-linux-gnu/sys/socket.h
utils.o: /usr/include/x86_64-linux-gnu/bits/types/struct_iovec.h
utils.o: /usr/include/x86_64-linux-gnu/bits/socket.h
utils.o: /usr/include/x86_64-linux-gnu/bits/socket_type.h
utils.o: /usr/include/x86_64-linux-gnu/bits/sockaddr.h
utils.o: /usr/include/x86_64-linux-gnu/asm/socket.h
utils.o: /usr/include/asm-generic/socket.h
utils.o: /usr/include/linux/posix_types.h
utils.o: /usr/include/linux/stddef.h
utils.o: /usr/include/x86_64-linux-gnu/asm/posix_types.h
utils.o: /usr/include/x86_64-linux-gnu/asm/posix_types_64.h
utils.o: /usr/include/asm-generic/posix_types.h
utils.o: /usr/include/x86_64-linux-gnu/asm/bitsperlong.h
utils.o: /usr/include/asm-generic/bitsperlong.h
utils.o: /usr/include/x86_64-linux-gnu/asm/sockios.h
utils.o: /usr/include/asm-generic/sockios.h
utils.o: /usr/include/x86_64-linux-gnu/bits/types/struct_osockaddr.h
utils.o: /usr/include/x86_64-linux-gnu/sys/un.h
utils.o: /usr/include/netinet/in.h
utils.o: /usr/include/x86_64-linux-gnu/bits/stdint-uintn.h
utils.o: /usr/include/x86_64-linux-gnu/bits/in.h
utils.o: /usr/include/netinet/tcp.h
utils.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdint.h
utils.o: /usr/include/stdint.h
utils.o: /usr/include/x86_64-linux-gnu/bits/wchar.h
utils.o: /usr/include/arpa/inet.h
utils.o: /usr/include/arpa/nameser.h
utils.o: /usr/include/x86_64-linux-gnu/sys/param.h
utils.o: /usr/include/signal.h
utils.o: /usr/include/x86_64-linux-gnu/bits/signum.h
utils.o: /usr/include/x86_64-linux-gnu/bits/signum-generic.h
utils.o: /usr/include/x86_64-linux-gnu/bits/types/sig_atomic_t.h
utils.o: /usr/include/x86_64-linux-gnu/bits/types/siginfo_t.h
utils.o: /usr/include/x86_64-linux-gnu/bits/types/__sigval_t.h
utils.o: /usr/include/x86_64-linux-gnu/bits/siginfo-arch.h
utils.o: /usr/include/x86_64-linux-gnu/bits/siginfo-consts.h
utils.o: /usr/include/x86_64-linux-gnu/bits/types/sigval_t.h
utils.o: /usr/include/x86_64-linux-gnu/bits/types/sigevent_t.h
utils.o: /usr/include/x86_64-linux-gnu/bits/sigevent-consts.h
utils.o: /usr/include/x86_64-linux-gnu/bits/sigaction.h
utils.o: /usr/include/x86_64-linux-gnu/bits/sigcontext.h
utils.o: /usr/include/x86_64-linux-gnu/bits/types/stack_t.h
utils.o: /usr/include/x86_64-linux-gnu/sys/ucontext.h
utils.o: /usr/include/x86_64-linux-gnu/bits/sigstack.h
utils.o: /usr/include/x86_64-linux-gnu/bits/ss_flags.h
utils.o: /usr/include/x86_64-linux-gnu/bits/types/struct_sigstack.h
utils.o: /usr/include/x86_64-linux-gnu/bits/sigthread.h
utils.o: /usr/include/x86_64-linux-gnu/bits/signal_ext.h
utils.o: /usr/include/x86_64-linux-gnu/bits/param.h
utils.o: /usr/include/linux/param.h
utils.o: /usr/include/x86_64-linux-gnu/asm/param.h
utils.o: /usr/include/asm-generic/param.h
utils.o: /usr/include/arpa/nameser_compat.h
utils.o: /usr/include/netdb.h
utils.o: /usr/include/rpc/netdb.h
utils.o: /usr/include/x86_64-linux-gnu/bits/netdb.h
utils.o: /usr/include/resolv.h
utils.o: /usr/include/x86_64-linux-gnu/bits/types/res_state.h
utils.o: ../../include/ldap_defaults.h
utils.o: ../../include/ldap_config.h
utils.o: ../../include/ldap_pvt.h
utils.o: ../../include/openldap.h
utils.o: ../../include/ldap.h
utils.o: ../../include/lber.h
utils.o: ../../include/ldap_features.h
utils.o: ../../include/lber_pvt.h
utils.o: ../../include/ldap_pvt_uc.h
utils.o: ../../include/ac/bytes.h
utils.o: ../../include/../libraries/liblunicode/ucdata/ucdata.h
uuid.o: uuid.c
uuid.o: /usr/include/stdc-predef.h
uuid.o: ../../include/portable.h
uuid.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
uuid.o: ../../include/ac/fdset.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/types.h
uuid.o: /usr/include/features.h
uuid.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
uuid.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
uuid.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/time64.h
uuid.o: ../../include/ldap_cdefs.h
uuid.o: ../../include/ldap_features.h
uuid.o: ../../include/ac/assert.h
uuid.o: /usr/include/assert.h
uuid.o: ../../include/ac/localize.h
uuid.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/limits.h
uuid.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/syslimits.h
uuid.o: /usr/include/limits.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/libc-header-start.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/posix1_lim.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/local_lim.h
uuid.o: /usr/include/linux/limits.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/posix2_lim.h
uuid.o: /usr/include/stdio.h
uuid.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdarg.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos64_t.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/types/__FILE.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/types/FILE.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/stdio_lim.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/sys_errlist.h
uuid.o: /usr/include/x86_64-linux-gnu/sys/types.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/types/clock_t.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/types/clockid_t.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/types/time_t.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/types/timer_t.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/stdint-intn.h
uuid.o: /usr/include/endian.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/endian.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/endianness.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/byteswap.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/uintn-identity.h
uuid.o: /usr/include/x86_64-linux-gnu/sys/select.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/select.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/types/sigset_t.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/struct_mutex.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h
uuid.o: ../../include/ac/stdlib.h
uuid.o: /usr/include/stdlib.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/waitflags.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/waitstatus.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/floatn.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/floatn-common.h
uuid.o: /usr/include/alloca.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/stdlib-float.h
uuid.o: ../../include/ac/string.h
uuid.o: /usr/include/string.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/types/locale_t.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/types/__locale_t.h
uuid.o: /usr/include/strings.h
uuid.o: ../../include/ac/socket.h
uuid.o: /usr/include/poll.h
uuid.o: /usr/include/x86_64-linux-gnu/sys/poll.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/poll.h
uuid.o: /usr/include/x86_64-linux-gnu/sys/socket.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/types/struct_iovec.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/socket.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/socket_type.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/sockaddr.h
uuid.o: /usr/include/x86_64-linux-gnu/asm/socket.h
uuid.o: /usr/include/asm-generic/socket.h
uuid.o: /usr/include/linux/posix_types.h
uuid.o: /usr/include/linux/stddef.h
uuid.o: /usr/include/x86_64-linux-gnu/asm/posix_types.h
uuid.o: /usr/include/x86_64-linux-gnu/asm/posix_types_64.h
uuid.o: /usr/include/asm-generic/posix_types.h
uuid.o: /usr/include/x86_64-linux-gnu/asm/bitsperlong.h
uuid.o: /usr/include/asm-generic/bitsperlong.h
uuid.o: /usr/include/x86_64-linux-gnu/asm/sockios.h
uuid.o: /usr/include/asm-generic/sockios.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/types/struct_osockaddr.h
uuid.o: /usr/include/x86_64-linux-gnu/sys/un.h
uuid.o: /usr/include/netinet/in.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/stdint-uintn.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/in.h
uuid.o: /usr/include/netinet/tcp.h
uuid.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdint.h
uuid.o: /usr/include/stdint.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/wchar.h
uuid.o: /usr/include/arpa/inet.h
uuid.o: /usr/include/arpa/nameser.h
uuid.o: /usr/include/x86_64-linux-gnu/sys/param.h
uuid.o: /usr/include/signal.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/signum.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/signum-generic.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/types/sig_atomic_t.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/types/siginfo_t.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/types/__sigval_t.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/siginfo-arch.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/siginfo-consts.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/types/sigval_t.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/types/sigevent_t.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/sigevent-consts.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/sigaction.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/sigcontext.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/types/stack_t.h
uuid.o: /usr/include/x86_64-linux-gnu/sys/ucontext.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/sigstack.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/ss_flags.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/types/struct_sigstack.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/sigthread.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/signal_ext.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/param.h
uuid.o: /usr/include/linux/param.h
uuid.o: /usr/include/x86_64-linux-gnu/asm/param.h
uuid.o: /usr/include/asm-generic/param.h
uuid.o: /usr/include/arpa/nameser_compat.h
uuid.o: /usr/include/netdb.h
uuid.o: /usr/include/rpc/netdb.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/netdb.h
uuid.o: /usr/include/resolv.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/types/res_state.h
uuid.o: ../../include/ac/time.h
uuid.o: /usr/include/x86_64-linux-gnu/sys/time.h
uuid.o: /usr/include/time.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/time.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/types/struct_tm.h
uuid.o: /usr/include/x86_64-linux-gnu/bits/types/struct_itimerspec.h
uuid.o: ../../include/lutil.h
uuid.o: ../../include/ldap_cdefs.h
uuid.o: ../../include/lber_types.h
sockpair.o: sockpair.c
sockpair.o: /usr/include/stdc-predef.h
sockpair.o: ../../include/portable.h
sockpair.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
sockpair.o: ../../include/ac/fdset.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/types.h
sockpair.o: /usr/include/features.h
sockpair.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
sockpair.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
sockpair.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/time64.h
sockpair.o: ../../include/ldap_cdefs.h
sockpair.o: ../../include/ldap_features.h
sockpair.o: ../../include/ac/assert.h
sockpair.o: /usr/include/assert.h
sockpair.o: ../../include/ac/localize.h
sockpair.o: ../../include/ac/socket.h
sockpair.o: /usr/include/x86_64-linux-gnu/sys/types.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/types/clock_t.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/types/clockid_t.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/types/time_t.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/types/timer_t.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/stdint-intn.h
sockpair.o: /usr/include/endian.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/endian.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/endianness.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/byteswap.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/uintn-identity.h
sockpair.o: /usr/include/x86_64-linux-gnu/sys/select.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/select.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/types/sigset_t.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/struct_mutex.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h
sockpair.o: /usr/include/poll.h
sockpair.o: /usr/include/x86_64-linux-gnu/sys/poll.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/poll.h
sockpair.o: /usr/include/x86_64-linux-gnu/sys/socket.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/types/struct_iovec.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/socket.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/socket_type.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/sockaddr.h
sockpair.o: /usr/include/x86_64-linux-gnu/asm/socket.h
sockpair.o: /usr/include/asm-generic/socket.h
sockpair.o: /usr/include/linux/posix_types.h
sockpair.o: /usr/include/linux/stddef.h
sockpair.o: /usr/include/x86_64-linux-gnu/asm/posix_types.h
sockpair.o: /usr/include/x86_64-linux-gnu/asm/posix_types_64.h
sockpair.o: /usr/include/asm-generic/posix_types.h
sockpair.o: /usr/include/x86_64-linux-gnu/asm/bitsperlong.h
sockpair.o: /usr/include/asm-generic/bitsperlong.h
sockpair.o: /usr/include/x86_64-linux-gnu/asm/sockios.h
sockpair.o: /usr/include/asm-generic/sockios.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/types/struct_osockaddr.h
sockpair.o: /usr/include/x86_64-linux-gnu/sys/un.h
sockpair.o: /usr/include/string.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/libc-header-start.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/types/locale_t.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/types/__locale_t.h
sockpair.o: /usr/include/strings.h
sockpair.o: /usr/include/netinet/in.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/stdint-uintn.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/in.h
sockpair.o: /usr/include/netinet/tcp.h
sockpair.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdint.h
sockpair.o: /usr/include/stdint.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/wchar.h
sockpair.o: /usr/include/arpa/inet.h
sockpair.o: /usr/include/arpa/nameser.h
sockpair.o: /usr/include/x86_64-linux-gnu/sys/param.h
sockpair.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/limits.h
sockpair.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/syslimits.h
sockpair.o: /usr/include/limits.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/posix1_lim.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/local_lim.h
sockpair.o: /usr/include/linux/limits.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/posix2_lim.h
sockpair.o: /usr/include/signal.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/signum.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/signum-generic.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/types/sig_atomic_t.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/types/siginfo_t.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/types/__sigval_t.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/siginfo-arch.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/siginfo-consts.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/types/sigval_t.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/types/sigevent_t.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/sigevent-consts.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/sigaction.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/sigcontext.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/types/stack_t.h
sockpair.o: /usr/include/x86_64-linux-gnu/sys/ucontext.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/sigstack.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/ss_flags.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/types/struct_sigstack.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/sigthread.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/signal_ext.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/param.h
sockpair.o: /usr/include/linux/param.h
sockpair.o: /usr/include/x86_64-linux-gnu/asm/param.h
sockpair.o: /usr/include/asm-generic/param.h
sockpair.o: /usr/include/arpa/nameser_compat.h
sockpair.o: /usr/include/netdb.h
sockpair.o: /usr/include/rpc/netdb.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/netdb.h
sockpair.o: /usr/include/resolv.h
sockpair.o: /usr/include/stdio.h
sockpair.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdarg.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos64_t.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/types/__FILE.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/types/FILE.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/stdio_lim.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/sys_errlist.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/types/res_state.h
sockpair.o: ../../include/ac/unistd.h
sockpair.o: /usr/include/unistd.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/posix_opt.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/environments.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/confname.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/getopt_posix.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/getopt_core.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/unistd_ext.h
sockpair.o: /usr/include/getopt.h
sockpair.o: /usr/include/x86_64-linux-gnu/bits/getopt_ext.h
sockpair.o: ../../include/lutil_lockf.h
sockpair.o: ../../include/lutil.h
sockpair.o: ../../include/ldap_cdefs.h
sockpair.o: ../../include/lber_types.h
meter.o: meter.c
meter.o: /usr/include/stdc-predef.h
meter.o: ../../include/portable.h
meter.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
meter.o: ../../include/ac/fdset.h
meter.o: /usr/include/x86_64-linux-gnu/bits/types.h
meter.o: /usr/include/features.h
meter.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
meter.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
meter.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
meter.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
meter.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
meter.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
meter.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
meter.o: /usr/include/x86_64-linux-gnu/bits/time64.h
meter.o: ../../include/ldap_cdefs.h
meter.o: ../../include/ldap_features.h
meter.o: ../../include/ac/assert.h
meter.o: /usr/include/assert.h
meter.o: ../../include/ac/localize.h
meter.o: ../../include/lutil_meter.h
meter.o: ../../include/portable.h
meter.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/limits.h
meter.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/syslimits.h
meter.o: /usr/include/limits.h
meter.o: /usr/include/x86_64-linux-gnu/bits/libc-header-start.h
meter.o: /usr/include/x86_64-linux-gnu/bits/posix1_lim.h
meter.o: /usr/include/x86_64-linux-gnu/bits/local_lim.h
meter.o: /usr/include/linux/limits.h
meter.o: /usr/include/x86_64-linux-gnu/bits/posix2_lim.h
meter.o: /usr/include/stdio.h
meter.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdarg.h
meter.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h
meter.o: /usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h
meter.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos64_t.h
meter.o: /usr/include/x86_64-linux-gnu/bits/types/__FILE.h
meter.o: /usr/include/x86_64-linux-gnu/bits/types/FILE.h
meter.o: /usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h
meter.o: /usr/include/x86_64-linux-gnu/bits/stdio_lim.h
meter.o: /usr/include/x86_64-linux-gnu/bits/sys_errlist.h
meter.o: /usr/include/x86_64-linux-gnu/sys/types.h
meter.o: /usr/include/x86_64-linux-gnu/bits/types/clock_t.h
meter.o: /usr/include/x86_64-linux-gnu/bits/types/clockid_t.h
meter.o: /usr/include/x86_64-linux-gnu/bits/types/time_t.h
meter.o: /usr/include/x86_64-linux-gnu/bits/types/timer_t.h
meter.o: /usr/include/x86_64-linux-gnu/bits/stdint-intn.h
meter.o: /usr/include/endian.h
meter.o: /usr/include/x86_64-linux-gnu/bits/endian.h
meter.o: /usr/include/x86_64-linux-gnu/bits/endianness.h
meter.o: /usr/include/x86_64-linux-gnu/bits/byteswap.h
meter.o: /usr/include/x86_64-linux-gnu/bits/uintn-identity.h
meter.o: /usr/include/x86_64-linux-gnu/sys/select.h
meter.o: /usr/include/x86_64-linux-gnu/bits/select.h
meter.o: /usr/include/x86_64-linux-gnu/bits/types/sigset_t.h
meter.o: /usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h
meter.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h
meter.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h
meter.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes.h
meter.o: /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h
meter.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h
meter.o: /usr/include/x86_64-linux-gnu/bits/struct_mutex.h
meter.o: /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h
meter.o: ../../include/ac/stdlib.h
meter.o: /usr/include/stdlib.h
meter.o: /usr/include/x86_64-linux-gnu/bits/waitflags.h
meter.o: /usr/include/x86_64-linux-gnu/bits/waitstatus.h
meter.o: /usr/include/x86_64-linux-gnu/bits/floatn.h
meter.o: /usr/include/x86_64-linux-gnu/bits/floatn-common.h
meter.o: /usr/include/alloca.h
meter.o: /usr/include/x86_64-linux-gnu/bits/stdlib-float.h
meter.o: ../../include/ac/time.h
meter.o: /usr/include/x86_64-linux-gnu/sys/time.h
meter.o: /usr/include/time.h
meter.o: /usr/include/x86_64-linux-gnu/bits/time.h
meter.o: /usr/include/x86_64-linux-gnu/bits/types/struct_tm.h
meter.o: /usr/include/x86_64-linux-gnu/bits/types/struct_itimerspec.h
meter.o: /usr/include/x86_64-linux-gnu/bits/types/locale_t.h
meter.o: /usr/include/x86_64-linux-gnu/bits/types/__locale_t.h
meter.o: ../../include/ac/assert.h
meter.o: ../../include/ac/string.h
meter.o: /usr/include/string.h
meter.o: /usr/include/strings.h
getpeereid.o: getpeereid.c
getpeereid.o: /usr/include/stdc-predef.h
getpeereid.o: ../../include/portable.h
getpeereid.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
getpeereid.o: ../../include/ac/fdset.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/types.h
getpeereid.o: /usr/include/features.h
getpeereid.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
getpeereid.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
getpeereid.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/time64.h
getpeereid.o: ../../include/ldap_cdefs.h
getpeereid.o: ../../include/ldap_features.h
getpeereid.o: ../../include/ac/assert.h
getpeereid.o: /usr/include/assert.h
getpeereid.o: ../../include/ac/localize.h
getpeereid.o: /usr/include/x86_64-linux-gnu/sys/types.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/types/clock_t.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/types/clockid_t.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/types/time_t.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/types/timer_t.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/stdint-intn.h
getpeereid.o: /usr/include/endian.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/endian.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/endianness.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/byteswap.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/uintn-identity.h
getpeereid.o: /usr/include/x86_64-linux-gnu/sys/select.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/select.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/types/sigset_t.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/struct_mutex.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h
getpeereid.o: ../../include/ac/unistd.h
getpeereid.o: /usr/include/unistd.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/posix_opt.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/environments.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/confname.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/getopt_posix.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/getopt_core.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/unistd_ext.h
getpeereid.o: /usr/include/getopt.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/getopt_ext.h
getpeereid.o: ../../include/lutil_lockf.h
getpeereid.o: ../../include/ac/socket.h
getpeereid.o: /usr/include/poll.h
getpeereid.o: /usr/include/x86_64-linux-gnu/sys/poll.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/poll.h
getpeereid.o: /usr/include/x86_64-linux-gnu/sys/socket.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/types/struct_iovec.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/socket.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/socket_type.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/sockaddr.h
getpeereid.o: /usr/include/x86_64-linux-gnu/asm/socket.h
getpeereid.o: /usr/include/asm-generic/socket.h
getpeereid.o: /usr/include/linux/posix_types.h
getpeereid.o: /usr/include/linux/stddef.h
getpeereid.o: /usr/include/x86_64-linux-gnu/asm/posix_types.h
getpeereid.o: /usr/include/x86_64-linux-gnu/asm/posix_types_64.h
getpeereid.o: /usr/include/asm-generic/posix_types.h
getpeereid.o: /usr/include/x86_64-linux-gnu/asm/bitsperlong.h
getpeereid.o: /usr/include/asm-generic/bitsperlong.h
getpeereid.o: /usr/include/x86_64-linux-gnu/asm/sockios.h
getpeereid.o: /usr/include/asm-generic/sockios.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/types/struct_osockaddr.h
getpeereid.o: /usr/include/x86_64-linux-gnu/sys/un.h
getpeereid.o: /usr/include/string.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/libc-header-start.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/types/locale_t.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/types/__locale_t.h
getpeereid.o: /usr/include/strings.h
getpeereid.o: /usr/include/netinet/in.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/stdint-uintn.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/in.h
getpeereid.o: /usr/include/netinet/tcp.h
getpeereid.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdint.h
getpeereid.o: /usr/include/stdint.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/wchar.h
getpeereid.o: /usr/include/arpa/inet.h
getpeereid.o: /usr/include/arpa/nameser.h
getpeereid.o: /usr/include/x86_64-linux-gnu/sys/param.h
getpeereid.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/limits.h
getpeereid.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/syslimits.h
getpeereid.o: /usr/include/limits.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/posix1_lim.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/local_lim.h
getpeereid.o: /usr/include/linux/limits.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/posix2_lim.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/xopen_lim.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/uio_lim.h
getpeereid.o: /usr/include/signal.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/signum.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/signum-generic.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/types/sig_atomic_t.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/types/siginfo_t.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/types/__sigval_t.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/siginfo-arch.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/siginfo-consts.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/siginfo-consts-arch.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/types/sigval_t.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/types/sigevent_t.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/sigevent-consts.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/sigaction.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/sigcontext.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/types/stack_t.h
getpeereid.o: /usr/include/x86_64-linux-gnu/sys/ucontext.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/sigstack.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/ss_flags.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/types/struct_sigstack.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/sigthread.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/signal_ext.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/param.h
getpeereid.o: /usr/include/linux/param.h
getpeereid.o: /usr/include/x86_64-linux-gnu/asm/param.h
getpeereid.o: /usr/include/asm-generic/param.h
getpeereid.o: /usr/include/arpa/nameser_compat.h
getpeereid.o: /usr/include/netdb.h
getpeereid.o: /usr/include/rpc/netdb.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/netdb.h
getpeereid.o: /usr/include/resolv.h
getpeereid.o: /usr/include/stdio.h
getpeereid.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdarg.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos64_t.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/types/__FILE.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/types/FILE.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/types/cookie_io_functions_t.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/stdio_lim.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/sys_errlist.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/types/res_state.h
getpeereid.o: ../../include/ac/errno.h
getpeereid.o: /usr/include/errno.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/errno.h
getpeereid.o: /usr/include/linux/errno.h
getpeereid.o: /usr/include/x86_64-linux-gnu/asm/errno.h
getpeereid.o: /usr/include/asm-generic/errno.h
getpeereid.o: /usr/include/asm-generic/errno-base.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/types/error_t.h
getpeereid.o: /usr/include/stdlib.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/waitflags.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/waitstatus.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/floatn.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/floatn-common.h
getpeereid.o: /usr/include/alloca.h
getpeereid.o: /usr/include/x86_64-linux-gnu/bits/stdlib-float.h
detach.o: detach.c
detach.o: /usr/include/stdc-predef.h
detach.o: ../../include/portable.h
detach.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
detach.o: ../../include/ac/fdset.h
detach.o: /usr/include/x86_64-linux-gnu/bits/types.h
detach.o: /usr/include/features.h
detach.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
detach.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
detach.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
detach.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
detach.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
detach.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
detach.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
detach.o: /usr/include/x86_64-linux-gnu/bits/time64.h
detach.o: ../../include/ldap_cdefs.h
detach.o: ../../include/ldap_features.h
detach.o: ../../include/ac/assert.h
detach.o: /usr/include/assert.h
detach.o: ../../include/ac/localize.h
detach.o: /usr/include/stdio.h
detach.o: /usr/include/x86_64-linux-gnu/bits/libc-header-start.h
detach.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdarg.h
detach.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h
detach.o: /usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h
detach.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos64_t.h
detach.o: /usr/include/x86_64-linux-gnu/bits/types/__FILE.h
detach.o: /usr/include/x86_64-linux-gnu/bits/types/FILE.h
detach.o: /usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h
detach.o: /usr/include/x86_64-linux-gnu/bits/stdio_lim.h
detach.o: /usr/include/x86_64-linux-gnu/bits/sys_errlist.h
detach.o: ../../include/ac/stdlib.h
detach.o: /usr/include/stdlib.h
detach.o: /usr/include/x86_64-linux-gnu/bits/waitflags.h
detach.o: /usr/include/x86_64-linux-gnu/bits/waitstatus.h
detach.o: /usr/include/x86_64-linux-gnu/bits/floatn.h
detach.o: /usr/include/x86_64-linux-gnu/bits/floatn-common.h
detach.o: /usr/include/x86_64-linux-gnu/sys/types.h
detach.o: /usr/include/x86_64-linux-gnu/bits/types/clock_t.h
detach.o: /usr/include/x86_64-linux-gnu/bits/types/clockid_t.h
detach.o: /usr/include/x86_64-linux-gnu/bits/types/time_t.h
detach.o: /usr/include/x86_64-linux-gnu/bits/types/timer_t.h
detach.o: /usr/include/x86_64-linux-gnu/bits/stdint-intn.h
detach.o: /usr/include/endian.h
detach.o: /usr/include/x86_64-linux-gnu/bits/endian.h
detach.o: /usr/include/x86_64-linux-gnu/bits/endianness.h
detach.o: /usr/include/x86_64-linux-gnu/bits/byteswap.h
detach.o: /usr/include/x86_64-linux-gnu/bits/uintn-identity.h
detach.o: /usr/include/x86_64-linux-gnu/sys/select.h
detach.o: /usr/include/x86_64-linux-gnu/bits/select.h
detach.o: /usr/include/x86_64-linux-gnu/bits/types/sigset_t.h
detach.o: /usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h
detach.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h
detach.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h
detach.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes.h
detach.o: /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h
detach.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h
detach.o: /usr/include/x86_64-linux-gnu/bits/struct_mutex.h
detach.o: /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h
detach.o: /usr/include/alloca.h
detach.o: /usr/include/x86_64-linux-gnu/bits/stdlib-float.h
detach.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/limits.h
detach.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/syslimits.h
detach.o: /usr/include/limits.h
detach.o: /usr/include/x86_64-linux-gnu/bits/posix1_lim.h
detach.o: /usr/include/x86_64-linux-gnu/bits/local_lim.h
detach.o: /usr/include/linux/limits.h
detach.o: /usr/include/x86_64-linux-gnu/bits/posix2_lim.h
detach.o: ../../include/ac/signal.h
detach.o: /usr/include/signal.h
detach.o: /usr/include/x86_64-linux-gnu/bits/signum.h
detach.o: /usr/include/x86_64-linux-gnu/bits/signum-generic.h
detach.o: /usr/include/x86_64-linux-gnu/bits/types/sig_atomic_t.h
detach.o: /usr/include/x86_64-linux-gnu/bits/types/siginfo_t.h
detach.o: /usr/include/x86_64-linux-gnu/bits/types/__sigval_t.h
detach.o: /usr/include/x86_64-linux-gnu/bits/siginfo-arch.h
detach.o: /usr/include/x86_64-linux-gnu/bits/siginfo-consts.h
detach.o: /usr/include/x86_64-linux-gnu/bits/types/sigval_t.h
detach.o: /usr/include/x86_64-linux-gnu/bits/types/sigevent_t.h
detach.o: /usr/include/x86_64-linux-gnu/bits/sigevent-consts.h
detach.o: /usr/include/x86_64-linux-gnu/bits/sigaction.h
detach.o: /usr/include/x86_64-linux-gnu/bits/sigcontext.h
detach.o: /usr/include/x86_64-linux-gnu/bits/types/stack_t.h
detach.o: /usr/include/x86_64-linux-gnu/sys/ucontext.h
detach.o: /usr/include/x86_64-linux-gnu/bits/sigstack.h
detach.o: /usr/include/x86_64-linux-gnu/bits/ss_flags.h
detach.o: /usr/include/x86_64-linux-gnu/bits/types/struct_sigstack.h
detach.o: /usr/include/x86_64-linux-gnu/bits/sigthread.h
detach.o: /usr/include/x86_64-linux-gnu/bits/signal_ext.h
detach.o: ../../include/ac/socket.h
detach.o: /usr/include/poll.h
detach.o: /usr/include/x86_64-linux-gnu/sys/poll.h
detach.o: /usr/include/x86_64-linux-gnu/bits/poll.h
detach.o: /usr/include/x86_64-linux-gnu/sys/socket.h
detach.o: /usr/include/x86_64-linux-gnu/bits/types/struct_iovec.h
detach.o: /usr/include/x86_64-linux-gnu/bits/socket.h
detach.o: /usr/include/x86_64-linux-gnu/bits/socket_type.h
detach.o: /usr/include/x86_64-linux-gnu/bits/sockaddr.h
detach.o: /usr/include/x86_64-linux-gnu/asm/socket.h
detach.o: /usr/include/asm-generic/socket.h
detach.o: /usr/include/linux/posix_types.h
detach.o: /usr/include/linux/stddef.h
detach.o: /usr/include/x86_64-linux-gnu/asm/posix_types.h
detach.o: /usr/include/x86_64-linux-gnu/asm/posix_types_64.h
detach.o: /usr/include/asm-generic/posix_types.h
detach.o: /usr/include/x86_64-linux-gnu/asm/bitsperlong.h
detach.o: /usr/include/asm-generic/bitsperlong.h
detach.o: /usr/include/x86_64-linux-gnu/asm/sockios.h
detach.o: /usr/include/asm-generic/sockios.h
detach.o: /usr/include/x86_64-linux-gnu/bits/types/struct_osockaddr.h
detach.o: /usr/include/x86_64-linux-gnu/sys/un.h
detach.o: /usr/include/string.h
detach.o: /usr/include/x86_64-linux-gnu/bits/types/locale_t.h
detach.o: /usr/include/x86_64-linux-gnu/bits/types/__locale_t.h
detach.o: /usr/include/strings.h
detach.o: /usr/include/netinet/in.h
detach.o: /usr/include/x86_64-linux-gnu/bits/stdint-uintn.h
detach.o: /usr/include/x86_64-linux-gnu/bits/in.h
detach.o: /usr/include/netinet/tcp.h
detach.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdint.h
detach.o: /usr/include/stdint.h
detach.o: /usr/include/x86_64-linux-gnu/bits/wchar.h
detach.o: /usr/include/arpa/inet.h
detach.o: /usr/include/arpa/nameser.h
detach.o: /usr/include/x86_64-linux-gnu/sys/param.h
detach.o: /usr/include/x86_64-linux-gnu/bits/param.h
detach.o: /usr/include/linux/param.h
detach.o: /usr/include/x86_64-linux-gnu/asm/param.h
detach.o: /usr/include/asm-generic/param.h
detach.o: /usr/include/arpa/nameser_compat.h
detach.o: /usr/include/netdb.h
detach.o: /usr/include/rpc/netdb.h
detach.o: /usr/include/x86_64-linux-gnu/bits/netdb.h
detach.o: /usr/include/resolv.h
detach.o: /usr/include/x86_64-linux-gnu/bits/types/res_state.h
detach.o: ../../include/ac/unistd.h
detach.o: /usr/include/unistd.h
detach.o: /usr/include/x86_64-linux-gnu/bits/posix_opt.h
detach.o: /usr/include/x86_64-linux-gnu/bits/environments.h
detach.o: /usr/include/x86_64-linux-gnu/bits/confname.h
detach.o: /usr/include/x86_64-linux-gnu/bits/getopt_posix.h
detach.o: /usr/include/x86_64-linux-gnu/bits/getopt_core.h
detach.o: /usr/include/x86_64-linux-gnu/bits/unistd_ext.h
detach.o: /usr/include/getopt.h
detach.o: /usr/include/x86_64-linux-gnu/bits/getopt_ext.h
detach.o: ../../include/lutil_lockf.h
detach.o: /usr/include/x86_64-linux-gnu/sys/stat.h
detach.o: /usr/include/x86_64-linux-gnu/bits/stat.h
detach.o: /usr/include/fcntl.h
detach.o: /usr/include/x86_64-linux-gnu/bits/fcntl.h
detach.o: /usr/include/x86_64-linux-gnu/bits/fcntl-linux.h
detach.o: /usr/include/x86_64-linux-gnu/sys/file.h
detach.o: /usr/include/x86_64-linux-gnu/sys/ioctl.h
detach.o: /usr/include/x86_64-linux-gnu/bits/ioctls.h
detach.o: /usr/include/x86_64-linux-gnu/asm/ioctls.h
detach.o: /usr/include/asm-generic/ioctls.h
detach.o: /usr/include/linux/ioctl.h
detach.o: /usr/include/x86_64-linux-gnu/asm/ioctl.h
detach.o: /usr/include/asm-generic/ioctl.h
detach.o: /usr/include/x86_64-linux-gnu/bits/ioctl-types.h
detach.o: /usr/include/x86_64-linux-gnu/sys/ttydefaults.h
detach.o: ../../include/lutil.h
detach.o: ../../include/ldap_cdefs.h
detach.o: ../../include/lber_types.h

# IF YOU PUT ANYTHING HERE IT WILL GO AWAY
