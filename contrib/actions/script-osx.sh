#!/bin/bash
set -ev

export MACOSX_DEPLOYMENT_TARGET=10.12
BUILD_REPO_URL=..

cd build

git clone $BUILD_REPO_URL secp256k1

cd secp256k1

./autogen.sh
./configure --enable-module-recovery --enable-experimental --enable-module-ecdh --disable-jni
make

mkdir -p ../libsecp256k1
cp .libs/libsecp256k1.0.dylib ../libsecp256k1
cd ..
tar -czf libsecp256k1-$LIB_VERSION-osx.tgz libsecp256k1
