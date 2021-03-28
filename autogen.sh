#!/bin/sh
##
##    (C) Copyright 2020 David Klann <dklann@broadcasttoo.com>
##
##    Adapted from './autogen.sh' in the Rivendell Install package
##    (C) Copyright 2002-2003,2016 Fred Gleason <fredg@paravelsystems.com>
##
##    This program is free software; you can redistribute it and/or modify
##    it under the terms of version 2 of the GNU General Public License as
##    published by the Free Software Foundation;
##
##    This program is distributed in the hope that it will be useful,
##    but WITHOUT ANY WARRANTY; without even the implied warranty of
##    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##    GNU General Public License for more details.
##
##    You should have received a copy of the GNU General Public License
##    along with this program; if not, write to the Free Software
##    Foundation, Inc., 59 Temple Place, Suite 330, 
##    Boston, MA  02111-1307  USA
##

mkdir -p m4

aclocal $ACLOCAL_FLAGS || {
    echo "aclocal \$ACLOCAL_FLAGS where \$ACLOCAL_FLAGS= failed, exiting..."
    exit 1
}

automake --add-missing -Wno-portability || {
    echo "automake --add-missing failed, exiting..."
    exit 1
}

autoconf || {
    echo "autoconf failed, exiting..."
    exit 1
}
