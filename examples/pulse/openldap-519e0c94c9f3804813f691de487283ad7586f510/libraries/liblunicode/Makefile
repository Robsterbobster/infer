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

# Makefile.in for LDAP -llunicode
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

LIBRARY = liblunicode.a

XXDIR = $(srcdir)/ucdata/
XXHEADERS = ucdata.h ure.h uctable.h

XXSRCS	= ucdata.c ucgendat.c ure.c urestubs.c
SRCS	= ucstr.c
OBJS	= ucdata.o ure.o urestubs.o ucstr.o

XLIB = $(LIBRARY)
XLIBS = $(LDAP_LIBLUTIL_A) $(LDAP_LIBLBER_LA)
#PROGRAMS = ucgendat

LDAP_INCDIR= ../../include       
LDAP_LIBDIR= ../../libraries

uctable.h: $(XXDIR)/uctable.h

$(XXDIR)/uctable.h: $(XXDIR)/ucgendat.c $(srcdir)/UnicodeData.txt $(srcdir)/CompositionExclusions.txt
	$(MAKE) ucgendat
	./ucgendat $(srcdir)/UnicodeData.txt -x $(srcdir)/CompositionExclusions.txt

ucgendat: $(XLIBS) ucgendat.o
	$(LTLINK) -o $@ ucgendat.o $(LIBS)

.links :
	@for i in $(XXSRCS) $(XXHEADERS); do \
		$(RM) $$i ; \
		ii=`find $(srcdir) -name $$i` ; \
		$(LN_S) $$ii . ; \
	done
	touch .links

$(XXSRCS) $(XXHEADERS) : .links

clean-local: FORCE
	@$(RM) *.dat .links $(XXHEADERS) ucgendat

depend-common: .links
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
# files: -I../../include -I../../include ucstr.c ucdata.c ucgendat.c ure.c urestubs.c
# command: cc -M -I.  -I../../include -I../../include ucstr.c ucdata.c ucgendat.c ure.c urestubs.c
#

ucstr.o: ucstr.c
ucstr.o: /usr/include/stdc-predef.h
ucstr.o: ../../include/portable.h
ucstr.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
ucstr.o: ../../include/ac/fdset.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/types.h
ucstr.o: /usr/include/features.h
ucstr.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
ucstr.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
ucstr.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/time64.h
ucstr.o: ../../include/ldap_cdefs.h
ucstr.o: ../../include/ldap_features.h
ucstr.o: ../../include/ac/assert.h
ucstr.o: /usr/include/assert.h
ucstr.o: ../../include/ac/localize.h
ucstr.o: ../../include/ac/bytes.h
ucstr.o: ../../include/ac/ctype.h
ucstr.o: /usr/include/ctype.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/endian.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/endianness.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/types/locale_t.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/types/__locale_t.h
ucstr.o: ../../include/ac/string.h
ucstr.o: /usr/include/string.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/libc-header-start.h
ucstr.o: /usr/include/strings.h
ucstr.o: ../../include/ac/stdlib.h
ucstr.o: /usr/include/stdlib.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/waitflags.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/waitstatus.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/floatn.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/floatn-common.h
ucstr.o: /usr/include/x86_64-linux-gnu/sys/types.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/types/clock_t.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/types/clockid_t.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/types/time_t.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/types/timer_t.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/stdint-intn.h
ucstr.o: /usr/include/endian.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/byteswap.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/uintn-identity.h
ucstr.o: /usr/include/x86_64-linux-gnu/sys/select.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/select.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/types/sigset_t.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/struct_mutex.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h
ucstr.o: /usr/include/alloca.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/stdlib-float.h
ucstr.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/limits.h
ucstr.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/syslimits.h
ucstr.o: /usr/include/limits.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/posix1_lim.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/local_lim.h
ucstr.o: /usr/include/linux/limits.h
ucstr.o: /usr/include/x86_64-linux-gnu/bits/posix2_lim.h
ucstr.o: ../../include/lber_pvt.h
ucstr.o: ../../include/lber.h
ucstr.o: ../../include/lber_types.h
ucstr.o: ../../include/ldap_cdefs.h
ucstr.o: ../../include/ldap_utf8.h
ucstr.o: ../../include/ldap_pvt_uc.h
ucstr.o: ../../include/../libraries/liblunicode/ucdata/ucdata.h
ucdata.o: ucdata.c
ucdata.o: /usr/include/stdc-predef.h
ucdata.o: ../../include/portable.h
ucdata.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
ucdata.o: ../../include/ac/fdset.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/types.h
ucdata.o: /usr/include/features.h
ucdata.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
ucdata.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
ucdata.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/time64.h
ucdata.o: ../../include/ldap_cdefs.h
ucdata.o: ../../include/ldap_features.h
ucdata.o: ../../include/ac/assert.h
ucdata.o: /usr/include/assert.h
ucdata.o: ../../include/ac/localize.h
ucdata.o: ../../include/ldap_config.h
ucdata.o: /usr/include/stdio.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/libc-header-start.h
ucdata.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdarg.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos64_t.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/types/__FILE.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/types/FILE.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/stdio_lim.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/sys_errlist.h
ucdata.o: ../../include/ac/stdlib.h
ucdata.o: /usr/include/stdlib.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/waitflags.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/waitstatus.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/floatn.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/floatn-common.h
ucdata.o: /usr/include/x86_64-linux-gnu/sys/types.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/types/clock_t.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/types/clockid_t.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/types/time_t.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/types/timer_t.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/stdint-intn.h
ucdata.o: /usr/include/endian.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/endian.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/endianness.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/byteswap.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/uintn-identity.h
ucdata.o: /usr/include/x86_64-linux-gnu/sys/select.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/select.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/types/sigset_t.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/struct_mutex.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h
ucdata.o: /usr/include/alloca.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/stdlib-float.h
ucdata.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/limits.h
ucdata.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/syslimits.h
ucdata.o: /usr/include/limits.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/posix1_lim.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/local_lim.h
ucdata.o: /usr/include/linux/limits.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/posix2_lim.h
ucdata.o: ../../include/ac/string.h
ucdata.o: /usr/include/string.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/types/locale_t.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/types/__locale_t.h
ucdata.o: /usr/include/strings.h
ucdata.o: ../../include/ac/unistd.h
ucdata.o: /usr/include/unistd.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/posix_opt.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/environments.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/confname.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/getopt_posix.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/getopt_core.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/unistd_ext.h
ucdata.o: /usr/include/getopt.h
ucdata.o: /usr/include/x86_64-linux-gnu/bits/getopt_ext.h
ucdata.o: ../../include/lutil_lockf.h
ucdata.o: ../../include/ac/bytes.h
ucdata.o: ../../include/lber_pvt.h
ucdata.o: ../../include/lber.h
ucdata.o: ../../include/lber_types.h
ucdata.o: ../../include/ldap_cdefs.h
ucdata.o: ucdata.h
ucdata.o: uctable.h
ucgendat.o: ucgendat.c
ucgendat.o: /usr/include/stdc-predef.h
ucgendat.o: ../../include/portable.h
ucgendat.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
ucgendat.o: ../../include/ac/fdset.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/types.h
ucgendat.o: /usr/include/features.h
ucgendat.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
ucgendat.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
ucgendat.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/time64.h
ucgendat.o: ../../include/ldap_cdefs.h
ucgendat.o: ../../include/ldap_features.h
ucgendat.o: ../../include/ac/assert.h
ucgendat.o: /usr/include/assert.h
ucgendat.o: ../../include/ac/localize.h
ucgendat.o: ../../include/ldap_config.h
ucgendat.o: /usr/include/stdio.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/libc-header-start.h
ucgendat.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdarg.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos64_t.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/types/__FILE.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/types/FILE.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/stdio_lim.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/sys_errlist.h
ucgendat.o: ../../include/ac/ctype.h
ucgendat.o: /usr/include/ctype.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/endian.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/endianness.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/types/locale_t.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/types/__locale_t.h
ucgendat.o: ../../include/ac/stdlib.h
ucgendat.o: /usr/include/stdlib.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/waitflags.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/waitstatus.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/floatn.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/floatn-common.h
ucgendat.o: /usr/include/x86_64-linux-gnu/sys/types.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/types/clock_t.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/types/clockid_t.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/types/time_t.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/types/timer_t.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/stdint-intn.h
ucgendat.o: /usr/include/endian.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/byteswap.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/uintn-identity.h
ucgendat.o: /usr/include/x86_64-linux-gnu/sys/select.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/select.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/types/sigset_t.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/struct_mutex.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h
ucgendat.o: /usr/include/alloca.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/stdlib-float.h
ucgendat.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/limits.h
ucgendat.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/syslimits.h
ucgendat.o: /usr/include/limits.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/posix1_lim.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/local_lim.h
ucgendat.o: /usr/include/linux/limits.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/posix2_lim.h
ucgendat.o: ../../include/ac/string.h
ucgendat.o: /usr/include/string.h
ucgendat.o: /usr/include/strings.h
ucgendat.o: ../../include/ac/unistd.h
ucgendat.o: /usr/include/unistd.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/posix_opt.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/environments.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/confname.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/getopt_posix.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/getopt_core.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/unistd_ext.h
ucgendat.o: /usr/include/getopt.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/getopt_ext.h
ucgendat.o: ../../include/lutil_lockf.h
ucgendat.o: ../../include/ac/bytes.h
ucgendat.o: ../../include/lutil.h
ucgendat.o: ../../include/ldap_cdefs.h
ucgendat.o: ../../include/lber_types.h
ucgendat.o: ../../include/ac/socket.h
ucgendat.o: /usr/include/poll.h
ucgendat.o: /usr/include/x86_64-linux-gnu/sys/poll.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/poll.h
ucgendat.o: /usr/include/x86_64-linux-gnu/sys/socket.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/types/struct_iovec.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/socket.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/socket_type.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/sockaddr.h
ucgendat.o: /usr/include/x86_64-linux-gnu/asm/socket.h
ucgendat.o: /usr/include/asm-generic/socket.h
ucgendat.o: /usr/include/linux/posix_types.h
ucgendat.o: /usr/include/linux/stddef.h
ucgendat.o: /usr/include/x86_64-linux-gnu/asm/posix_types.h
ucgendat.o: /usr/include/x86_64-linux-gnu/asm/posix_types_64.h
ucgendat.o: /usr/include/asm-generic/posix_types.h
ucgendat.o: /usr/include/x86_64-linux-gnu/asm/bitsperlong.h
ucgendat.o: /usr/include/asm-generic/bitsperlong.h
ucgendat.o: /usr/include/x86_64-linux-gnu/asm/sockios.h
ucgendat.o: /usr/include/asm-generic/sockios.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/types/struct_osockaddr.h
ucgendat.o: /usr/include/x86_64-linux-gnu/sys/un.h
ucgendat.o: /usr/include/netinet/in.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/stdint-uintn.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/in.h
ucgendat.o: /usr/include/netinet/tcp.h
ucgendat.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdint.h
ucgendat.o: /usr/include/stdint.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/wchar.h
ucgendat.o: /usr/include/arpa/inet.h
ucgendat.o: /usr/include/arpa/nameser.h
ucgendat.o: /usr/include/x86_64-linux-gnu/sys/param.h
ucgendat.o: /usr/include/signal.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/signum.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/signum-generic.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/types/sig_atomic_t.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/types/siginfo_t.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/types/__sigval_t.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/siginfo-arch.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/siginfo-consts.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/types/sigval_t.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/types/sigevent_t.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/sigevent-consts.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/sigaction.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/sigcontext.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/types/stack_t.h
ucgendat.o: /usr/include/x86_64-linux-gnu/sys/ucontext.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/sigstack.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/ss_flags.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/types/struct_sigstack.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/sigthread.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/signal_ext.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/param.h
ucgendat.o: /usr/include/linux/param.h
ucgendat.o: /usr/include/x86_64-linux-gnu/asm/param.h
ucgendat.o: /usr/include/asm-generic/param.h
ucgendat.o: /usr/include/arpa/nameser_compat.h
ucgendat.o: /usr/include/netdb.h
ucgendat.o: /usr/include/rpc/netdb.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/netdb.h
ucgendat.o: /usr/include/resolv.h
ucgendat.o: /usr/include/x86_64-linux-gnu/bits/types/res_state.h
ure.o: ure.c
ure.o: /usr/include/stdc-predef.h
ure.o: ../../include/portable.h
ure.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
ure.o: ../../include/ac/fdset.h
ure.o: /usr/include/x86_64-linux-gnu/bits/types.h
ure.o: /usr/include/features.h
ure.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
ure.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
ure.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
ure.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
ure.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
ure.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
ure.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
ure.o: /usr/include/x86_64-linux-gnu/bits/time64.h
ure.o: ../../include/ldap_cdefs.h
ure.o: ../../include/ldap_features.h
ure.o: ../../include/ac/assert.h
ure.o: /usr/include/assert.h
ure.o: ../../include/ac/localize.h
ure.o: ../../include/ac/stdlib.h
ure.o: /usr/include/stdlib.h
ure.o: /usr/include/x86_64-linux-gnu/bits/libc-header-start.h
ure.o: /usr/include/x86_64-linux-gnu/bits/waitflags.h
ure.o: /usr/include/x86_64-linux-gnu/bits/waitstatus.h
ure.o: /usr/include/x86_64-linux-gnu/bits/floatn.h
ure.o: /usr/include/x86_64-linux-gnu/bits/floatn-common.h
ure.o: /usr/include/x86_64-linux-gnu/sys/types.h
ure.o: /usr/include/x86_64-linux-gnu/bits/types/clock_t.h
ure.o: /usr/include/x86_64-linux-gnu/bits/types/clockid_t.h
ure.o: /usr/include/x86_64-linux-gnu/bits/types/time_t.h
ure.o: /usr/include/x86_64-linux-gnu/bits/types/timer_t.h
ure.o: /usr/include/x86_64-linux-gnu/bits/stdint-intn.h
ure.o: /usr/include/endian.h
ure.o: /usr/include/x86_64-linux-gnu/bits/endian.h
ure.o: /usr/include/x86_64-linux-gnu/bits/endianness.h
ure.o: /usr/include/x86_64-linux-gnu/bits/byteswap.h
ure.o: /usr/include/x86_64-linux-gnu/bits/uintn-identity.h
ure.o: /usr/include/x86_64-linux-gnu/sys/select.h
ure.o: /usr/include/x86_64-linux-gnu/bits/select.h
ure.o: /usr/include/x86_64-linux-gnu/bits/types/sigset_t.h
ure.o: /usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h
ure.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h
ure.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h
ure.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes.h
ure.o: /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h
ure.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h
ure.o: /usr/include/x86_64-linux-gnu/bits/struct_mutex.h
ure.o: /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h
ure.o: /usr/include/alloca.h
ure.o: /usr/include/x86_64-linux-gnu/bits/stdlib-float.h
ure.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/limits.h
ure.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/syslimits.h
ure.o: /usr/include/limits.h
ure.o: /usr/include/x86_64-linux-gnu/bits/posix1_lim.h
ure.o: /usr/include/x86_64-linux-gnu/bits/local_lim.h
ure.o: /usr/include/linux/limits.h
ure.o: /usr/include/x86_64-linux-gnu/bits/posix2_lim.h
ure.o: ../../include/ac/string.h
ure.o: /usr/include/string.h
ure.o: /usr/include/x86_64-linux-gnu/bits/types/locale_t.h
ure.o: /usr/include/x86_64-linux-gnu/bits/types/__locale_t.h
ure.o: /usr/include/strings.h
ure.o: ../../include/ac/unistd.h
ure.o: /usr/include/unistd.h
ure.o: /usr/include/x86_64-linux-gnu/bits/posix_opt.h
ure.o: /usr/include/x86_64-linux-gnu/bits/environments.h
ure.o: /usr/include/x86_64-linux-gnu/bits/confname.h
ure.o: /usr/include/x86_64-linux-gnu/bits/getopt_posix.h
ure.o: /usr/include/x86_64-linux-gnu/bits/getopt_core.h
ure.o: /usr/include/x86_64-linux-gnu/bits/unistd_ext.h
ure.o: /usr/include/getopt.h
ure.o: /usr/include/x86_64-linux-gnu/bits/getopt_ext.h
ure.o: ../../include/lutil_lockf.h
ure.o: ure.h
ure.o: /usr/include/stdio.h
ure.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdarg.h
ure.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h
ure.o: /usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h
ure.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos64_t.h
ure.o: /usr/include/x86_64-linux-gnu/bits/types/__FILE.h
ure.o: /usr/include/x86_64-linux-gnu/bits/types/FILE.h
ure.o: /usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h
ure.o: /usr/include/x86_64-linux-gnu/bits/stdio_lim.h
ure.o: /usr/include/x86_64-linux-gnu/bits/sys_errlist.h
urestubs.o: urestubs.c
urestubs.o: /usr/include/stdc-predef.h
urestubs.o: ../../include/portable.h
urestubs.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
urestubs.o: ../../include/ac/fdset.h
urestubs.o: /usr/include/x86_64-linux-gnu/bits/types.h
urestubs.o: /usr/include/features.h
urestubs.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
urestubs.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
urestubs.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
urestubs.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
urestubs.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
urestubs.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
urestubs.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
urestubs.o: /usr/include/x86_64-linux-gnu/bits/time64.h
urestubs.o: ../../include/ldap_cdefs.h
urestubs.o: ../../include/ldap_features.h
urestubs.o: ../../include/ac/assert.h
urestubs.o: /usr/include/assert.h
urestubs.o: ../../include/ac/localize.h
urestubs.o: ../../include/ac/bytes.h
urestubs.o: ure.h
urestubs.o: /usr/include/stdio.h
urestubs.o: /usr/include/x86_64-linux-gnu/bits/libc-header-start.h
urestubs.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdarg.h
urestubs.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h
urestubs.o: /usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h
urestubs.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos64_t.h
urestubs.o: /usr/include/x86_64-linux-gnu/bits/types/__FILE.h
urestubs.o: /usr/include/x86_64-linux-gnu/bits/types/FILE.h
urestubs.o: /usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h
urestubs.o: /usr/include/x86_64-linux-gnu/bits/stdio_lim.h
urestubs.o: /usr/include/x86_64-linux-gnu/bits/sys_errlist.h
urestubs.o: ucdata.h

# IF YOU PUT ANYTHING HERE IT WILL GO AWAY
