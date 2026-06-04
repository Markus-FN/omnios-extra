#!/usr/bin/bash
#
# CDDL HEADER START
#
# This file and its contents are supplied under the terms of the
# Common Development and Distribution License ("CDDL"), version 1.0.
#
# CDDL HEADER END
#

. ../../lib/build.sh

PROG=qpdf
VER=12.3.2
PKG=ooce/util/qpdf
SUMMARY="Content-preserving PDF transformation system"
DESC="qpdf is a command-line tool and C++ library for structural, content-preserving transformations of PDF files."

set_arch 64

set_mirror "$GITHUB/$PROG/$PROG/archive/refs/tags"
DISTNAME="v${VER}.tar.gz"
BUILDDIR="${PROG}-${VER}"

OPREFIX=${PREFIX}
PREFIX+="/${PROG}"

# Replace after first download:
# digest -a sha256 tmp/v12.3.2.tar.gz
set_checksum "none"

CONFIGURE_OPTS[amd64]="
    -DCMAKE_INSTALL_PREFIX=${PREFIX}
    -DCMAKE_INSTALL_LIBDIR=${OPREFIX}/lib/amd64
    -DCMAKE_INSTALL_INCLUDEDIR=${OPREFIX}/include
    -DCMAKE_BUILD_TYPE=Release
"

BUILD_DEPENDS_IPS+="
    ooce/library/libjpeg-turbo 
"

LDFLAGS[amd64]=" -L$OPREFIX/lib/amd64 -R$OPREFIX/lib/amd64"

XFORM_ARGS="
    -DOPREFIX=${OPREFIX#/}
    -DPREFIX=${PREFIX#/}
    -DPROG=$PROG
    -DPKGROOT=$PROG
"

SKIP_RTIME_CHECK=1

init
download_source / v$VER
patch_source
prep_build cmake
build -noctf
strip_install
make_package
clean_up

# vim:ts=4:sw=4:et
