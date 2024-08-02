#!/bin/bash
set -e
#> /etc/apt/sources.list
sudo apt install -y ca-certificates

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 15CF4D18AF4F7421
> /etc/apt/sources.list
echo "# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-security main restricted universe multiverse
" | sudo tee -a /etc/apt/sources.list



# echo "# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse
# # deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse
# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
# # deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
# # deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse
# # deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse
# " | sudo tee -a /etc/apt/sources.list
# echo "deb https://mirrors.tuna.tsinghua.edu.cn/llvm-apt/bionic/ llvm-toolchain-bionic-11 main" | sudo tee -a /etc/apt/sources.list
apt-get update && \
    apt-get install -y build-essential make cmake ninja-build git binutils-gold binutils-dev curl wget python3 clang-11 libboost-all-dev  gnutls-bin llvm-11
# wget http://ftp.gnu.org/gnu/glibc/glibc-2.34.tar.gz

# tar -xf glibc-2.34.tar.gz
# cd glibc-2.34
# mkdir bulid
# cd bulid/
# ../configure --prefix=/usr
# make -j4&& make install
# cd ../../
# strings /lib/x86_64-linux-gnu/libc.so.6 |grep GLIBC_
# export DEBIAN_FRONTEND=noninteractive # jump over "Configuring tzdata"
# export LC_ALL=C

# $apt_get update

# LLVM_DEP_PACKAGES="build-essential make cmake ninja-build git binutils-gold binutils-dev curl wget python3"
# $apt_get install -y $LLVM_DEP_PACKAGES

# export CXX=g++
# export CC=gcc
# unset CFLAGS
# unset CXXFLAGS

# pushd instrument

# mkdir -p llvm_tools

# pushd llvm_tools

# wget -O llvm-11.0.0.src.tar.xz https://github.com/llvm/llvm-project/releases/download/llvmorg-11.0.0/llvm-11.0.0.src.tar.xz
# tar -xf llvm-11.0.0.src.tar.xz
# mv      llvm-11.0.0.src        llvm

# wget -O  clang-11.0.0.src.tar.xz https://github.com/llvm/llvm-project/releases/download/llvmorg-11.0.0/clang-11.0.0.src.tar.xz
# tar -xf  clang-11.0.0.src.tar.xz
# mv       clang-11.0.0.src        clang

# wget -O compiler-rt-11.0.0.src.tar.xz https://github.com/llvm/llvm-project/releases/download/llvmorg-11.0.0/compiler-rt-11.0.0.src.tar.xz
# tar -xf compiler-rt-11.0.0.src.tar.xz
# mv      compiler-rt-11.0.0.src        compiler-rt

# mkdir -p build

# pushd build

# cmake -G "Ninja" \
#       -DCMAKE_BUILD_TYPE=Release \
#       -DLLVM_TARGETS_TO_BUILD="X86" \
#       -DLLVM_BINUTILS_INCDIR=/usr/include \
#       -DLLVM_ENABLE_PROJECTS="clang;compiler-rt" \
#       -DLLVM_BUILD_TESTS=OFF \
#       -DLLVM_INCLUDE_TESTS=OFF \
#       -DLLVM_BUILD_BENCHMARKS=OFF \
#       -DLLVM_INCLUDE_BENCHMARKS=OFF \
#       ../llvm
# ninja; ninja install

# popd # go to llvm_tools

# popd # go to instrument

# popd # go to where build.sh is located

# #######################################
# ### Install LLVMgold in bfd-plugins ###
# #######################################

# mkdir -p /usr/lib/bfd-plugins
# cp /usr/local/lib/libLTO.so /usr/lib/bfd-plugins
# cp /usr/local/lib/LLVMgold.so /usr/lib/bfd-plugins

# #############################
# ### Install some packages ###
# #############################

# $apt_get install -y python3-dev python3-pip pkg-config autoconf automake libtool-bin gawk libboost-all-dev

# # See https://networkx.org/documentation/stable/release/index.html
# case `python3 -c 'import sys; print(sys.version_info[:][1])'` in
#     [01])
#         python3 -m pip install 'networkx<1.9';;
#     2)
#         python3 -m pip install 'networkx<1.11';;
#     3)
#         python3 -m pip install 'networkx<2.0';;
#     4)
#         python3 -m pip install 'networkx<2.2';;
#     5)
#         python3 -m pip install 'networkx<2.5';;
#     6)
#         python3 -m pip install 'networkx<2.6';;
#     7)
#         python3 -m pip install 'networkx<2.7';;
#     8)
#         python3 -m pip install 'networkx<=3.1';;
#     *)
#         python3 -m pip install networkx;;
# esac
# python3 -m pip install pydot pydotplus

update-alternatives \
  --install /usr/lib/llvm              llvm             /usr/lib/llvm-11  20 \
  --slave   /usr/bin/llvm-config       llvm-config      /usr/bin/llvm-config-11  \
    --slave   /usr/bin/llvm-ar           llvm-ar          /usr/bin/llvm-ar-11 \
    --slave   /usr/bin/llvm-as           llvm-as          /usr/bin/llvm-as-11 \
    --slave   /usr/bin/llvm-bcanalyzer   llvm-bcanalyzer  /usr/bin/llvm-bcanalyzer-11 \
    --slave   /usr/bin/llvm-c-test       llvm-c-test      /usr/bin/llvm-c-test-11 \
    --slave   /usr/bin/llvm-cov          llvm-cov         /usr/bin/llvm-cov-11 \
    --slave   /usr/bin/llvm-diff         llvm-diff        /usr/bin/llvm-diff-11 \
    --slave   /usr/bin/llvm-dis          llvm-dis         /usr/bin/llvm-dis-11 \
    --slave   /usr/bin/llvm-dwarfdump    llvm-dwarfdump   /usr/bin/llvm-dwarfdump-11 \
    --slave   /usr/bin/llvm-extract      llvm-extract     /usr/bin/llvm-extract-11 \
    --slave   /usr/bin/llvm-link         llvm-link        /usr/bin/llvm-link-11 \
    --slave   /usr/bin/llvm-mc           llvm-mc          /usr/bin/llvm-mc-11 \
    --slave   /usr/bin/llvm-nm           llvm-nm          /usr/bin/llvm-nm-11 \
    --slave   /usr/bin/llvm-objdump      llvm-objdump     /usr/bin/llvm-objdump-11 \
    --slave   /usr/bin/llvm-ranlib       llvm-ranlib      /usr/bin/llvm-ranlib-11 \
    --slave   /usr/bin/llvm-readobj      llvm-readobj     /usr/bin/llvm-readobj-11 \
    --slave   /usr/bin/llvm-rtdyld       llvm-rtdyld      /usr/bin/llvm-rtdyld-11 \
    --slave   /usr/bin/llvm-size         llvm-size        /usr/bin/llvm-size-11 \
    --slave   /usr/bin/llvm-stress       llvm-stress      /usr/bin/llvm-stress-11 \
    --slave   /usr/bin/llvm-symbolizer   llvm-symbolizer  /usr/bin/llvm-symbolizer-11 \
    --slave   /usr/bin/llvm-tblgen       llvm-tblgen      /usr/bin/llvm-tblgen-11

update-alternatives \
  --install /usr/bin/clang                 clang                  /usr/bin/clang-11     20 \
  --slave   /usr/bin/clang++               clang++                /usr/bin/clang++-11 \
  --slave   /usr/bin/clang-cpp             clang-cpp              /usr/bin/clang-cpp-11
