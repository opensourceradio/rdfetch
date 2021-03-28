#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.
dnl configure.ac
dnl
dnl Autoconf configuration for the rivendell_install package.
dnl
dnl Use autoconf to process this into a configure script
dnl
dnl   (C) Copyright 2016 Fred Gleason <fredg@paravelsystems.com>
dnl
dnl   This program is free software; you can redistribute it and/or modify
dnl   it under the terms of the GNU General Public License version 2 as
dnl   published by the Free Software Foundation.
dnl
dnl   This program is distributed in the hope that it will be useful,
dnl   but WITHOUT ANY WARRANTY; without even the implied warranty of
dnl   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
dnl   GNU General Public License for more details.
dnl
dnl   You should have received a copy of the GNU General Public
dnl   License along with this program; if not, write to the Free Software
dnl   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
dnl

AC_PREREQ([2.69])

AC_INIT([rdfetch],m4_esyscmd(cat PACKAGE_VERSION))
AM_INIT_AUTOMAKE

AC_SUBST(RPM_RELEASE,1)
m4_ifdef([AM_SILENT_RULES],[AM_SILENT_RULES([yes])])
AC_CONFIG_MACRO_DIR([m4])

#
# Some Fully Resolved Install Paths
# (for the packaging system and friends)
#
if test ${prefix} = "NONE" ; then
  PREFIX=/usr/local
  AC_SUBST(LOCAL_PREFIX,/usr/local)
else
  PREFIX=${prefix}
  AC_SUBST(LOCAL_PREFIX,${prefix})
fi

# Rdfetch specifics, we prefer /home/rd/rdfetch/configuration
# for all the rdfetch configuration and notification
# stuff.
AC_SUBST(HOMERD,/home/rd)
AC_SUBST(RDFETCH_TOPDIR,/home/rd/rdfetch)

AC_SUBST(PODGET_DIR_CONFIG,/home/rd/rdfetch/configuration)
AC_SUBST(PODGET_DIR_SESSION,/home/rd/rdfetch/configuration/tmp)
AC_SUBST(PODGET_DIR_LIBRARY,/home/rd/rdfetch/podcasts)
AC_SUBST(PODGET_DIR_LOG,/home/rd/rdfetch/log)

#
# Option Switches
#
AC_ARG_ENABLE(docbook,[  --disable-docbook       disable building of documentation],[DOCBOOK_DISABLED=yes],[])

#
# Build DocBook Items?
#
if test -z $DOCBOOK_DISABLED ; then
  USING_DOCBOOK=yes
fi
AM_CONDITIONAL([DOCBOOK_AM], [test "$USING_DOCBOOK" = yes])

#
# DocBook
#
if test -z $DOCBOOK_DISABLED ; then
  USING_DOCBOOK=yes
fi
AM_CONDITIONAL([DOCBOOK_AM], [test "$USING_DOCBOOK" = yes])
dnl This was from the Rivendell configure.ac;
dnl we expect DOCBOOK_STYLESHEETS to be exported.
dnl if test $DOCBOOK_STYLESHEETS ; then
dnl    ln -s $DOCBOOK_STYLESHEETS helpers/docbook
dnl fi

#
# Configure RPM Build
#
AC_CHECK_PROG(RPMBUILD_FOUND,rpmbuild,[yes],[])
if test -z $RPMBUILD_FOUND ; then
  AC_SUBST(RPMBUILD,rpm)
else
  AC_SUBST(RPMBUILD,rpmbuild)
fi
if test -d /usr/src/redhat ; then
  AC_SUBST(VENDOR,redhat)
else
  AC_SUBST(VENDOR,suse)
fi 
AC_SUBST(RPM_DATESTAMP,`date +%a\ %b\ %d\ %Y`)

AC_CONFIG_FILES([   \
    podgetrc        \
    rdfetch.spec    \
    README.md       \
    Makefile])
# These "config files" are actually executable scripts.
AC_CONFIG_FILES([rdfetch],[chmod +x rdfetch])
AC_CONFIG_FILES([podget-wrapper],[chmod +x podget-wrapper])

AC_OUTPUT()

AC_MSG_NOTICE()
AC_MSG_NOTICE(Now enter 'make' to build the software.)
AC_MSG_NOTICE()
