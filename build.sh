#!/bin/bash

git checkout -b v290_backward_compatible
git submodule update --init pixman

mkdir -p build
cd build

../configure --static --disable-system --enable-linux-user
make

LIBC=`readlink -f ../libc.a`
all="aarch64  arm  armeb  i386  mips  mipsel  ppc  ppc64  x86_64"
for q in $all;do
    cd $q-linux-user
    rm -f qemu-$q
    make V=1 CFLAGS="-v" 2>&1|grep collect2 > y.sh
    chmod +x y.sh
    sed -i "s#-lc#$LIBC#" y.sh
    ./y.sh
    cd ..
done
