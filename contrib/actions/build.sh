#!/bin/bash

BUILD_DIR=/root/secp256k1
SRC_DIR=$BUILD_DIR/secp256k1

# win32
cd $SRC_DIR
source contrib/actions/version_env.sh

git clean -fd

./autogen.sh
echo "LDFLAGS = -no-undefined" >> Makefile.am
LDFLAGS="-Wl,--no-insert-timestamp" ./configure \
    --host=i686-w64-mingw32 --prefix=/usr/local/win32 \
    --enable-module-recovery \
    --enable-experimental \
    --enable-module-ecdh \
    --disable-jni

make
make install
BUILD32=$BUILD_DIR/win32
mkdir -p $BUILD32/libsecp256k1
cp .libs/libsecp256k1-0.dll $BUILD32/libsecp256k1
cd $BUILD32
zip -r $BUILD_DIR/libsecp256k1-$LIB_VERSION-win32.zip libsecp256k1

# win64
cd $SRC_DIR

git clean -fd

./autogen.sh
echo "LDFLAGS = -no-undefined" >> Makefile.am
LDFLAGS="-Wl,--no-insert-timestamp" ./configure \
    --host=x86_64-w64-mingw32 --prefix=/usr/local/win64 \
    --enable-module-recovery \
    --enable-experimental \
    --enable-module-ecdh \
    --disable-jni

make
make install
BUILD64=$BUILD_DIR/win64
mkdir -p $BUILD64/libsecp256k1
cp .libs/libsecp256k1-0.dll $BUILD64/libsecp256k1
cd $BUILD64
zip -r $BUILD_DIR/libsecp256k1-$LIB_VERSION-win64.zip libsecp256k1
