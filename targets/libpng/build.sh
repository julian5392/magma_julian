#!/bin/bash
set -e

##
# Pre-requirements:
# - env TARGET: path to target work dir
# - env OUT: path to directory where artifacts are stored
# - env CC, CXX, FLAGS, LIBS, etc...
##

if [ ! -d "$TARGET/repo" ]; then
    echo "fetch.sh must be executed first."
    exit 1
fi
cd "$TARGET/repo"
mkdir temp
export TMP_DIR=$PWD/temp

echo "png.c:620
pngerror.c:955
pngrtran.c:1967
pngrutil.c:992
pngrutil.c:3189
pngrutil.c:3480
pngrutil.c:4645
" > ./temp/BBtargets.txt

# build the libpng library
export COPY_CFLAGS=$CFLAGS
export COPY_CXXFLAGS=$CXXFLAGS


# export ADDITIONAL="-targets=$TMP_DIR/BBtargets.txt -outdir=$TMP_DIR"
export ADDITIONAL="-targets=$TMP_DIR/BBtargets.txt -outdir=$TMP_DIR -flto -fuse-ld=gold -Wl,-plugin-opt=save-temps"
export CFLAGS="$CFLAGS $ADDITIONAL"
export CXXFLAGS="$CXXFLAGS $ADDITIONAL"
export LDFLAGS=-lpthread
autoreconf -f -i
./configure --disable-shared
make -j$(nproc) clean
make -j$(nproc) libpng16.la
cp .libs/libpng16.a "$OUT/"
cat $TMP_DIR/BBnames.txt | rev | cut -d: -f2- | rev | sort | uniq > $TMP_DIR/BBnames2.txt && mv $TMP_DIR/BBnames2.txt $TMP_DIR/BBnames.txt
cat $TMP_DIR/BBcalls.txt | sort | uniq > $TMP_DIR/BBcalls2.txt && mv $TMP_DIR/BBcalls2.txt $TMP_DIR/BBcalls.txt
# build libpng_read_fuzzer.
llvm-ar -s .libs/libpng16.a
llvm-ranlib .libs/libpng16.a
$CXX -v $CXXFLAGS -std=c++11 -I. \
     contrib/oss-fuzz/libpng_read_fuzzer.cc \
     -o $OUT/libpng_read_fuzzer \
     $LDFLAGS .libs/libpng16.a $LIBS -lz -flto -fuse-ld=gold -Wl,-plugin-opt=save-temps
echo "all done"
$TOOL "$OUT/" $TMP_DIR libpng_read_fuzzer || cat /magma/targets/libpng/repo/temp/step2.log
# $TOOL "$OUT/" $TMP_DIR libpng_read_fuzzer
file $OUT/libpng_read_fuzzer
export CFLAGS="$COPY_CFLAGS -distance=$TMP_DIR/distance.cfg.txt"
export CXXFLAGS="$COPY_CXXFLAGS -distance=$TMP_DIR/distance.cfg.txt"
cat $TMP_DIR/distance.cfg.txt
./configure --with-libpng-prefix=MAGMA_ --disable-shared
make -j$(nproc) clean
make -j$(nproc) libpng16.la
cp .libs/libpng16.a "$OUT/"
llvm-ar -s .libs/libpng16.a
llvm-ranlib .libs/libpng16.a
# build libpng_read_fuzzer.
$CXX -v $CXXFLAGS -std=c++11 -I. \
     contrib/oss-fuzz/libpng_read_fuzzer.cc \
     -o $OUT/libpng_read_fuzzer \
     $LDFLAGS .libs/libpng16.a $LIBS -lz -flto -fuse-ld=gold -Wl,-plugin-opt=save-temps