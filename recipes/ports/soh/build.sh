#!/bin/bash

# Auto-fix CRLF line endings (Windows â†?Linux)
sed -i 's/\r$//' "$0"

set -e

PORT_FOLDER="$1"
PORT_BUILD="$2"
PORT_EXE="$3"
ARCH="$4"

FILES=(
  "libz.so.1"
  "libbz2.so.1"
  "libbz2.so.1.0"
  "libopus.so.0"
  "liblzma.so.5"
  "libogg.so.0"
  "libpng16.so.16"
  "libspdlog.so.1"
  "libspdlog.so.1.12"
  "libzip.so.5"
  "libtinyxml2.so.10"
  "libfmt.so.9"
  "libcrypto.so.1.1"
)

CDIR=$(pwd)
DEST_DIR="${CDIR}/dist/libs.${ARCH}"

if [[ ${ARCH} == "aarch64" ]]; then
  SOURCE_DIR="/usr/lib/aarch64-linux-gnu"
elif [[ ${ARCH} == "x86_64" ]]; then
  SOURCE_DIR="/usr/lib/x86_64-linux-gnu"
fi

echo "=== SoH CN Build ==="
echo "Port: ${PORT_FOLDER}"
echo "Arch: ${ARCH}"
echo "Build: ${PORT_BUILD}"

# Clone and checkout
git clone https://github.com/wonderfulnx/Shipwright-CN.git
cd Shipwright-CN
git checkout 9.2.3-cn-rc1
git submodule update --init

# Setup compiler
if ! command -v clang-18 &> /dev/null; then
    export CC=clang
    export CXX=clang++
else
    export CC=clang-18
    export CXX=clang++-18
fi

# Build
mkdir build-soh && cd build-soh
cmake .. -GNinja -DUSE_OPENGLES=1 -DBUILD_CROWD_CONTROL=1 -DCMAKE_BUILD_TYPE=DEBUG
cmake --build . -j$(nproc)
cmake --build . --target GenerateSohOtr -j$(nproc)
cd ../..

# Prepare dist directory
mkdir -p ${CDIR}/dist/assets/extractor
mkdir -p ${CDIR}/dist/libs.${ARCH}

# Copy build outputs
ls -lha Shipwright-CN/build-soh/soh/
strip "Shipwright-CN/build-soh/soh/${PORT_EXE}.elf" || true
cp "Shipwright-CN/build-soh/soh/${PORT_EXE}.elf" "dist/${PORT_EXE}.elf.${ARCH}"
cp "Shipwright-CN/build-soh/soh/${PORT_EXE}.o2r" "dist/"
strip "Shipwright-CN/build-soh/ZAPD/ZAPD.out" || true
cp "Shipwright-CN/build-soh/ZAPD/ZAPD.out" "${CDIR}/dist/assets/extractor/ZAPD.out.${ARCH}"

# Package extractor assets
cd dist/assets
mkdir assets_zip
cp -r "${CDIR}/Shipwright-CN/soh/assets/extractor/." assets_zip/
cp -r "${CDIR}/Shipwright-CN/soh/assets/xml/" assets_zip/
cd assets_zip
zip -r ../extractor.zip ./*
cd ..
rm -rf assets_zip

# Copy shared libraries
for file in "${FILES[@]}"; do
    cp "${SOURCE_DIR}/${file}" "${DEST_DIR}/" 2>/dev/null || echo "Warning: ${file} not found"
done

# Create tarball
ls -lha dist/
tar -czf "/workspace/${PORT_FOLDER}-linux-${ARCH}.tar.gz" -C ${CDIR}/dist .

echo "=== Build Complete ==="
echo "Output: ${PORT_FOLDER}-linux-${ARCH}.tar.gz"
