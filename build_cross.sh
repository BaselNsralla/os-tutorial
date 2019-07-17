#! /bin/bash
set -e
trap 'previous_command=$this_command; this_command=$BASH_COMMAND' DEBUG
trap 'echo FAILED COMMAND: $previous_command' EXIT

#-------------------------------------------------------------------------------------------
# This script will download packages for, configure, build and install a GCC cross-compiler.
# Customize the variables (INSTALL_PATH, TARGET, etc.) to your liking before running.
# If you get an error and need to resume the script from some point in the middle,
# just delete/comment the preceding lines before running it again.
#
# See: http://preshing.com/20141119/how-to-build-a-gcc-cross-compiler
#-------------------------------------------------------------------------------------------

INSTALL_PATH=/opt/cross
TARGET=i386-elf
USE_NEWLIB=0

BIN_CONFIGURATION_OPTIONS="--enable-interwork --enable-multilib --disable-nls --disable-werror" # --disable-threads --disable-shared
GCC_CONFIGURATION_OPTIONS="--disable-nls --disable-libssp --enable-languages=c --without-headers" # --disable-threads --disable-shared
PARALLEL_MAKE=-j4
BINUTILS_VERSION=binutils-2.24
GCC_VERSION=gcc-4.9.2
LINUX_KERNEL_VERSION=linux-3.17.2
GLIBC_VERSION=glibc-2.20
MPFR_VERSION=mpfr-3.1.2
GMP_VERSION=gmp-6.0.0a
MPC_VERSION=mpc-1.0.2
ISL_VERSION=isl-0.12.2
CLOOG_VERSION=cloog-0.18.1
export PATH=$INSTALL_PATH/bin:$PATH

# Download packages
export http_proxy=$HTTP_PROXY https_proxy=$HTTP_PROXY ftp_proxy=$HTTP_PROXY
wget -nc https://ftp.gnu.org/gnu/binutils/$BINUTILS_VERSION.tar.gz
wget -nc https://ftp.gnu.org/gnu/gcc/$GCC_VERSION/$GCC_VERSION.tar.gz
if [ $USE_NEWLIB -ne 0 ]; then
    wget -nc -O newlib-master.zip https://github.com/bminor/newlib/archive/master.zip || true
    unzip -qo newlib-master.zip
else
    wget -nc https://www.kernel.org/pub/linux/kernel/v3.x/$LINUX_KERNEL_VERSION.tar.xz
    wget -nc https://ftp.gnu.org/gnu/glibc/$GLIBC_VERSION.tar.xz
fi
wget -nc https://ftp.gnu.org/gnu/mpfr/$MPFR_VERSION.tar.xz
wget -nc https://ftp.gnu.org/gnu/gmp/$GMP_VERSION.tar.xz
wget -nc https://ftp.gnu.org/gnu/mpc/$MPC_VERSION.tar.gz
wget -nc ftp://gcc.gnu.org/pub/gcc/infrastructure/$ISL_VERSION.tar.bz2
wget -nc ftp://gcc.gnu.org/pub/gcc/infrastructure/$CLOOG_VERSION.tar.gz

# Extract everything
for f in *.tar*; do tar xfk $f; done

# Make symbolic links
cd $GCC_VERSION
ln -sf `ls -1d ../mpfr-*/` mpfr
ln -sf `ls -1d ../gmp-*/` gmp
ln -sf `ls -1d ../mpc-*/` mpc
ln -sf `ls -1d ../isl-*/` isl
ln -sf `ls -1d ../cloog-*/` cloog
cd ..

# Step 1. Binutils
mkdir -p build-binutils
cd build-binutils
../$BINUTILS_VERSION/configure --prefix=$INSTALL_PATH --target=$TARGET $BIN_CONFIGURATION_OPTIONS
make $PARALLEL_MAKE
sudo make install
cd ..

# Step 3. C/C++ Compilers
mkdir -p build-gcc
cd build-gcc

../$GCC_VERSION/configure --prefix=$INSTALL_PATH --target=$TARGET $GCC_CONFIGURATION_OPTIONS
make $PARALLEL_MAKE all-gcc
make install-gcc
cd ..


# Step 7. Standard C++ Library & the rest of GCC
cd build-gcc
make $PARALLEL_MAKE all
make install
cd ..

#trap - EXIT
echo 'Success!'
