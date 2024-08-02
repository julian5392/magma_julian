#!/bin/bash
set -e

##
# Pre-requirements:
# - env FUZZER: path to fuzzer work dir
##

if [ ! -d "$FUZZER/repo" ]; then
    echo "fetch.sh must be executed first."
    exit 1
fi

# apt-get update
# apt-get upgrade
# apt-get dist-upgrade
strings /lib/x86_64-linux-gnu/libc.so.6 |grep GLIBC_

cd "$FUZZER/repo/afl-2.57b"
export CC=clang 
export CXX=clang++
make -j $(nproc) all
cd ./llvm_mode
make -j $(nproc)
cd $FUZZER/repo/instrument
# make >> /home/julian/fuzz/magma/tools/captain/aflgo_build.log 2>&1
make all
cd $FUZZER/repo/distance/distance_calculator
cmake .
cmake --build .
cd $FUZZER/repo

# compile afl_driver.cpp
./instrument/aflgo-clang $CXXFLAGS -std=c++11 -c "afl_driver.cpp" -fPIC -o "$OUT/afl_driver.o" 2>&1 | tee ./build_output.log