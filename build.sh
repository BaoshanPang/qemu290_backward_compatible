#!/bin/bash

BLDDIR=`pwd`
SRCDIR=`dirname $0`
cd $SRCDIR
git checkout -b v290_backward_compatible
git submodule update --init pixman

cd $BLDDIR
$SRCDIR/configure --static --disable-system --enable-linux-user
make
