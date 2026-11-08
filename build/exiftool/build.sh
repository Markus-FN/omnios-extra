#!/usr/bin/bash
#
# CDDL HEADER ...

. ../../lib/build.sh

PROG=exiftool
IMAGE=Image-ExifTool
VER=13.60
PKG=ooce/multimedia/exiftool
SUMMARY="ExifTool - Read, write and edit metadata in files"
DESC="ExifTool is a platform-independent Perl library and command-line \
application for reading, writing and editing metadata in a wide variety \
of files."
set_arch 64

set_mirror "https://downloads.sourceforge.net/project"
set_checksum sha256 "c8e3c42576f46d862e4cd9c192989776e7363931e890c95056bcd6293e83ea36"
set_builddir $IMAGE"-"$VER

PERL_MAKE_TEST=1
SKIP_LICENCES="Various"
extract_licence() {
    logmsg "-- extracting ExifTool licence information"

    pushd "$TMPDIR/$BUILDDIR" > /dev/null || logerr "Invalid build directory"

    sed -n '/^COPYRIGHT AND LICENSE/,/^DISTRIBUTION FILES/{ /^DISTRIBUTION FILES/!p; }' \
        README > LICENCE

    popd > /dev/null
}

OPREFIX=${PREFIX}
PREFIX+="/${PROG}"

PERL_MAKEFILE_OPTS="
   INSTALL_BASE=$PREFIX
   INSTALLSITELIB=$PREFIX/bin/lib
   INSTALLSITEMAN1DIR=$PREFIX/share/man/man1
   INSTALLSITEMAN3DIR=$PREFIX/share/man/man3
"

XFORM_ARGS="
    -DOPREFIX=${OPREFIX#/}
    -DPREFIX=${PREFIX#/}
    -DPROG=$PROG
    -DPKGROOT=$PROG
"

RUN_DEPENDS_IPS+="
   runtime/perl   
"

init
download_source $PROG $IMAGE $VER
prep_build
extract_licence
buildperl
make_package
clean_up
