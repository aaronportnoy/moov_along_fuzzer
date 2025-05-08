#!/bin/bash
set -e

# Set AFL++ environment
export CC=afl-clang-fast
export CXX=afl-clang-fast++
export CFLAGS="-g -fno-stack-protector -U_FORTIFY_SOURCE -O0"
export CXXFLAGS="$CFLAGS"

# Create and enter build directory
cd moov_along
rm -rf build
mkdir build && cd build

# Configure with CMake and build
cmake ../
cmake --build .
make -j$(nproc)

echo "[+] Build complete."

