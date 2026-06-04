#!/usr/bin/bash
#
# {{{ CDDL HEADER
#
# This file and its contents are supplied under the terms of the
# Common Development and Distribution License ("CDDL"), version 1.0.
# }}}
#

. ../../lib/build.sh

PROG=ghostscript
VER=10.07.1
PKG=ooce/print/ghostscript
SUMMARY="Ghostscript PostScript and PDF interpreter"
DESC="Ghostscript is an interpreter for PostScript and PDF files and includes the libgs rendering library."

set_arch 64

# Source tarball is ghostpdl-10.07.1.tar.gz and extracts to ghostpdl-10.07.1
DIST=ghostpdl
DIR=gs${VER//./}
set_builddir "$DIST-$VER"

set_mirror "https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/"

# Initial bootstrap. Replace with real sha256 after first successful download:
# digest -a sha256 tmp/ghostpdl-10.07.1.tar.gz
set_checksum none

BUILD_DEPENDS_IPS+="
    ooce/library/freetype2
    ooce/library/libjpeg-tdurbo
    ooce/library/libpng
    ooce/library/tiff
    ooce/library/lcms2
    ooce/library/zlib
"

CONFIGURE_OPTS+="
    --prefix=/opt/ooce/$PROG
    --bindir=/opt/ooce/$PROG/bin
    --libdir=/opt/ooce/$PROG/lib/$ISAPART64
    --includedir=/opt/ooce/$PROG/include
    --enable-dynamic
    --with-system-libtiff
    --with-system-lcms2
    --with-system-libpng
    --with-system-zlib
"

# Ghostscript’s build is standard configure + make + make install.
# Upstream documents the normal sequence as configure, make, install. 
# ./configure --help is also the right place to inspect available knobs.
# See Ghostscript build docs and OmniOS Extra build framework docs.

init
download_source $DIR $DIST $VER
#prep_build
#build
#strip_install
#make_package
#clean_up

# vim:ts=4:sw=4:et:fdm=marker
