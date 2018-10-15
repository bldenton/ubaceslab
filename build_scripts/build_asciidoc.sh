#!/bin/sh                                                                                                                                                                                                                                    
set -e # Fail on first error

ASCIIDOC_VERSION=$1

echo "Building ASCIIDOC for ${UBCESLAB_SYSTEMTYPE:?undefined}"

CURRENT_DIR=$PWD

mkdir -p ${UBCESLAB_SWENV_PREFIX:?undefined}/sourcesdir/asciidoc

(cd $UBCESLAB_SWENV_PREFIX/sourcesdir/asciidoc
if [ ! -f asciidoc-$ASCIIDOC_VERSION.tar.gz ]; then
   wget http://sourceforge.net/projects/asciidoc/files/asciidoc/$ASCIIDOC_VERSION/asciidoc-$ASCIIDOC_VERSION.tar.gz
fi
)

TOPDIR=${UBCESLAB_SWENV_PREFIX:?undefined}/apps/asciidoc
export ASCIIDOC_DIR=$TOPDIR/$ASCIIDOC_VERSION

mkdir -p $UBCESLAB_SWENV_PREFIX/builddir
BUILDDIR=`mktemp -d $UBCESLAB_SWENV_PREFIX/builddir/asciidoc-XXXXXX`
mkdir -p $BUILDDIR
cd $BUILDDIR

tar -xzf $UBCESLAB_SWENV_PREFIX/sourcesdir/asciidoc/asciidoc-$ASCIIDOC_VERSION.tar.gz
cd asciidoc-$ASCIIDOC_VERSION || exit 1
#make configure
./configure --prefix=$ASCIIDOC_DIR 
#make -j ${NPROC:-1} all doc

#rm -rf $ASCIIDOC_DIR
make install
make docs

cd $UBCESLAB_SWENV_PREFIX
rm -rf $BUILDDIR || true

#cd $CURRENT_DIR
#MODULEDIR=$UBCESLAB_SWENV_PREFIX/apps/lmod/modulefiles/git
#mkdir -p $MODULEDIR
#
#echo "local version = \"$GIT_VERSION\"" > $MODULEDIR/$GIT_VERSION.lua
#echo "local apps_dir = \"$UBCESLAB_SWENV_PREFIX/apps\"" >> $MODULEDIR/$GIT_VERSION.lua
#cat ../modulefiles/git.lua >> $MODULEDIR/$GIT_VERSION
