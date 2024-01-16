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

# Makefile for LDAP tools
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

SRCS	= ldapsearch.c ldapmodify.c ldapdelete.c ldapmodrdn.c \
		ldappasswd.c ldapwhoami.c ldapvc.c ldapcompare.c \
		ldapexop.c ldapurl.c common.c
OBJS	= ldapsearch.o ldapmodify.o ldapdelete.o ldapmodrdn.o \
		ldappasswd.o ldapwhoami.o ldapvc.o ldapcompare.o \
		ldapexop.o ldapurl.o common.o

LDAP_INCDIR= ../../include       
LDAP_LIBDIR= ../../libraries

MKVOPTS = -s

XLIBS =  $(LDAP_L)
XXLIBS	= $(SECURITY_LIBS) $(LUTIL_LIBS) $(CLIENT_LIBS)

XSRCS	= ldsversion.c ldmversion.c lddversion.c ldrversion.c ldpversion.c \
	ldwversion.c ldvversion.c ldcversion.c ldeversion.c lduversion.c

PROGRAMS = ldapsearch ldapmodify ldapdelete ldapmodrdn \
	ldappasswd ldapwhoami ldapvc ldapcompare ldapexop ldapurl


ldapsearch:	ldsversion.o
	$(LTLINK) -o $@ ldapsearch.o common.o ldsversion.o $(LIBS)

ldapmodify:	ldmversion.o
	$(LTLINK) -o $@ ldapmodify.o common.o ldmversion.o $(LIBS)

ldapdelete:	lddversion.o
	$(LTLINK) -o $@ ldapdelete.o common.o lddversion.o $(LIBS)

ldapmodrdn:	ldrversion.o
	$(LTLINK) -o $@ ldapmodrdn.o common.o ldrversion.o $(LIBS)

ldappasswd:	ldpversion.o
	$(LTLINK) -o $@ ldappasswd.o common.o ldpversion.o $(LIBS)

ldapwhoami:	ldwversion.o
	$(LTLINK) -o $@ ldapwhoami.o common.o ldwversion.o $(LIBS)

ldapvc:	ldvversion.o
	$(LTLINK) -o $@ ldapvc.o common.o ldvversion.o $(LIBS)

ldapcompare: ldcversion.o
	$(LTLINK) -o $@ ldapcompare.o common.o ldcversion.o $(LIBS)

ldapexop: ldeversion.o
	$(LTLINK) -o $@ ldapexop.o common.o ldeversion.o $(LIBS)

ldapurl: lduversion.o
	$(LTLINK) -o $@ ldapurl.o lduversion.o $(LIBS)

ldsversion.c: Makefile
	@-$(RM) $@
	$(MKVERSION) $(MKVOPTS) ldapsearch > $@

ldsversion.o: ldapsearch.o common.o $(XLIBS)

ldmversion.c: Makefile
	@-$(RM) $@
	$(MKVERSION) $(MKVOPTS) ldapmodify > $@

ldmversion.o: ldapmodify.o common.o $(XLIBS)

lddversion.c: Makefile
	@-$(RM) $@
	$(MKVERSION) $(MKVOPTS) ldapdelete > $@

lddversion.o: ldapdelete.o common.o $(XLIBS)

ldpversion.c: Makefile
	@-$(RM) $@
	$(MKVERSION) $(MKVOPTS) ldappasswd > $@

ldpversion.o: ldappasswd.o common.o $(XLIBS)

ldrversion.c: Makefile
	@-$(RM) $@
	$(MKVERSION) $(MKVOPTS) ldapmodrdn > $@

ldrversion.o: ldapmodrdn.o common.o $(XLIBS)

ldwversion.c: Makefile
	@-$(RM) $@
	$(MKVERSION) $(MKVOPTS) ldapwhoami > $@

ldwversion.o: ldapwhoami.o common.o $(XLIBS)

ldvversion.c: Makefile
	@-$(RM) $@
	$(MKVERSION) $(MKVOPTS) ldapvc > $@

ldvversion.o: ldapvc.o common.o $(XLIBS)

ldcversion.c: Makefile
	@-$(RM) $@
	$(MKVERSION) $(MKVOPTS) ldapcompare > $@

ldcversion.o: ldapcompare.o common.o $(XLIBS)

ldeversion.c: Makefile
	@-$(RM) $@
	$(MKVERSION) $(MKVOPTS) ldapexop > $@

ldeversion.o: ldapexop.o common.o $(XLIBS)

lduversion.c: Makefile
	@-$(RM) $@
	$(MKVERSION) $(MKVOPTS) ldapurl > $@

lduversion.o: ldapurl.o $(XLIBS)

install-local:	FORCE
	-$(MKDIR) $(DESTDIR)$(bindir)
	@(								\
	    for prg in $(PROGRAMS); do					\
		$(LTINSTALL) $(INSTALLFLAGS) $(STRIP_OPTS) -m 755 $$prg$(EXEEXT)	\
		    $(DESTDIR)$(bindir);				\
	    done							\
	)
	$(RM) $(DESTDIR)$(bindir)/ldapadd$(EXEEXT)
	$(LN_S) $(DESTDIR)$(bindir)/ldapmodify$(EXEEXT) $(DESTDIR)$(bindir)/ldapadd$(EXEEXT)

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
# Makefile Template for Programs
#

all-common: $(PROGRAMS) FORCE

clean-common: 	FORCE
	$(RM) $(PROGRAMS) $(XPROGRAMS) $(XSRCS) *.o *.lo a.out core *.core \
		    .libs/* *.exe

depend-common: FORCE
	$(MKDEP) $(DEFS) $(DEFINES) $(SRCS)

lint: FORCE
	$(LINT) $(DEFS) $(DEFINES) $(SRCS)

lint5: FORCE
	$(5LINT) $(DEFS) $(DEFINES) $(SRCS)

Makefile: $(top_srcdir)/build/rules.mk

# DO NOT DELETE THIS LINE -- mkdep uses it.
# DO NOT PUT ANYTHING AFTER THIS LINE, IT WILL GO AWAY.


#
# files: -I../../include -I../../include ldapsearch.c ldapmodify.c ldapdelete.c ldapmodrdn.c ldappasswd.c ldapwhoami.c ldapvc.c ldapcompare.c ldapexop.c ldapurl.c common.c
# command: cc -M -I.  -I../../include -I../../include ldapsearch.c ldapmodify.c ldapdelete.c ldapmodrdn.c ldappasswd.c ldapwhoami.c ldapvc.c ldapcompare.c ldapexop.c ldapurl.c common.c
#

ldapsearch.o: ldapsearch.c
ldapsearch.o: /usr/include/stdc-predef.h
ldapsearch.o: ../../include/portable.h
ldapsearch.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
ldapsearch.o: ../../include/ac/fdset.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/types.h
ldapsearch.o: /usr/include/features.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/time64.h
ldapsearch.o: ../../include/ldap_cdefs.h
ldapsearch.o: ../../include/ldap_features.h
ldapsearch.o: ../../include/ac/assert.h
ldapsearch.o: /usr/include/assert.h
ldapsearch.o: ../../include/ac/localize.h
ldapsearch.o: /usr/include/stdio.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/libc-header-start.h
ldapsearch.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdarg.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos64_t.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/types/__FILE.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/types/FILE.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/stdio_lim.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/sys_errlist.h
ldapsearch.o: ../../include/ac/stdlib.h
ldapsearch.o: /usr/include/stdlib.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/waitflags.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/waitstatus.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/floatn.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/floatn-common.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/sys/types.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/types/clock_t.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/types/clockid_t.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/types/time_t.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/types/timer_t.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/stdint-intn.h
ldapsearch.o: /usr/include/endian.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/endian.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/endianness.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/byteswap.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/uintn-identity.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/sys/select.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/select.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/types/sigset_t.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/struct_mutex.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h
ldapsearch.o: /usr/include/alloca.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/stdlib-float.h
ldapsearch.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/limits.h
ldapsearch.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/syslimits.h
ldapsearch.o: /usr/include/limits.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/posix1_lim.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/local_lim.h
ldapsearch.o: /usr/include/linux/limits.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/posix2_lim.h
ldapsearch.o: ../../include/ac/ctype.h
ldapsearch.o: /usr/include/ctype.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/types/locale_t.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/types/__locale_t.h
ldapsearch.o: ../../include/ac/string.h
ldapsearch.o: /usr/include/string.h
ldapsearch.o: /usr/include/strings.h
ldapsearch.o: ../../include/ac/unistd.h
ldapsearch.o: /usr/include/unistd.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/posix_opt.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/environments.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/confname.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/getopt_posix.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/getopt_core.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/unistd_ext.h
ldapsearch.o: /usr/include/getopt.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/getopt_ext.h
ldapsearch.o: ../../include/lutil_lockf.h
ldapsearch.o: ../../include/ac/errno.h
ldapsearch.o: /usr/include/errno.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/errno.h
ldapsearch.o: /usr/include/linux/errno.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/asm/errno.h
ldapsearch.o: /usr/include/asm-generic/errno.h
ldapsearch.o: /usr/include/asm-generic/errno-base.h
ldapsearch.o: ../../include/ac/time.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/sys/time.h
ldapsearch.o: /usr/include/time.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/time.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/types/struct_tm.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/types/struct_itimerspec.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/sys/stat.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/stat.h
ldapsearch.o: ../../include/ac/signal.h
ldapsearch.o: /usr/include/signal.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/signum.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/signum-generic.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/types/sig_atomic_t.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/types/siginfo_t.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/types/__sigval_t.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/siginfo-arch.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/siginfo-consts.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/types/sigval_t.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/types/sigevent_t.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/sigevent-consts.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/sigaction.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/sigcontext.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/types/stack_t.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/sys/ucontext.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/sigstack.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/ss_flags.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/types/struct_sigstack.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/sigthread.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/signal_ext.h
ldapsearch.o: /usr/include/fcntl.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/fcntl.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/fcntl-linux.h
ldapsearch.o: ../../include/ldap.h
ldapsearch.o: ../../include/lber.h
ldapsearch.o: ../../include/lber_types.h
ldapsearch.o: ../../include/ldap_cdefs.h
ldapsearch.o: ../../include/ldap_features.h
ldapsearch.o: ../../include/ldif.h
ldapsearch.o: ../../include/lutil.h
ldapsearch.o: ../../include/ac/socket.h
ldapsearch.o: /usr/include/poll.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/sys/poll.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/poll.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/sys/socket.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/types/struct_iovec.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/socket.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/socket_type.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/sockaddr.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/asm/socket.h
ldapsearch.o: /usr/include/asm-generic/socket.h
ldapsearch.o: /usr/include/linux/posix_types.h
ldapsearch.o: /usr/include/linux/stddef.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/asm/posix_types.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/asm/posix_types_64.h
ldapsearch.o: /usr/include/asm-generic/posix_types.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/asm/bitsperlong.h
ldapsearch.o: /usr/include/asm-generic/bitsperlong.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/asm/sockios.h
ldapsearch.o: /usr/include/asm-generic/sockios.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/types/struct_osockaddr.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/sys/un.h
ldapsearch.o: /usr/include/netinet/in.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/stdint-uintn.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/in.h
ldapsearch.o: /usr/include/netinet/tcp.h
ldapsearch.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdint.h
ldapsearch.o: /usr/include/stdint.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/wchar.h
ldapsearch.o: /usr/include/arpa/inet.h
ldapsearch.o: /usr/include/arpa/nameser.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/sys/param.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/param.h
ldapsearch.o: /usr/include/linux/param.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/asm/param.h
ldapsearch.o: /usr/include/asm-generic/param.h
ldapsearch.o: /usr/include/arpa/nameser_compat.h
ldapsearch.o: /usr/include/netdb.h
ldapsearch.o: /usr/include/rpc/netdb.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/netdb.h
ldapsearch.o: /usr/include/resolv.h
ldapsearch.o: /usr/include/x86_64-linux-gnu/bits/types/res_state.h
ldapsearch.o: ../../include/lutil_ldap.h
ldapsearch.o: ../../include/ldap_defaults.h
ldapsearch.o: ../../include/ldap_config.h
ldapsearch.o: ../../include/ldap_pvt.h
ldapsearch.o: ../../include/openldap.h
ldapsearch.o: ../../include/lber_pvt.h
ldapsearch.o: ../../include/ldap_pvt_uc.h
ldapsearch.o: ../../include/ac/bytes.h
ldapsearch.o: ../../include/../libraries/liblunicode/ucdata/ucdata.h
ldapsearch.o: common.h
ldapmodify.o: ldapmodify.c
ldapmodify.o: /usr/include/stdc-predef.h
ldapmodify.o: ../../include/portable.h
ldapmodify.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
ldapmodify.o: ../../include/ac/fdset.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/types.h
ldapmodify.o: /usr/include/features.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/time64.h
ldapmodify.o: ../../include/ldap_cdefs.h
ldapmodify.o: ../../include/ldap_features.h
ldapmodify.o: ../../include/ac/assert.h
ldapmodify.o: /usr/include/assert.h
ldapmodify.o: ../../include/ac/localize.h
ldapmodify.o: /usr/include/stdio.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/libc-header-start.h
ldapmodify.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdarg.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos64_t.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/types/__FILE.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/types/FILE.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/stdio_lim.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/sys_errlist.h
ldapmodify.o: ../../include/ac/stdlib.h
ldapmodify.o: /usr/include/stdlib.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/waitflags.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/waitstatus.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/floatn.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/floatn-common.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/sys/types.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/types/clock_t.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/types/clockid_t.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/types/time_t.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/types/timer_t.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/stdint-intn.h
ldapmodify.o: /usr/include/endian.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/endian.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/endianness.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/byteswap.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/uintn-identity.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/sys/select.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/select.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/types/sigset_t.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/struct_mutex.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h
ldapmodify.o: /usr/include/alloca.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/stdlib-float.h
ldapmodify.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/limits.h
ldapmodify.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/syslimits.h
ldapmodify.o: /usr/include/limits.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/posix1_lim.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/local_lim.h
ldapmodify.o: /usr/include/linux/limits.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/posix2_lim.h
ldapmodify.o: ../../include/ac/ctype.h
ldapmodify.o: /usr/include/ctype.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/types/locale_t.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/types/__locale_t.h
ldapmodify.o: ../../include/ac/string.h
ldapmodify.o: /usr/include/string.h
ldapmodify.o: /usr/include/strings.h
ldapmodify.o: ../../include/ac/unistd.h
ldapmodify.o: /usr/include/unistd.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/posix_opt.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/environments.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/confname.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/getopt_posix.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/getopt_core.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/unistd_ext.h
ldapmodify.o: /usr/include/getopt.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/getopt_ext.h
ldapmodify.o: ../../include/lutil_lockf.h
ldapmodify.o: ../../include/ac/socket.h
ldapmodify.o: /usr/include/poll.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/sys/poll.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/poll.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/sys/socket.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/types/struct_iovec.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/socket.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/socket_type.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/sockaddr.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/asm/socket.h
ldapmodify.o: /usr/include/asm-generic/socket.h
ldapmodify.o: /usr/include/linux/posix_types.h
ldapmodify.o: /usr/include/linux/stddef.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/asm/posix_types.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/asm/posix_types_64.h
ldapmodify.o: /usr/include/asm-generic/posix_types.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/asm/bitsperlong.h
ldapmodify.o: /usr/include/asm-generic/bitsperlong.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/asm/sockios.h
ldapmodify.o: /usr/include/asm-generic/sockios.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/types/struct_osockaddr.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/sys/un.h
ldapmodify.o: /usr/include/netinet/in.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/stdint-uintn.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/in.h
ldapmodify.o: /usr/include/netinet/tcp.h
ldapmodify.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdint.h
ldapmodify.o: /usr/include/stdint.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/wchar.h
ldapmodify.o: /usr/include/arpa/inet.h
ldapmodify.o: /usr/include/arpa/nameser.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/sys/param.h
ldapmodify.o: /usr/include/signal.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/signum.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/signum-generic.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/types/sig_atomic_t.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/types/siginfo_t.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/types/__sigval_t.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/siginfo-arch.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/siginfo-consts.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/types/sigval_t.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/types/sigevent_t.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/sigevent-consts.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/sigaction.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/sigcontext.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/types/stack_t.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/sys/ucontext.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/sigstack.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/ss_flags.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/types/struct_sigstack.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/sigthread.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/signal_ext.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/param.h
ldapmodify.o: /usr/include/linux/param.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/asm/param.h
ldapmodify.o: /usr/include/asm-generic/param.h
ldapmodify.o: /usr/include/arpa/nameser_compat.h
ldapmodify.o: /usr/include/netdb.h
ldapmodify.o: /usr/include/rpc/netdb.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/netdb.h
ldapmodify.o: /usr/include/resolv.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/types/res_state.h
ldapmodify.o: ../../include/ac/time.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/sys/time.h
ldapmodify.o: /usr/include/time.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/time.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/types/struct_tm.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/types/struct_itimerspec.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/sys/stat.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/stat.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/sys/file.h
ldapmodify.o: /usr/include/fcntl.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/fcntl.h
ldapmodify.o: /usr/include/x86_64-linux-gnu/bits/fcntl-linux.h
ldapmodify.o: ../../include/ldap.h
ldapmodify.o: ../../include/lber.h
ldapmodify.o: ../../include/lber_types.h
ldapmodify.o: ../../include/ldap_cdefs.h
ldapmodify.o: ../../include/ldap_features.h
ldapmodify.o: ../../include/lutil.h
ldapmodify.o: ../../include/lutil_ldap.h
ldapmodify.o: ../../include/ldif.h
ldapmodify.o: ../../include/ldap_defaults.h
ldapmodify.o: ../../include/ldap_config.h
ldapmodify.o: ../../include/ldap_pvt.h
ldapmodify.o: ../../include/openldap.h
ldapmodify.o: ../../include/lber_pvt.h
ldapmodify.o: ../../include/ldap_pvt_uc.h
ldapmodify.o: ../../include/ac/bytes.h
ldapmodify.o: ../../include/../libraries/liblunicode/ucdata/ucdata.h
ldapmodify.o: common.h
ldapdelete.o: ldapdelete.c
ldapdelete.o: /usr/include/stdc-predef.h
ldapdelete.o: ../../include/portable.h
ldapdelete.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
ldapdelete.o: ../../include/ac/fdset.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/types.h
ldapdelete.o: /usr/include/features.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/time64.h
ldapdelete.o: ../../include/ldap_cdefs.h
ldapdelete.o: ../../include/ldap_features.h
ldapdelete.o: ../../include/ac/assert.h
ldapdelete.o: /usr/include/assert.h
ldapdelete.o: ../../include/ac/localize.h
ldapdelete.o: /usr/include/stdio.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/libc-header-start.h
ldapdelete.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdarg.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos64_t.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/types/__FILE.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/types/FILE.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/stdio_lim.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/sys_errlist.h
ldapdelete.o: ../../include/ac/stdlib.h
ldapdelete.o: /usr/include/stdlib.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/waitflags.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/waitstatus.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/floatn.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/floatn-common.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/sys/types.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/types/clock_t.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/types/clockid_t.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/types/time_t.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/types/timer_t.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/stdint-intn.h
ldapdelete.o: /usr/include/endian.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/endian.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/endianness.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/byteswap.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/uintn-identity.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/sys/select.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/select.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/types/sigset_t.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/struct_mutex.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h
ldapdelete.o: /usr/include/alloca.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/stdlib-float.h
ldapdelete.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/limits.h
ldapdelete.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/syslimits.h
ldapdelete.o: /usr/include/limits.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/posix1_lim.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/local_lim.h
ldapdelete.o: /usr/include/linux/limits.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/posix2_lim.h
ldapdelete.o: ../../include/ac/ctype.h
ldapdelete.o: /usr/include/ctype.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/types/locale_t.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/types/__locale_t.h
ldapdelete.o: ../../include/ac/string.h
ldapdelete.o: /usr/include/string.h
ldapdelete.o: /usr/include/strings.h
ldapdelete.o: ../../include/ac/unistd.h
ldapdelete.o: /usr/include/unistd.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/posix_opt.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/environments.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/confname.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/getopt_posix.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/getopt_core.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/unistd_ext.h
ldapdelete.o: /usr/include/getopt.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/getopt_ext.h
ldapdelete.o: ../../include/lutil_lockf.h
ldapdelete.o: ../../include/ac/socket.h
ldapdelete.o: /usr/include/poll.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/sys/poll.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/poll.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/sys/socket.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/types/struct_iovec.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/socket.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/socket_type.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/sockaddr.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/asm/socket.h
ldapdelete.o: /usr/include/asm-generic/socket.h
ldapdelete.o: /usr/include/linux/posix_types.h
ldapdelete.o: /usr/include/linux/stddef.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/asm/posix_types.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/asm/posix_types_64.h
ldapdelete.o: /usr/include/asm-generic/posix_types.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/asm/bitsperlong.h
ldapdelete.o: /usr/include/asm-generic/bitsperlong.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/asm/sockios.h
ldapdelete.o: /usr/include/asm-generic/sockios.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/types/struct_osockaddr.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/sys/un.h
ldapdelete.o: /usr/include/netinet/in.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/stdint-uintn.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/in.h
ldapdelete.o: /usr/include/netinet/tcp.h
ldapdelete.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdint.h
ldapdelete.o: /usr/include/stdint.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/wchar.h
ldapdelete.o: /usr/include/arpa/inet.h
ldapdelete.o: /usr/include/arpa/nameser.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/sys/param.h
ldapdelete.o: /usr/include/signal.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/signum.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/signum-generic.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/types/sig_atomic_t.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/types/siginfo_t.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/types/__sigval_t.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/siginfo-arch.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/siginfo-consts.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/types/sigval_t.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/types/sigevent_t.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/sigevent-consts.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/sigaction.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/sigcontext.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/types/stack_t.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/sys/ucontext.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/sigstack.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/ss_flags.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/types/struct_sigstack.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/sigthread.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/signal_ext.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/param.h
ldapdelete.o: /usr/include/linux/param.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/asm/param.h
ldapdelete.o: /usr/include/asm-generic/param.h
ldapdelete.o: /usr/include/arpa/nameser_compat.h
ldapdelete.o: /usr/include/netdb.h
ldapdelete.o: /usr/include/rpc/netdb.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/netdb.h
ldapdelete.o: /usr/include/resolv.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/types/res_state.h
ldapdelete.o: ../../include/ac/time.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/sys/time.h
ldapdelete.o: /usr/include/time.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/time.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/types/struct_tm.h
ldapdelete.o: /usr/include/x86_64-linux-gnu/bits/types/struct_itimerspec.h
ldapdelete.o: ../../include/ldap.h
ldapdelete.o: ../../include/lber.h
ldapdelete.o: ../../include/lber_types.h
ldapdelete.o: ../../include/ldap_cdefs.h
ldapdelete.o: ../../include/ldap_features.h
ldapdelete.o: ../../include/lutil.h
ldapdelete.o: ../../include/lutil_ldap.h
ldapdelete.o: ../../include/ldap_defaults.h
ldapdelete.o: ../../include/ldap_config.h
ldapdelete.o: common.h
ldapmodrdn.o: ldapmodrdn.c
ldapmodrdn.o: /usr/include/stdc-predef.h
ldapmodrdn.o: ../../include/portable.h
ldapmodrdn.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
ldapmodrdn.o: ../../include/ac/fdset.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/types.h
ldapmodrdn.o: /usr/include/features.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/time64.h
ldapmodrdn.o: ../../include/ldap_cdefs.h
ldapmodrdn.o: ../../include/ldap_features.h
ldapmodrdn.o: ../../include/ac/assert.h
ldapmodrdn.o: /usr/include/assert.h
ldapmodrdn.o: ../../include/ac/localize.h
ldapmodrdn.o: /usr/include/stdio.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/libc-header-start.h
ldapmodrdn.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdarg.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos64_t.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/types/__FILE.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/types/FILE.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/stdio_lim.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/sys_errlist.h
ldapmodrdn.o: ../../include/ac/stdlib.h
ldapmodrdn.o: /usr/include/stdlib.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/waitflags.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/waitstatus.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/floatn.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/floatn-common.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/sys/types.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/types/clock_t.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/types/clockid_t.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/types/time_t.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/types/timer_t.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/stdint-intn.h
ldapmodrdn.o: /usr/include/endian.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/endian.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/endianness.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/byteswap.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/uintn-identity.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/sys/select.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/select.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/types/sigset_t.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/struct_mutex.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h
ldapmodrdn.o: /usr/include/alloca.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/stdlib-float.h
ldapmodrdn.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/limits.h
ldapmodrdn.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/syslimits.h
ldapmodrdn.o: /usr/include/limits.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/posix1_lim.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/local_lim.h
ldapmodrdn.o: /usr/include/linux/limits.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/posix2_lim.h
ldapmodrdn.o: ../../include/ac/ctype.h
ldapmodrdn.o: /usr/include/ctype.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/types/locale_t.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/types/__locale_t.h
ldapmodrdn.o: ../../include/ac/string.h
ldapmodrdn.o: /usr/include/string.h
ldapmodrdn.o: /usr/include/strings.h
ldapmodrdn.o: ../../include/ac/unistd.h
ldapmodrdn.o: /usr/include/unistd.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/posix_opt.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/environments.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/confname.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/getopt_posix.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/getopt_core.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/unistd_ext.h
ldapmodrdn.o: /usr/include/getopt.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/getopt_ext.h
ldapmodrdn.o: ../../include/lutil_lockf.h
ldapmodrdn.o: ../../include/ac/socket.h
ldapmodrdn.o: /usr/include/poll.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/sys/poll.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/poll.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/sys/socket.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/types/struct_iovec.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/socket.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/socket_type.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/sockaddr.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/asm/socket.h
ldapmodrdn.o: /usr/include/asm-generic/socket.h
ldapmodrdn.o: /usr/include/linux/posix_types.h
ldapmodrdn.o: /usr/include/linux/stddef.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/asm/posix_types.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/asm/posix_types_64.h
ldapmodrdn.o: /usr/include/asm-generic/posix_types.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/asm/bitsperlong.h
ldapmodrdn.o: /usr/include/asm-generic/bitsperlong.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/asm/sockios.h
ldapmodrdn.o: /usr/include/asm-generic/sockios.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/types/struct_osockaddr.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/sys/un.h
ldapmodrdn.o: /usr/include/netinet/in.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/stdint-uintn.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/in.h
ldapmodrdn.o: /usr/include/netinet/tcp.h
ldapmodrdn.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdint.h
ldapmodrdn.o: /usr/include/stdint.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/wchar.h
ldapmodrdn.o: /usr/include/arpa/inet.h
ldapmodrdn.o: /usr/include/arpa/nameser.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/sys/param.h
ldapmodrdn.o: /usr/include/signal.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/signum.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/signum-generic.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/types/sig_atomic_t.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/types/siginfo_t.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/types/__sigval_t.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/siginfo-arch.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/siginfo-consts.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/types/sigval_t.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/types/sigevent_t.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/sigevent-consts.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/sigaction.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/sigcontext.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/types/stack_t.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/sys/ucontext.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/sigstack.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/ss_flags.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/types/struct_sigstack.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/sigthread.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/signal_ext.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/param.h
ldapmodrdn.o: /usr/include/linux/param.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/asm/param.h
ldapmodrdn.o: /usr/include/asm-generic/param.h
ldapmodrdn.o: /usr/include/arpa/nameser_compat.h
ldapmodrdn.o: /usr/include/netdb.h
ldapmodrdn.o: /usr/include/rpc/netdb.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/netdb.h
ldapmodrdn.o: /usr/include/resolv.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/types/res_state.h
ldapmodrdn.o: ../../include/ac/time.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/sys/time.h
ldapmodrdn.o: /usr/include/time.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/time.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/types/struct_tm.h
ldapmodrdn.o: /usr/include/x86_64-linux-gnu/bits/types/struct_itimerspec.h
ldapmodrdn.o: ../../include/ldap.h
ldapmodrdn.o: ../../include/lber.h
ldapmodrdn.o: ../../include/lber_types.h
ldapmodrdn.o: ../../include/ldap_cdefs.h
ldapmodrdn.o: ../../include/ldap_features.h
ldapmodrdn.o: ../../include/lutil.h
ldapmodrdn.o: ../../include/lutil_ldap.h
ldapmodrdn.o: ../../include/ldap_defaults.h
ldapmodrdn.o: ../../include/ldap_config.h
ldapmodrdn.o: common.h
ldappasswd.o: ldappasswd.c
ldappasswd.o: /usr/include/stdc-predef.h
ldappasswd.o: ../../include/portable.h
ldappasswd.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
ldappasswd.o: ../../include/ac/fdset.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/types.h
ldappasswd.o: /usr/include/features.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/time64.h
ldappasswd.o: ../../include/ldap_cdefs.h
ldappasswd.o: ../../include/ldap_features.h
ldappasswd.o: ../../include/ac/assert.h
ldappasswd.o: /usr/include/assert.h
ldappasswd.o: ../../include/ac/localize.h
ldappasswd.o: /usr/include/stdio.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/libc-header-start.h
ldappasswd.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdarg.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos64_t.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/types/__FILE.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/types/FILE.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/stdio_lim.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/sys_errlist.h
ldappasswd.o: ../../include/ac/stdlib.h
ldappasswd.o: /usr/include/stdlib.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/waitflags.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/waitstatus.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/floatn.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/floatn-common.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/sys/types.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/types/clock_t.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/types/clockid_t.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/types/time_t.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/types/timer_t.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/stdint-intn.h
ldappasswd.o: /usr/include/endian.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/endian.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/endianness.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/byteswap.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/uintn-identity.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/sys/select.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/select.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/types/sigset_t.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/struct_mutex.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h
ldappasswd.o: /usr/include/alloca.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/stdlib-float.h
ldappasswd.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/limits.h
ldappasswd.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/syslimits.h
ldappasswd.o: /usr/include/limits.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/posix1_lim.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/local_lim.h
ldappasswd.o: /usr/include/linux/limits.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/posix2_lim.h
ldappasswd.o: ../../include/ac/ctype.h
ldappasswd.o: /usr/include/ctype.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/types/locale_t.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/types/__locale_t.h
ldappasswd.o: ../../include/ac/socket.h
ldappasswd.o: /usr/include/poll.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/sys/poll.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/poll.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/sys/socket.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/types/struct_iovec.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/socket.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/socket_type.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/sockaddr.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/asm/socket.h
ldappasswd.o: /usr/include/asm-generic/socket.h
ldappasswd.o: /usr/include/linux/posix_types.h
ldappasswd.o: /usr/include/linux/stddef.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/asm/posix_types.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/asm/posix_types_64.h
ldappasswd.o: /usr/include/asm-generic/posix_types.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/asm/bitsperlong.h
ldappasswd.o: /usr/include/asm-generic/bitsperlong.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/asm/sockios.h
ldappasswd.o: /usr/include/asm-generic/sockios.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/types/struct_osockaddr.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/sys/un.h
ldappasswd.o: /usr/include/string.h
ldappasswd.o: /usr/include/strings.h
ldappasswd.o: /usr/include/netinet/in.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/stdint-uintn.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/in.h
ldappasswd.o: /usr/include/netinet/tcp.h
ldappasswd.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdint.h
ldappasswd.o: /usr/include/stdint.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/wchar.h
ldappasswd.o: /usr/include/arpa/inet.h
ldappasswd.o: /usr/include/arpa/nameser.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/sys/param.h
ldappasswd.o: /usr/include/signal.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/signum.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/signum-generic.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/types/sig_atomic_t.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/types/siginfo_t.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/types/__sigval_t.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/siginfo-arch.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/siginfo-consts.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/types/sigval_t.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/types/sigevent_t.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/sigevent-consts.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/sigaction.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/sigcontext.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/types/stack_t.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/sys/ucontext.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/sigstack.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/ss_flags.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/types/struct_sigstack.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/sigthread.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/signal_ext.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/param.h
ldappasswd.o: /usr/include/linux/param.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/asm/param.h
ldappasswd.o: /usr/include/asm-generic/param.h
ldappasswd.o: /usr/include/arpa/nameser_compat.h
ldappasswd.o: /usr/include/netdb.h
ldappasswd.o: /usr/include/rpc/netdb.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/netdb.h
ldappasswd.o: /usr/include/resolv.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/types/res_state.h
ldappasswd.o: ../../include/ac/string.h
ldappasswd.o: ../../include/ac/time.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/sys/time.h
ldappasswd.o: /usr/include/time.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/time.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/types/struct_tm.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/types/struct_itimerspec.h
ldappasswd.o: ../../include/ac/unistd.h
ldappasswd.o: /usr/include/unistd.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/posix_opt.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/environments.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/confname.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/getopt_posix.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/getopt_core.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/unistd_ext.h
ldappasswd.o: /usr/include/getopt.h
ldappasswd.o: /usr/include/x86_64-linux-gnu/bits/getopt_ext.h
ldappasswd.o: ../../include/lutil_lockf.h
ldappasswd.o: ../../include/ldap.h
ldappasswd.o: ../../include/lber.h
ldappasswd.o: ../../include/lber_types.h
ldappasswd.o: ../../include/ldap_cdefs.h
ldappasswd.o: ../../include/ldap_features.h
ldappasswd.o: ../../include/lutil.h
ldappasswd.o: ../../include/lutil_ldap.h
ldappasswd.o: ../../include/ldap_defaults.h
ldappasswd.o: ../../include/ldap_config.h
ldappasswd.o: common.h
ldapwhoami.o: ldapwhoami.c
ldapwhoami.o: /usr/include/stdc-predef.h
ldapwhoami.o: ../../include/portable.h
ldapwhoami.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
ldapwhoami.o: ../../include/ac/fdset.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/types.h
ldapwhoami.o: /usr/include/features.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/time64.h
ldapwhoami.o: ../../include/ldap_cdefs.h
ldapwhoami.o: ../../include/ldap_features.h
ldapwhoami.o: ../../include/ac/assert.h
ldapwhoami.o: /usr/include/assert.h
ldapwhoami.o: ../../include/ac/localize.h
ldapwhoami.o: /usr/include/stdio.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/libc-header-start.h
ldapwhoami.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdarg.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos64_t.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/types/__FILE.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/types/FILE.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/stdio_lim.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/sys_errlist.h
ldapwhoami.o: ../../include/ac/stdlib.h
ldapwhoami.o: /usr/include/stdlib.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/waitflags.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/waitstatus.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/floatn.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/floatn-common.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/sys/types.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/types/clock_t.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/types/clockid_t.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/types/time_t.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/types/timer_t.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/stdint-intn.h
ldapwhoami.o: /usr/include/endian.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/endian.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/endianness.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/byteswap.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/uintn-identity.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/sys/select.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/select.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/types/sigset_t.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/struct_mutex.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h
ldapwhoami.o: /usr/include/alloca.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/stdlib-float.h
ldapwhoami.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/limits.h
ldapwhoami.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/syslimits.h
ldapwhoami.o: /usr/include/limits.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/posix1_lim.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/local_lim.h
ldapwhoami.o: /usr/include/linux/limits.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/posix2_lim.h
ldapwhoami.o: ../../include/ac/ctype.h
ldapwhoami.o: /usr/include/ctype.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/types/locale_t.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/types/__locale_t.h
ldapwhoami.o: ../../include/ac/socket.h
ldapwhoami.o: /usr/include/poll.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/sys/poll.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/poll.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/sys/socket.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/types/struct_iovec.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/socket.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/socket_type.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/sockaddr.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/asm/socket.h
ldapwhoami.o: /usr/include/asm-generic/socket.h
ldapwhoami.o: /usr/include/linux/posix_types.h
ldapwhoami.o: /usr/include/linux/stddef.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/asm/posix_types.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/asm/posix_types_64.h
ldapwhoami.o: /usr/include/asm-generic/posix_types.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/asm/bitsperlong.h
ldapwhoami.o: /usr/include/asm-generic/bitsperlong.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/asm/sockios.h
ldapwhoami.o: /usr/include/asm-generic/sockios.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/types/struct_osockaddr.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/sys/un.h
ldapwhoami.o: /usr/include/string.h
ldapwhoami.o: /usr/include/strings.h
ldapwhoami.o: /usr/include/netinet/in.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/stdint-uintn.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/in.h
ldapwhoami.o: /usr/include/netinet/tcp.h
ldapwhoami.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdint.h
ldapwhoami.o: /usr/include/stdint.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/wchar.h
ldapwhoami.o: /usr/include/arpa/inet.h
ldapwhoami.o: /usr/include/arpa/nameser.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/sys/param.h
ldapwhoami.o: /usr/include/signal.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/signum.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/signum-generic.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/types/sig_atomic_t.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/types/siginfo_t.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/types/__sigval_t.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/siginfo-arch.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/siginfo-consts.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/types/sigval_t.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/types/sigevent_t.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/sigevent-consts.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/sigaction.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/sigcontext.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/types/stack_t.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/sys/ucontext.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/sigstack.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/ss_flags.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/types/struct_sigstack.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/sigthread.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/signal_ext.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/param.h
ldapwhoami.o: /usr/include/linux/param.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/asm/param.h
ldapwhoami.o: /usr/include/asm-generic/param.h
ldapwhoami.o: /usr/include/arpa/nameser_compat.h
ldapwhoami.o: /usr/include/netdb.h
ldapwhoami.o: /usr/include/rpc/netdb.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/netdb.h
ldapwhoami.o: /usr/include/resolv.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/types/res_state.h
ldapwhoami.o: ../../include/ac/string.h
ldapwhoami.o: ../../include/ac/time.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/sys/time.h
ldapwhoami.o: /usr/include/time.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/time.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/types/struct_tm.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/types/struct_itimerspec.h
ldapwhoami.o: ../../include/ac/unistd.h
ldapwhoami.o: /usr/include/unistd.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/posix_opt.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/environments.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/confname.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/getopt_posix.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/getopt_core.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/unistd_ext.h
ldapwhoami.o: /usr/include/getopt.h
ldapwhoami.o: /usr/include/x86_64-linux-gnu/bits/getopt_ext.h
ldapwhoami.o: ../../include/lutil_lockf.h
ldapwhoami.o: ../../include/ldap.h
ldapwhoami.o: ../../include/lber.h
ldapwhoami.o: ../../include/lber_types.h
ldapwhoami.o: ../../include/ldap_cdefs.h
ldapwhoami.o: ../../include/ldap_features.h
ldapwhoami.o: ../../include/lutil.h
ldapwhoami.o: ../../include/lutil_ldap.h
ldapwhoami.o: ../../include/ldap_defaults.h
ldapwhoami.o: ../../include/ldap_config.h
ldapwhoami.o: common.h
ldapvc.o: ldapvc.c
ldapvc.o: /usr/include/stdc-predef.h
ldapvc.o: ../../include/portable.h
ldapvc.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
ldapvc.o: ../../include/ac/fdset.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/types.h
ldapvc.o: /usr/include/features.h
ldapvc.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
ldapvc.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
ldapvc.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/time64.h
ldapvc.o: ../../include/ldap_cdefs.h
ldapvc.o: ../../include/ldap_features.h
ldapvc.o: ../../include/ac/assert.h
ldapvc.o: /usr/include/assert.h
ldapvc.o: ../../include/ac/localize.h
ldapvc.o: /usr/include/stdio.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/libc-header-start.h
ldapvc.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdarg.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos64_t.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/types/__FILE.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/types/FILE.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/stdio_lim.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/sys_errlist.h
ldapvc.o: ../../include/ac/stdlib.h
ldapvc.o: /usr/include/stdlib.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/waitflags.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/waitstatus.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/floatn.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/floatn-common.h
ldapvc.o: /usr/include/x86_64-linux-gnu/sys/types.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/types/clock_t.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/types/clockid_t.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/types/time_t.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/types/timer_t.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/stdint-intn.h
ldapvc.o: /usr/include/endian.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/endian.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/endianness.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/byteswap.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/uintn-identity.h
ldapvc.o: /usr/include/x86_64-linux-gnu/sys/select.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/select.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/types/sigset_t.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/struct_mutex.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h
ldapvc.o: /usr/include/alloca.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/stdlib-float.h
ldapvc.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/limits.h
ldapvc.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/syslimits.h
ldapvc.o: /usr/include/limits.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/posix1_lim.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/local_lim.h
ldapvc.o: /usr/include/linux/limits.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/posix2_lim.h
ldapvc.o: ../../include/ac/ctype.h
ldapvc.o: /usr/include/ctype.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/types/locale_t.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/types/__locale_t.h
ldapvc.o: ../../include/ac/socket.h
ldapvc.o: /usr/include/poll.h
ldapvc.o: /usr/include/x86_64-linux-gnu/sys/poll.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/poll.h
ldapvc.o: /usr/include/x86_64-linux-gnu/sys/socket.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/types/struct_iovec.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/socket.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/socket_type.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/sockaddr.h
ldapvc.o: /usr/include/x86_64-linux-gnu/asm/socket.h
ldapvc.o: /usr/include/asm-generic/socket.h
ldapvc.o: /usr/include/linux/posix_types.h
ldapvc.o: /usr/include/linux/stddef.h
ldapvc.o: /usr/include/x86_64-linux-gnu/asm/posix_types.h
ldapvc.o: /usr/include/x86_64-linux-gnu/asm/posix_types_64.h
ldapvc.o: /usr/include/asm-generic/posix_types.h
ldapvc.o: /usr/include/x86_64-linux-gnu/asm/bitsperlong.h
ldapvc.o: /usr/include/asm-generic/bitsperlong.h
ldapvc.o: /usr/include/x86_64-linux-gnu/asm/sockios.h
ldapvc.o: /usr/include/asm-generic/sockios.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/types/struct_osockaddr.h
ldapvc.o: /usr/include/x86_64-linux-gnu/sys/un.h
ldapvc.o: /usr/include/string.h
ldapvc.o: /usr/include/strings.h
ldapvc.o: /usr/include/netinet/in.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/stdint-uintn.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/in.h
ldapvc.o: /usr/include/netinet/tcp.h
ldapvc.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdint.h
ldapvc.o: /usr/include/stdint.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/wchar.h
ldapvc.o: /usr/include/arpa/inet.h
ldapvc.o: /usr/include/arpa/nameser.h
ldapvc.o: /usr/include/x86_64-linux-gnu/sys/param.h
ldapvc.o: /usr/include/signal.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/signum.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/signum-generic.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/types/sig_atomic_t.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/types/siginfo_t.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/types/__sigval_t.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/siginfo-arch.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/siginfo-consts.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/types/sigval_t.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/types/sigevent_t.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/sigevent-consts.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/sigaction.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/sigcontext.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/types/stack_t.h
ldapvc.o: /usr/include/x86_64-linux-gnu/sys/ucontext.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/sigstack.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/ss_flags.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/types/struct_sigstack.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/sigthread.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/signal_ext.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/param.h
ldapvc.o: /usr/include/linux/param.h
ldapvc.o: /usr/include/x86_64-linux-gnu/asm/param.h
ldapvc.o: /usr/include/asm-generic/param.h
ldapvc.o: /usr/include/arpa/nameser_compat.h
ldapvc.o: /usr/include/netdb.h
ldapvc.o: /usr/include/rpc/netdb.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/netdb.h
ldapvc.o: /usr/include/resolv.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/types/res_state.h
ldapvc.o: ../../include/ac/string.h
ldapvc.o: ../../include/ac/time.h
ldapvc.o: /usr/include/x86_64-linux-gnu/sys/time.h
ldapvc.o: /usr/include/time.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/time.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/types/struct_tm.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/types/struct_itimerspec.h
ldapvc.o: ../../include/ac/unistd.h
ldapvc.o: /usr/include/unistd.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/posix_opt.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/environments.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/confname.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/getopt_posix.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/getopt_core.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/unistd_ext.h
ldapvc.o: /usr/include/getopt.h
ldapvc.o: /usr/include/x86_64-linux-gnu/bits/getopt_ext.h
ldapvc.o: ../../include/lutil_lockf.h
ldapvc.o: ../../include/ldap.h
ldapvc.o: ../../include/lber.h
ldapvc.o: ../../include/lber_types.h
ldapvc.o: ../../include/ldap_cdefs.h
ldapvc.o: ../../include/ldap_features.h
ldapvc.o: ../../include/lutil.h
ldapvc.o: ../../include/lutil_ldap.h
ldapvc.o: ../../include/ldap_defaults.h
ldapvc.o: ../../include/ldap_config.h
ldapvc.o: common.h
ldapcompare.o: ldapcompare.c
ldapcompare.o: /usr/include/stdc-predef.h
ldapcompare.o: ../../include/portable.h
ldapcompare.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
ldapcompare.o: ../../include/ac/fdset.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/types.h
ldapcompare.o: /usr/include/features.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/time64.h
ldapcompare.o: ../../include/ldap_cdefs.h
ldapcompare.o: ../../include/ldap_features.h
ldapcompare.o: ../../include/ac/assert.h
ldapcompare.o: /usr/include/assert.h
ldapcompare.o: ../../include/ac/localize.h
ldapcompare.o: /usr/include/stdio.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/libc-header-start.h
ldapcompare.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdarg.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos64_t.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/types/__FILE.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/types/FILE.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/stdio_lim.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/sys_errlist.h
ldapcompare.o: ../../include/ac/stdlib.h
ldapcompare.o: /usr/include/stdlib.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/waitflags.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/waitstatus.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/floatn.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/floatn-common.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/sys/types.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/types/clock_t.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/types/clockid_t.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/types/time_t.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/types/timer_t.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/stdint-intn.h
ldapcompare.o: /usr/include/endian.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/endian.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/endianness.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/byteswap.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/uintn-identity.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/sys/select.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/select.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/types/sigset_t.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/struct_mutex.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h
ldapcompare.o: /usr/include/alloca.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/stdlib-float.h
ldapcompare.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/limits.h
ldapcompare.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/syslimits.h
ldapcompare.o: /usr/include/limits.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/posix1_lim.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/local_lim.h
ldapcompare.o: /usr/include/linux/limits.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/posix2_lim.h
ldapcompare.o: ../../include/ac/ctype.h
ldapcompare.o: /usr/include/ctype.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/types/locale_t.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/types/__locale_t.h
ldapcompare.o: ../../include/ac/string.h
ldapcompare.o: /usr/include/string.h
ldapcompare.o: /usr/include/strings.h
ldapcompare.o: ../../include/ac/unistd.h
ldapcompare.o: /usr/include/unistd.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/posix_opt.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/environments.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/confname.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/getopt_posix.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/getopt_core.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/unistd_ext.h
ldapcompare.o: /usr/include/getopt.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/getopt_ext.h
ldapcompare.o: ../../include/lutil_lockf.h
ldapcompare.o: ../../include/ac/errno.h
ldapcompare.o: /usr/include/errno.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/errno.h
ldapcompare.o: /usr/include/linux/errno.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/asm/errno.h
ldapcompare.o: /usr/include/asm-generic/errno.h
ldapcompare.o: /usr/include/asm-generic/errno-base.h
ldapcompare.o: ../../include/ac/socket.h
ldapcompare.o: /usr/include/poll.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/sys/poll.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/poll.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/sys/socket.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/types/struct_iovec.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/socket.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/socket_type.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/sockaddr.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/asm/socket.h
ldapcompare.o: /usr/include/asm-generic/socket.h
ldapcompare.o: /usr/include/linux/posix_types.h
ldapcompare.o: /usr/include/linux/stddef.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/asm/posix_types.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/asm/posix_types_64.h
ldapcompare.o: /usr/include/asm-generic/posix_types.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/asm/bitsperlong.h
ldapcompare.o: /usr/include/asm-generic/bitsperlong.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/asm/sockios.h
ldapcompare.o: /usr/include/asm-generic/sockios.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/types/struct_osockaddr.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/sys/un.h
ldapcompare.o: /usr/include/netinet/in.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/stdint-uintn.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/in.h
ldapcompare.o: /usr/include/netinet/tcp.h
ldapcompare.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdint.h
ldapcompare.o: /usr/include/stdint.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/wchar.h
ldapcompare.o: /usr/include/arpa/inet.h
ldapcompare.o: /usr/include/arpa/nameser.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/sys/param.h
ldapcompare.o: /usr/include/signal.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/signum.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/signum-generic.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/types/sig_atomic_t.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/types/siginfo_t.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/types/__sigval_t.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/siginfo-arch.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/siginfo-consts.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/types/sigval_t.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/types/sigevent_t.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/sigevent-consts.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/sigaction.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/sigcontext.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/types/stack_t.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/sys/ucontext.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/sigstack.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/ss_flags.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/types/struct_sigstack.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/sigthread.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/signal_ext.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/param.h
ldapcompare.o: /usr/include/linux/param.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/asm/param.h
ldapcompare.o: /usr/include/asm-generic/param.h
ldapcompare.o: /usr/include/arpa/nameser_compat.h
ldapcompare.o: /usr/include/netdb.h
ldapcompare.o: /usr/include/rpc/netdb.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/netdb.h
ldapcompare.o: /usr/include/resolv.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/types/res_state.h
ldapcompare.o: ../../include/ac/time.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/sys/time.h
ldapcompare.o: /usr/include/time.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/time.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/types/struct_tm.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/types/struct_itimerspec.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/sys/stat.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/stat.h
ldapcompare.o: /usr/include/fcntl.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/fcntl.h
ldapcompare.o: /usr/include/x86_64-linux-gnu/bits/fcntl-linux.h
ldapcompare.o: ../../include/ldap.h
ldapcompare.o: ../../include/lber.h
ldapcompare.o: ../../include/lber_types.h
ldapcompare.o: ../../include/ldap_cdefs.h
ldapcompare.o: ../../include/ldap_features.h
ldapcompare.o: ../../include/lutil.h
ldapcompare.o: ../../include/lutil_ldap.h
ldapcompare.o: ../../include/ldap_defaults.h
ldapcompare.o: ../../include/ldap_config.h
ldapcompare.o: common.h
ldapexop.o: ldapexop.c
ldapexop.o: /usr/include/stdc-predef.h
ldapexop.o: ../../include/portable.h
ldapexop.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
ldapexop.o: ../../include/ac/fdset.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/types.h
ldapexop.o: /usr/include/features.h
ldapexop.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
ldapexop.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
ldapexop.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/time64.h
ldapexop.o: ../../include/ldap_cdefs.h
ldapexop.o: ../../include/ldap_features.h
ldapexop.o: ../../include/ac/assert.h
ldapexop.o: /usr/include/assert.h
ldapexop.o: ../../include/ac/localize.h
ldapexop.o: /usr/include/stdio.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/libc-header-start.h
ldapexop.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdarg.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos64_t.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/types/__FILE.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/types/FILE.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/stdio_lim.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/sys_errlist.h
ldapexop.o: ../../include/ac/stdlib.h
ldapexop.o: /usr/include/stdlib.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/waitflags.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/waitstatus.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/floatn.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/floatn-common.h
ldapexop.o: /usr/include/x86_64-linux-gnu/sys/types.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/types/clock_t.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/types/clockid_t.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/types/time_t.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/types/timer_t.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/stdint-intn.h
ldapexop.o: /usr/include/endian.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/endian.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/endianness.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/byteswap.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/uintn-identity.h
ldapexop.o: /usr/include/x86_64-linux-gnu/sys/select.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/select.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/types/sigset_t.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/struct_mutex.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h
ldapexop.o: /usr/include/alloca.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/stdlib-float.h
ldapexop.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/limits.h
ldapexop.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/syslimits.h
ldapexop.o: /usr/include/limits.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/posix1_lim.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/local_lim.h
ldapexop.o: /usr/include/linux/limits.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/posix2_lim.h
ldapexop.o: ../../include/ac/ctype.h
ldapexop.o: /usr/include/ctype.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/types/locale_t.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/types/__locale_t.h
ldapexop.o: ../../include/ac/socket.h
ldapexop.o: /usr/include/poll.h
ldapexop.o: /usr/include/x86_64-linux-gnu/sys/poll.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/poll.h
ldapexop.o: /usr/include/x86_64-linux-gnu/sys/socket.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/types/struct_iovec.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/socket.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/socket_type.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/sockaddr.h
ldapexop.o: /usr/include/x86_64-linux-gnu/asm/socket.h
ldapexop.o: /usr/include/asm-generic/socket.h
ldapexop.o: /usr/include/linux/posix_types.h
ldapexop.o: /usr/include/linux/stddef.h
ldapexop.o: /usr/include/x86_64-linux-gnu/asm/posix_types.h
ldapexop.o: /usr/include/x86_64-linux-gnu/asm/posix_types_64.h
ldapexop.o: /usr/include/asm-generic/posix_types.h
ldapexop.o: /usr/include/x86_64-linux-gnu/asm/bitsperlong.h
ldapexop.o: /usr/include/asm-generic/bitsperlong.h
ldapexop.o: /usr/include/x86_64-linux-gnu/asm/sockios.h
ldapexop.o: /usr/include/asm-generic/sockios.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/types/struct_osockaddr.h
ldapexop.o: /usr/include/x86_64-linux-gnu/sys/un.h
ldapexop.o: /usr/include/string.h
ldapexop.o: /usr/include/strings.h
ldapexop.o: /usr/include/netinet/in.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/stdint-uintn.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/in.h
ldapexop.o: /usr/include/netinet/tcp.h
ldapexop.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdint.h
ldapexop.o: /usr/include/stdint.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/wchar.h
ldapexop.o: /usr/include/arpa/inet.h
ldapexop.o: /usr/include/arpa/nameser.h
ldapexop.o: /usr/include/x86_64-linux-gnu/sys/param.h
ldapexop.o: /usr/include/signal.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/signum.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/signum-generic.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/types/sig_atomic_t.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/types/siginfo_t.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/types/__sigval_t.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/siginfo-arch.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/siginfo-consts.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/types/sigval_t.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/types/sigevent_t.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/sigevent-consts.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/sigaction.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/sigcontext.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/types/stack_t.h
ldapexop.o: /usr/include/x86_64-linux-gnu/sys/ucontext.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/sigstack.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/ss_flags.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/types/struct_sigstack.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/sigthread.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/signal_ext.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/param.h
ldapexop.o: /usr/include/linux/param.h
ldapexop.o: /usr/include/x86_64-linux-gnu/asm/param.h
ldapexop.o: /usr/include/asm-generic/param.h
ldapexop.o: /usr/include/arpa/nameser_compat.h
ldapexop.o: /usr/include/netdb.h
ldapexop.o: /usr/include/rpc/netdb.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/netdb.h
ldapexop.o: /usr/include/resolv.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/types/res_state.h
ldapexop.o: ../../include/ac/string.h
ldapexop.o: ../../include/ac/time.h
ldapexop.o: /usr/include/x86_64-linux-gnu/sys/time.h
ldapexop.o: /usr/include/time.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/time.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/types/struct_tm.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/types/struct_itimerspec.h
ldapexop.o: ../../include/ac/unistd.h
ldapexop.o: /usr/include/unistd.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/posix_opt.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/environments.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/confname.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/getopt_posix.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/getopt_core.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/unistd_ext.h
ldapexop.o: /usr/include/getopt.h
ldapexop.o: /usr/include/x86_64-linux-gnu/bits/getopt_ext.h
ldapexop.o: ../../include/lutil_lockf.h
ldapexop.o: ../../include/ldap.h
ldapexop.o: ../../include/lber.h
ldapexop.o: ../../include/lber_types.h
ldapexop.o: ../../include/ldap_cdefs.h
ldapexop.o: ../../include/ldap_features.h
ldapexop.o: ../../include/ldif.h
ldapexop.o: ../../include/lutil.h
ldapexop.o: ../../include/lutil_ldap.h
ldapexop.o: ../../include/ldap_defaults.h
ldapexop.o: ../../include/ldap_config.h
ldapexop.o: common.h
ldapurl.o: ldapurl.c
ldapurl.o: /usr/include/stdc-predef.h
ldapurl.o: ../../include/portable.h
ldapurl.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
ldapurl.o: ../../include/ac/fdset.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/types.h
ldapurl.o: /usr/include/features.h
ldapurl.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
ldapurl.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
ldapurl.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/time64.h
ldapurl.o: ../../include/ldap_cdefs.h
ldapurl.o: ../../include/ldap_features.h
ldapurl.o: ../../include/ac/assert.h
ldapurl.o: /usr/include/assert.h
ldapurl.o: ../../include/ac/localize.h
ldapurl.o: ../../include/ac/stdlib.h
ldapurl.o: /usr/include/stdlib.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/libc-header-start.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/waitflags.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/waitstatus.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/floatn.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/floatn-common.h
ldapurl.o: /usr/include/x86_64-linux-gnu/sys/types.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/types/clock_t.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/types/clockid_t.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/types/time_t.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/types/timer_t.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/stdint-intn.h
ldapurl.o: /usr/include/endian.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/endian.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/endianness.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/byteswap.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/uintn-identity.h
ldapurl.o: /usr/include/x86_64-linux-gnu/sys/select.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/select.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/types/sigset_t.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/struct_mutex.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h
ldapurl.o: /usr/include/alloca.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/stdlib-float.h
ldapurl.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/limits.h
ldapurl.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/syslimits.h
ldapurl.o: /usr/include/limits.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/posix1_lim.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/local_lim.h
ldapurl.o: /usr/include/linux/limits.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/posix2_lim.h
ldapurl.o: /usr/include/stdio.h
ldapurl.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdarg.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos64_t.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/types/__FILE.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/types/FILE.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/stdio_lim.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/sys_errlist.h
ldapurl.o: ../../include/ac/unistd.h
ldapurl.o: /usr/include/unistd.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/posix_opt.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/environments.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/confname.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/getopt_posix.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/getopt_core.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/unistd_ext.h
ldapurl.o: /usr/include/getopt.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/getopt_ext.h
ldapurl.o: ../../include/lutil_lockf.h
ldapurl.o: ../../include/ac/socket.h
ldapurl.o: /usr/include/poll.h
ldapurl.o: /usr/include/x86_64-linux-gnu/sys/poll.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/poll.h
ldapurl.o: /usr/include/x86_64-linux-gnu/sys/socket.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/types/struct_iovec.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/socket.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/socket_type.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/sockaddr.h
ldapurl.o: /usr/include/x86_64-linux-gnu/asm/socket.h
ldapurl.o: /usr/include/asm-generic/socket.h
ldapurl.o: /usr/include/linux/posix_types.h
ldapurl.o: /usr/include/linux/stddef.h
ldapurl.o: /usr/include/x86_64-linux-gnu/asm/posix_types.h
ldapurl.o: /usr/include/x86_64-linux-gnu/asm/posix_types_64.h
ldapurl.o: /usr/include/asm-generic/posix_types.h
ldapurl.o: /usr/include/x86_64-linux-gnu/asm/bitsperlong.h
ldapurl.o: /usr/include/asm-generic/bitsperlong.h
ldapurl.o: /usr/include/x86_64-linux-gnu/asm/sockios.h
ldapurl.o: /usr/include/asm-generic/sockios.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/types/struct_osockaddr.h
ldapurl.o: /usr/include/x86_64-linux-gnu/sys/un.h
ldapurl.o: /usr/include/string.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/types/locale_t.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/types/__locale_t.h
ldapurl.o: /usr/include/strings.h
ldapurl.o: /usr/include/netinet/in.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/stdint-uintn.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/in.h
ldapurl.o: /usr/include/netinet/tcp.h
ldapurl.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdint.h
ldapurl.o: /usr/include/stdint.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/wchar.h
ldapurl.o: /usr/include/arpa/inet.h
ldapurl.o: /usr/include/arpa/nameser.h
ldapurl.o: /usr/include/x86_64-linux-gnu/sys/param.h
ldapurl.o: /usr/include/signal.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/signum.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/signum-generic.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/types/sig_atomic_t.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/types/siginfo_t.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/types/__sigval_t.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/siginfo-arch.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/siginfo-consts.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/types/sigval_t.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/types/sigevent_t.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/sigevent-consts.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/sigaction.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/sigcontext.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/types/stack_t.h
ldapurl.o: /usr/include/x86_64-linux-gnu/sys/ucontext.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/sigstack.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/ss_flags.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/types/struct_sigstack.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/sigthread.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/signal_ext.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/param.h
ldapurl.o: /usr/include/linux/param.h
ldapurl.o: /usr/include/x86_64-linux-gnu/asm/param.h
ldapurl.o: /usr/include/asm-generic/param.h
ldapurl.o: /usr/include/arpa/nameser_compat.h
ldapurl.o: /usr/include/netdb.h
ldapurl.o: /usr/include/rpc/netdb.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/netdb.h
ldapurl.o: /usr/include/resolv.h
ldapurl.o: /usr/include/x86_64-linux-gnu/bits/types/res_state.h
ldapurl.o: ../../include/ldap.h
ldapurl.o: ../../include/lber.h
ldapurl.o: ../../include/lber_types.h
ldapurl.o: ../../include/ldap_cdefs.h
ldapurl.o: ../../include/ldap_features.h
ldapurl.o: ../../include/ldap_pvt.h
ldapurl.o: ../../include/openldap.h
ldapurl.o: ../../include/lber_pvt.h
ldapurl.o: ../../include/ldap_pvt_uc.h
ldapurl.o: ../../include/ac/bytes.h
ldapurl.o: ../../include/../libraries/liblunicode/ucdata/ucdata.h
ldapurl.o: ../../include/lutil.h
common.o: common.c
common.o: /usr/include/stdc-predef.h
common.o: ../../include/portable.h
common.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h
common.o: ../../include/ac/fdset.h
common.o: /usr/include/x86_64-linux-gnu/bits/types.h
common.o: /usr/include/features.h
common.o: /usr/include/x86_64-linux-gnu/sys/cdefs.h
common.o: /usr/include/x86_64-linux-gnu/bits/wordsize.h
common.o: /usr/include/x86_64-linux-gnu/bits/long-double.h
common.o: /usr/include/x86_64-linux-gnu/gnu/stubs.h
common.o: /usr/include/x86_64-linux-gnu/gnu/stubs-64.h
common.o: /usr/include/x86_64-linux-gnu/bits/timesize.h
common.o: /usr/include/x86_64-linux-gnu/bits/typesizes.h
common.o: /usr/include/x86_64-linux-gnu/bits/time64.h
common.o: ../../include/ldap_cdefs.h
common.o: ../../include/ldap_features.h
common.o: ../../include/ac/assert.h
common.o: /usr/include/assert.h
common.o: ../../include/ac/localize.h
common.o: /usr/include/stdio.h
common.o: /usr/include/x86_64-linux-gnu/bits/libc-header-start.h
common.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdarg.h
common.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h
common.o: /usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h
common.o: /usr/include/x86_64-linux-gnu/bits/types/__fpos64_t.h
common.o: /usr/include/x86_64-linux-gnu/bits/types/__FILE.h
common.o: /usr/include/x86_64-linux-gnu/bits/types/FILE.h
common.o: /usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h
common.o: /usr/include/x86_64-linux-gnu/bits/stdio_lim.h
common.o: /usr/include/x86_64-linux-gnu/bits/sys_errlist.h
common.o: ../../include/ac/stdlib.h
common.o: /usr/include/stdlib.h
common.o: /usr/include/x86_64-linux-gnu/bits/waitflags.h
common.o: /usr/include/x86_64-linux-gnu/bits/waitstatus.h
common.o: /usr/include/x86_64-linux-gnu/bits/floatn.h
common.o: /usr/include/x86_64-linux-gnu/bits/floatn-common.h
common.o: /usr/include/x86_64-linux-gnu/sys/types.h
common.o: /usr/include/x86_64-linux-gnu/bits/types/clock_t.h
common.o: /usr/include/x86_64-linux-gnu/bits/types/clockid_t.h
common.o: /usr/include/x86_64-linux-gnu/bits/types/time_t.h
common.o: /usr/include/x86_64-linux-gnu/bits/types/timer_t.h
common.o: /usr/include/x86_64-linux-gnu/bits/stdint-intn.h
common.o: /usr/include/endian.h
common.o: /usr/include/x86_64-linux-gnu/bits/endian.h
common.o: /usr/include/x86_64-linux-gnu/bits/endianness.h
common.o: /usr/include/x86_64-linux-gnu/bits/byteswap.h
common.o: /usr/include/x86_64-linux-gnu/bits/uintn-identity.h
common.o: /usr/include/x86_64-linux-gnu/sys/select.h
common.o: /usr/include/x86_64-linux-gnu/bits/select.h
common.o: /usr/include/x86_64-linux-gnu/bits/types/sigset_t.h
common.o: /usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h
common.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h
common.o: /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h
common.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes.h
common.o: /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h
common.o: /usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h
common.o: /usr/include/x86_64-linux-gnu/bits/struct_mutex.h
common.o: /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h
common.o: /usr/include/alloca.h
common.o: /usr/include/x86_64-linux-gnu/bits/stdlib-float.h
common.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/limits.h
common.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/syslimits.h
common.o: /usr/include/limits.h
common.o: /usr/include/x86_64-linux-gnu/bits/posix1_lim.h
common.o: /usr/include/x86_64-linux-gnu/bits/local_lim.h
common.o: /usr/include/linux/limits.h
common.o: /usr/include/x86_64-linux-gnu/bits/posix2_lim.h
common.o: ../../include/ac/signal.h
common.o: /usr/include/signal.h
common.o: /usr/include/x86_64-linux-gnu/bits/signum.h
common.o: /usr/include/x86_64-linux-gnu/bits/signum-generic.h
common.o: /usr/include/x86_64-linux-gnu/bits/types/sig_atomic_t.h
common.o: /usr/include/x86_64-linux-gnu/bits/types/siginfo_t.h
common.o: /usr/include/x86_64-linux-gnu/bits/types/__sigval_t.h
common.o: /usr/include/x86_64-linux-gnu/bits/siginfo-arch.h
common.o: /usr/include/x86_64-linux-gnu/bits/siginfo-consts.h
common.o: /usr/include/x86_64-linux-gnu/bits/types/sigval_t.h
common.o: /usr/include/x86_64-linux-gnu/bits/types/sigevent_t.h
common.o: /usr/include/x86_64-linux-gnu/bits/sigevent-consts.h
common.o: /usr/include/x86_64-linux-gnu/bits/sigaction.h
common.o: /usr/include/x86_64-linux-gnu/bits/sigcontext.h
common.o: /usr/include/x86_64-linux-gnu/bits/types/stack_t.h
common.o: /usr/include/x86_64-linux-gnu/sys/ucontext.h
common.o: /usr/include/x86_64-linux-gnu/bits/sigstack.h
common.o: /usr/include/x86_64-linux-gnu/bits/ss_flags.h
common.o: /usr/include/x86_64-linux-gnu/bits/types/struct_sigstack.h
common.o: /usr/include/x86_64-linux-gnu/bits/sigthread.h
common.o: /usr/include/x86_64-linux-gnu/bits/signal_ext.h
common.o: ../../include/ac/string.h
common.o: /usr/include/string.h
common.o: /usr/include/x86_64-linux-gnu/bits/types/locale_t.h
common.o: /usr/include/x86_64-linux-gnu/bits/types/__locale_t.h
common.o: /usr/include/strings.h
common.o: ../../include/ac/ctype.h
common.o: /usr/include/ctype.h
common.o: ../../include/ac/unistd.h
common.o: /usr/include/unistd.h
common.o: /usr/include/x86_64-linux-gnu/bits/posix_opt.h
common.o: /usr/include/x86_64-linux-gnu/bits/environments.h
common.o: /usr/include/x86_64-linux-gnu/bits/confname.h
common.o: /usr/include/x86_64-linux-gnu/bits/getopt_posix.h
common.o: /usr/include/x86_64-linux-gnu/bits/getopt_core.h
common.o: /usr/include/x86_64-linux-gnu/bits/unistd_ext.h
common.o: /usr/include/getopt.h
common.o: /usr/include/x86_64-linux-gnu/bits/getopt_ext.h
common.o: ../../include/lutil_lockf.h
common.o: ../../include/ac/errno.h
common.o: /usr/include/errno.h
common.o: /usr/include/x86_64-linux-gnu/bits/errno.h
common.o: /usr/include/linux/errno.h
common.o: /usr/include/x86_64-linux-gnu/asm/errno.h
common.o: /usr/include/asm-generic/errno.h
common.o: /usr/include/asm-generic/errno-base.h
common.o: ../../include/ac/time.h
common.o: /usr/include/x86_64-linux-gnu/sys/time.h
common.o: /usr/include/time.h
common.o: /usr/include/x86_64-linux-gnu/bits/time.h
common.o: /usr/include/x86_64-linux-gnu/bits/types/struct_tm.h
common.o: /usr/include/x86_64-linux-gnu/bits/types/struct_itimerspec.h
common.o: ../../include/ac/socket.h
common.o: /usr/include/poll.h
common.o: /usr/include/x86_64-linux-gnu/sys/poll.h
common.o: /usr/include/x86_64-linux-gnu/bits/poll.h
common.o: /usr/include/x86_64-linux-gnu/sys/socket.h
common.o: /usr/include/x86_64-linux-gnu/bits/types/struct_iovec.h
common.o: /usr/include/x86_64-linux-gnu/bits/socket.h
common.o: /usr/include/x86_64-linux-gnu/bits/socket_type.h
common.o: /usr/include/x86_64-linux-gnu/bits/sockaddr.h
common.o: /usr/include/x86_64-linux-gnu/asm/socket.h
common.o: /usr/include/asm-generic/socket.h
common.o: /usr/include/linux/posix_types.h
common.o: /usr/include/linux/stddef.h
common.o: /usr/include/x86_64-linux-gnu/asm/posix_types.h
common.o: /usr/include/x86_64-linux-gnu/asm/posix_types_64.h
common.o: /usr/include/asm-generic/posix_types.h
common.o: /usr/include/x86_64-linux-gnu/asm/bitsperlong.h
common.o: /usr/include/asm-generic/bitsperlong.h
common.o: /usr/include/x86_64-linux-gnu/asm/sockios.h
common.o: /usr/include/asm-generic/sockios.h
common.o: /usr/include/x86_64-linux-gnu/bits/types/struct_osockaddr.h
common.o: /usr/include/x86_64-linux-gnu/sys/un.h
common.o: /usr/include/netinet/in.h
common.o: /usr/include/x86_64-linux-gnu/bits/stdint-uintn.h
common.o: /usr/include/x86_64-linux-gnu/bits/in.h
common.o: /usr/include/netinet/tcp.h
common.o: /usr/lib/gcc/x86_64-linux-gnu/9/include/stdint.h
common.o: /usr/include/stdint.h
common.o: /usr/include/x86_64-linux-gnu/bits/wchar.h
common.o: /usr/include/arpa/inet.h
common.o: /usr/include/arpa/nameser.h
common.o: /usr/include/x86_64-linux-gnu/sys/param.h
common.o: /usr/include/x86_64-linux-gnu/bits/param.h
common.o: /usr/include/linux/param.h
common.o: /usr/include/x86_64-linux-gnu/asm/param.h
common.o: /usr/include/asm-generic/param.h
common.o: /usr/include/arpa/nameser_compat.h
common.o: /usr/include/netdb.h
common.o: /usr/include/rpc/netdb.h
common.o: /usr/include/x86_64-linux-gnu/bits/netdb.h
common.o: /usr/include/resolv.h
common.o: /usr/include/x86_64-linux-gnu/bits/types/res_state.h
common.o: ../../include/ldap.h
common.o: ../../include/lber.h
common.o: ../../include/lber_types.h
common.o: ../../include/ldap_cdefs.h
common.o: ../../include/ldap_features.h
common.o: ../../include/ldif.h
common.o: ../../include/lutil.h
common.o: ../../include/lutil_ldap.h
common.o: ../../include/ldap_defaults.h
common.o: ../../include/ldap_config.h
common.o: ../../include/ldap_pvt.h
common.o: ../../include/openldap.h
common.o: ../../include/lber_pvt.h
common.o: ../../include/ldap_pvt_uc.h
common.o: ../../include/ac/bytes.h
common.o: ../../include/../libraries/liblunicode/ucdata/ucdata.h
common.o: common.h

# IF YOU PUT ANYTHING HERE IT WILL GO AWAY
