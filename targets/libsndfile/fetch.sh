#!/bin/bash

##
# Pre-requirements:
# - env TARGET: path to target work dir
##
git config --global http.postBuffer 524288000
git config --global http.sslVerify false
git clone --no-checkout https://github.com/libsndfile/libsndfile.git \
    "$TARGET/repo"
git -C "$TARGET/repo" checkout 86c9f9eb7022d186ad4d0689487e7d4f04ce2b29