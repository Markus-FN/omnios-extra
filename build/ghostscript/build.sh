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

DIST=ghostpdl
DIR=gs${VER//./}
set_builddir "$DIST-$VER"

set_mirror "https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/"

set_checksum sha256 56f6a82907c3a73bba95de1319e029adf16477e34df2dea180d390e71e7c4053

BUILD_DEPENDS_IPS+="
"

OPREFIX=${PREFIX}
PREFIX+="/${PROG}"

CONFIGURE_OPTS[amd64]="
    --prefix=${OPREFIX}
    --exec-prefix=${PREFIX}
    --libdir=${OPREFIX}/lib/$ISAPART64
    --disable-hidden-visibility
"

XFORM_ARGS="
    -DOPREFIX=${OPREFIX#/}
    -DPREFIX=${PREFIX#/}
    -DPROG=$PROG
    -DPKGROOT=$PROG
"

SKIP_RTIME_CHECK=1

init
download_source $DIR $DIST $VER
patch_source
prep_build
build -noctf
strip_install
make_package
clean_up

# vim:ts=4:sw=4:et:fdm=marker
