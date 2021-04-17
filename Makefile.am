## automake.am
##
## Top level Makefile.am for RDFetch.
##
## Use automake to process this into a Makefile.in
##
##   (C) Copyright 2020 David Klann <dklann@broadcasttool.com>
##
##   This program is free software; you can redistribute it and/or modify
##   it under the terms of the GNU General Public License version 3 as
##   published by the Free Software Foundation.
##
##   This program is distributed in the hope that it will be useful,
##   but WITHOUT ANY WARRANTY; without even the implied warranty of
##   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##   GNU General Public License for more details.
##
##   You should have received a copy of the GNU General Public
##   License along with this program; if not, write to the Free Software
##   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
##

dist_bin_SCRIPTS = rdfetch \
                   podget-wrapper \
                   zsh-functions

man_MANS = rdfetch.1

ACLOCAL_AMFLAGS = -I m4

EXTRA_DIST = autogen.sh             \
             PACKAGE_VERSION        \
             rdfetch.in             \
             podget-wrapper.in      \
             zsh-functions.in       \
             rdfetch.spec.in        \
             rdfetch-rivendell.menu \
             rdfetch.desktop        \
             rdfetch.svg            \
             LICENSE                \
             msmtp.rdfetch          \
             notifyrc               \
             podgetrc.in            \
             serverlist             \
             rdfetch.1              \
             rdfetch.html           \
             rdfetch.pdf            \
             rdfetch.xml

CLEANFILES = *~        \
             *.rpm     \
             *.tar.gz  \
             *.1       \
             *.pdf     \
             *.html    \
             README    \
             README.md \
             $(dist_bin_SCRIPTS)

DISTCLEANFILES = config.guess \
                 config.sub

MAINTAINERCLEANFILES = *~            \
                       *.tar.gz      \
                       *.rpm         \
                       *.1           \
                       *.html        \
                       *.pdf         \
                       aclocal.m4    \
                       Makefile      \
                       Makefile.in   \
                       config.guess  \
                       config.log    \
                       config.status \
                       config.sub    \
                       configure     \
                       depcomp       \
                       libtool       \
                       ltmain.sh     \
                       $(dist_bin_SCRIPTS) \
                       README        \
                       README.md     \
                       mkinstalldirs

maintainer-clean-local:	
	rm -rf m4

rpm:	dist
	mkdir -p $(HOME)/rpmbuild/SOURCES
	cp rdfetch-$(VERSION).tar.gz $(HOME)/rpmbuild/SOURCES/
	sha256sum $(HOME)/rpmbuild/SOURCES/rdfetch-$(VERSION).tar.gz > $(HOME)/rpmbuild/SOURCES/rdfetch-$(VERSION).tar.gz.sha256
	$(RPMBUILD) -ba --target noarch-$(VENDOR)-linux rdfetch.spec
	mv $(HOME)/rpmbuild/RPMS/noarch/rdfetch-*.rpm $(top_srcdir)/
	mv $(HOME)/rpmbuild/SRPMS/rdfetch-*.src.rpm $(top_srcdir)/
	rm $(HOME)/rpmbuild/SOURCES/rdfetch-$(VERSION).tar.gz

install-exec-am:	rdfetch.1 rdfetch.pdf rdfetch.html rdfetch podget-wrapper
	mkdir -p $(DESTDIR)@HOMERD@/rdfetch/log/archive
	mkdir -p $(DESTDIR)@HOMERD@/rdfetch/configuration
	mkdir -p $(DESTDIR)@HOMERD@/rdfetch/podcasts
	mkdir -p $(DESTDIR)@HOMERD@/rdfetch/tmp

	cp msmtp.rdfetch $(DESTDIR)@HOMERD@/rdfetch/configuration
	cp notifyrc $(DESTDIR)@HOMERD@/rdfetch/configuration
	cp podgetrc $(DESTDIR)@HOMERD@/rdfetch/configuration
	cp serverlist $(DESTDIR)@HOMERD@/rdfetch/configuration
	chmod 600 $(DESTDIR)@HOMERD@/rdfetch/configuration/msmtp.rdfetch

	mkdir -p $(DESTDIR)@bindir@
	cp -p rdfetch $(DESTDIR)@bindir@
	cp -p podget-wrapper $(DESTDIR)@bindir@
	cp -p zsh-functions $(DESTDIR)@bindir@

	mkdir -p $(DESTDIR)@sysconfdir@/xdg/menus/applications-merged
	cp rdfetch-rivendell.menu $(DESTDIR)@sysconfdir@/xdg/menus/applications-merged/

	mkdir -p $(DESTDIR)@datadir@/applications
	cp rdfetch.desktop $(DESTDIR)@datadir@/applications/

	mkdir -p $(DESTDIR)@datadir@/icons/gnome/scalable/apps
	cp rdfetch.svg $(DESTDIR)@datadir@/icons/gnome/scalable/apps/

uninstall-local:	
	rm -f $(DESTDIR)@bindir@/rdfetch
	rm -f $(DESTDIR)@bindir@/podget-wrapper
	rm -f $(DESTDIR)@bindir@/zsh-functions
	-rmdir $(DESTDIR)@prefix@/bin

	rm -f $(DESTDIR)@datadir@/applications/rdfetch.desktop
	-rmdir $(DESTDIR)@datadir@/applications

	rm -f $(DESTDIR)@sysconfdir@/xdg/menus/applications-merged/rdfetch-rivendell.menu
	-rmdir $(DESTDIR)@sysconfdir@/xdg/menus/applications-merged

	rm -f $(DESTDIR)@datadir@/icons/gnome/scalable/apps/rdfetch.svg
	-rmdir $(DESTDIR)@datadir@/icons/gnome/scalable/apps

	rm -rf $(DESTDIR)@HOMERD@/rdfetch

# From https://www.gnu.org/savannah-checkouts/gnu/autoconf/manual/autoconf-2.69/autoconf.html#Installation-Directory-Variables
edit = sed \
          -e  's|QQQbindirQQQ|$(bindir)|g' \
          -e  's|QQQprefixQQQ|$(prefix)|g' \
          -e  's|QQQdatadirQQQ|$(datadir)|g' \
          -e  's|QQQHOMERDQQQ|$(HOMERD)|g'

zsh-functions rdfetch.desktop:	Makefile
	rm -f $@ $@.tmp
	srcdir=''; \
	    test -f ./$@.in || srcdir=$(srcdir)/; \
	    $(edit) $${srcdir}$@.in > $@.tmp
	chmod 755 $@.tmp
	mv $@.tmp $@

zsh-functions:	$(srcdir)/zsh-functions.in
rdfetch.desktop:	$(srcdir)/rdfetch.desktop.in

##
## Build Dependencies
##
%.html:	%.xml
	xsltproc -o $@ $(DOCBOOK_STYLESHEETS)/xhtml/docbook.xsl $<
%.pdf:	%.xml
	xsltproc $(DOCBOOK_STYLESHEETS)/fo/docbook.xsl $< | fop - -pdf $@
%.1:	%.xml
	xsltproc $(DOCBOOK_STYLESHEETS)/manpages/docbook.xsl $<
README:	README.md
	pandoc --from=markdown_github --to plain -o $@ $<
