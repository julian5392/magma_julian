#!/bin/bash
set -e

##
# Pre-requirements:
# - env FUZZER: path to fuzzer work dir
# - env TARGET: path to target work dir
# - env MAGMA: path to Magma support files
# - env OUT: path to directory where artifacts are stored
# - env CFLAGS and CXXFLAGS must be set to link against Magma instrumentation
##

export CC="$FUZZER/repo/instrument/afl-clang-fast"
export CXX="$FUZZER/repo/instrument/afl-clang-fast++"
export AS="$FUZZER/repo/afl-2.57b/afl-as"
export TOOL="$FUZZER/repo/distance/gen_distance_fast.py"

export LIBS="$LIBS -l:$OUT/afl_driver.o -lstdc++"

"$MAGMA/build.sh"
"$TARGET/build.sh"

# NOTE: We pass $OUT directly to the target build.sh script, since the artifact
#       itself is the fuzz target. In the case of Angora, we might need to
#       replace $OUT by $OUT/fast and $OUT/track, for instance.
