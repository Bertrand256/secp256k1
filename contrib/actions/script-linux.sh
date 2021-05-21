#!/bin/bash
set -ev

BUILD_REPO_URL=..

cd build

git clone $BUILD_REPO_URL secp256k1

docker run --rm \
    -v $(pwd):/root/secp256k1 \
    -t zebralucky/zbarw-build \
    /root/secp256k1/secp256k1/contrib/actions/build.sh
