#!/bin/bash

##
# Pre-requirements:
# - env TARGET: path to target work dir
##
git config --global http.postBuffer 524288000
git config --global http.sslVerify false
git clone --no-checkout https://github.com/glennrp/libpng.git \
    "$TARGET/repo"
git -C "$TARGET/repo" checkout a37d4836519517bdce6cb9d956092321eca3e73b